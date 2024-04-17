import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/secure_storage.dart';
import 'package:frontend/utils.dart';
import 'package:http/http.dart' as http;

import 'common_layout.dart';

class DiscussionPostScreen extends StatefulWidget {
  const DiscussionPostScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DiscussionPostScreenState();
}

class _DiscussionPostScreenState extends State<DiscussionPostScreen> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  late String postCategory;
  bool showError = false;
  late String errorMessage;

  Future<void> handleSubmit() async {
    final String subject = subjectController.text;
    final String body = bodyController.text;

    // Replace with your backend API URL
    String? accessToken = await SecureStorage().storage.read(key: 'accessToken');
    Map<String, String> headers = {'Content-Type': 'application/json', 'Authorization': '$accessToken'};
    String apiUrl = '${dotenv.env["BASE_URL"]}/posts';

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode({
            'subject': subject,
            'body': body,
            'postCategory': postCategory,
          }),
          headers: headers);
      if (!mounted) return;
      if (response.statusCode == 200) {
        // Successful login
        print('Post created');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const CommonLayout(pageIndex: 1)));
        // Navigate to the home screen or perform other actions
      } else {
        // Failed login
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

  void closeError() {
    setState(() {
      showError = false;
    });
  }

  @override
  void initState() {
    super.initState();
    postCategory = "";
    showError = false;
    errorMessage = "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.grey[850],
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Center(
              child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Card(
                        color: CustomColor.lightgrey,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            controller: subjectController,
                            decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Subject',
                                border: InputBorder.none),
                          ),
                        ))),
                const SizedBox(height: 5),
                Expanded(
                    flex: 2,
                    child: Card(
                        color: CustomColor.lightgrey,
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextField(
                              style: const TextStyle(color: Colors.white),
                              controller: bodyController,
                              decoration: const InputDecoration(
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: 'What\'s on your mind?',
                                  border: InputBorder.none),
                            )))),
                const SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: CustomColor.lightgrey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('Choose Category',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16))),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    postCategory = "VENTING";
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: postCategory == "VENTING"
                                      ? CustomColor.purple
                                      : Colors.blue,
                                ),
                                child: const Text('Venting',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    postCategory = "QUESTIONING";
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: postCategory == "QUESTIONING"
                                      ? CustomColor.purple
                                      : Colors.green,
                                ),
                                child: const Text('Questioning',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    postCategory = "SUPPORT";
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: postCategory == "SUPPORT"
                                      ? CustomColor.purple
                                      : Colors.red,
                                ),
                                child: const Text('Support',
                                    style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    )),
                const SizedBox(height: 100),
                Expanded(
                    flex: 1,
                    child: Card(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle login logic
                          handleSubmit();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: CustomColor.purple,
                        ),
                        child: const Text('Submit',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    )),
                if (showError)
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          errorMessage,
                          style: const TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Close the error message
                            closeError();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          )),
        ));
  }
}
