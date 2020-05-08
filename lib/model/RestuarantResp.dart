class RestaurantResp {
  int resultsFound;
  int resultsStart;
  int resultsShown;
  List<Restaurants> restaurants;

  RestaurantResp(
      {this.resultsFound,
        this.resultsStart,
        this.resultsShown,
        this.restaurants});

  RestaurantResp.fromJson(Map<String, dynamic> json) {
    resultsFound = json['results_found'];
    resultsStart = json['results_start'];
    resultsShown = json['results_shown'];
    if (json['restaurants'] != null) {
      restaurants = new List<Restaurants>();
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results_found'] = this.resultsFound;
    data['results_start'] = this.resultsStart;
    data['results_shown'] = this.resultsShown;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurants {
  Restaurant restaurant;

  Restaurants({this.restaurant});

  Restaurants.fromJson(Map<String, dynamic> json) {
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    return data;
  }
}

class Restaurant {
  R r;
  String apikey;
  String id;
  String name;
  String url;
  Location location;
  int switchToOrderMenu;
  String cuisines;
  String timings;
  int averageCostForTwo;
  int priceRange;
  String currency;
  List<String> highlights;
  int opentableSupport;
  int isZomatoBookRes;
  String mezzoProvider;
  int isBookFormWebView;
  String bookFormWebViewUrl;
  String bookAgainUrl;
  String thumb;
  UserRating userRating;
  int allReviewsCount;
  String photosUrl;
  int photoCount;
  List<Photos> photos;
  String menuUrl;
  String featuredImage;
  int hasOnlineDelivery;
  int isDeliveringNow;
  String storeType;
  bool includeBogoOffers;
  String deeplink;
  int isTableReservationSupported;
  int hasTableBooking;
  String eventsUrl;
  String phoneNumbers;
  AllReviews allReviews;
  List<String> establishment;

  Restaurant(
      {this.r,
        this.apikey,
        this.id,
        this.name,
        this.url,
        this.location,
        this.switchToOrderMenu,
        this.cuisines,
        this.timings,
        this.averageCostForTwo,
        this.priceRange,
        this.currency,
        this.highlights,
        this.opentableSupport,
        this.isZomatoBookRes,
        this.mezzoProvider,
        this.isBookFormWebView,
        this.bookFormWebViewUrl,
        this.bookAgainUrl,
        this.thumb,
        this.userRating,
        this.allReviewsCount,
        this.photosUrl,
        this.photoCount,
        this.photos,
        this.menuUrl,
        this.featuredImage,
        this.hasOnlineDelivery,
        this.isDeliveringNow,
        this.storeType,
        this.includeBogoOffers,
        this.deeplink,
        this.isTableReservationSupported,
        this.hasTableBooking,
        this.eventsUrl,
        this.phoneNumbers,
        this.allReviews,
        this.establishment});

  Restaurant.fromJson(Map<String, dynamic> json) {
    r = json['R'] != null ? new R.fromJson(json['R']) : null;
    apikey = json['apikey'];
    id = json['id'];
    name = json['name'];
    url = json['url'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    switchToOrderMenu = json['switch_to_order_menu'];
    cuisines = json['cuisines'];
    timings = json['timings'];
    averageCostForTwo = json['average_cost_for_two'];
    priceRange = json['price_range'];
    currency = json['currency'];
    highlights = json['highlights'].cast<String>();
    opentableSupport = json['opentable_support'];
    isZomatoBookRes = json['is_zomato_book_res'];
    mezzoProvider = json['mezzo_provider'];
    isBookFormWebView = json['is_book_form_web_view'];
    bookFormWebViewUrl = json['book_form_web_view_url'];
    bookAgainUrl = json['book_again_url'];
    thumb = json['thumb'];
    userRating = json['user_rating'] != null
        ? new UserRating.fromJson(json['user_rating'])
        : null;
    allReviewsCount = json['all_reviews_count'];
    photosUrl = json['photos_url'];
    photoCount = json['photo_count'];
    if (json['photos'] != null) {
      photos = new List<Photos>();
      json['photos'].forEach((v) {
        photos.add(new Photos.fromJson(v));
      });
    }
    menuUrl = json['menu_url'];
    featuredImage = json['featured_image'];
    hasOnlineDelivery = json['has_online_delivery'];
    isDeliveringNow = json['is_delivering_now'];
    storeType = json['store_type'];
    includeBogoOffers = json['include_bogo_offers'];
    deeplink = json['deeplink'];
    isTableReservationSupported = json['is_table_reservation_supported'];
    hasTableBooking = json['has_table_booking'];
    eventsUrl = json['events_url'];
    phoneNumbers = json['phone_numbers'];
    allReviews = json['all_reviews'] != null
        ? new AllReviews.fromJson(json['all_reviews'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.r != null) {
      data['R'] = this.r.toJson();
    }
    data['apikey'] = this.apikey;
    data['id'] = this.id;
    data['name'] = this.name;
    data['url'] = this.url;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['switch_to_order_menu'] = this.switchToOrderMenu;
    data['cuisines'] = this.cuisines;
    data['timings'] = this.timings;
    data['average_cost_for_two'] = this.averageCostForTwo;
    data['price_range'] = this.priceRange;
    data['currency'] = this.currency;
    data['highlights'] = this.highlights;
    data['opentable_support'] = this.opentableSupport;
    data['is_zomato_book_res'] = this.isZomatoBookRes;
    data['mezzo_provider'] = this.mezzoProvider;
    data['is_book_form_web_view'] = this.isBookFormWebView;
    data['book_form_web_view_url'] = this.bookFormWebViewUrl;
    data['book_again_url'] = this.bookAgainUrl;
    data['thumb'] = this.thumb;
    if (this.userRating != null) {
      data['user_rating'] = this.userRating.toJson();
    }
    data['all_reviews_count'] = this.allReviewsCount;
    data['photos_url'] = this.photosUrl;
    data['photo_count'] = this.photoCount;
    if (this.photos != null) {
      data['photos'] = this.photos.map((v) => v.toJson()).toList();
    }
    data['menu_url'] = this.menuUrl;
    data['featured_image'] = this.featuredImage;
    data['has_online_delivery'] = this.hasOnlineDelivery;
    data['is_delivering_now'] = this.isDeliveringNow;
    data['store_type'] = this.storeType;
    data['include_bogo_offers'] = this.includeBogoOffers;
    data['deeplink'] = this.deeplink;
    data['is_table_reservation_supported'] = this.isTableReservationSupported;
    data['has_table_booking'] = this.hasTableBooking;
    data['events_url'] = this.eventsUrl;
    data['phone_numbers'] = this.phoneNumbers;
    if (this.allReviews != null) {
      data['all_reviews'] = this.allReviews.toJson();
    }
    data['establishment'] = this.establishment;
    return data;
  }
}

class R {
  HasMenuStatus hasMenuStatus;
  int resId;

  R({this.hasMenuStatus, this.resId});

  R.fromJson(Map<String, dynamic> json) {
    hasMenuStatus = json['has_menu_status'] != null
        ? new HasMenuStatus.fromJson(json['has_menu_status'])
        : null;
    resId = json['res_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hasMenuStatus != null) {
      data['has_menu_status'] = this.hasMenuStatus.toJson();
    }
    data['res_id'] = this.resId;
    return data;
  }
}

class HasMenuStatus {
  int delivery;
  int takeaway;

  HasMenuStatus({this.delivery, this.takeaway});

  HasMenuStatus.fromJson(Map<String, dynamic> json) {
    delivery = json['delivery'];
    takeaway = json['takeaway'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['delivery'] = this.delivery;
    data['takeaway'] = this.takeaway;
    return data;
  }
}

class Location {
  String address;
  String locality;
  String city;
  int cityId;
  String latitude;
  String longitude;
  String zipcode;
  int countryId;
  String localityVerbose;

  Location(
      {this.address,
        this.locality,
        this.city,
        this.cityId,
        this.latitude,
        this.longitude,
        this.zipcode,
        this.countryId,
        this.localityVerbose});

  Location.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    locality = json['locality'];
    city = json['city'];
    cityId = json['city_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    zipcode = json['zipcode'];
    countryId = json['country_id'];
    localityVerbose = json['locality_verbose'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['locality'] = this.locality;
    data['city'] = this.city;
    data['city_id'] = this.cityId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['zipcode'] = this.zipcode;
    data['country_id'] = this.countryId;
    data['locality_verbose'] = this.localityVerbose;
    return data;
  }
}

class UserRating {
  String aggregateRating;
  String ratingText;
  String ratingColor;
  RatingObj ratingObj;
  String votes;

  UserRating(
      {this.aggregateRating,
        this.ratingText,
        this.ratingColor,
        this.ratingObj,
        this.votes});

  UserRating.fromJson(Map<String, dynamic> json) {
    aggregateRating = json['aggregate_rating'];
    ratingText = json['rating_text'];
    ratingColor = json['rating_color'];
    ratingObj = json['rating_obj'] != null
        ? new RatingObj.fromJson(json['rating_obj'])
        : null;
    votes = json['votes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aggregate_rating'] = this.aggregateRating;
    data['rating_text'] = this.ratingText;
    data['rating_color'] = this.ratingColor;
    if (this.ratingObj != null) {
      data['rating_obj'] = this.ratingObj.toJson();
    }
    data['votes'] = this.votes;
    return data;
  }
}

class RatingObj {
  Title title;
  BgColor bgColor;

  RatingObj({this.title, this.bgColor});

  RatingObj.fromJson(Map<String, dynamic> json) {
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    bgColor = json['bg_color'] != null
        ? new BgColor.fromJson(json['bg_color'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    if (this.bgColor != null) {
      data['bg_color'] = this.bgColor.toJson();
    }
    return data;
  }
}

class Title {
  String text;

  Title({this.text});

  Title.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class BgColor {
  String type;
  String tint;

  BgColor({this.type, this.tint});

  BgColor.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    tint = json['tint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['tint'] = this.tint;
    return data;
  }
}

class Photos {
  Photo photo;

  Photos({this.photo});

  Photos.fromJson(Map<String, dynamic> json) {
    photo = json['photo'] != null ? new Photo.fromJson(json['photo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    return data;
  }
}

class Photo {
  String id;
  String url;
  String thumbUrl;
  User user;
  int resId;
  String caption;
  int timestamp;
  String friendlyTime;
  int width;
  int height;

  Photo(
      {this.id,
        this.url,
        this.thumbUrl,
        this.user,
        this.resId,
        this.caption,
        this.timestamp,
        this.friendlyTime,
        this.width,
        this.height});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    thumbUrl = json['thumb_url'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    resId = json['res_id'];
    caption = json['caption'];
    timestamp = json['timestamp'];
    friendlyTime = json['friendly_time'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['thumb_url'] = this.thumbUrl;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['res_id'] = this.resId;
    data['caption'] = this.caption;
    data['timestamp'] = this.timestamp;
    data['friendly_time'] = this.friendlyTime;
    data['width'] = this.width;
    data['height'] = this.height;
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

class AllReviews {
  List<Reviews> reviews;

  AllReviews({this.reviews});

  AllReviews.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  List<Null> review;

  Reviews({this.review});

  Reviews.fromJson(Map<String, dynamic> json) {
    if (json['review'] != null) {
      review = new List<Null>();
      json['review'].forEach((v) {

      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.review != null) {
      data['review'] = this.review.map((v) => v).toList();
    }
    return data;
  }
}