# Android → Flutter: a translation layer

> Companion to `AGENT.md`. That file tells the agent *what* to do; this one tells **you** *why*, by mapping every rule back to its Kotlin/Compose equivalent in `Zapdos-Android`.
>
> Read it in order the first time. After that, use it as a lookup table.

---

## 1. The 30-second map

| Zapdos (Kotlin/Compose) | This project (Dart/Flutter) | Fidelity |
|---|---|---|
| Gradle module per layer | folder per layer, one package | ⚠️ convention only |
| `@HiltViewModel` / `@Inject` / `@Binds` | `@injectable` / `@LazySingleton` / `@module` | ✅ very close |
| `ViewModel` + `StateStore` | `Bloc` | ✅ merged into one |
| `Event.reduce(old): State` | `on<Event>` handler | ⚠️ logic moves location |
| `mapStateToProps` → `Props` → `Content` | State getters + `const` sub-widgets | ⚠️ **dropped** — see §7 |
| sealed `GetXResult` | `@freezed sealed` union | ✅ near-perfect |
| `when` (exhaustive) | `switch` with patterns (exhaustive) | ✅ near-perfect |
| `data class` + `copy()` | `@freezed` + `copyWith()` | ✅ |
| Retrofit + OkHttp interceptors | `dio` + `Interceptor` | ✅ |
| Room / DataStore | `shared_preferences` (this case needs no DB) | — |
| `TextResource` / `stringResource()` | `gen_l10n` → `context.l10n.x` | ✅ |
| `AppTheme.colors/dimens/typography` | `ThemeExtension<AppColors>` etc. | ✅ near-perfect |
| injected `Navigator` interface | `auto_route` + `AutoRouteGuard` | ✅ same intent |
| `@DayNightPreviews` + `Props.preview()` | golden tests, light + dark | ⚠️ no live preview |
| KSP codegen (invisible, in `build/`) | `build_runner` (visible, `*.g.dart`) | ⚠️ you must run it |
| `suspend` + structured concurrency | `Future` + `async` | ❌ **no cancellation** — see §16 |
| `Flow` / `StateFlow` | `Stream` / Bloc's own stream | ✅ |
| `collectAsStateWithLifecycle()` | `BlocBuilder` | ✅ |
| `LazyColumn` | `ListView.builder` | ✅ |
| Compose recomposition + stability | widget rebuild + `const` + `identical` | ⚠️ **different model** — see §15 |

---

## 2. Project structure — losing the compiler

**Zapdos:** ~8 Gradle modules today, designed to grow to Talisman's 170. `presentation:dashboard` *physically cannot* import `data:dashboard`, because the Gradle dependency isn't declared. The build fails. The architecture is enforced by the compiler.

**Here:** one Dart package, folders only.

```
lib/features/home/domain/
lib/features/home/data/
lib/features/home/presentation/
```

Nothing stops `presentation/home_bloc.dart` from writing `import '../data/home_repository_impl.dart'`. It compiles. It runs. It's wrong.

**Why we accept this:** the case asks in so many words for *"clear and scalable feature-first folder structure (e.g., features/onboarding, features/home, core, shared)"*. That's a folder structure in a single package. Splitting into real pub packages (via pub workspaces or melos) would give you back the compiler boundary, but it's a chunk of setup the brief didn't ask for.

**What replaces the compiler:** lint rules in `analysis_options.yaml`, plus discipline. This is the single biggest thing you give up moving from Zapdos to a normal Flutter project — worth saying out loud in the interview, because it shows you know what a Gradle module is actually *buying* you.

> **Talking point:** "In the Android project this boundary is enforced by the build graph. In a single-package Flutter app it's a convention, so I documented it in `AGENT.md` and backed it with lints. At scale I'd promote each layer to its own package in a pub workspace."

### Feature-first vs layer-first — where the market actually stands

Worth knowing, because it's a likely interview question and the honest answer isn't a slogan.

- **Universal agreement:** the UI layer is organized by feature. Nobody defends a global `lib/screens/` bucket.
- **Still contested:** whether `data/` and `domain/` nest inside each feature. The **Flutter team's own architecture guide** says no — it's a hybrid, with `ui/<feature>/` but `data/repositories/` grouped by type, on the grounds that *"repositories and services can be used across different features."*
- **Andrea Bizzotto's article** (the most-cited piece on this, 2022) argues fully feature-first — with the caveat that decides everything: *"do not attempt to apply a feature-first approach by looking at the UI."* Features are functional requirements, not screens.

Zapdos is fully feature-first (`domain/dashboard`, `presentation/dashboard`) and so is this project, which is also what the case brief asks for by name.

