import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:too_much_to_do/models/task.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  late final Box box;

  late final DateTime _selectedDate;
  late final TimeOfDay _selectedTimeOfDay;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _taskFormKey = GlobalKey<FormState>();

  _addTask() async {
    Task newTask = Task(
        title: _titleController.text,
        description: _descriptionController.text,
        doBy: DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _selectedTimeOfDay.hour,
            _selectedTimeOfDay.minute),
        completed: false);
    box.add(newTask);
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box('taskBox');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _taskFormKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ShadowsIntoLight',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 1.5,
              ),
              decoration: const InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
                hintText: 'Clean Bathroom',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 1.5,
                ),
              ),
              controller: _titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Task needs a title...';
                }
              },
            ),
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ShadowsIntoLight',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 1.5,
              ),
              decoration: const InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
                hintText: 'Clean Bathroom',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.normal,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 1.5,
                ),
              ),
              controller: _descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Task needs a description...';
                }
              },
            ),
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ShadowsIntoLight',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 1.5,
              ),
              decoration: const InputDecoration(
                labelText: 'Do By Date',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 1.5,
                ),
              ),
              controller: _dateController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Every task needs a date...';
                }
                return null;
              },
              onTap: () {
                setState(() async {
                  var date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  _selectedDate = date!;
                  _dateController.text = date.toString().substring(0, 10);
                });
              },
            ),
            TextFormField(
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'ShadowsIntoLight',
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                letterSpacing: 1.5,
              ),
              decoration: const InputDecoration(
                labelText: 'Do By Time',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  letterSpacing: 1.5,
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 1.5,
                ),
              ),
              controller: _timeController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Every task needs a time...';
                }
                return null;
              },
              onTap: () {
                setState(() async {
                  var time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  _selectedTimeOfDay = time!;
                  _timeController.text = '${time.hour}:${time.minute}';
                });
              },
            ),
            TextButton(
              onPressed: () {
                if (_taskFormKey.currentState!.validate()) {
                  _addTask();
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ShadowsIntoLight',
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
