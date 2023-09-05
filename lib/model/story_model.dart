import 'package:chatapp/model/models.dart';

class Story {
  final User user;
  final String imageUrl;
  final bool isViewed;

  Story(this.user, this.imageUrl, this.isViewed );
}