**The caveat is load-bearing, and this project proves it.** An early draft of `AGENT.md` listed three features: `onboarding`, `paywall`, `home`. But the case says the onboarding flow *ends when the paywall's close button is tapped* — so `paywall` must call `CompleteOnboarding`, which lives in `onboarding/domain/`. A feature importing a sibling, on day one.

The paywall isn't a feature. It's the last page of the onboarding **flow**. Merging it fixed the violation without an exception clause — which is the general test: **if two features must import each other, you drew the boundary at a screen.** Flutter's official worry about shared repositories is usually the same mistake wearing a different hat.

---

## 3. Dependency injection — Hilt → get_it + injectable

Closest mapping in the whole document. `injectable` is explicitly modelled on annotation-based DI.

| Hilt | injectable |
|---|---|
| `@Inject constructor` | `@injectable` on the class |
| `@Singleton` | `@singleton` / `@lazySingleton` |
| `@Binds` (interface → impl) | `@Injectable(as: HomeRepository)` |
| `@Provides` in a `@Module` | `@module` class with getters |
| `@HiltAndroidApp` | `configureDependencies()` in `main()` |
| `hiltViewModel()` | `getIt<HomeBloc>()` |

```kotlin
// Zapdos
@Singleton
class GetCategories @Inject constructor(
    private val repository: CategoryRepository,
) { suspend operator fun invoke(): GetCategoriesResult = repository.categories() }
```

```dart
// Here
@injectable
class GetCategories {
  const GetCategories(this._repository);
  final CategoryRepository _repository;

  Future<GetCategoriesResult> call() => _repository.categories();
}
```

Kotlin's `operator fun invoke` → Dart's `call()`. Both let you write `getCategories()` at the call site.

**The leak:** Hilt validates the whole dependency graph *at compile time* — a missing binding fails the build. `get_it` resolves **at runtime**, so a missing registration is an exception the first time that screen opens. This is why step 4 in `AGENT.md`'s checklist is called out: forgetting `@injectable` compiles perfectly and crashes on navigation.

**Binding an interface:**

```kotlin
// Zapdos — in framework/app, the composition root
@Binds
abstract fun bindCategoryRepository(impl: CategoryRepositoryImpl): CategoryRepository
```

```dart
// Here — the annotation sits on the impl itself
@Injectable(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository { ... }
```

Note the philosophical difference: Zapdos deliberately puts *all* `@Binds` in `framework/app` so features don't know their own wiring. `injectable` puts the annotation on the implementation class. That's the idiomatic Dart way and we follow it — the impl is in `data/` and nothing in `domain/` or `presentation/` learns about it, so the important property survives.

---

## 4. State management — ViewModel + StateStore + reduce → Bloc

This is where the mental adjustment is biggest, so take it slowly.

### Zapdos

Four moving parts:

```kotlin
data class HomeState(
    val isLoading: Boolean = false,
    val questions: List<Question> = emptyList(),
) : ScreenState {
    companion object { fun initial() = HomeState() }
}

sealed interface HomeEvent : ScreenEvent<HomeState> {
    data class QuestionsLoaded(val questions: List<Question>) : HomeEvent {
        override fun reduce(oldState: HomeState) =        // ← logic lives HERE
            oldState.copy(isLoading = false, questions = questions)
    }
}

class HomeScreenStateStore @Inject constructor() :
    DefaultStateStore<HomeState, HomeEvent>(HomeState.initial())

@HiltViewModel
class HomeViewModel @Inject constructor(
    private val getQuestions: GetQuestions,
) : BasicViewModel<HomeState, HomeEvent>() {
    fun load() = viewModelScope.launch {          // ← async work HERE
        when (val result = getQuestions()) {
            is Success -> sendEvent(QuestionsLoaded(result.questions))
            is Error   -> sendEvent(LoadFailed(result))
        }
    }
}
```

The ViewModel does the *work*; the Event does the *reduction*. Clean split, no central reducer.

### Here

Two moving parts. Bloc absorbs the StateStore, and the `on<Event>` handler absorbs both jobs:

```dart
@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default(<Question>[]) List<Question> questions,
    HomeError? error,
  }) = _HomeState;
  const HomeState._();

  factory HomeState.initial() => const HomeState();
}

@freezed
sealed class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started()          = HomeStarted;
  const factory HomeEvent.refreshRequested() = HomeRefreshRequested;
}

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getQuestions) : super(HomeState.initial()) {
    on<HomeStarted>(_onStarted);
    on<HomeRefreshRequested>(_onRefreshRequested);
  }

  final GetQuestions _getQuestions;

  Future<void> _onStarted(HomeStarted event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));   // ← work AND reduction
    final result = await _getQuestions();                 //    both live here
    switch (result) {
      case GetQuestionsSuccess(:final questions):
        emit(state.copyWith(isLoading: false, questions: questions));
      case GetQuestionsNetwork():
        emit(state.copyWith(isLoading: false, error: HomeError.network));
      case GetQuestionsServer() || GetQuestionsUnknown():
        emit(state.copyWith(isLoading: false, error: HomeError.generic));
    }
  }
}
```

