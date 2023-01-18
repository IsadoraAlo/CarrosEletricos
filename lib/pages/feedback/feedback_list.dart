// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../components/navigation_drawer.dart';
import '../../models/feedback.dart';
import '../../repository/feedback_repository.dart';
import 'feedback_registry.dart';

class FeedbacksListPage extends StatefulWidget {
  const FeedbacksListPage({Key? key}) : super(key: key);

  @override
  State<FeedbacksListPage> createState() => _FeedbacksListPageState();
}

class _FeedbacksListPageState extends State<FeedbacksListPage> {
  final _feedbackRepository = FeedbacksRepository();
  late Future<List<Feedbacks>> _futureFeedbacks;

  @override
  void initState() {
    loadFeedbacks();
    super.initState();
  }

  void loadFeedbacks() {
    _futureFeedbacks = _feedbackRepository.listFeedbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        centerTitle: true,
        elevation: 0.0,
        title: const Text('Feedbacks',
            style: TextStyle(
                color: Colors.blueAccent, fontWeight: FontWeight.w800)),
        iconTheme: const IconThemeData(color: Colors.blueAccent),
      ),
      drawer: const NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: FutureBuilder<List<Feedbacks>>(
          future: _futureFeedbacks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              final feedbacks = snapshot.data ?? [];
              return ListView.separated(
                itemCount: feedbacks.length,
                itemBuilder: (context, index) {
                  final feedback = feedbacks[index];
                  return Slidable(
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            await _feedbackRepository
                                .removeFeedback(feedback.id!);

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Feedback removed successfully!')));

                            setState(() {
                              feedbacks.removeAt(index);
                            });
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Remove',
                        ),
                        SlidableAction(
                          onPressed: (context) async {
                            var success = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FeedbacksRegistryPage(
                                  feedbackforEdit: feedback,
                                ),
                              ),
                            ) as bool?;

                            if (success != null && success) {
                              setState(() {
                                loadFeedbacks();
                              });
                            }
                          },
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                        ),
                      ],
                    ),
                    child: FeedbacksListItem(feedback: feedback),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool? feedbackCadastrada = await Navigator.of(context)
                .pushNamed('/feedback-registry') as bool?;

            if (feedbackCadastrada != null && feedbackCadastrada) {
              setState(() {
                loadFeedbacks();
              });
            }
          },
          child: const Icon(Icons.add)),
    );
  }
}

class FeedbacksListItem extends StatelessWidget {
  final Feedbacks feedback;
  const FeedbacksListItem({Key? key, required this.feedback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 20),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [Colors.lightGreen, Colors.blueAccent],
            ),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                topLeft: Radius.circular(20))),
        child: ListTile(
          leading: const Icon(
            Icons.person,
            size: 50,
            color: Colors.white,
          ),
          title: Text(feedback.evaluation,
              style: const TextStyle(color: Colors.white)),
          subtitle:
              const Text('Anonymous', style: TextStyle(color: Colors.white)),
          trailing: Text(
            (feedback.rating),
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/feedback-details',
                arguments: feedback);
          },
        ));
  }
}
