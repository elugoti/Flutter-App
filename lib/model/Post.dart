
class PostList{
  final List<Post> posts;

  PostList({this.posts});

  factory PostList.fromJson(List<dynamic> parsedJson){
    List<Post> info = new List<Post>();
    info = parsedJson.map((i) => Post.fromJson(i)).toList();
    return PostList(posts: info);
  }
}

class Post{
  int id;
  int userId;
  String title;
  String body;

  Post({this.id, this.userId, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      id : json["id"],
      userId : json["userId"],
      title : json["title"],
      body : json["body"]
    );
  }
}