### What actually changed

| | Zapdos | Bloc |
|---|---|---|
| Who does async work | ViewModel | the `on<Event>` handler |
| Who computes the next state | the Event's `reduce` | the same handler, via `emit` |
| Event naming | past-tense **facts** (`QuestionsLoaded`) | user **intents** (`RefreshRequested`) |
| Is the reduction pure? | yes, by construction | no — handlers are `async` and side-effecting |
| Testing the reduction | plain unit test on `reduce` | `bloc_test` (still fast, no widgets) |

The event-naming flip is the part that trips people up. In Zapdos an event means *"this already happened, fold it in."* In Bloc an event means *"the user wants this, go do it."* `HomeRefreshRequested` is idiomatic Bloc; `HomeQuestionsLoaded` as a *public* event is not — that's just an internal `emit`.

**Why we're not porting `reduce` onto the event classes:** it's expressible in Dart and it's genuinely elegant, but it's not how anyone writes `flutter_bloc`, and *"consistent Dart/Flutter coding conventions"* is a literal scoring line on this case. Not the place to be clever.

### One-shot events

Zapdos has no Effect channel by design: dialogs and snackbars are nullable State fields with an explicit dismiss event. **We keep exactly that**, because Bloc's answer is the same:

```dart
BlocListener<HomeBloc, HomeState>(
  listenWhen: (prev, curr) => prev.error != curr.error && curr.error != null,
  listener: (context, state) {
    ScaffoldMessenger.of(context).showSnackBar(...);
    context.read<HomeBloc>().add(const HomeEvent.errorDismissed());
  },
  child: ...,
)
```

`BlocListener` fires on state *transitions* without rebuilding, which is the missing piece Compose doesn't have an exact analogue for.

### A lifecycle difference worth knowing

Android's `ViewModel` exists primarily to survive **Activity recreation** on rotation. Flutter never destroys and recreates your UI on a config change — there is no Activity teardown to survive. So a Bloc's lifetime is just its `BlocProvider`'s position in the widget tree. Provide it above the screen you want it to outlive, and no higher.

---

## 5. State shape — flat fields, not a sealed union

Almost every Flutter tutorial writes this:

```dart
sealed class HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState { final List<Question> questions; }
class HomeError extends HomeState { final String message; }
```

**We don't**, and this is one place where your Android instinct is simply better. Zapdos's rule — *"Sealed `UiState.Loading/Success/Error` ❌, independent `isLoading` / `error` / `items` fields ✅"* — carries over unchanged.

The reason is pull-to-refresh. With a sealed union, refreshing an already-loaded list forces you into either `HomeLoading` (list disappears, screen flashes) or a bolted-on `HomeLoaded(isRefreshing: true)` — at which point you've reinvented flat fields with extra steps. Flat fields let you render a populated list *and* a spinner *and* a stale-data banner at once, because those are independent facts.

Same conclusion, both frameworks. Easy point to make in an interview.

---

## 6. Derived data — `derivedStateOf` → a getter on State

`AGENT.md` says: never compute in `build()`. Here's the mechanism.

```kotlin
// Zapdos — this lived in mapStateToProps
val visible = if (state.selectedCategoryId == null) state.questions
              else state.questions.filter { it.categoryId == state.selectedCategoryId }
```

```dart
// Here — a getter on the freezed state
@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({...}) = _HomeState;
  const HomeState._();                    // ← REQUIRED for custom getters

  List<Question> get visibleQuestions => selectedCategoryId == null
      ? questions
      : questions.where((q) => q.categoryId == selectedCategoryId).toList();

  bool isLocked(Question q) => q.isPremium && !hasSubscription;
}
```

That `const HomeState._();` private constructor is easy to forget — without it freezed won't let you add members, and the error message is not obvious.

**The payoff** is that presentation logic stays a plain unit test:

```dart
test('premium questions are locked for free users', () {
  final state = HomeState.initial()
      .copyWith(questions: [premiumQuestion], hasSubscription: false);

  expect(state.isLocked(premiumQuestion), isTrue);
});
```

No `pumpWidget`, no mock bloc, no `MaterialApp`, no theme. That's the *actual* value `mapStateToProps` gave you in Zapdos, and getters recover most of it in idiomatic Flutter.

---

## 7. What we deliberately dropped: the Props layer

Zapdos's signature move:

```
State → mapStateToProps → Props (@Immutable) → Content(props) — never sees State or the ViewModel
```

We're **not** porting it. Reasons, honestly:

