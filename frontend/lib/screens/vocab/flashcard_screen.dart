import 'package:flutter/material.dart';

import '../../controllers/vocab_controller.dart';
import '../../models/course_model.dart';
import '../../models/vocab_model.dart';

class FlashcardScreen extends StatefulWidget {
  final CourseModel classroom;

  const FlashcardScreen({
    super.key,
    required this.classroom,
  });

  @override
  State<FlashcardScreen> createState() =>
      _FlashcardScreenState();
}

class _FlashcardScreenState
    extends State<FlashcardScreen> {

  final VocabController controller =
  VocabController();

  List<VocabModel> vocabs = [];

  bool isLoading = true;

  int currentIndex = 0;

  bool showMeaning = false;

  @override
  void initState() {
    super.initState();
    loadVocabs();
  }

  Future<void> loadVocabs() async {

    try {

      vocabs = await controller.getVocabs(
        widget.classroom.id!,
      );

    } catch (e) {

      debugPrint(e.toString());

    }

    setState(() {

      isLoading = false;

    });

  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {

      return const Scaffold(

        body: Center(
          child: CircularProgressIndicator(),
        ),

      );

    }

    if (vocabs.isEmpty) {

      return Scaffold(

        appBar: AppBar(
          title: Text(widget.classroom.name),
        ),

        body: const Center(

          child: Text(
            "Lớp chưa có Vocabulary",
          ),

        ),

      );

    }

    final vocab = vocabs[currentIndex];

    return Scaffold(

      appBar: AppBar(

        title: Text(widget.classroom.name),

      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 20),

            Text(

              "${currentIndex + 1}/${vocabs.length}",

              style: const TextStyle(

                fontSize: 18,

                fontWeight: FontWeight.bold,

              ),

            ),

            const SizedBox(height: 30),

            Expanded(

              child: GestureDetector(

                onTap: () {

                  setState(() {

                    showMeaning = !showMeaning;

                  });

                },

                child: Card(

                  elevation: 6,

                  shape: RoundedRectangleBorder(

                    borderRadius:
                    BorderRadius.circular(20),

                  ),

                  child: Container(

                    width: double.infinity,

                    padding:
                    const EdgeInsets.all(20),

                    child: Center(

                      child: showMeaning

                          ? Column(

                        mainAxisAlignment:
                        MainAxisAlignment.center,

                        children: [

                          Text(

                            vocab.meaning,

                            textAlign:
                            TextAlign.center,

                            style:
                            const TextStyle(

                              fontSize: 30,

                              fontWeight:
                              FontWeight.bold,

                            ),

                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          Text(

                            vocab.example,

                            textAlign:
                            TextAlign.center,

                            style:
                            const TextStyle(

                              fontSize: 18,

                              color:
                              Colors.grey,

                            ),

                          ),

                        ],

                      )

                          : Text(

                        vocab.word,

                        textAlign:
                        TextAlign.center,

                        style:
                        const TextStyle(

                          fontSize: 36,

                          fontWeight:
                          FontWeight.bold,

                        ),

                      ),

                    ),

                  ),

                ),

              ),

            ),

            const SizedBox(height: 20),

            Row(

              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,

              children: [

                ElevatedButton.icon(

                  onPressed: currentIndex == 0

                      ? null

                      : () {

                    setState(() {

                      currentIndex--;

                      showMeaning = false;

                    });

                  },

                  icon: const Icon(
                    Icons.arrow_back,
                  ),

                  label: const Text(
                    "Trước",
                  ),

                ),

                ElevatedButton.icon(

                  onPressed:

                  currentIndex ==
                      vocabs.length - 1

                      ? null

                      : () {

                    setState(() {

                      currentIndex++;

                      showMeaning = false;

                    });

                  },

                  icon: const Icon(
                    Icons.arrow_forward,
                  ),

                  label: const Text(
                    "Tiếp",
                  ),

                ),

              ],

            ),

            const SizedBox(height: 20),

            const Text(

              "Chạm vào thẻ để xem nghĩa",

              style: TextStyle(

                color: Colors.grey,

              ),

            ),

          ],

        ),

      ),

    );

  }

}