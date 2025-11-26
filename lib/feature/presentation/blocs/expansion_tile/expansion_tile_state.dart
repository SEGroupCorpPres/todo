part of 'expansion_tile_cubit.dart';

class ExpansionTileState extends Equatable {
  final bool isExpandedTobeCompleted;
  final bool isExpandedInWork;
  final bool isExpandedUnderReview;
  final bool isExpandedDone;

  const ExpansionTileState({
    this.isExpandedTobeCompleted = false,
    this.isExpandedInWork = false,
    this.isExpandedUnderReview = false,
    this.isExpandedDone = false,
  });

  ExpansionTileState copyWith({
    bool? isExpandedTobeCompleted,
    bool? isExpandedInWork,
    bool? isExpandedUnderReview,
    bool? isExpandedDone,
  }) {
    return ExpansionTileState(
      isExpandedTobeCompleted: isExpandedTobeCompleted ?? this.isExpandedTobeCompleted,
      isExpandedInWork: isExpandedInWork ?? this.isExpandedInWork,
      isExpandedUnderReview: isExpandedUnderReview ?? this.isExpandedUnderReview,
      isExpandedDone: isExpandedDone ?? this.isExpandedDone,
    );
  }

  @override
  List<Object> get props => [
    isExpandedTobeCompleted,
    isExpandedInWork,
    isExpandedUnderReview,
    isExpandedDone,
  ];
}