1. **It's a React idiom, not a Flutter one.** The name `mapStateToProps` is literally from Redux. Compose absorbed a lot of React thinking; Flutter absorbed less. A Flutter reviewer will read it as imported from another ecosystem.
2. **The performance argument doesn't transfer for free.** In Compose, `@Immutable` Props plus compiler-memoized lambdas let the runtime skip recomposition. In Flutter, if you build a new props object containing closures on every rebuild, `==` is false every time and nothing is skipped. You'd have to keep callbacks *outside* the props object to get value equality at all — doable, but the win isn't automatic the way it is in Compose.
3. **Getters recover the testability** (§6), which was the real prize.

What we lose: leaf widgets can still see domain types unless you're disciplined, and there's no `Props.preview()` factory to seed goldens from. `AGENT.md` compensates by requiring `const` sub-widgets that take **primitives only**:

```dart
// ✅ takes primitives — reusable, const, trivially golden-testable
class QuestionTile extends StatelessWidget {
  const QuestionTile({
    required this.title,
    required this.isLocked,
    required this.onTap,
    super.key,
  });
  final String title;
  final bool isLocked;
  final VoidCallback onTap;
  ...
}

// ❌ takes a domain entity — now the widget layer knows about domain
class QuestionTile extends StatelessWidget {
  const QuestionTile({required this.question, super.key});
  final Question question;
}
```

> **Talking point** for the README and the interview: *"On Android I use a Props layer so all presentation logic is a pure function. In Flutter I got the same testability from state getters without fighting the framework's conventions — and the Props pattern's rebuild benefit doesn't transfer, because Dart closures break value equality."* That's a stronger answer than having shipped the pattern.

---

## 8. Navigation — Navigator interfaces → auto_route

Zapdos: each feature declares a `HomeNavigator` interface; `framework/app` implements it. The feature never sees a route constant, so features can't reach each other.

Flutter: `auto_route` generates a typed route table from `@RoutePage()` annotations.

```dart
// features/home/presentation/view/home_page.dart
@RoutePage()
class HomePage extends StatelessWidget { ... }
```

```dart
// app/router/app_router.dart — the composition root
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingRoute.page, initial: true, guards: [OnboardingGuard()]),
        AutoRoute(page: PaywallRoute.page),
        AutoRoute(page: HomeRoute.page),
      ];
}
```

Navigating is `context.router.replaceAll([const HomeRoute()])` — typed, no string routes.

**"Users who complete onboarding should not re-enter it"** — the case's one genuinely stateful navigation rule — is an `AutoRouteGuard`, which is the direct analogue of a nav-graph conditional start destination:

```dart
class OnboardingGuard extends AutoRouteGuard {
  const OnboardingGuard(this._isOnboardingCompleted);
  final IsOnboardingCompleted _isOnboardingCompleted;

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (await _isOnboardingCompleted()) {
      router.replaceAll([const HomeRoute()]);
    } else {
      resolver.next();
    }
  }
}
```

The Zapdos property that matters — **features don't import features** — survives: `onboarding` never imports `home`, it just asks the router to go to a route the composition root registered.

---

## 9. Errors — the one thing that ports perfectly

Zapdos's rule: sealed result type **per operation**, never a generic `Result<T>`, never throw across layers. Dart 3 + freezed express this beautifully.

```kotlin
sealed interface GetCategoriesResult {
    data class Success(val categories: List<Category>) : GetCategoriesResult
    sealed interface Error : GetCategoriesResult {
        val cause: Throwable?
        data class Unauthorized(override val cause: Throwable? = null) : Error
        data class Unknown(override val cause: Throwable? = null) : Error
    }
}
```

```dart
@freezed
sealed class GetCategoriesResult with _$GetCategoriesResult {
  const factory GetCategoriesResult.success(List<Category> categories) = GetCategoriesSuccess;
  const factory GetCategoriesResult.network()                          = GetCategoriesNetwork;
  const factory GetCategoriesResult.server(int statusCode)             = GetCategoriesServer;
  const factory GetCategoriesResult.unknown([Object? cause])           = GetCategoriesUnknown;
}
```

Consumption is the same exhaustiveness guarantee you get from Kotlin's `when`:

```dart
switch (result) {
  case GetCategoriesSuccess(:final categories): ...
  case GetCategoriesNetwork():                  ...
  case GetCategoriesServer(:final statusCode):  ...
  case GetCategoriesUnknown():                  ...
}
```

**Never write `default:`.** With a sealed class and no default, adding a new case turns every incomplete switch into a compile error — exactly like Kotlin.

### The `Either<Failure, T>` question

Most Flutter Clean Architecture tutorials use `dartz`/`fpdart` and `Either<Failure, T>`. `AGENT.md` bans it, and that's a deliberate divergence from the local convention, so know your reasoning:

