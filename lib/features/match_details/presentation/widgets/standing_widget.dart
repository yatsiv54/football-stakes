import 'package:flutter/material.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/matches/data/entities/match/match_entity.dart';

class StandingWidget extends StatelessWidget {
  final MatchEntity match;
  const StandingWidget({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: _TeamCol(
              title: match.homeTeam.name,
              logo: match.homeTeam.logo,
            ),
          ),
          Expanded(child: _buildCenter()),
          Expanded(
            child: _TeamCol(
              title: match.awayTeam.name,
              logo: match.awayTeam.logo,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenter() {
    if (_isLive(match.status)) {
      return _LiveCol(match: match);
    }

    if (_isFinished(match.status)) {
      return _FinishedCol(match: match);
    }

    return _UpcomingCol(match: match);
  }
}

class _TeamCol extends StatelessWidget {
  final String title;
  final String logo;
  const _TeamCol({required this.title, required this.logo});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: logo == '' ? SizedBox() : Image.network(logo),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: MyStyles.h1,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _UpcomingCol extends StatelessWidget {
  final MatchEntity match;
  const _UpcomingCol({required this.match});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(opacity: 0.6, child: Text('Upcoming', style: MyStyles.body)),
        Text('— : —', style: MyStyles.h2),
        Opacity(opacity: 0.6, child: Text(match.time, style: MyStyles.body)),
      ],
    );
  }
}

class _LiveCol extends StatelessWidget {
  final MatchEntity match;
  const _LiveCol({required this.match});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Text('LIVE', style: MyStyles.body.copyWith(color: MyColors.red)),
        Text('${match.score.home} : ${match.score.away}', style: MyStyles.h2),
        Opacity(
          opacity: 0.6,
          child: Text(
            RegExp(r'^\d').hasMatch(match.status)
                ? "${match.status}'"
                : match.status,
            style: MyStyles.body,
          ),
        ),
      ],
    );
  }
}

class _FinishedCol extends StatelessWidget {
  final MatchEntity match;
  const _FinishedCol({required this.match});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Text('FT', style: MyStyles.body.copyWith(color: MyColors.yellow)),
        Text('${match.score.home} : ${match.score.away}', style: MyStyles.h2),
      ],
    );
  }
}

bool _isLive(String status) {
  if (['Half Time', 'HT', 'Break', 'Penalty In Progress'].contains(status)) {
    return true;
  }
  return RegExp(r'^\d+(\+\d+)?$').hasMatch(status);
}

bool _isFinished(String status) {
  return status == 'Finished' ||
      status == 'FT' ||
      status == 'AET' ||
      status == 'PEN';
}
