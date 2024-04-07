import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/discussion_post.dart';
import 'package:frontend/discussion_post_screen.dart';
import 'package:frontend/utils.dart';
import 'package:http/http.dart' as http;

class DiscussionHomeScreen extends StatefulWidget {
  const DiscussionHomeScreen({super.key});

  @override
  DiscussionHomeScreenState createState() => DiscussionHomeScreenState();
}

class DiscussionHomeScreenState extends State<DiscussionHomeScreen> {
  List<DiscussionPost> _discussionPosts = [];
  int _currentPage = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDiscussionPosts();
  }

  Future<List<DiscussionPost>> fetchDiscussionPosts(int page) async {
    String apiUrl = '${dotenv.env["BASE_URL"]}/posts?pageNo=$page';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((post) => DiscussionPost(
              post['id'],
              post['subject'],
              post['body'],
              post['postCategory'],
              post['username'],
              post['createdAt']))
          .toList();
    } else {
      throw Exception('Failed to load discussion posts');
    }
  }

  Future<void> _loadDiscussionPosts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<DiscussionPost> posts =
          await fetchDiscussionPosts(_currentPage);
      setState(() {
        _discussionPosts.addAll(posts);
        _currentPage++;
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
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top section
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: GestureDetector(
              onTap: () {
                // Navigate to another page
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DiscussionPostScreen()));
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
          _discussionPosts.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (!_isLoading &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        _loadDiscussionPosts();
                      }
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: _discussionPosts.length + 1,
                      itemBuilder: (context, index) {
                        if (index < _discussionPosts.length) {
                          return Card(
                            color: CustomColor.lightgrey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _discussionPosts[index].subject,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: () {
                                            switch (_discussionPosts[index]
                                                .postCategory) {
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
                                          borderRadius: BorderRadius.circular(
                                              15), // Set the border radius
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        // Add padding for spacing
                                        child: Text(
                                          _discussionPosts[index].postCategory,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.white, // Set text color
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _discussionPosts[index].body,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (_isLoading){
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