`Either<Failure, T>` **is** the generic `Result<T>` your Android rules reject. It gives you one `Failure` hierarchy shared by every operation, so `getCategories` and `completePurchase` return the same error type even though nothing can be `PaymentDeclined` in the first one. Per-operation unions make each call site's real failure modes visible and exhaustively checkable.

Be ready to defend it — a reviewer *may* expect `Either`. "I use per-operation sealed results so the type tells you exactly which failures are reachable here" is a good answer.

### Where exceptions still live

Inside `data/` only. The Dio interceptor throws typed exceptions; the repository is the only thing that catches them:

```dart
Future<GetCategoriesResult> categories() async {
  try {
    final dtos = await _remote.getCategories();
    return GetCategoriesResult.success(dtos.map((e) => e.toDomain()).toList());
  } on NetworkException {
    return const GetCategoriesResult.network();
  } on ServerException catch (e) {
    return GetCategoriesResult.server(e.statusCode);
  } on Object catch (e) {
    return GetCategoriesResult.unknown(e);
  }
}
```

---

## 10. Models — data class → freezed, and the DTO split

| Kotlin | Dart |
|---|---|
| `data class` | `@freezed` class |
| `.copy(x = 1)` | `.copyWith(x: 1)` |
| structural `equals`/`hashCode` free | freezed generates them |
| `toString()` free | freezed generates it |
| `@Serializable` on a DTO | `@JsonSerializable()` on a DTO |

```dart
// data/dto/category_dto.dart — DTO knows JSON, stays in data/
@JsonSerializable()
class CategoryDto {
  const CategoryDto({required this.id, required this.name, this.iconUrl});
  final String id;
  final String name;
  @JsonKey(name: 'icon_url') final String? iconUrl;

  factory CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);
}

// data/mapper/category_mapper.dart — pure, tested
extension CategoryDtoMapper on CategoryDto {
  Category toDomain() => Category(id: id, name: name, iconUrl: iconUrl);
}

// domain/entity/category.dart — knows nothing about JSON
@freezed
abstract class Category with _$Category {
  const factory Category({required String id, required String name, String? iconUrl}) = _Category;
}
```

Same discipline as Zapdos: *"Entities are plain immutable data classes — no `@Serializable`, no `@Entity`."*

**Practical note on the mapper:** it's the cheapest bug-catcher in the app. The dummy API is external and may hand you nulls or renamed fields; a table-driven mapper test pins the contract.

> **freezed version syntax:** freezed 3.x requires `abstract class` for single-constructor classes and `sealed class` for unions. freezed 2.x used a plain `class` for both. The examples here are 3.x. If codegen complains about the class modifier, that's the mismatch.

---

## 11. Networking — Retrofit/OkHttp → dio

| Retrofit / OkHttp | dio |
|---|---|
| `Interceptor` | `Interceptor` (same name, same idea) |
| `@GET("getCategories")` | `_dio.get<...>('/getCategories')` |
| `HttpLoggingInterceptor` | `LogInterceptor` |
| `CallAdapter` | not needed — everything is a `Future` |
| `Call.cancel()` | `CancelToken` |

Status-code validation and error translation belong in **one** interceptor so no repository repeats it:

```dart
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final mapped = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.connectionError => const NetworkException(),
      DioExceptionType.badResponse      => ServerException(err.response?.statusCode ?? -1),
      _                                 => UnknownException(err),
    };
    handler.reject(DioException(requestOptions: err.requestOptions, error: mapped));
  }
}
```

Retrofit generates the client from an interface; with plain dio you write the data source by hand. That's fine at this size — `retrofit` for Dart exists, but it's another generator for two endpoints.

---

## 12. Theming — AppTheme → ThemeExtension

Another near-perfect mapping, and the case explicitly rewards it (*"reusable design elements using ThemeData, TextStyle, ColorScheme"*, *"support for light/dark mode"*).

```kotlin
// Zapdos
Text(text, color = AppTheme.colors.textPrimary, style = AppTheme.typography.body)
Spacer(Modifier.height(AppTheme.dimens.spacingMd))
```

```dart
// Here
Text(text, style: context.appTypography.body.copyWith(color: context.appColors.textPrimary));
SizedBox(height: context.appDimens.spacingMd);
```

Flutter's built-in `ColorScheme` only covers Material's semantic roles. Anything the Figma has that Material doesn't — brand gradients, a paywall's premium accent — goes in a `ThemeExtension`:

```dart
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({required this.textPrimary, required this.premiumAccent});
  final Color textPrimary;
  final Color premiumAccent;

  @override
  AppColors copyWith({Color? textPrimary, Color? premiumAccent}) => AppColors(
        textPrimary: textPrimary ?? this.textPrimary,
        premiumAccent: premiumAccent ?? this.premiumAccent,
      );

  @override
  AppColors lerp(AppColors? other, double t) => other == null ? this : AppColors(
        textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
        premiumAccent: Color.lerp(premiumAccent, other.premiumAccent, t)!,
      );
}

extension AppColorsX on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
```

