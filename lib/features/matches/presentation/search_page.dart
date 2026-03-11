import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football/core/theme/colors.dart';
import 'package:football/core/theme/text_styles.dart';
import 'package:football/features/matches/presentation/cubit/matches_cubit.dart';
import 'package:football/features/matches/presentation/widgets/match_card.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MatchesCubit>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: MyColors.grey1,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 24,
                          child: Image.asset('assets/images/icons/search.png'),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            autofocus: true,
                            style: MyStyles.body,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: MyStyles.body,
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: cubit.search,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    cubit.search('');
                    context.pop();
                  },
                  child: Text(
                    'Cancel',
                    style: MyStyles.bodyBold.copyWith(color: MyColors.yellow),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<MatchesCubit, MatchesCubitState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    matchesLoaded: (_, filteredMatches) {
                      if (filteredMatches.isEmpty) {
                        return const Center(child: Text('Nothing found'));
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: filteredMatches.length,
                        itemBuilder: (context, index) {
                          return MatchCard(match: filteredMatches[index]);
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16),
                      );
                    },
                    orElse: () => const SizedBox(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
