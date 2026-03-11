import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';

class AcademyCard extends StatelessWidget {
  final VoidCallback onTap;
  final String img;
  final String title;
  const AcademyCard({
    super.key,
    required this.img,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                img,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => Container(color: MyColors.grey2),
              ),
            ),

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.4, 1.0],
                    colors: [Colors.transparent, Colors.black],
                  ).createShader(rect);
                },
                blendMode: BlendMode.dstIn,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Image.asset(img, fit: BoxFit.cover),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 16,
              left: 12,
              right: 12,
              child: Text(title, style: MyStyles.bodyBold),
            ),
          ],
        ),
      ),
    );
  }
}
