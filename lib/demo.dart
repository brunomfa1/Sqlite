import 'package:flutter/material.dart';
import 'package:flutter_video/page/add_contact.dart';
import 'package:flutter_video/models/contacts.dart';
import 'package:flutter_video/data_base/helper.dart';

class Demo extends StatefulWidget {
  Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter SQLite'),
      ),
      //Adiciona a Future Builder para obter os contratos
      body: FutureBuilder<List<Contact>>(
        future: DBHelper.readContacts(), //read contacts list here
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          //Se o snapshot ainda não estiver dados 
          if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Loading...'),
                ],
              ),
            );
          }
          //Se o snapshot retornar vazio [], mostra o texto
          //Se não ele mostra a lista de contatos
          return snapshot.data!.isEmpty
              ? Center(
                  child: Text('No Contact in List yet!'),
                )
              : ListView(
                  children: snapshot.data!.map((contacts) {
                    return Center(
                      child: ListTile(
                        title: Text(contacts.name),
                        subtitle: Text(contacts.contact),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await DBHelper.deleteContacts(contacts.id!);
                            setState(() {
                              //Reconstroi o widget depois de deletar
                            });
                          },
                        ),
                        onTap: () async {
                          //Toque em ListTile, para atualização
                          final refresh = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => AddContacts(
                                        contact: Contact(
                                          id: contacts.id,
                                          name: contacts.name,
                                          contact: contacts.contact,
                                        ),
                                      )));

                          if (refresh) {
                            setState(() {
                              //Se retornar verdadeiro, Reconstroi todo o widget
                            });
                          }
                        },
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final refresh = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddContacts()));

          if (refresh) {
            setState(() {
              //Se retornar verdadeiro, Reconstroi todo o widget
            });
          }
        },
      ),
    );
  }
}
