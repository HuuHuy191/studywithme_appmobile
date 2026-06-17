import 'package:flutter/material.dart';

import '../../controllers/course_controller.dart';
import '../../models/course_model.dart';
import '../course/create_course_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  final CourseController controller =
  CourseController();

  List<CourseModel> courses = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  Future<void> loadCourses() async {
    try {
      courses =
      await controller.getCourses();
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFFF5F7FF),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF48CAE4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.auto_stories,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Study With Me",
              style: TextStyle(
                color: Color(0xFF1A1A2E),
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),

      floatingActionButton:
      FloatingActionButton(
        onPressed: () async {

          final result =
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
              const CreateCourseScreen(),
            ),
          );

          if (result == true) {
            loadCourses();
          }
        },
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 6,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF6C63FF),
          strokeWidth: 3,
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // Header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C63FF), Color(0xFF48CAE4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Xin chào 👋",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Bạn đang có ${courses.length} khóa học",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Khóa học của bạn",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
                letterSpacing: 0.2,
              ),
            ),

            const SizedBox(height: 12),

            Expanded(
              child: courses.isEmpty

                  ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.menu_book_outlined,
                        size: 48,
                        color: Color(0xFF6C63FF),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Chưa có khóa học nào",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF8A8A9A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Nhấn + để tạo khóa học đầu tiên",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFFB0B0C0),
                      ),
                    ),
                  ],
                ),
              )

                  : GridView.builder(

                itemCount:
                courses.length,

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.15,
                ),

                itemBuilder:
                    (context, index) {

                  final course =
                  courses[index];

                  const Color cardColor =
                  Color(0xFF6C63FF);

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: cardColor.withOpacity(0.18),
                          blurRadius: 12,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Card(

                      elevation: 0,
                      color: Colors.white,

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(18),
                      ),

                      child: InkWell(

                        borderRadius:
                        BorderRadius.circular(18),

                        onTap: () {

                          // TODO:
                          // CourseDetailScreen

                        },

                        child: Padding(
                          padding:
                          const EdgeInsets.all(16),

                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,

                            children: [

                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: cardColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.groups,
                                  size: 30,
                                  color: cardColor,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                course.name,
                                textAlign:
                                TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,

                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color(0xFF1A1A2E),
                                  height: 1.3,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: cardColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Mã lớp: ${course.classCode}",
                                  style: TextStyle(
                                    color: cardColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}