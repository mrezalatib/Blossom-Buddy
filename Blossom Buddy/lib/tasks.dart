import 'package:flutter/material.dart';

class myBlossomTasks extends StatefulWidget {
  @override
  _BlossomBuddyState createState() => _BlossomBuddyState();
}

class _BlossomBuddyState extends State<myBlossomTasks> {
  List<Task> tasks = [];
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController = TextEditingController();

  void _addTask() {
    if (_taskTitleController.text.isNotEmpty) {
      setState(() {
        tasks.add(
          Task(
            title: _taskTitleController.text,
            description: _taskDescriptionController.text,
            creationTime: DateTime.now(),
          ),
        );
      });
      _taskTitleController.clear();
      _taskDescriptionController.clear();
      Navigator.of(context).pop(); // Close the add task dialog after adding
    }
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFCC9C5), // Set the background color of the entire dialog
          title: Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _taskTitleController,
                decoration: InputDecoration(labelText: 'Task Title'),
              ),
              TextField(
                controller: _taskDescriptionController,
                decoration: InputDecoration(labelText: 'Task Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: _addTask,
              child: Text('Add Task',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }



  void _showTaskDetails(Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(task.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.description.isNotEmpty ? task.description : 'No description'),
              SizedBox(height: 10),
              Text('Created on: ${task.creationTime.toLocal()}'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _deleteTask(tasks.indexOf(task)); // Call the delete function
                      Navigator.of(context).pop(); // Close the dialog after deleting
                    },
                    child: Text('Delete Task'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color(0xFFFCC9C5), // Match the style with Start Task Now button
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {}, // Placeholder for Start Task functionality
                    child: Text('Start Task Now'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Color(0xFFFCC9C5),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFB9CBDA)),
      body: Container(
        color: Color(0xFFB9CBDA), // Set your desired background color here
        child: tasks.isEmpty
            ? Center(child: Text('No tasks available.'))
            : ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              child: ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) => _toggleTaskCompletion(index),
                  checkColor: Colors.white, // Color of the tick
                  activeColor: Colors.green, // Background color of the checkbox
                ),
                onTap: () => _showTaskDetails(task),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: Color(0xFFFCC9C5),
        child: Icon(Icons.add),
      ),
    );
  }
}

class Task {
  String title;
  String description;
  DateTime creationTime;
  bool isCompleted;

  Task({
    required this.title,
    this.description = '',
    required this.creationTime,
    this.isCompleted = false,
  });
}
