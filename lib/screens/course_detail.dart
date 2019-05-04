import 'package:flutter/material.dart';
import 'package:upg_fisi/infrastructure/course_sqflite_repository.dart';
import 'package:upg_fisi/infrastructure/database_provider.dart';
import 'package:upg_fisi/model/course.dart';

CourseSqfliteRepository courseRepository = CourseSqfliteRepository(DatabaseProvider.get);
final List<String> choices = const <String> [
  'Save Course & Back',
  'Delete Course',
  'Back to List'
];

const mnuSave = 'Save Course & Back';
const mnuDelete = 'Delete Course';
const mnuBack = 'Back to List';

class CourseDetail extends StatefulWidget {
  final Course course;
  CourseDetail(this.course);

  @override
  State<StatefulWidget> createState() => CourseDetailState(course);
}

class CourseDetailState extends State<CourseDetail> {
  Course course;
  CourseDetailState(this.course);
  final _semesterList = [1, 2, 3, 4];
  final _creditList = [3, 4, 6, 8, 10];
  int _semester = 1;
  int _credits = 4;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = course.name;
    descriptionController.text = course.description;
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(course.name),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: select,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding( 
        padding: EdgeInsets.only(top:35.0, left: 10.0, right: 10.0),
        child: ListView(children: <Widget>[Column(
        children: <Widget>[
          TextField(
            controller: nameController,
            style: textStyle,
            onChanged: (value) => this.updateName(),
            decoration: InputDecoration(
              labelText: "Name",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:15.0, bottom: 15.0),
            child: TextField(
            controller: descriptionController,
            style: textStyle,
            onChanged: (value) => this.updateDescription(),
            decoration: InputDecoration(
              labelText: "Description",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          )),
          ListTile(title:DropdownButton<String>(
            items: _semesterList.map((int value) {
              return DropdownMenuItem<String> (
                value: value.toString(),
                child: Text(value.toString()),
              );
            }).toList(),
            style: textStyle,
            value: retrieveSemester(course.semester).toString(),
            onChanged: (value) => updateSemester(value),
          ))
        ],
      )],)
      )
    );
  }

  void select (String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        Navigator.pop(context, true);
        if (course.id == null) {
          return;
        }
        result = await courseRepository.delete(course);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Delete Course"),
            content: Text("The Course has been deleted"),
          );
          showDialog(
            context: context,
            builder: (_) => alertDialog);
          
        }
        break;
        case mnuBack:
          Navigator.pop(context, true);
          break;
      default:
    }
  }

  void save() {
    if (course.id != null) {
      debugPrint('update');
      courseRepository.update(course);
    }
    else {
      debugPrint('insert');
      courseRepository.insert(course);
    }
    Navigator.pop(context, true);
  }

  void updateSemester(String value) {
    switch (value) {
      case "1":
        course.semester = 1;
        break;
      case "2":
        course.semester = 2;
        break;
      case "3":
        course.semester = 3;
        break;
      case "4":
        course.semester = 4;
        break;
    }
    setState(() {
     _semester = int.parse(value);
    });
  }

  int retrieveSemester(int value) {
    return _semesterList[value-1];
  }

  void updateName(){
    course.name = nameController.text;
  }

  void updateDescription() {
    course.description = descriptionController.text;
  }
}
