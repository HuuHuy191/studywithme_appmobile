import 'package:flutter/material.dart';

import '../../controllers/vocab_controller.dart';

import '../../models/course_model.dart';

import '../../models/vocab_model.dart';

class VocabScreen extends StatefulWidget {

  final CourseModel classroom;

  final bool isOwner;

  const VocabScreen({

    super.key,

    required this.classroom,

    required this.isOwner,

  });

  @override
  State<VocabScreen> createState() =>
      _VocabScreenState();

}

class _VocabScreenState
    extends State<VocabScreen> {

  final VocabController controller =
  VocabController();

  List<VocabModel> vocabs = [];

  bool isLoading = true;


  void showCreateDialog() {

    final wordController =
    TextEditingController();

    final meaningController =
    TextEditingController();

    final exampleController =
    TextEditingController();

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title: const Text(
            "Thêm Vocabulary",
          ),

          content: SingleChildScrollView(

            child: Column(

              mainAxisSize:
              MainAxisSize.min,

              children: [

                TextField(

                  controller:
                  wordController,

                  decoration:
                  const InputDecoration(

                    labelText:
                    "Word",

                  ),

                ),

                TextField(

                  controller:
                  meaningController,

                  decoration:
                  const InputDecoration(

                    labelText:
                    "Meaning",

                  ),

                ),

                TextField(

                  controller:
                  exampleController,

                  decoration:
                  const InputDecoration(

                    labelText:
                    "Example",

                  ),

                ),

              ],

            ),

          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(context);

              },

              child:
              const Text("Huỷ"),

            ),

            ElevatedButton(

              child:
              const Text("Thêm"),

                onPressed: () async {

                  try {

                    bool success =
                    await controller.createVocab(

                      word: wordController.text,

                      meaning: meaningController.text,

                      example: exampleController.text,

                      courseId: widget.classroom.id!,

                    );

                    print("SUCCESS = $success");

                    if (success) {

                      Navigator.pop(context);

                      await loadVocabs();

                      ScaffoldMessenger.of(context).showSnackBar(

                        const SnackBar(

                          content: Text("Đã thêm Vocabulary"),

                        ),

                      );

                    }

                  } catch (e) {

                    print(e);

                  }

                }

            ),

          ],

        );

      },

    );

  }
  void initState() {
    super.initState();

    loadVocabs();
  }

  Future<void> loadVocabs() async {
    vocabs =
    await controller.getVocabs(
      widget.classroom.id!,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text(widget.classroom.name),

      ),

      floatingActionButton:

      widget.isOwner

          ? FloatingActionButton(

        child: const Icon(Icons.add),

        onPressed: () {
          showCreateDialog();
        },

      )

          : null,

      body: isLoading

          ? const Center(

        child:
        CircularProgressIndicator(),

      )

          : ListView.builder(

        itemCount: vocabs.length,

        itemBuilder: (context, index) {
          final vocab = vocabs[index];

          return Card(

            child: ListTile(

              title: Text(vocab.word),

              subtitle: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(vocab.meaning),

                  Text(

                    vocab.example,

                    style: const TextStyle(

                      color: Colors.grey,

                    ),

                  ),

                ],

              ),

              trailing: widget.isOwner

                  ? IconButton(

                icon: const Icon(

                  Icons.delete,

                  color: Colors.red,

                ),

                onPressed: () async {

                  bool? confirm =
                  await showDialog(

                    context: context,

                    builder: (_) {

                      return AlertDialog(

                        title: const Text(
                          "Xóa Vocabulary",
                        ),

                        content: Text(
                            "Bạn có chắc muốn xóa '${vocab.word}'?"
                        ),

                        actions: [

                          TextButton(

                            onPressed: () {

                              Navigator.pop(
                                context,
                                false,
                              );

                            },

                            child: const Text("Huỷ"),

                          ),

                          ElevatedButton(

                            onPressed: () {

                              Navigator.pop(
                                context,
                                true,
                              );

                            },

                            child: const Text("Xóa"),

                          ),

                        ],

                      );

                    },

                  );

                  if (confirm != true) return;

                  bool success =
                  await controller.deleteVocab(
                    vocab.id!,
                  );

                  if (success) {

                    await loadVocabs();

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(

                        content: Text(
                          "Đã xóa Vocabulary",
                        ),

                      ),

                    );

                  }

                },

              )

                  : null,

            ),

          );
        },

      ),

    );
  }
}