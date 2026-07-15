import 'package:flutter/material.dart';
import '../../controllers/course_controller.dart';
import '../../controllers/member_controller.dart';
import '../../models/course_model.dart';
import '../../models/member_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../vocab/vocab_screen.dart';
import '../vocab/flashcard_screen.dart';
import '../quiz/create_quiz_screen.dart';
import '../quiz/quiz_list_screen.dart';
class ClassDetailScreen extends StatefulWidget {
  final CourseModel classroom;

  const ClassDetailScreen({
    super.key,
    required this.classroom,
  });

  @override
  State<ClassDetailScreen> createState() =>
      _ClassDetailScreenState();
}

class _ClassDetailScreenState
    extends State<ClassDetailScreen> {

  final MemberController memberController =
  MemberController();
  final CourseController courseController =
  CourseController();
  late CourseModel classroom;
  List<MemberModel> members = [];
  bool isOwner = false;
  bool isLoading = true;
  bool isEditing = false;


  late TextEditingController descriptionController;

  late TextEditingController maxMemberController;
  @override
  @override
  void initState() {
    super.initState();

    classroom = widget.classroom;

    descriptionController = TextEditingController(
      text: classroom.description,
    );

    maxMemberController = TextEditingController(
      text: classroom.maxMembers.toString(),
    );

    loadMembers();
    checkOwner();
  }

  Future<void> loadMembers() async {

    try {

      members = await memberController.getMembers(
        classroom.id!,
      );

    } catch (e) {

      debugPrint(e.toString());

    }

    setState(() {
      isLoading = false;
    });
  }
  Future<void> checkOwner() async {

    final prefs =
    await SharedPreferences.getInstance();

    final userId =
    prefs.getInt("userId");

    print("USER = $userId");
    print("OWNER = ${widget.classroom.ownerId}");

    setState(() {

      isOwner =
          widget.classroom.ownerId == userId;

    });

    print("IS OWNER = $isOwner");
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(classroom.name),
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Card(

              elevation: 3,

              child: Padding(

                padding:
                const EdgeInsets.all(16),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(
                      classroom.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Mã lớp: ${classroom.classCode}",
                    ),

                    const SizedBox(height: 8),

                    isEditing
                        ? TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "Mô tả lớp",
                      ),
                    )
                        : Text(
                      "Mô tả: ${classroom.description}",
                    ),

                    const SizedBox(height: 8),

                    isEditing
                        ? TextField(
                      controller: maxMemberController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Số lượng tối đa",
                      ),
                    )
                        : Text(
                      "Số thành viên: ${members.length}/${classroom.maxMembers}",
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),

            if (isOwner)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(

                  icon: Icon(
                    isEditing
                        ? Icons.save
                        : Icons.edit,
                  ),

                  label: Text(

                    isEditing
                        ? "Lưu thay đổi"
                        : "Chỉnh sửa lớp",

                  ),

                  onPressed: () async {

                    if (!isEditing) {

                      setState(() {

                        isEditing = true;

                      });

                    }else {

                      bool success =
                      await courseController.updateCourse(

                        classroom.id!,

                        descriptionController.text,

                        int.parse(
                          maxMemberController.text,
                        ),

                      );

                      if (success) {

                        classroom =
                        await courseController.getCourseDetail(
                            classroom.id!);

                        descriptionController.text =
                            classroom.description;

                        maxMemberController.text =
                            classroom.maxMembers.toString();

                        setState(() {

                          isEditing = false;

                        });

                        ScaffoldMessenger.of(context).showSnackBar(

                          const SnackBar(

                            content: Text(
                              "Cập nhật thành công",
                            ),

                          ),

                        );

                      } else {

                        ScaffoldMessenger.of(context).showSnackBar(

                          const SnackBar(

                            content: Text(
                              "Cập nhật thất bại",
                            ),

                          ),

                        );

                      }

                    }

                  },

                ),
              ),

            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.menu_book),
                label: const Text("Học Vocabulary"),
                onPressed: () {
                  // TODO
                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => FlashcardScreen(

                        classroom: classroom,

                      ),

                    ),

                  );
                },
              ),
            ),
            const SizedBox(height: 15),

            if (isOwner)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(

                  icon: const Icon(Icons.add_circle),

                  label: const Text(
                    "Tạo Vocabulary",
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) => VocabScreen(

                          classroom: classroom,

                          isOwner: true,

                        ),

                      ),

                    );

                  },

                ),
              ),
            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.quiz),
                label: const Text("Làm Quiz"),
                onPressed: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => QuizListScreen(

                        classroom: classroom,

                        isOwner: isOwner,

                      ),

                    ),

                  );

                },
              ),
            ),

            const SizedBox(height: 10),

// Nút Tạo Quiz (chỉ chủ lớp)
            if (isOwner)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add_box),
                  label: const Text("Tạo Quiz"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CreateQuizScreen(
                          classroom: widget.classroom, // hoặc classroom tùy project
                        ),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 30),
            const Text(

              "Danh sách thành viên",

              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),

            ),

            const SizedBox(height: 10),

            ListView.builder(

              shrinkWrap: true,

              physics:
              const NeverScrollableScrollPhysics(),

              itemCount: members.length,

              itemBuilder: (context, index) {

                final member = members[index];

                return Card(

                  child: ListTile(

                    leading: Icon(

                      member.role == "owner"
                          ? Icons.workspace_premium
                          : Icons.person,

                      color: member.role == "owner"
                          ? Colors.orange
                          : Colors.blue,

                    ),

                    title: Text(member.email),

                    subtitle: Text(

                      member.role == "owner"
                          ? "Chủ lớp"
                          : "Thành viên",

                    ),

                    trailing: isOwner && member.role != "owner"

                        ? IconButton(

                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),

                      onPressed: () async {

                        bool? confirm = await showDialog(

                          context: context,

                          builder: (context) => AlertDialog(

                            title: const Text("Xác nhận"),

                            content: Text(
                              "Bạn có chắc muốn xóa ${member.email} khỏi lớp?",
                            ),

                            actions: [

                              TextButton(

                                onPressed: () {
                                  Navigator.pop(context, false);
                                },

                                child: const Text("Hủy"),

                              ),

                              ElevatedButton(

                                onPressed: () {
                                  Navigator.pop(context, true);
                                },

                                child: const Text("Xóa"),

                              ),

                            ],

                          ),

                        );

                        if (confirm != true) return;

                        bool success = await memberController.removeMember(

                          widget.classroom.id!,

                          member.id,

                        );

                        if (success) {

                          await loadMembers();

                          ScaffoldMessenger.of(context).showSnackBar(

                            const SnackBar(

                              content: Text("Đã xóa thành viên"),

                            ),

                          );

                        } else {

                          ScaffoldMessenger.of(context).showSnackBar(

                            const SnackBar(

                              content: Text("Xóa thất bại"),

                            ),

                          );

                        }

                      },

                    )

                        : null,

                  )

                );

              },

            ),

            const SizedBox(height: 30),



          ],
        ),
      ),
    );
  }
}