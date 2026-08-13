import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hubx_flutter_case/core/theme/theme_extensions.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/category.dart';
import 'package:hubx_flutter_case/features/home/domain/entity/question.dart';
import 'package:hubx_flutter_case/features/home/presentation/bloc/home_bloc.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/category_tile.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/home_premium_banner.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/home_search_field.dart';
import 'package:hubx_flutter_case/features/home/presentation/widgets/question_card.dart';
import 'package:hubx_flutter_case/l10n/gen/app_localizations.dart';
import 'package:hubx_flutter_case/shared/widgets/app_error_view.dart';
import 'package:hubx_flutter_case/shared/widgets/app_loader.dart';

/// Home layout: greeting, search, premium banner, article carousel and the
/// categories grid, all inside one scroll view.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppL10n l10n = AppL10n.of(context);
    final dimens = context.appDimens;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        if (state.isInitialLoading) return const AppLoader();

        return RefreshIndicator(
          color: context.appColors.brand,
          onRefresh: () async =>
              context.read<HomeBloc>().add(const HomeEvent.refreshRequested()),
          child: CustomScrollView(
            // Always scrollable so pull-to-refresh works even when a failed
            // load leaves the page shorter than the viewport.
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: <Widget>[
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  dimens.pageGutter,
                  dimens.spaceLg,
                  dimens.pageGutter,
                  dimens.spaceLg,
                ),
                sliver: SliverToBoxAdapter(child: _Header(l10n: l10n)),
              ),
              if (state.showsQuestions)
                SliverToBoxAdapter(child: _QuestionsSection(state: state)),
              if (state.showsQuestionsError)
                SliverToBoxAdapter(
                  child: AppErrorView(
                    message: l10n.homeQuestionsError,
                    retryLabel: l10n.commonRetry,
                    isCompact: true,
                    onRetry: () => context.read<HomeBloc>().add(
                      const HomeEvent.refreshRequested(),
                    ),
                  ),
                ),
              _CategoriesSection(state: state, l10n: l10n),
              SliverToBoxAdapter(
                child: SizedBox(
                  height:
                      dimens.spaceXxl + MediaQuery.paddingOf(context).bottom,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.l10n});

  final AppL10n l10n;

  @override
  Widget build(BuildContext context) {
    final dimens = context.appDimens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          l10n.homeGreeting,
          style: context.appText.titleLg.copyWith(
            color: context.appColors.onCanvas,
          ),
        ),
        SizedBox(height: dimens.spaceXxs),
        Text(
          l10n.homeQuestion,
          style: context.appText.bodyMd.copyWith(
            color: context.appColors.onCanvasMuted,
          ),
        ),
        SizedBox(height: dimens.spaceLg),
        HomeSearchField(
          hintText: l10n.homeSearchHint,
          onChanged: (String query) =>
              context.read<HomeBloc>().add(HomeEvent.searchChanged(query)),
          onCleared: () =>
              context.read<HomeBloc>().add(const HomeEvent.searchCleared()),
        ),
        SizedBox(height: dimens.spaceLg),
        HomePremiumBanner(
          title: l10n.homePremiumBannerTitle,
          body: l10n.homePremiumBannerBody,
          onTap: () {},
        ),
      ],
    );
  }
}

class _QuestionsSection extends StatelessWidget {
  const _QuestionsSection({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final dimens = context.appDimens;
    final AppL10n l10n = AppL10n.of(context);
    // Cards show a sliver of the next one, which signals horizontal scroll
    // without needing an affordance.
    final double cardWidth = MediaQuery.sizeOf(context).width * 0.62;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: dimens.pageGutter),
          child: Text(
            l10n.homeGetStartedTitle,
            style: context.appText.titleMd.copyWith(
              color: context.appColors.onCanvas,
            ),
          ),
        ),
        SizedBox(height: dimens.spaceMd),
        SizedBox(
          height: cardWidth * 0.82,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: dimens.pageGutter),
            itemCount: state.questions.length,
            separatorBuilder: (_, _) => SizedBox(width: dimens.spaceMd),
            itemBuilder: (BuildContext context, int index) {
              final Question question = state.questions[index];
              return QuestionCard(
                title: question.title,
                imageUrl: question.imageUrl,
                width: cardWidth,
                onTap: () {},
              );
            },
          ),
        ),
        SizedBox(height: dimens.spaceXl),
      ],
    );
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection({required this.state, required this.l10n});

  final HomeState state;
  final AppL10n l10n;

  @override
  Widget build(BuildContext context) {
    final dimens = context.appDimens;

    if (state.showsCategoriesError) {
      return SliverToBoxAdapter(
        child: AppErrorView(
          message: l10n.homeCategoriesError,
          retryLabel: l10n.commonRetry,
          onRetry: () =>
              context.read<HomeBloc>().add(const HomeEvent.refreshRequested()),
        ),
      );
    }

    if (state.hasNoSearchResults) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(dimens.pageGutter),
          child: Text(
            l10n.homeSearchEmpty(state.query),
            textAlign: TextAlign.center,
            style: context.appText.bodyMd.copyWith(
              color: context.appColors.onCanvasMuted,
            ),
          ),
        ),
      );
    }

    final List<Category> categories = state.visibleCategories;

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: dimens.pageGutter),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // Two columns on a phone, more once there is room for them.
          crossAxisCount: MediaQuery.sizeOf(context).width > 600 ? 3 : 2,
          mainAxisSpacing: dimens.spaceMd,
          crossAxisSpacing: dimens.spaceMd,
          childAspectRatio: 1.4,
        ),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final Category category = categories[index];
          return CategoryTile(
            title: category.title,
            imageUrl: category.imageUrl,
            semanticsLabel: l10n.homeCategoryItemSemantics(category.title),
            onTap: () {},
          );
        },
      ),
    );
  }
}
