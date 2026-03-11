import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';

class LayoutNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const LayoutNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: MyColors.grey1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          spacing: 12,
          children: [
            Expanded(
              child: _NavItem(
                title: 'Matches',
                onTap: onTap,
                index: 0,
                current: currentIndex,
                icon: 'assets/images/icons/navbar/football.png',
              ),
            ),
            Expanded(
              child: _NavItem(
                title: 'My Picks',
                onTap: onTap,
                index: 1,
                current: currentIndex,
                icon: 'assets/images/icons/navbar/picks.png',
              ),
            ),
            Expanded(
              child: _NavItem(
                title: 'Academy',
                onTap: onTap,
                index: 2,
                current: currentIndex,
                icon: 'assets/images/icons/navbar/academy.png',
              ),
            ),
            Expanded(
              child: _NavItem(
                title: 'Insights',
                onTap: onTap,
                index: 3,
                current: currentIndex,
                icon: 'assets/images/icons/navbar/chart.png',
              ),
            ),
            Expanded(
              child: _NavItem(
                title: 'Settings',
                onTap: onTap,
                index: 4,
                current: currentIndex,
                icon: 'assets/images/icons/navbar/settings.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final String title;
  final int current;
  final String icon;
  final ValueChanged<int> onTap;
  const _NavItem({
    required this.onTap,
    required this.index,
    required this.current,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    var isActive = index == current;
    return InkWell(
      onTap: () => onTap(index),
      child: SizedBox(
        child: Opacity(
          opacity: isActive ? 1.0 : 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isActive
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        MyColors.yellow,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(icon, width: 24, height: 24),
                    )
                  : Image.asset(icon, width: 24, height: 24),
              const SizedBox(height: 5),
              Text(title, style: MyStyles.medium),
            ],
          ),
        ),
      ),
    );
  }
}
