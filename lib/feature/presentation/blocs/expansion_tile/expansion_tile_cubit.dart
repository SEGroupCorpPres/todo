import 'package:todo/core/core.dart';

part 'expansion_tile_state.dart';

class ExpansionTileCubit extends Cubit<ExpansionTileState> {
  ExpansionTileCubit() : super(const ExpansionTileState());

  void toggleTobeCompleted() {
    emit(state.copyWith(isExpandedTobeCompleted: !state.isExpandedTobeCompleted));
  }

  void toggleInWork() {
    emit(state.copyWith(isExpandedInWork: !state.isExpandedInWork));
  }

  void toggleUnderReview() {
    emit(state.copyWith(isExpandedUnderReview: !state.isExpandedUnderReview));
  }

  void toggleDone() {
    emit(state.copyWith(isExpandedDone: !state.isExpandedDone));
  }
}
