# PlantApp — HUBX Flutter Case

A Flutter implementation of the HUBX developer case: an **onboarding flow**
that ends at a paywall, and a **home flow** driven by two live endpoints.
Bloc for state, Clean Architecture per feature, `dio` + `freezed` +
`json_serializable` for the network layer, `auto_route` for navigation and
`get_it`/`injectable` for the object graph.

## Running it

```bash
flutter pub get
dart run build_runner build
flutter run
```

Codegen (`freezed`, `json_serializable`, `injectable`, `auto_route`) must run
before the first build, and again after any change to an annotated class.

```bash
flutter analyze                # zero issues expected
dart format --set-exit-if-changed lib test
flutter test                   # 164 tests
```

## What the app does

**Onboarding** — three intro pages, then the paywall. Tapping the paywall's
close button is what ends onboarding, per the brief: the completion flag is
persisted and the router replaces the stack with home. A user who completes
the flow never sees it again, on this launch or any later one.

**Home** — a header band carrying the greeting, the search field and the two
painted leaves tucked behind it, a premium strip, a horizontal carousel from
`getQuestions`, a categories grid from `getCategories`, and the design's
bottom bar. Pull to refresh; search filters the grid live.

## Matching the design

The artwork is the Figma file's own image fills rather than lookalikes, each
cropped to its subject so a centred fit lands where the design puts it. The
three care badges ship in the file as one green master that it tints per
placement; they are vendored already tinted.

Type is **Rubik**, bundled under `assets/fonts` so it renders identically on
both platforms instead of falling back to SF Pro or Roboto.

The icons are the design's own exports, in `assets/icons` — none of them
exist in Material's set, and approximating them by eye is what made the
bottom bar and the paywall's feature strip read wrong. All but the premium
strip's envelope are single-colour masters, so `core/icons/app_icons.dart`
tints them from the theme. The paywall's three feature marks are whole tiles
— ground and glyph together — rather than a glyph on a box of our own; the
third one's own export is corrupt in the file, so it is composed from the
design's tile ground and the design's leaf. They ship at 1x for the file's
360dp frame, so re-exporting at 3x is a straight file swap if they need to be
sharper.

The viewfinder over the welcome plant and the phone's camera preview is still
drawn (`shared/widgets/scan_frame.dart`): the design stretches the same mark
to a different aspect on each screen, which a bitmap cannot follow without
distorting its own stroke weight.

## Layout

```
assets/images/    artwork from the design file's own image fills
assets/icons/     icons exported from the design file
assets/fonts/     Rubik, the design's typeface
lib/
  app/            composition root — router, guards, DI, root widget
  core/           theme, network, storage, l10n, asset paths
  shared/widgets/ reusable widgets, primitives-only APIs
  features/
    onboarding/   domain / data / presentation — intro AND paywall
    home/         domain / data / presentation
test/             mirrors lib/
```

`domain/` is pure Dart with no Flutter import. `presentation/` depends on
`domain/` and never on `data/`. Features never import each other; anything
cross-cutting is wired in `app/`.

## Deliberate trade-offs

These are the places where the project diverges from the most common Flutter
idiom. Each was a choice, not an oversight.

**Per-operation sealed result unions, not `Either<Failure, T>`.** Each
operation defines its own union — `GetCategoriesResult` has `success`,
`network`, `server(statusCode)`, `parse` and `unknown`. Callers consume it
with an exhaustive `switch` and no `default:`, so adding a failure mode later
is a compile error at every call site rather than a silent fall-through. A
generic `Either` is more reusable but pushes error semantics into a `Failure`
hierarchy that every caller has to re-interpret; `dartz`/`fpdart` would also
add a functional vocabulary the rest of the codebase does not use.

**Flat state fields, not a `Loading | Success | Error` union.** `HomeState`
carries `isLoading`, `questions`, `categories` and two nullable failure
fields at once. A sealed UI-state union cannot express "showing cached
categories while refreshing, with the articles endpoint down" — which is
exactly what home does. Derived questions (`visibleCategories`,
`showsQuestionsError`) are getters on the state, so they are unit-tested
without pumping a widget tree.

**Two failure fields, not one.** The two home endpoints fail independently. A
dead `getCategories` still leaves the articles carousel usable, and each
section offers its own retry.

