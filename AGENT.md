# AGENT.md

> Instructions for AI coding agents working in this repository.

---

## What this project is

**HUBX Flutter Developer Case** — a Flutter app: **Bloc (flutter_bloc), Clean Architecture, feature-first, dio, freezed, get_it/injectable, auto_route**.

Two flows: **Onboarding → Paywall → Home**. Onboarding is entered once; completing it is persisted and guarded.

**Dart 3, null-safe, Material widget set.** Never write StatefulWidget where a Bloc belongs, never `setState` for business state, never a global mutable singleton.

## Commands

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # freezed, json_serializable, injectable, auto_route
flutter analyze                                            # must be clean
dart format --set-exit-if-changed lib test                 # must be clean
flutter test                                               # all tests
flutter test test/features/home                            # one feature
flutter test --update-goldens                              # regenerate goldens (review the diff!)
```

Run `build_runner`, then `analyze` + `format` + the relevant tests before considering any change done.

**Any change to a `@freezed`, `@JsonSerializable`, `@injectable`, or `@RoutePage` class requires re-running `build_runner`.** Forgetting this is the most common way to break the build.

## Folder layout

```
lib/
  main.dart                    bootstrap only — configureDependencies() then runApp()
  app/                         COMPOSITION ROOT
    app.dart                   root MaterialApp.router widget
    router/                    AppRouter (auto_route), route guards
    di/                        get_it instance + @InjectableInit config
  core/
    network/                   Dio client, interceptors, AppException, status-code validation
    theme/                     ThemeData light/dark, ThemeExtensions (colors, dimens, typography)
    storage/                   SharedPreferences wrapper
    util/                      pure Dart helpers — no Flutter imports
  l10n/                        .arb files + generated localizations
  shared/
    widgets/                   reusable widgets used by 2+ features
  features/
    onboarding/                the whole onboarding FLOW, intro through paywall
      domain/                  entities, repository interfaces, use cases, result unions
      data/                    DTOs, mappers, data sources, repository impls
      presentation/
        intro/                 bloc/, view/, widgets/
        paywall/               bloc/, view/, widgets/
    home/
      domain/
      data/
      presentation/            bloc/, view/, widgets/