Register one instance in the light `ThemeData` and one in dark, and `AppTheme.colors.x` becomes `context.appColors.x` with the same "no literal colors anywhere" guarantee.

One thing Compose doesn't give you: `lerp` means Flutter animates smoothly between your custom light and dark palettes on theme switch, for free.

---

## 13. Strings — TextResource → gen_l10n

Zapdos's `TextResource` exists because a ViewModel shouldn't hold a `Context` to resolve `R.string`. Flutter has the same problem (no `BuildContext` in a Bloc) and the same solution shape.

```
lib/l10n/app_en.arb   →  codegen  →  context.l10n.homeTitle
```

Rule, same as Android: **no hardcoded user-facing strings in widgets.**

The wrinkle: a Bloc can't reach `context.l10n`. So a Bloc never emits a display string — it emits a **semantic error enum** and the widget resolves it:

```dart
enum HomeError { network, generic }

// in the widget
final message = switch (state.error) {
  HomeError.network => context.l10n.errorNoConnection,
  HomeError.generic => context.l10n.errorGeneric,
  null              => null,
};
```

That's `TextResource`'s job, done at the widget boundary instead of in a wrapper type. Same principle: the state layer stays free of localization.

---

## 14. Collections and immutability

Zapdos requires `ImmutableList<T>` in Props, never `List<T>`, because Compose treats `List` as unstable and skips its skipping.

Dart has no equivalent pressure — freezed generates deep value equality for `List` fields, and there's no stability inference to satisfy. `AGENT.md` therefore just uses `List`, and doesn't pull in `built_collection` or `fast_immutable_collections`.

Trade-off you should know: Dart's `List` is mutable at runtime. A freezed class hands out the same list instance, and a caller *could* mutate it. In practice nobody does, and adding an immutable-collections package to prevent it is a poor trade for a case this size. If you want the guarantee, `List.unmodifiable` in the factory is one line.

---

## 15. The rebuild model — the deepest conceptual difference

Do not skip this one. It's where Compose intuitions actively mislead.

**Compose:** recomposition is fine-grained. The compiler analyzes parameter *stability*; a composable whose stable inputs are unchanged is **skipped** individually. `@Immutable` is you telling the compiler "trust this type." Lambdas are memoized automatically.

**Flutter:** there is no stability analysis and no automatic memoization. When a widget rebuilds, it constructs new child widget objects. Flutter then walks the element tree and, for each child, asks: is the new widget `identical()` to the old one? If yes, it **skips the entire subtree**. If no, it calls `Widget.canUpdate` (same `runtimeType` + same `key`) and, if that passes, updates the element in place and rebuilds that child.

So the lever is *object identity*, not type stability. Which is exactly why `const` matters so much:

```dart
// canonicalized by the compiler — the SAME instance every rebuild
// → identical() is true → subtree skipped entirely
const AppLoader()

// new instance every rebuild → subtree rebuilds, even if nothing changed
AppLoader()
```

Practical consequences for this project:

- **`const` everywhere it's legal.** `flutter_lints` has `prefer_const_constructors` on; treat its warnings as errors, not style nits. This is the closest thing Flutter has to Compose's skipping.
- **Scope your `BlocBuilder` tightly.** Wrapping a whole page in one `BlocBuilder` rebuilds the whole page on every emit. Wrap only the part that depends on the changing field, or use `BlocSelector`:
  ```dart
  BlocSelector<HomeBloc, HomeState, bool>(
    selector: (state) => state.isLoading,
    builder: (context, isLoading) => isLoading ? const AppLoader() : const SizedBox.shrink(),
  )
  ```
- **A rebuild is cheap; a relayout and repaint are not.** Flutter's build phase is fast by design. Don't contort the code to avoid rebuilds — profile first. This is a real difference in *degree* from Compose, where recomposition avoidance is more central to how you write.

---

## 16. Concurrency — the biggest genuine downgrade

Kotlin coroutines give you structured concurrency. Dart Futures do not. This is the one place Flutter is meaningfully weaker, and knowing it is a strong interview signal.

| Kotlin | Dart | Note |
|---|---|---|
| `suspend fun` | `Future<T>` + `async` | ✅ |
| `viewModelScope.launch { }` | `on<Event>` handler body | ⚠️ see below |
| `coroutineScope { async { } ... }` parallel | `Future.wait([a, b])` | ✅ |
| `withContext(Dispatchers.IO)` | *nothing needed* | Dart I/O is already non-blocking |
| `Dispatchers.Default` for CPU work | `Isolate` / `compute()` | heavier — real isolates, no shared memory |
| **scope cancellation** | **none** | ❌ |
| `Flow` | `Stream` | ✅ |
| `Flow.collect` | `await for` / `.listen` | ✅ |

