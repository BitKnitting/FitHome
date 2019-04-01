//
// The Comments class is responsible for reading and writing
// comments from a datastore. I start out with json then plan
// to move to Firestore.
import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:fithome/Users/user.dart';

//******************************************** */
// If anything changes, the comments.g.dart file needs
// to be recreated.
// This is done using either:
// flutter packages pub run build_runner build
// for a one time build or:
// flutter packages pub run build_runner watch
// To run each time there is a change.
part 'comments.g.dart';

@JsonSerializable()
class Comment {
  String email;
  DateTime dateTime;
  String comment;
  Comment({this.email, this.dateTime, this.comment});
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

@JsonSerializable()
// Comments is a list of comments where each comment is an instance
// of Comment().
class Comments {
  Comments({
    this.comments,
  });

  List<Comment> comments = [];

  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsToJson(this);
  //
  // Write a comment string to the datastore.
  //
  Future<void> write(String commentString) async {
    // Make an instance of a Comment and fill in the fields.
    Comment commentToWrite = Comment();
    commentToWrite.email = User.email;
    commentToWrite.dateTime = DateTime.now();
    commentToWrite.comment = commentString;
    // Write the Comment() instance to the datastore.
    _writeToJson(commentToWrite);
  }

  Future<List<Comment>> read() async {
    // Get the file handle to the comments file.
    final file = await _localFile;
    bool fileExists = await file.exists();
    if (fileExists) {
      Map commentsMap = jsonDecode(await file.readAsString());
      return Comments.fromJson(commentsMap).comments;
    }
    return null;
  }

  //
  // Write the comment to the json file.  Append to the comments if
  // other comments exist.
  void _writeToJson(Comment commentToWrite) async {
    // Get the file handle to the comments file.
    final file = await _localFile;
    // If the file exists, it has other comments in it.
    bool fileExists = await file.exists();
    print('This file exists: $fileExists');
    Comments theComments = Comments();
    theComments.comments = [];
    if (fileExists) {
      // Look at the list of comments.
      String jsonString = await file.readAsString();
      Map commentsMap = await jsonDecode(jsonString);
      Comments currentComments = Comments.fromJson(commentsMap);
      theComments.comments.addAll(currentComments.comments);
    }
    theComments.comments.add(commentToWrite);
    Map commentsMap = theComments.toJson();
    await file.writeAsString(jsonEncode(commentsMap));
  }

//
// File utility functions
//
// From Flutter doc: https://bit.ly/2UjKTFY
// Example of writing to a file owned by the app.
// In this case, writing to comments.json
//
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/comments.json');
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
}
