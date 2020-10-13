import 'package:easy_localization/easy_localization.dart';
import 'package:cubit/cubit.dart';
import '../../stories/FeedModel.dart';
import './protests_state.dart';

class ProtestsCubit extends Cubit<ProtestsState> {
  ProtestsCubit() : super(InitialState()) {
    getNextProtest();
  }

  final protests = 6;
  static int which = -1;

  fn(string) {
    return string == null || string.startsWith("STORY_")? '' : string;
  }

  void getNextProtest() async {
    try {
      emit(LoadingState());
      which = (which + 1) % this.protests;
      var f = NumberFormat("00", "en_US");
      var index = f.format(which);
      var title = 'STORY_TITLE_' + index;
      var summary = 'STORY_SUMMARY_' + index;
      var body = 'STORY_' + index;
      var date = 'STORY_DATE_' + index;
      var credit = 'STORY_CREDIT_' + index;
      var image = 'STORY_IMAGE_' + index;
      var postURL = 'STORY_URL_' + index;
      var referenceURL = 'STORY_URL_' + index;
      final protest = FeedModel(
          date: fn(date.tr()),
          title: fn(title.tr()),
          summary: fn(summary.tr()),
          body: fn(body.tr()),
          credit: fn(credit.tr()),
          imageURL: fn(image.tr()),
          referenceURL: fn(referenceURL.tr()),
          postURL: fn(postURL.tr()),
          isHTML: false,);
      emit(LoadedState(protest));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
