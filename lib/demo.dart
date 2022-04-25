import 'package:flutter/material.dart';
import 'package:teste_sqlite/data_base/helper.dart';
import 'package:teste_sqlite/models/contacts.dart';

class Demo extends StatefulWidget {
  Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.blue,
        centerTitle: true,
        title: Text('Flutter SQLite'),
      ),
      //ADICIONANDO O CONSTRUTOR FUTURO DE CONTACTS
      body: FutureBuilder<List<Contact>>(
        future: DBHelper.readContacts(),//lendo a lista de contacts 
        builder:(BuildContext context, AsyncSnapshot<List<Contact>> snapshot){
          //SE O snapshot não tem dados ainda 
            if(!snapshot.hasData){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Carregando...')
                  ],
                ),
            );
          }
          //SE O snapshot retornar vazio [], mostra o texto
          //SE NÃO MOSTRA A LISTA DE CONTACT
          return snapshot.data!.isEmpty?
          Center(
            child: Text('Sem Contatos na lista ainda'),
            )
            :ListView(
                children: snapshot.data!.map((contacts){
                  return Center(
                    child: ListTile(
                      title: Text(contacts.name),
                      subtitle: Text(contacts.contact),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){},
                      ),
                    ),
                  );
              }).toList(),
          );
        },            
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
      ),
    );
  }
}