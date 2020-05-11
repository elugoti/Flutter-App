class ReviewsResponse {
  int reviewsCount;
  int reviewsStart;
  int reviewsShown;
  List<UserReviews> userReviews;

  ReviewsResponse(
      {this.reviewsCount,
        this.reviewsStart,
        this.reviewsShown,
        this.userReviews});

  ReviewsResponse.fromJson(Map<String, dynamic> json) {
    reviewsCount = json['reviews_count'];
    reviewsStart = json['reviews_start'];
    reviewsShown = json['reviews_shown'];
    if (json['user_reviews'] != null) {
      userReviews = new List<UserReviews>();
      json['user_reviews'].forEach((v) {
        userReviews.add(new UserReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviews_count'] = this.reviewsCount;
    data['reviews_start'] = this.reviewsStart;
    data['reviews_shown'] = this.reviewsShown;
    if (this.userReviews != null) {
      data['user_reviews'] = this.userReviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserReviews {
  Review review;

  UserReviews({this.review});

  UserReviews.fromJson(Map<String, dynamic> json) {
    review =
    json['review'] != null ? new Review.fromJson(json['review']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.review != null) {
      data['review'] = this.review.toJson();
    }
    return data;
  }
}

class Review {
  int rating;
  String reviewText;
  int id;
  String ratingColor;
  String reviewTimeFriendly;
  String ratingText;
  int timestamp;
  int likes;
  User user;
  int commentsCount;

  Review(
      {this.rating,
        this.reviewText,
        this.id,
        this.ratingColor,
        this.reviewTimeFriendly,
        this.ratingText,
        this.timestamp,
        this.likes,
        this.user,
        this.commentsCount});

  Review.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    reviewText = json['review_text'];
    id = json['id'];
    ratingColor = json['rating_color'];
    reviewTimeFriendly = json['review_time_friendly'];
    ratingText = json['rating_text'];
    timestamp = json['timestamp'];
    likes = json['likes'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    commentsCount = json['comments_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['review_text'] = this.reviewText;
    data['id'] = this.id;
    data['rating_color'] = this.ratingColor;
    data['review_time_friendly'] = this.reviewTimeFriendly;
    data['rating_text'] = this.ratingText;
    data['timestamp'] = this.timestamp;
    data['likes'] = this.likes;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['comments_count'] = this.commentsCount;
    return data;
  }
}

class User {
  String name;
  String zomatoHandle;
  String foodieLevel;
  int foodieLevelNum;
  String foodieColor;
  String profileUrl;
  String profileImage;
  String profileDeeplink;

  User(
      {this.name,
        this.zomatoHandle,
        this.foodieLevel,
        this.foodieLevelNum,
        this.foodieColor,
        this.profileUrl,
        this.profileImage,
        this.profileDeeplink});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    zomatoHandle = json['zomato_handle'];
    foodieLevel = json['foodie_level'];
    foodieLevelNum = json['foodie_level_num'];
    foodieColor = json['foodie_color'];
    profileUrl = json['profile_url'];
    profileImage = json['profile_image'];
    profileDeeplink = json['profile_deeplink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['zomato_handle'] = this.zomatoHandle;
    data['foodie_level'] = this.foodieLevel;
    data['foodie_level_num'] = this.foodieLevelNum;
    data['foodie_color'] = this.foodieColor;
    data['profile_url'] = this.profileUrl;
    data['profile_image'] = this.profileImage;
    data['profile_deeplink'] = this.profileDeeplink;
    return data;
  }
}