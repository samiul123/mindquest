import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/discussion_post_details.dart';
import 'package:frontend/discussion_post_screen.dart';
import 'package:frontend/utils.dart';
import 'package:http/http.dart' as http;

class DiscussionHomeScreen extends StatefulWidget {
  final Function(int, Widget) replacePage;

  const DiscussionHomeScreen({super.key, required this.replacePage});

  @override
  DiscussionHomeScreenState createState() => DiscussionHomeScreenState();
}

class DiscussionHomeScreenState extends State<DiscussionHomeScreen> {
  List<dynamic> _discussionPosts = [];
  dynamic _currentPage;
  bool _isLoading = false;
  bool _showDownArrow = false;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _loadDiscussionPosts(0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<dynamic> fetchDiscussionPosts(int page) async {
    String apiUrl = '${dotenv.env["BASE_URL"]}/posts?pageNo=$page';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load discussion posts');
    }
  }

  Future<void> _loadDiscussionPosts(int pageNo) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final dynamic posts = await fetchDiscussionPosts(pageNo);
      setState(() {
        _currentPage = posts;
        if (_currentPage['first']) {
          _discussionPosts = _currentPage['content'];
        } else {
          _discussionPosts.addAll(_currentPage['content']);
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

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollListener());
    return Scaffold(
        backgroundColor: Colors.grey[850],
        body: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top section
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: GestureDetector(
                  onTap: () {
                    // Navigate to another page
                    widget.replacePage(1, const DiscussionPostScreen());
                  },
                  child: const Card(
                    color: CustomColor.lightgrey,
                    child: Center(
                      child: Text(
                        "What's on your mind?",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              // Bottom section
              const SizedBox(height: 5),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _isLoading
                            ? _discussionPosts.length + 1
                            : _discussionPosts.length,
                        itemBuilder: (context, index) {
                          if (index < _discussionPosts.length) {
                            return InkWell(
                                onTap: () {
                                  print("Post tapped");
                                  widget.replacePage(
                                      1,
                                      DiscussionPostDetails(
                                          post: _discussionPosts[index]));
                                },
                                child: Card(
                                    color: CustomColor.lightgrey,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _discussionPosts[index]
                                                        ['subject'],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                      Date.getTimeDifference(
                                                          DateTime.parse(
                                                              _discussionPosts[
                                                                      index][
                                                                  'createdAt'])),
                                                      style: const TextStyle(
                                                          color: Colors.white)),
                                                ],
                                              ),
                                              Expanded(
                                                  child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: () {
                                                      switch (_discussionPosts[
                                                              index]
                                                          ['postCategory']) {
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
                                                    // Set the background color
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15), // Set the border radius
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  // Add padding for spacing
                                                  child: Text(
                                                    _discussionPosts[index]
                                                        ['postCategory'],
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors
                                                          .white, // Set text color
                                                    ),
                                                  ),
                                                ),
                                              ))
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            _discussionPosts[index]['body'],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )));
                          } else if (_isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
              const SizedBox(height: 10),
              if (_showDownArrow)
                const Icon(Icons.arrow_drop_down_outlined, color: Colors.white),
            ],
          ),
        ));
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      double currentScroll = _scrollController.position.pixels;
      double maxScroll = _scrollController.position.maxScrollExtent;

      if (maxScroll - currentScroll <= 50) {
        setState(() {
          _showDownArrow = false;
        });
      } else {
        setState(() {
          _showDownArrow = true;
        });
      }

      if (currentScroll == maxScroll) {
        if (!_currentPage['last']) {
          _loadDiscussionPosts(_currentPage['number'] + 1);
        }
      }
    }
  }
}