test/                          mirrors lib/ exactly
```

## Dependency rules — never violate

1. `domain/` imports **nothing** from `data/` or `presentation/`, and **no Flutter** — pure Dart only (`package:flutter/*` is banned there).
2. `presentation/` depends on `domain/`. **`presentation/` must never import `data/`.**
3. `data/` depends on `domain/` (implements its interfaces). Never the reverse.
4. Features **never** import sibling features. Cross-feature wiring happens in `app/`.
   - **A feature is a functional requirement, not a screen.** The paywall is a *page inside* the onboarding flow, not a sibling of it — it completes onboarding, so it needs onboarding's use cases. If two "features" must import each other, you drew the boundary at a screen; merge them.
   - Shared repositories are the same smell. If one lands in `core/`, first check whether the two features are really one.
5. `shared/widgets/` and `core/theme/` must never import `domain/` or any feature.
6. `core/util/` is pure Dart — no Flutter imports.

Enforce with `analysis_options.yaml`; there is no compiler boundary here the way Gradle modules give you.

## Packages

Add with `flutter pub add <name>` and let pub resolve versions — do not hand-write version constraints.

| Concern | Package |
|---|---|
| State management | `flutter_bloc`, `bloc` |
| Event concurrency | `bloc_concurrency`, `stream_transform` |
| Immutable models / unions | `freezed`, `freezed_annotation` |
| JSON | `json_serializable`, `json_annotation` |
| HTTP | `dio` |
| DI | `get_it`, `injectable`, `injectable_generator` |
| Navigation | `auto_route`, `auto_route_generator` |
| Persistence | `shared_preferences` |
| Value equality | `equatable` **only** where freezed is overkill |
| Codegen host | `build_runner` |
| Lints | `flutter_lints` |
| Tests | `flutter_test`, `bloc_test`, `mocktail` |

**Do not add:** `provider` (Bloc covers it), `dartz`/`fpdart` (see error rules), `get`/`getx`, `riverpod`, `http` (dio is the client), `flutter_screenutil` (use `MediaQuery`/`LayoutBuilder`).

## State management — how every screen works

Intent → `Bloc.add(Event)` → `on<Event>` handler → `emit(State)` → `BlocBuilder` → widgets

- **State** — one `@freezed` class per screen with **flat fields** (`isLoading`, `error`, `items`), plus **getters for derived data**. Never a sealed `Loading/Success/Error` union — flat fields let you show a list and a refresh spinner at once.
- **Derived logic belongs on the State as a getter**, not in `build()`. That keeps it unit-testable without a widget tree.
- **Event** — one `@freezed sealed` class per screen. Cases are named for **what the user did** (`HomeRefreshRequested`, `PaywallPlanSelected`) or **what happened** (`HomeQuestionsLoaded`).
- **Bloc** — `@injectable`, one `on<Event>` handler per event case, registered in the constructor. Handlers call use cases and `emit`. **All async work happens here.**
- **Widget** — `BlocBuilder`/`BlocSelector` reads state, dispatches via `context.read<Bloc>().add(...)`.

Use **Cubit** only for a screen with no events worth naming (pure fetch-and-show). Default to **Bloc**.

**Concurrency: Bloc processes events concurrently by default.** A mashed retry button or a fast scroll fires N overlapping requests. Every event that triggers I/O must declare a transformer from `bloc_concurrency`:

| Event kind | Transformer | Why |
|---|---|---|
| Refresh / retry / submit | `droppable()` | ignore taps while one is in flight |
| Pagination / "load more" | `throttleDroppable(100ms)` | drop bursts from fast scrolling |
| Search / filter text | `restartable()` + `debounce` | cancel the stale query |
| Must-not-lose sequences | `sequential()` | process in order, none dropped |

```dart
on<HomeRefreshRequested>(_onRefreshRequested, transformer: droppable());
```

Omitting the transformer is a bug, not a style choice.

**One-shot concerns** (snackbars, dialogs, navigation-on-success) go through `BlocListener`, driven by a nullable field in State plus an explicit dismiss/consume event. Do not add a separate side-effect stream.

### Adding a screen — all 10 steps

1. `domain/`: entity, repository interface, **result union**
2. `domain/`: use case — one class, one `call()`
3. `data/`: DTO (`@JsonSerializable`) + mapper + data source + repository impl
4. **`@injectable` annotations** on the new use case / repo impl / data source
5. `presentation/bloc/`: `<Screen>State` (flat fields + getters)
6. `presentation/bloc/`: `<Screen>Event` (sealed)
7. `presentation/bloc/`: `<Screen>Bloc` with an `on<E>` handler per event
8. `presentation/view/`: `<Screen>Page` (`@RoutePage()`) + `const` sub-widgets in `presentation/widgets/`
9. **`app/router/`: add the route to `AppRouter`** (+ a guard if the flow requires one)
10. `test/`: use case tests (one per result branch), mapper tests, `bloc_test`, state-getter tests

**Steps 4 and 9 are the ones that get forgotten.** Both compile fine and fail at runtime — step 4 as a `get_it` "not registered" throw, step 9 as a missing route.

## Domain rules

- One use case = one operation. `@injectable class GetCategories { Future<GetCategoriesResult> call(); }`.
- Errors are **sealed result unions per operation**, never a generic `Result<T>`, never `Either<Failure, T>`, and **never a thrown exception crossing out of `data/`**:
  ```dart
  @freezed
  sealed class GetCategoriesResult with _$GetCategoriesResult {
    const factory GetCategoriesResult.success(List<Category> categories) = GetCategoriesSuccess;
    const factory GetCategoriesResult.network()                          = GetCategoriesNetwork;
    const factory GetCategoriesResult.server(int statusCode)             = GetCategoriesServer;
    const factory GetCategoriesResult.unknown([Object? cause])           = GetCategoriesUnknown;
  }
  ```
  Consume with Dart 3 exhaustive `switch` — no `default:` clause, so a new case becomes a compile error.
- Entities are plain `@freezed` classes. **No `@JsonSerializable` on an entity** — that belongs to the DTO.
- Never reference `Dio`, `SharedPreferences`, `BuildContext`, or any Flutter type in `domain/`.

## Data rules

- **DTOs never leave `data/`.** Mappers convert DTO → entity at the repository boundary.
- Data sources split by origin: `RemoteDataSource`, `LocalDataSource`.
- Repository impls are thin: call source, catch typed exceptions, map to the result union. No business rules.
- **Status-code validation and error translation live in a Dio interceptor**, which throws a typed `AppException` (`NetworkException`, `ServerException(statusCode)`, `ParseException`). The repository is the only place that catches it.
- Mappers are pure top-level functions or extensions, and are tested.

## UI rules

- `<Screen>Page` is the `@RoutePage()` entry. It provides the Bloc (`BlocProvider(create: (_) => getIt<HomeBloc>())`) and renders a `<Screen>View`.
- **Extract `const` sub-widgets that take primitives**, not domain entities. `QuestionTile({required String title, required bool isLocked, required VoidCallback onTap})` — not `QuestionTile({required Question question})`.
- Never compute filters, sorts, or formatting inside `build()`. Put it on the State getter or in a mapper.
- **Prefer `BlocSelector`** over `BlocBuilder` when a widget needs one field; use `buildWhen` otherwise.
- All styling via `Theme.of(context)` and the `ThemeExtension`s — **no literal `Color`, no magic `double` for spacing**. Use `context.appDimens.spacingMd`, not `16`.
- All user-facing text via generated localizations. **No hardcoded strings in widgets.**
- Responsiveness via `MediaQuery`, `LayoutBuilder`, `Flexible`, `Expanded`. **No fixed pixel widths** for anything that spans the screen.
- Light and dark are both first-class; every screen must be legible in both.
- `ListView.builder` / `SliverList` for any list that can exceed a screen — never a `Column` inside `SingleChildScrollView` for API-driven lists.

## Reusable widgets

> Generic, or needed by a second feature, or a design-system decision → `shared/widgets/`. Otherwise it stays in the feature.

- **Never** define a button, loader, error view, or dialog inside a feature. Those live in `shared/widgets/`.
- A shared widget must not take a domain type — primitives and callbacks only.
- Don't extract on speculation. A **second real caller** is the trigger.

## Testing

**Mandatory:** use cases (one test per result branch), DTO→entity mappers, repository impls, State getters.
**Strongly expected:** `bloc_test` per Bloc — one group per event.
**Where it earns its keep:** golden tests for the paywall and onboarding pages, light and dark.

Stack: `flutter_test`, `bloc_test`, `mocktail`. Arrange/Act/Assert, descriptive names, no real network, no real time, no `pumpAndSettle` on an infinite animation.

## Common mistakes — do not make these

| ❌ | ✅ |
|---|---|
| `presentation/` importing `data/` | Depend on `domain/` use cases |
| Feature A importing feature B | Route via `app/` |
| Sealed `UiState.loading/success/error` | Flat `isLoading` / `error` / `items` fields |
| Filtering or formatting inside `build()` | A getter on the State |
| Passing a domain entity into a leaf widget | Pass primitives |
| `Either<Failure, T>` / generic `Result<T>` | Per-operation sealed result union |
| Exception thrown out of `data/` | Caught in the repo, mapped to a result case |
| `switch` with `default:` on a result union | Exhaustive switch, no default |
| Hardcoded `Color(0xFF...)` or `EdgeInsets.all(16)` | `Theme.of(context)` + `ThemeExtension` |
| Hardcoded user-facing string | Generated localizations |
| `setState` for business state | Bloc |
| `BuildContext` or `Dio` in `domain/` | Neither ever appears there |
| Adding a route only to the widget tree | Register it in `AppRouter` (step 9) |
| Editing a `@freezed` class without rerunning codegen | `dart run build_runner build` |
| I/O-triggering `on<Event>` with no transformer | `droppable()` / `restartable()` / `throttleDroppable()` |
| Hand-written version constraints | `flutter pub add` |

## Never introduce

`getx` · `riverpod` · `provider` · `dartz`/`fpdart` · `setState` for business state · `GlobalKey` as a state channel · global mutable singletons · `print` (use a logger) · `late` without an assignment guarantee · `dynamic` in a public signature · `// ignore:` without a comment explaining why · `TODO`/`FIXME` in merged work.

## Conventions

- Files `snake_case.dart`; one public class per file; `part`/`part of` only for generated code.
- Branches: `feature/<short-description>`. Commits: imperative summary, grouped by functionality.
- Prefer library-private (`_`) and feature-private; a feature's public surface is its use cases, its `Page`, and its route.
- `analysis_options.yaml` includes `flutter_lints` and must pass with zero warnings.

## Reference material

- Case requirements, evaluation criteria, Figma link, and API endpoints: `docs/CASE.md`
- Why each rule looks the way it does, with Kotlin/Compose equivalents: `docs/ANDROID_TO_FLUTTER.md`
