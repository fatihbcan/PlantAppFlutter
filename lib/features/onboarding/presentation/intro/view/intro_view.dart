import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/bloc/intro_bloc.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/widgets/intro_artwork.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/widgets/intro_headline.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/widgets/intro_page_dots.dart';
import 'package:hubx_flutter_case/l10n/gen/app_localizations.dart';
import 'package:hubx_flutter_case/shared/widgets/app_primary_button.dart';

/// The swipeable intro pages plus the persistent CTA below them.
class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  // A PageController is a view concern: it holds no business state, only the
  // scroll position the Bloc's page index is mirrored onto.
  late final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _syncController(int pageIndex) {
    if (!_controller.hasClients) return;
    final int current = _controller.page?.round() ?? _controller.initialPage;
    if (current == pageIndex) return;
    _controller.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppL10n l10n = AppL10n.of(context);
    final dimens = context.appDimens;
    final List<_IntroPageContent> pages = _pagesFor(l10n);

    return BlocConsumer<IntroBloc, IntroState>(
      listenWhen: (IntroState previous, IntroState current) =>
          previous.pageIndex != current.pageIndex,
      listener: (BuildContext context, IntroState state) =>
          _syncController(state.pageIndex),
      builder: (BuildContext context, IntroState state) {
        final _IntroPageContent page = pages[state.pageIndex];

        return Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (int index) =>
                    context.read<IntroBloc>().add(IntroEvent.pageSwiped(index)),
                itemBuilder: (BuildContext context, int index) =>
                    _IntroPageBody(content: pages[index]),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                dimens.pageGutter,
                dimens.spaceLg,
                dimens.pageGutter,
                dimens.spaceSm,
              ),
              child: AppPrimaryButton(
                label: page.cta,
                onPressed: () => context.read<IntroBloc>().add(
                  const IntroEvent.nextPressed(),
                ),
              ),
            ),
            if (page.legal != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: dimens.spaceXxl),
                child: Text(
                  page.legal!,
                  textAlign: TextAlign.center,
                  style: context.appText.caption.copyWith(
                    color: context.appColors.onCanvasSubtle,
                  ),
                ),
              ),
            SizedBox(height: dimens.spaceLg),
            if (state.showsPageIndicator)
              IntroPageDots(
                count: state.pageCount,
                activeIndex: state.pageIndex,
                semanticsLabel: l10n.onboardingPageIndicator(
                  state.humanPageNumber,
                  state.pageCount,
                ),
              ),
            SizedBox(
              height: dimens.spaceLg + MediaQuery.paddingOf(context).bottom,
            ),
          ],
        );
      },
    );
  }

  List<_IntroPageContent> _pagesFor(AppL10n l10n) => <_IntroPageContent>[
    _IntroPageContent(
      title: l10n.onboardingWelcomeTitle(l10n.appTitle),
      highlight: l10n.appTitle,
      underlinesHighlight: false,
      body: l10n.onboardingWelcomeBody,
      cta: l10n.onboardingWelcomeCta,
      legal: l10n.onboardingWelcomeLegal,
      artwork: IntroArtwork.welcome,
    ),
    _IntroPageContent(
      title: l10n.onboardingIdentifyTitle,
      highlight: l10n.onboardingIdentifyHighlight,
      cta: l10n.onboardingIdentifyCta,
      artwork: IntroArtwork.identify,
    ),
    _IntroPageContent(
      title: l10n.onboardingDiagnoseTitle,
      highlight: l10n.onboardingDiagnoseHighlight,
      cta: l10n.onboardingDiagnoseCta,
      artwork: IntroArtwork.careGuides,
    ),
  ];
}

/// One intro page: copy on top, artwork filling what is left below it.
///
/// The copy takes its natural height and the artwork absorbs the rest, which
/// is what keeps the headline pinned near the top of a tall screen instead of
/// floating down with the illustration.
class _IntroPageBody extends StatelessWidget {
  const _IntroPageBody({required this.content});

  final _IntroPageContent content;

  @override
  Widget build(BuildContext context) {
    final dimens = context.appDimens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(
            dimens.pageGutter,
            dimens.spaceXl,
            dimens.pageGutter,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IntroHeadline(
                text: content.title,
                highlight: content.highlight,
                isHighlightUnderlined: content.underlinesHighlight,
              ),
              if (content.body != null) ...<Widget>[
                SizedBox(height: dimens.spaceMd),
                Text(
                  content.body!,
                  style: context.appText.bodyMd.copyWith(
                    color: context.appColors.onCanvasMuted,
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: dimens.spaceLg),
        Expanded(child: IntroArtworkView(artwork: content.artwork)),
      ],
    );
  }
}

/// Immutable copy bundle for one intro page.
@immutable
class _IntroPageContent {
  const _IntroPageContent({
    required this.title,
    required this.cta,
    required this.artwork,
    this.highlight,
    this.underlinesHighlight = true,
    this.body,
    this.legal,
  });

  final String title;
  final String cta;
  final IntroArtwork artwork;
  final String? highlight;

  /// The welcome page emphasises the product name with weight only; the two
  /// onboarding pages draw the stroke as well.
  final bool underlinesHighlight;
  final String? body;
  final String? legal;
}
