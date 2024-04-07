import 'package:flutter/material.dart';
import 'package:frontend/utils.dart';

class DiscussionPostScreen extends StatefulWidget {
  const DiscussionPostScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DiscussionPostScreenState();
}

class _DiscussionPostScreenState extends State<DiscussionPostScreen> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

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
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                    ),
                                    child: const Text('Venting',
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                  const SizedBox(width: 20),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    child: const Text('Questioning',
                                        style: TextStyle(color: Colors.black)),
                                  ),
                                  const SizedBox(width: 20),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: const Text('Support',
                                        style: TextStyle(color: Colors.black)),
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
                              // handleLogin(context);
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
                  ],
                ),
             )
          ),
        ));
  }
}
