import 'package:flutter/material.dart';

class AddContacts extends StatefulWidget {
  AddContacts({Key? key}) : super(key: key);

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  //Para o campo Texto
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();  

  @override
  void dispose(){
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contatos'),
      ),
      //Dois campos texto para digitar NOME e CONTACT
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}

//CRIANDO UM METODO CAMPO TEXTO  