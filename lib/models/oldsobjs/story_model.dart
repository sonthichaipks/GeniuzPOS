import 'package:com_csith_geniuzpos/models/persons/user_model.dart';
import 'package:meta/meta.dart';

class Story {
  final User user;
  final String imageUrl;
  final bool isViewed;

  const Story({
    @required this.user,
    this.imageUrl = "",
    this.isViewed = false,
  });
}
