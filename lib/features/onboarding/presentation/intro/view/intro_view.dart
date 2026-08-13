import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/bloc/intro_bloc.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/widgets/intro_headline.dart';
import 'package:hubx_flutter_case/features/onboarding/presentation/intro/widgets/intro_hero.dart';
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
                    _IntroPageBody(content: pages[index], isFirst: index == 0),
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
      body: l10n.onboardingWelcomeBody,
      cta: l10n.onboardingWelcomeCta,
      legal: l10n.onboardingWelcomeLegal,
      icon: Icons.eco_rounded,
    ),
    _IntroPageContent(
      title: l10n.onboardingIdentifyTitle,
      highlight: l10n.onboardingIdentifyHighlight,
      cta: l10n.onboardingIdentifyCta,
      icon: Icons.center_focus_strong_rounded,
    ),
    _IntroPageContent(
      title: l10n.onboardingDiagnoseTitle,
      highlight: l10n.onboardingDiagnoseHighlight,
      cta: l10n.onboardingDiagnoseCta,
      icon: Icons.menu_book_rounded,
    ),
  ];
}

/// One intro page: artwork on top, copy underneath.
class _IntroPageBody extends StatelessWidget {
  const _IntroPageBody({required this.content, required this.isFirst});

  final _IntroPageContent content;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final dimens = context.appDimens;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Copy keeps a fixed share of the page so the artwork absorbs the
        // difference between a short and a tall device.
        final int heroFlex = constraints.maxHeight > 640 ? 6 : 5;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: heroFlex,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isFirst ? 0 : dimens.pageGutter,
                ),
                child: IntroHero(icon: content.icon, isRounded: !isFirst),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: dimens.pageGutter),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: dimens.spaceXl),
                    IntroHeadline(
                      text: content.title,
                      highlight: content.highlight,
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
            ),
          ],
        );
      },
    );
  }
}

/// Immutable copy bundle for one intro page.
@immutable
class _IntroPageContent {
  const _IntroPageContent({
    required this.title,
    required this.cta,
    required this.icon,
    this.highlight,
    this.body,
    this.legal,
  });

  final String title;
  final String cta;
  final IconData icon;
  final String? highlight;
  final String? body;
  final String? legal;
}