**Every I/O event declares a concurrency transformer.** Bloc processes events
concurrently by default, so a mashed retry button fans out into N requests.
Refresh and submit are `droppable()`, search is `restartable()` behind a
debounce, page changes are `sequential()`. The tests that cover this
deliberately use slow stubs — an instantly-completing mock never overlaps
with anything, so `droppable` would have nothing to drop and the test would
pass for the wrong reason.

**A JSON-decoding interceptor.** Both endpoints return JSON under
`content-type: text/plain`, so Dio leaves the body as a raw `String`.
`JsonDecodeInterceptor` decodes it before anything else sees it, keeping the
server's quirk in one file instead of in every data source.

**Failing open on persistence.** If the onboarding flag cannot be read, the
guard shows onboarding; if it cannot be written, the paywall still lets the
user through and surfaces a snackbar. Repeating onboarding is a milder
failure than locking someone out of the app.

**The paywall lives inside `features/onboarding/`, not beside it.** It is a
page in the onboarding flow — it completes onboarding and needs its use
cases. Making it a sibling feature would force one feature to import
another's domain, which is the signal that the boundary was drawn at a screen
instead of at a functional requirement.

**No hardcoded colours, spacing or strings.** Colours, spacing and text
styles come from three `ThemeExtension`s (`AppColors`, `AppDimens`,
`AppTypography`) reached through `context.appColors` / `.appDimens` /
`.appText`; user-facing text comes from generated localisations; image paths
come from `AppAssets`. `AppDimens` switches to a tighter scale below a 700dp
viewport so onboarding still fits on a small phone.

**Artwork composed in fractions, not fixed offsets.** The pieces that make up
an illustration — the welcome badges, the phone mockups, the header plant —
are placed and sized as fractions of the box they are given, and clipped
where the design cuts them off. A design measured at 360×800 then holds its
proportions on a 402pt phone or a tablet instead of drifting apart.

## Artwork

The illustrations in `assets/images/` are exported from the case's Figma
file, which reads without an account. Paths live in `AppAssets` so no widget
holds a string literal. Figma serves these capped at about 512px on the
longest edge — enough for 1x and 2x at the sizes they are drawn, slightly
soft for the largest of them on a 3x screen.

One piece is drawn rather than exported: the viewfinder in
`shared/widgets/scan_frame.dart`, because the design stretches the same mark
to a different aspect on each screen. Everything else — including the three
care badges on the welcome screen and the paywall's three feature tiles — is
the design file's own export, vendored under `assets/images` and
`assets/icons`.

## Known gaps

**Tab bar.** The home design's five destinations are all present, but only
Home has a screen in this case. Diagnose, My Garden and Profile render and
are marked disabled for a screen reader rather than posing as buttons that
silently do nothing; Home is marked current, and the raised scan control is
the bar's one live affordance. A widget test holds all three claims.

**Home content taps.** The article cards and the category tiles carry an
`onTap` that is still empty — the case defines no destination for either.
Unlike the tab bar, they are not marked disabled, so they ripple and do
nothing. `Question.articleUrl` is fetched and mapped ready for the article
cards to open it. The premium strip does navigate: it pushes the paywall over
home, so closing it pops back with home's state intact.

## Testing

164 tests. Unit and Bloc level: DTO→entity mappers (null collapsing,
rank/order sorting), repository impls (one test per result branch), use
cases, `bloc_test` suites for `HomeBloc`, `PaywallBloc` and `IntroBloc`
including concurrency behaviour, State getters, and the two interceptors'
translation rules.

Widget level: each screen's `*View`, pumped over a mocked Bloc through
`test/helpers/pump_app.dart`, which supplies the theme extensions, the
localisations and a configurable viewport. `HomeView` covers the loader, the
loaded grid and carousel, each failure path separately — a dead
`getCategories` still leaves the carousel usable — search, and
pull-to-refresh. `IntroView` covers the per-page copy, artwork and dots, and
both ways of advancing. `PaywallView` covers the plan tiles, selection, the
close control and the CTA's disabled states. Below that, the shared widgets
and `HomeBottomBar`, whose test asserts through the semantics tree that the
dead destinations are announced as disabled.

Two things are deliberately not covered. Navigation: it lives in the `*Page`
route entries, which need DI and a router, and the state transitions that
trigger it are already asserted in the Bloc suites. And goldens: they would
pin down rendering that varies by machine without defending anything the
design work does not already state.
