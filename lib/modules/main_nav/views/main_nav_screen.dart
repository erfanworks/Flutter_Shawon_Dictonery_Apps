import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/theme/theme_rebuild.dart';
import '../../../constant/const_string.dart';
import '../../favorites/views/favorites_screen.dart';
import '../../history/views/history_screen.dart';
import '../../home_search/views/home_search_screen.dart';
import '../../settings/views/settings_screen.dart';
import '../../../widget/dictionary/squiggle_underline.dart';
import '../controllers/navbar_controller.dart';

class _TabDef {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _TabDef({required this.icon, required this.activeIcon, required this.label});
}

class MainNavScreen extends GetView<NavbarController> {
  const MainNavScreen({super.key});

  static const _tabs = [
    _TabDef(icon: Icons.search_rounded, activeIcon: Icons.search_rounded, label: 'Search'),
    _TabDef(icon: Icons.star_outline_rounded, activeIcon: Icons.star_rounded, label: ConstString.favoritesTitle),
    _TabDef(icon: Icons.history_rounded, activeIcon: Icons.history_rounded, label: ConstString.historyTitle),
    _TabDef(icon: Icons.settings_outlined, activeIcon: Icons.settings_rounded, label: ConstString.settingsTitle),
  ];

  @override
  Widget build(BuildContext context) {
    return ThemeRebuild(
      builder: (context) {
        final colors = AppColors.of(context);

        return Scaffold(
          backgroundColor: colors.bgPaper,
          // Theme revision is in the Obx deps so every tab re-reads AppColors.
          body: Obx(() {
            final index = controller.currentIndex.value;
            final rev = Get.find<ThemeController>().revision.value;
            return IndexedStack(
              index: index,
              children: [
                KeyedSubtree(
                  key: ValueKey('tab-search-$rev'),
                  child: const HomeSearchScreen(),
                ),
                KeyedSubtree(
                  key: ValueKey('tab-favorites-$rev'),
                  child: const FavoritesScreen(),
                ),
                KeyedSubtree(
                  key: ValueKey('tab-history-$rev'),
                  child: const HistoryScreen(),
                ),
                KeyedSubtree(
                  key: ValueKey('tab-settings-$rev'),
                  child: const SettingsScreen(),
                ),
              ],
            );
          }),
          bottomNavigationBar: Obx(() {
            final index = controller.currentIndex.value;
            Get.find<ThemeController>().revision.value;
            final barColors = AppColors.of(context);
            return Container(
              decoration: BoxDecoration(
                color: barColors.bgPaperRaised,
                border: Border(top: BorderSide(color: barColors.ink100, width: 1)),
              ),
              child: SafeArea(
                child: SizedBox(
                  height: 60.h,
                  child: Row(
                    children: List.generate(_tabs.length, (i) {
                      final active = index == i;
                      final tab = _tabs[i];
                      return Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => controller.changeTab(i),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 8.h,
                                child: active
                                    ? SquiggleUnderline(width: 14, strokeWidth: 2, color: barColors.marigold)
                                    : null,
                              ),
                              Icon(
                                active ? tab.activeIcon : tab.icon,
                                size: 22.sp,
                                color: active ? barColors.marigold : barColors.ink500,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                tab.label,
                                style: AppTypography.labelSm(
                                  color: active ? barColors.marigold : barColors.ink500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
