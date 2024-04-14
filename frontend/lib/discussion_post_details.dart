import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/discussion_post.dart';
import 'package:frontend/utils.dart';
import 'package:http/http.dart' as http;

class DiscussionPostDetails extends StatefulWidget {
  final dynamic post;

  const DiscussionPostDetails({required this.post, super.key});

  @override
  State<StatefulWidget> createState() => _DiscussionPostDetailsState();
}

class _DiscussionPostDetailsState extends State<DiscussionPostDetails> {
  late dynamic post;
  List<dynamic> _comments = [];
  bool _isLoading = false;
  Color _sendIconColor = Colors.grey;
  TextEditingController commentController = TextEditingController();
  bool showError = false;
  String errorMessage = "";
  bool _isSendButtonEnabled = false;
  dynamic _commentPage;
  final ScrollController _scrollController = ScrollController();
  bool _showDownArrow = false;

  @override
  void initState() {
    super.initState();
    post = widget.post;
    commentController.addListener(_onCommentChanged);
    _scrollController.addListener(_scrollListener);
    _loadComments(0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<dynamic> _fetchComments(int postId, int page) async {
    String apiUrl =
        '${dotenv.env["BASE_URL"]}/comments?postId=$postId&pageNo=$page';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load discussion posts');
    }
  }

  Future<void> _loadComments(int pageNo) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final dynamic comments = await _fetchComments(post['id'], pageNo);
      setState(() {
        _commentPage = comments;
        if (comments['first']) {
          _comments = comments['content'];
        } else {
          _comments.addAll(comments['content']);
        }
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleSend() async {
    final String comment = commentController.text;

    // Replace with your backend API URL
    String apiUrl = '${dotenv.env["BASE_URL"]}/comments';
    Map<String, String> headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode(
              {'postId': post['id'], 'body': comment, 'username': 'sa001'}),
          headers: headers);
      if (!mounted) return;
      if (response.statusCode == 200) {
        // Successful login
        print('Comment created');
        _loadComments(0);
      } else {
        print('Post creation failed');
        // Show an error message or perform other actions
        setState(() {
          showError = true;
          errorMessage = response.body;
        });
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
      setState(() {
        showError = true;
        errorMessage = "Server is busy. Please try again later.";
      });
    }
  }

  void _onSendClicked() {
    if (_isSendButtonEnabled) {
      setState(() {
        _sendIconColor = CustomColor.purple;
      });
      _handleSend();
      commentController.clear();
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _sendIconColor = Colors.grey;
          _isSendButtonEnabled = false;
        });
      });
    }
  }

  void _onCommentChanged() {
    setState(() {
      _isSendButtonEnabled = commentController.text.isNotEmpty;
      _sendIconColor = _isSendButtonEnabled ? Colors.white : Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollListener());
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            (Card(
              color: CustomColor.lightgrey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.account_circle,
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
                        Text(post['username'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                              Date.getTimeDifference(
                                  DateTime.parse(post['createdAt'])),
                              style: const TextStyle(color: Colors.white)),
                        ))
                      ],
                    ),
                    const Divider(
                      height: 10,
                      thickness: .5,
                      color: Colors.white54,
                    ),
                    Row(
                      children: [
                        Text(post['subject'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            decoration: BoxDecoration(
                              color: () {
                                switch (post['postCategory']) {
                                  case "Venting":
                                    return Colors.blue;
                                  case "Questioning":
                                    return Colors.green;
                                  case "Support":
                                    return Colors.red;
                                  default:
                                    return Colors.black;
                                }
                              }(),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.all(5),
                            // Add padding for spacing
                            child: Text(
                              post['postCategory'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                    Text(post['body'],
                        style: const TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            )),
            const Row(
              children: [
                SizedBox(width: .5),
                Text(' Comments', style: TextStyle(color: Colors.white))
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _isLoading ? _comments.length + 1 : _comments.length,
                itemBuilder: (context, index) {
                  if (index < _comments.length) {
                    return Card(
                      color: CustomColor.lightgrey,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.account_circle,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    _comments[index]['username'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Expanded(
                                      child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        Date.getTimeDifference(DateTime.parse(
                                            _comments[index]["createdAt"])),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ))
                                ],
                              ),
                              // ),
                              const SizedBox(height: 10),
                              Text(
                                _comments[index]['body'],
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Reply',
                                      style: TextStyle(color: Colors.white)),
                                  Icon(
                                    Icons.reply,
                                    color: Colors.white,
                                  )
                                ],
                              )
                            ],
                          )),
                    );
                  } else if (_isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            if (_showDownArrow)
              const Icon(Icons.arrow_drop_down_outlined, color: Colors.white),
            const SizedBox(height: 10),
            Card(
                color: CustomColor.lightgrey,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorColor: Colors.white,
                            style: const TextStyle(color: Colors.white),
                            controller: commentController,
                            decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Add comment',
                                border: InputBorder.none),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _onSendClicked();
                          },
                          child: Icon(Icons.send, color: _sendIconColor),
                        )
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    double currentScroll = _scrollController.position.pixels;
    double maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll - currentScroll <= 100) {
      setState(() {
        _showDownArrow = false;
      });
    } else {
      setState(() {
        _showDownArrow = true;
      });
    }
    if (currentScroll == maxScroll) {
      if (!_commentPage['last']) {
        _loadComments(_commentPage['number'] + 1);
      }
    }
  }
}
