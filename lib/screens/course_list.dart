import 'package:flutter/material.dart';
import 'package:upg_fisi/infrastructure/course_sqflite_repository.dart';
import 'package:upg_fisi/infrastructure/database_provider.dart';
import 'package:upg_fisi/model/course.dart';
import 'package:upg_fisi/screens/course_detail.dart';

class CourseList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CourseListState();
}

class CourseListState extends State<CourseList> {
  CourseSqfliteRepository courseRepository = CourseSqfliteRepository(DatabaseProvider.get);
  List<Course> courses;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (courses == null) {
      courses = List<Course>();
      getData();
    }
    return Scaffold(
      body: courseListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          navigateToDetail(Course('', 1, 4, ''));
        }
        ,
        tooltip: "Add new Course",
        child: new Icon(Icons.add),
      ),
    );
  }
  
  ListView courseListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(this.courses[position].semester),
              child:Text(this.courses[position].semester.toString()),
            ),
          title: Text(this.courses[position].name),
          subtitle: Text(this.courses[position].credits.toString()),
          onTap: () {
            debugPrint("Tapped on " + this.courses[position].id.toString());
            navigateToDetail(this.courses[position]);
          },
          ),
        );
      },
    );
  }
  
  void getData() {    
      final coursesFuture = courseRepository.getList();
      coursesFuture.then((courseList) {
        setState(() {
          courses = courseList;
          count = courseList.length;
        });
        debugPrint("Items " + count.toString());
      });
  }

  Color getColor(int semester) {
    switch (semester) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.yellow;
        break;
      case 4:
        return Colors.green;
        break;
      default:
        return Colors.green;
    }
  }

  void navigateToDetail(Course course) async {
    bool result = await Navigator.push(context, 
        MaterialPageRoute(builder: (context) => CourseDetail(course)),
    );
    if (result == true) {
      getData();
    }
  }
}