**`viewModelScope` auto-cancels every in-flight coroutine when the ViewModel clears.** Dart has no such mechanism — a `Future` cannot be cancelled once started. If a Bloc closes while a request is in flight, the response still arrives and `emit` throws.

Two defences, both required:

```dart
// 1. Guard the emit
if (emit.isDone) return;

// 2. Cancel the actual HTTP request via dio
final cancelToken = CancelToken();
@override
Future<void> close() {
  _cancelToken.cancel();
  return super.close();
}
```

**The dispatcher rule inverts.** `AGENT.md` for Zapdos says *"never hardcode `Dispatchers.X`; inject via qualifier."* Here there's nothing to inject: Dart is single-threaded with an event loop, and all I/O (dio, shared_preferences) is already asynchronous and non-blocking. You only reach for `Isolate`/`compute()` for genuinely CPU-bound work — parsing a very large JSON payload, image processing. Two endpoints of dummy data is not that.

**Parallel fetch**, since the home screen needs both endpoints:

```kotlin
// Zapdos
coroutineScope {
    val categories = async { getCategories() }
    val questions  = async { getQuestions() }
    HomeData(categories.await(), questions.await())
}
```

```dart
// Here
final (categories, questions) = await (_getCategories(), _getQuestions()).wait;
```

That record-`.wait` syntax is Dart 3 and gives you typed destructuring — nicer than `Future.wait` with its `List<dynamic>`.

### Event transformers — Bloc's answer to what `Flow` gives you free

In Kotlin you'd reach for `debounce`, `flatMapLatest`, or `conflate` on a `Flow`, and a re-`launch` in the same `Job` cancels the previous one. **Bloc has no such default — it processes events concurrently.** Tap retry five times and you get five in-flight requests racing to `emit`.

The fix is an event transformer, declared per handler:

```dart
import 'package:bloc_concurrency/bloc_concurrency.dart';

on<HomeRefreshRequested>(_onRefreshRequested, transformer: droppable());
on<SearchQueryChanged>(_onQueryChanged,       transformer: restartable());
on<HomeNextPageRequested>(_onNextPage,        transformer: throttleDroppable(_100ms));
```

| Kotlin `Flow` | `bloc_concurrency` | Meaning |
|---|---|---|
| `conflate` / job guard | `droppable()` | ignore new events while one is processing |
| `flatMapLatest` | `restartable()` | cancel the previous handler, start fresh |
| `flatMapConcat` | `sequential()` | queue, process in order |
| (default) `flatMapMerge` | `concurrent()` | Bloc's **default** — all at once |

`restartable()` stops the old handler's `emit`s from landing, but it **cannot cancel the underlying `Future`** — that limitation from earlier in this section still applies, so pair it with a dio `CancelToken` when the request is expensive.

Bloc's default being `concurrent()` is the trap. Kotlin's `viewModelScope` plus a `Job` reference makes accidental concurrency something you have to opt into; here it's what you get by not thinking about it.

---

## 17. Testing

| Zapdos | Here |
|---|---|
| JUnit + MockK + Kotest | `flutter_test` + `mocktail` |
| `coEvery { } returns` | `when(() => ...).thenAnswer(...)` |
| Turbine for Flow | `bloc_test` `expect:` |
| `` `descriptive backtick names` `` | `test('descriptive string', ...)` |
| Robolectric | `flutter_test` (already runs headless) |
| Espresso / Compose UI tests | `testWidgets` |
| Paparazzi / screenshot tests | golden tests (built in) |

The Bloc test:

```dart
blocTest<HomeBloc, HomeState>(
  'emits loading then questions when the fetch succeeds',
  setUp: () => when(() => getQuestions()).thenAnswer(
    (_) async => GetQuestionsResult.success([question]),
  ),
  build: () => HomeBloc(getQuestions),
  act: (bloc) => bloc.add(const HomeEvent.started()),
  expect: () => [
    HomeState.initial().copyWith(isLoading: true),
    HomeState.initial().copyWith(isLoading: false, questions: [question]),
  ],
);
```

`bloc_test` asserts the **whole sequence** of emitted states, which is stricter than the typical Android ViewModel test and catches missing intermediate loading states.

**Golden tests** are Flutter's real advantage and the closest thing to `@DayNightPreviews`. There's no live preview pane, but you get something better for CI: a committed PNG that fails the build when the UI drifts. Run each screen light and dark. Since the case grades pixel-perfection against Figma, this is a strong thing to have.

Caveat: goldens are font- and platform-sensitive. Generate them on one machine, or they'll fail spuriously on another.

---

## 18. Codegen — KSP → build_runner

