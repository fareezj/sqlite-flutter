import 'package:flutter/material.dart';
import 'package:flutter_sqlite_sample/db/database-helper.dart';
import 'package:flutter_sqlite_sample/main.dart';
import 'package:flutter_sqlite_sample/model/dog.dart';
import 'package:flutter_sqlite_sample/viewModel/dog-view-model.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<List<Map>> _dogData;

  DogViewModel dogViewModel = DogViewModel();
  var fido = Dog(id: 0, name: 'Fido', age: 20);
  var john = Dog(id: 1, name: 'John', age: 20);

  @override
  void initState() {
    super.initState();
    _dogData = dogViewModel.getData();
  }

  addNewDog() {
    dogViewModel.insertDog(fido);
    dogViewModel.insertDog(john);
  }

  updateDog() {
    Map<String, dynamic> updateDogVal = {"id": 2, "name": 'Bob', "age": 30};
    dogViewModel.updateDog(updateDogVal, 0);
  }

  deleteDog() {
    int id = 2;
    dogViewModel.deleteDog(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            ElevatedButton(
              onPressed: () => addNewDog(),
              child: Text('Add Dog'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green;
                  }
                  return Colors.amber;
                }),
              ),
            ),
            ElevatedButton(
              onPressed: () => updateDog(),
              child: Text('Update Dog'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green;
                  }
                  return Colors.amber;
                }),
              ),
            ),
            ElevatedButton(
              onPressed: () => deleteDog(),
              child: Text('Delete Dog'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.green;
                  }
                  return Colors.amber;
                }),
              ),
            ),
            Container(
              child: FutureBuilder<List<Map>>(
                  future: _dogData,
                  builder: (
                      BuildContext context,
                      AsyncSnapshot<List<Map>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                        return(
                        ListTile(
                          title: Text('${snapshot?.data[index]}'),
                        )
                        );
                      });
                    } else
                      return Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text('Result: ${snapshot.data}'),
                      );
                  }),
            )
          ],
        )),
      ),
    );
  }
}
