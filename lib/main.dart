import 'package:flutter/material.dart';

void main() {
  runApp(const AssignmentManagerApp());
}

// ============================================================
// MODEL
// ============================================================

class Assignment {
  String title;
  String subject;
  String dueDate;
  bool completed;
  Color color;

  Assignment({
    required this.title,
    required this.subject,
    required this.dueDate,
    required this.color,
    this.completed = false,
  });
}

// ============================================================
// MAIN APP
// ============================================================

class AssignmentManagerApp extends StatelessWidget {
  const AssignmentManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Assignment Manager',

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
        ),
      ),

      home: const MainScreen(),
    );
  }
}

// ============================================================
// MAIN SCREEN
// ============================================================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int selectedIndex = 0;

  List<Assignment> assignments = [
    Assignment(
      title: "Algorithm Analysis",
      subject: "DAA",
      dueDate: "Oct 05",
      color: Colors.deepPurple,
    ),

    Assignment(
      title: "Network Protocols",
      subject: "Computer Networks",
      dueDate: "Oct 07",
      color: Colors.blue,
    ),

    Assignment(
      title: "Flutter UI Design",
      subject: "Mobile App",
      dueDate: "Oct 10",
      color: Colors.pink,
      completed: true,
    ),

    Assignment(
      title: "DevOps Pipeline",
      subject: "DevOps",
      dueDate: "Oct 12",
      color: Colors.orange,
    ),

    Assignment(
      title: "Data Mining Report",
      subject: "Data Mining",
      dueDate: "Oct 15",
      color: Colors.green,
    ),
  ];

  // ==========================================================
  // ADD ASSIGNMENT
  // ==========================================================

  void addAssignment(
    String title,
    String subject,
    String dueDate,
    Color color,
  ) {
    setState(() {
      assignments.add(
        Assignment(
          title: title,
          subject: subject,
          dueDate: dueDate,
          color: color,
        ),
      );

      selectedIndex = 1;
    });
  }

  // ==========================================================
  // TOGGLE COMPLETION
  // ==========================================================

  void toggleAssignment(int index) {
    setState(() {
      assignments[index].completed =
          !assignments[index].completed;
    });
  }

  // ==========================================================
  // DELETE
  // ==========================================================

  void deleteAssignment(int index) {
    setState(() {
      assignments.removeAt(index);
    });
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {

    final List<Widget> screens = [

      DashboardScreen(
        assignments: assignments,
      ),

      AssignmentsScreen(
        assignments: assignments,
        onToggle: toggleAssignment,
        onDelete: deleteAssignment,
      ),

      AddAssignmentScreen(
        onAdd: addAssignment,
      ),

      CompletedScreen(
        assignments: assignments,
        onToggle: toggleAssignment,
      ),
    ];

    return Scaffold(
      body: screens[selectedIndex],

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
            ),
          ],
        ),

        child: NavigationBar(
          height: 70,

          selectedIndex: selectedIndex,

          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },

          backgroundColor: Colors.white,

          indicatorColor:
              const Color(0xFFE8E5FF),

          destinations: const [

            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: "Home",
            ),

            NavigationDestination(
              icon: Icon(Icons.assignment_outlined),
              selectedIcon: Icon(Icons.assignment),
              label: "Assignments",
            ),

            NavigationDestination(
              icon: Icon(Icons.add_circle_outline),
              selectedIcon: Icon(Icons.add_circle),
              label: "Add",
            ),

            NavigationDestination(
              icon: Icon(Icons.check_circle_outline),
              selectedIcon: Icon(Icons.check_circle),
              label: "Completed",
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// DASHBOARD SCREEN
// ============================================================

class DashboardScreen extends StatelessWidget {

  final List<Assignment> assignments;

  const DashboardScreen({
    super.key,
    required this.assignments,
  });

  @override
  Widget build(BuildContext context) {

    int total = assignments.length;

    int completed =
        assignments.where((a) => a.completed).length;

    int pending = total - completed;

    double progress =
        total == 0 ? 0 : completed / total;

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: [
              Color(0xFFF4F1FF),
              Color(0xFFF8F9FF),
              Colors.white,
            ],
          ),
        ),

        child: SafeArea(

          child: SingleChildScrollView(

            padding: const EdgeInsets.all(20),

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                // ------------------------------------------------
                // HEADER
                // ------------------------------------------------

                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        const Text(
                          "Hello, Ashwini 👋",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF29243D),
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          "Let's manage your assignments!",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),

                    Container(
                      padding: const EdgeInsets.all(12),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple
                                .withOpacity(.15),
                            blurRadius: 12,
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.notifications_none,
                        color: Color(0xFF6C63FF),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // ------------------------------------------------
                // PROGRESS CARD
                // ------------------------------------------------

                Container(

                  width: double.infinity,

                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(

                    borderRadius:
                        BorderRadius.circular(25),

                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF6C63FF),
                        Color(0xFF8B5CF6),
                      ],
                    ),

                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.deepPurple.withOpacity(.25),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Row(

                    children: [

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Your Progress",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "$completed of $total completed",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "$pending assignments remaining",
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(

                        height: 85,
                        width: 85,

                        child: Stack(

                          alignment: Alignment.center,

                          children: [

                            CircularProgressIndicator(
                              value: progress,

                              strokeWidth: 8,

                              backgroundColor:
                                  Colors.white24,

                              valueColor:
                                  const AlwaysStoppedAnimation<
                                      Color>(
                                Colors.white,
                              ),
                            ),

                            Text(
                              "${(progress * 100).round()}%",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // ------------------------------------------------
                // STAT CARDS
                // ------------------------------------------------

                Row(

                  children: [

                    Expanded(
                      child: statCard(
                        "Total",
                        total.toString(),
                        Icons.assignment,
                        Colors.blue,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: statCard(
                        "Pending",
                        pending.toString(),
                        Icons.access_time,
                        Colors.orange,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: statCard(
                        "Done",
                        completed.toString(),
                        Icons.check_circle,
                        Colors.green,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // ------------------------------------------------
                // UPCOMING
                // ------------------------------------------------

                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    const Text(
                      "Upcoming Assignments",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "View all",
                      style: TextStyle(
                        color: Colors.deepPurple[400],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                ...assignments
                    .where((a) => !a.completed)
                    .take(3)
                    .map(
                      (assignment) =>
                          assignmentCard(assignment),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // STAT CARD
  // ==========================================================

  Widget statCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {

    return Container(

      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 10,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
          ),
        ],
      ),

      child: Column(

        children: [

          Icon(
            icon,
            color: color,
            size: 28,
          ),

          const SizedBox(height: 8),

          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // ASSIGNMENT CARD
  // ==========================================================

  Widget assignmentCard(Assignment assignment) {

    return Container(

      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
          ),
        ],
      ),

      child: Row(

        children: [

          Container(

            width: 50,
            height: 50,

            decoration: BoxDecoration(
              color: assignment.color.withOpacity(.12),
              borderRadius:
                  BorderRadius.circular(15),
            ),

            child: Icon(
              Icons.assignment,
              color: assignment.color,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  assignment.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  assignment.subject,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          Container(

            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),

            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(.1),
              borderRadius:
                  BorderRadius.circular(10),
            ),

            child: Text(
              assignment.dueDate,
              style: const TextStyle(
                color: Colors.orange,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ASSIGNMENTS SCREEN
// ============================================================

class AssignmentsScreen extends StatefulWidget {

  final List<Assignment> assignments;

  final Function(int) onToggle;

  final Function(int) onDelete;

  const AssignmentsScreen({
    super.key,
    required this.assignments,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  State<AssignmentsScreen> createState() =>
      _AssignmentsScreenState();
}

class _AssignmentsScreenState
    extends State<AssignmentsScreen> {

  String search = "";

  @override
  Widget build(BuildContext context) {

    List<Assignment> filtered = widget.assignments
        .where(
          (a) =>
              a.title
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||
              a.subject
                  .toLowerCase()
                  .contains(search.toLowerCase()),
        )
        .toList();

    return Scaffold(

      backgroundColor: const Color(0xFFF7F7FB),

      appBar: AppBar(

        backgroundColor:
            const Color(0xFFF7F7FB),

        elevation: 0,

        title: const Text(
          "My Assignments",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF29243D),
          ),
        ),
      ),

      body: Column(

        children: [

          // SEARCH

          Padding(

            padding:
                const EdgeInsets.fromLTRB(
                  20,
                  5,
                  20,
                  15,
                ),

            child: TextField(

              onChanged: (value) {

                setState(() {
                  search = value;
                });
              },

              decoration: InputDecoration(

                hintText:
                    "Search assignments...",

                prefixIcon:
                    const Icon(Icons.search),

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(16),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(

            child: filtered.isEmpty

                ? const Center(
                    child: Text(
                      "No assignments found",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                    ),
                  )

                : ListView.builder(

                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),

                    itemCount:
                        filtered.length,

                    itemBuilder:
                        (context, index) {

                      Assignment assignment =
                          filtered[index];

                      int originalIndex =
                          widget.assignments
                              .indexOf(assignment);

                      return Dismissible(

                        key: ValueKey(assignment),

                        direction:
                            DismissDirection.endToStart,

                        onDismissed: (_) {

                          widget.onDelete(
                            originalIndex,
                          );
                        },

                        background: Container(

                          margin:
                              const EdgeInsets.only(
                            bottom: 12,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.circular(20),
                          ),

                          alignment:
                              Alignment.centerRight,

                          padding:
                              const EdgeInsets.only(
                            right: 25,
                          ),

                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),

                        child: assignmentListCard(
                          assignment,
                          originalIndex,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget assignmentListCard(
    Assignment assignment,
    int index,
  ) {

    return Container(

      margin:
          const EdgeInsets.only(bottom: 12),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
          ),
        ],
      ),

      child: ListTile(

        contentPadding:
            const EdgeInsets.all(12),

        leading: GestureDetector(

          onTap: () {
            widget.onToggle(index);
          },

          child: Container(

            width: 48,
            height: 48,

            decoration: BoxDecoration(
              color: assignment.color
                  .withOpacity(.12),

              borderRadius:
                  BorderRadius.circular(14),
            ),

            child: Icon(
              assignment.completed
                  ? Icons.check_circle
                  : Icons.assignment,
              color: assignment.color,
            ),
          ),
        ),

        title: Text(
          assignment.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            decoration: assignment.completed
                ? TextDecoration.lineThrough
                : null,
          ),
        ),

        subtitle: Padding(

          padding:
              const EdgeInsets.only(top: 5),

          child: Text(
            "${assignment.subject} • Due ${assignment.dueDate}",
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ),

        trailing: IconButton(

          icon: const Icon(
            Icons.delete_outline,
            color: Colors.redAccent,
          ),

          onPressed: () {
            widget.onDelete(index);
          },
        ),
      ),
    );
  }
}

// ============================================================
// ADD ASSIGNMENT SCREEN
// ============================================================

class AddAssignmentScreen extends StatefulWidget {

  final Function(
    String,
    String,
    String,
    Color,
  ) onAdd;

  const AddAssignmentScreen({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddAssignmentScreen> createState() =>
      _AddAssignmentScreenState();
}

class _AddAssignmentScreenState
    extends State<AddAssignmentScreen> {

  final titleController =
      TextEditingController();

  final subjectController =
      TextEditingController();

  final dueDateController =
      TextEditingController();

  Color selectedColor =
      Colors.deepPurple;

  final List<Color> colors = [
    Colors.deepPurple,
    Colors.blue,
    Colors.pink,
    Colors.orange,
    Colors.green,
    Colors.teal,
  ];

  void createAssignment() {

    if (titleController.text.trim().isEmpty ||
        subjectController.text.trim().isEmpty ||
        dueDateController.text.trim().isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text("Please fill all fields"),
        ),
      );

      return;
    }

    widget.onAdd(
      titleController.text.trim(),
      subjectController.text.trim(),
      dueDateController.text.trim(),
      selectedColor,
    );

    titleController.clear();
    subjectController.clear();
    dueDateController.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
          const Color(0xFFF7F7FB),

      appBar: AppBar(

        backgroundColor:
            const Color(0xFFF7F7FB),

        elevation: 0,

        title: const Text(
          "Create Assignment",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF29243D),
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // HEADER CARD

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(

                gradient:
                    const LinearGradient(
                  colors: [
                    Color(0xFF6C63FF),
                    Color(0xFF8B5CF6),
                  ],
                ),

                borderRadius:
                    BorderRadius.circular(25),
              ),

              child: const Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Icon(
                    Icons.edit_note,
                    color: Colors.white,
                    size: 45,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Create New Assignment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "Add your assignment details below.",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // TITLE

            const Text(
              "Assignment Title",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 8),

            TextField(

              controller: titleController,

              decoration: InputDecoration(

                hintText:
                    "Enter assignment title",

                prefixIcon:
                    const Icon(Icons.assignment),

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // SUBJECT

            const Text(
              "Subject",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 8),

            TextField(

              controller:
                  subjectController,

              decoration: InputDecoration(

                hintText:
                    "Enter subject name",

                prefixIcon:
                    const Icon(Icons.book),

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // DUE DATE

            const Text(
              "Due Date",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 8),

            TextField(

              controller:
                  dueDateController,

              decoration: InputDecoration(

                hintText:
                    "Example: Oct 20",

                prefixIcon:
                    const Icon(Icons.calendar_month),

                filled: true,

                fillColor: Colors.white,

                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(15),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // COLOR

            const Text(
              "Choose Color",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 12),

            Row(

              children: colors.map((color) {

                bool selected =
                    selectedColor == color;

                return GestureDetector(

                  onTap: () {

                    setState(() {
                      selectedColor = color;
                    });
                  },

                  child: Container(

                    margin:
                        const EdgeInsets.only(
                      right: 12,
                    ),

                    width: 40,
                    height: 40,

                    decoration: BoxDecoration(

                      color: color,

                      shape: BoxShape.circle,

                      border: selected
                          ? Border.all(
                              color: Colors.black,
                              width: 3,
                            )
                          : null,
                    ),

                    child: selected
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            // ADD BUTTON

            SizedBox(

              width: double.infinity,

              height: 55,

              child: ElevatedButton(

                onPressed:
                    createAssignment,

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      const Color(0xFF6C63FF),

                  foregroundColor:
                      Colors.white,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                  ),
                ),

                child: const Text(
                  "Create Assignment",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// COMPLETED SCREEN
// ============================================================

class CompletedScreen extends StatelessWidget {

  final List<Assignment> assignments;

  final Function(int) onToggle;

  const CompletedScreen({
    super.key,
    required this.assignments,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {

    final completed =
        assignments
            .where((a) => a.completed)
            .toList();

    return Scaffold(

      backgroundColor:
          const Color(0xFFF7F7FB),

      appBar: AppBar(

        backgroundColor:
            const Color(0xFFF7F7FB),

        elevation: 0,

        title: const Text(
          "Completed",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF29243D),
          ),
        ),
      ),

      body: completed.isEmpty

          ? Center(

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Container(

                    padding:
                        const EdgeInsets.all(25),

                    decoration: BoxDecoration(

                      color: Colors.green
                          .withOpacity(.1),

                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 65,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "No completed assignments",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Complete an assignment to see it here.",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )

          : ListView.builder(

              padding:
                  const EdgeInsets.all(20),

              itemCount:
                  completed.length,

              itemBuilder:
                  (context, index) {

                Assignment assignment =
                    completed[index];

                int originalIndex =
                    assignments
                        .indexOf(assignment);

                return Container(

                  margin:
                      const EdgeInsets.only(
                    bottom: 12,
                  ),

                  padding:
                      const EdgeInsets.all(16),

                  decoration:
                      BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(20),

                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(.05),
                        blurRadius: 10,
                      ),
                    ],
                  ),

                  child: Row(

                    children: [

                      Container(

                        width: 50,
                        height: 50,

                        decoration:
                            BoxDecoration(

                          color: Colors.green
                              .withOpacity(.1),

                          borderRadius:
                              BorderRadius.circular(15),
                        ),

                        child: const Icon(
                          Icons.check,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(width: 15),

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              assignment.title,

                              style:
                                  const TextStyle(

                                fontWeight:
                                    FontWeight.bold,

                                fontSize: 16,

                                decoration:
                                    TextDecoration
                                        .lineThrough,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              assignment.subject,

                              style: TextStyle(
                                color:
                                    Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(

                        onPressed: () {

                          onToggle(
                            originalIndex,
                          );
                        },

                        icon: const Icon(
                          Icons.undo,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}