The workflow difference is bigger than it sounds.

**KSP:** runs as part of `./gradlew build`. Output goes to `build/`, invisible, never committed. You basically never think about it.

**build_runner:** a **separate command you must remember to run**, and its output lands *next to your source* as `home_state.freezed.dart` and `category_dto.g.dart`, joined via `part` directives.

```bash
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs   # during active work
```

Things that will bite you at least once:

- **Edited a `@freezed` class and the errors make no sense?** You didn't rerun codegen.
- **`--delete-conflicting-outputs` is not optional in practice.** Without it, renames leave stale generated files that conflict.
- **Missing `part 'home_state.freezed.dart';`** produces a cascade of unrelated-looking errors.
- **Generated files are gitignored** in this project. That's the common Flutter convention, and it keeps the diff readable — but it means a reviewer cloning the repo must run `build_runner` before it compiles. Say so in the README's setup section. (Some teams commit them for exactly that reason; either is defensible, just be deliberate.)

---

## 19. Quick Kotlin → Dart syntax notes

| Kotlin | Dart |
|---|---|
| `val` / `var` | `final` / `var` |
| `const val` (compile-time) | `const` |
| `String?` | `String?` (same) |
| `?.` | `?.` (same) |
| `?:` | `??` |
| `!!` | `!` |
| `when (x) { }` as expression | `switch (x) { }` as expression |
| `is Foo ->` | `case Foo():` |
| `data class` destructuring | records + patterns: `final (a, b) = pair;` |
| `listOf().map { }` | `list.map(...).toList()` — **`.toList()` is required**, `map` is lazy |
| `filter { }` | `.where(...)` |
| `firstOrNull { }` | `.firstWhereOrNull(...)` (needs `collection` package) |
| extension functions | extensions (same idea, must be in an `extension` block) |
| `object` singleton | `static` members, or a `@singleton` in DI |
| `internal` | library-private via `_` prefix, or `src/` + exports |
| trailing lambda `foo { }` | no equivalent — always `foo(() { })` |
| named args optional | named args opt-in per parameter, and `required` is explicit |

The two that cause the most real bugs: **`map` is lazy in Dart** (forget `.toList()` and it silently never runs), and **`_` is the only privacy mechanism** — and it's *library*-private, not class-private, so anything in the same file can see it.

---

## 20. How this differs from the popular reference repo

You'll be asked, or you'll want to raise it: [`guilherme-v/flutter-clean-architecture-example`](https://github.com/guilherme-v/flutter-clean-architecture-example) (~875★) is the most-starred Flutter clean architecture example. We diverge from it in four ways, deliberately.

**Understand what it is first:** its `lib/layers/presentation/` holds *six parallel implementations of the same two screens* — `using_bloc/`, `using_cubit/`, `using_get_it/`, `using_mobx/`, `using_provider/`, `using_riverpod/`. It's a state-management **comparison**, not a project template. Its shape follows from that.

| | That repo | Here | Why |
|---|---|---|---|
| Folders | layer-first (`lib/layers/{domain,data,presentation}`) | feature-first | The case explicitly asks for feature-first. Layer-first is fine for its single "character" feature and stops scaling past a few. |
| Models | `equatable` + hand-written `fromJson` | `freezed` + `json_serializable` | The case names both packages. That repo runs `build_runner` only for MobX. |
| Errors | **none at all** | interceptor → typed exception → sealed result | Its `CharacterRepositoryImpl` and `CharacterPageBloc` contain no `try`/`catch`, and `lib/` has no failure or exception type anywhere. |
| Routing | plain `Navigator` | `auto_route` | The case names `auto_route`. |

The error-handling gap is the striking one, and it's the general lesson: **stars track pedagogical clarity, not production completeness.** Error handling is precisely what a teaching repo strips out to keep the happy path readable. Never adopt a reference architecture without checking what it chose not to show you.

What we took *from* it: `bloc_concurrency` event transformers (§16), and its test tree mirroring `lib/` one-for-one including tests of the state classes themselves.

---

## 21. Checklist before you call it done

- [ ] `dart run build_runner build --delete-conflicting-outputs` clean
- [ ] `flutter analyze` zero issues
- [ ] `dart format --set-exit-if-changed lib test` clean
- [ ] `flutter test` green, goldens included
- [ ] No `import` from `presentation/` into `data/` (grep it)
- [ ] No `package:flutter` import anywhere under `domain/` (grep it)
- [ ] No literal `Color(` or bare numeric `EdgeInsets`/`SizedBox` outside `core/theme/`
- [ ] No hardcoded user-facing string outside `lib/l10n/`
- [ ] Both flows walked by hand in light **and** dark
- [ ] Onboarding does not re-appear after completing it and restarting the app
- [ ] Airplane mode on the home screen shows the error state, and retry recovers
