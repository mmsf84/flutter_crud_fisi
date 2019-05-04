import 'package:flutter/material.dart';
import 'package:upg_fisi/infrastructure/profesor_sqflite_repository.dart';
import 'package:upg_fisi/infrastructure/database_provider.dart';
import 'package:upg_fisi/model/profesor.dart';
import 'package:upg_fisi/screens/profesor_detail.dart';
import 'package:upg_fisi/app_constants.dart';

class ProfesorList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfesorListState();
}

class ProfesorListState extends State<ProfesorList> {
  ProfesorSqfliteRepository profesorRepository = ProfesorSqfliteRepository(DatabaseProvider.get);
  List<Profesor> profesores;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (profesores == null) {
      profesores = List<Profesor>();
      getData();
    }
    return Scaffold(
      body: profesorListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          navigateToDetail(Profesor('', '', 0));
        }
        ,
        tooltip: "Agregar nuevo Docente",
        child: new Icon(Icons.add),
      ),
    );
  }
  
  ListView profesorListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getColor(this.profesores[position].nivel),
              child:Text(this.profesores[position].lastname.toString().substring(0,1)),
            ),
          title: Text(this.profesores[position].name+" "+this.profesores[position].lastname),
          subtitle: getNivel(this.profesores[position].nivel),
          onTap: () {
            debugPrint("Tapped on " + this.profesores[position].id.toString());
            navigateToDetail(this.profesores[position]);
          },
          ),
        );
      },
    );
  }
  
  void getData() {    
      final profesFuture = profesorRepository.getList();
      profesFuture.then((profesorList) {
        setState(() {
          profesores = profesorList;
          count = profesorList.length;
        });
        debugPrint("Items " + count.toString());
      });
  }

  Color getColor(int nivel) {
    switch (nivel) {
      case 1:
        return Colors.green;
        break;
      case 2:
        return Colors.orange;
        break;
      case 3:
        return Colors.red;
        break;
      default:
        return Colors.green;
    }
  }

  Text getNivel(int nivel){
    switch (nivel) {
      case 1:
        return Text(AppConstants.pregrado);
        break;
      case 2:
        return Text(AppConstants.maestria);
        break;
      case 3:
        return Text(AppConstants.doctorado);
        break;
      default:
        return Text(AppConstants.pregrado);
    }
  }

  void navigateToDetail(Profesor profesor) async {
    bool result = await Navigator.push(context, 
        MaterialPageRoute(builder: (context) => ProfesorDetail(profesor)),
    );
    if (result == true) {
      getData();
    }
  }
}
