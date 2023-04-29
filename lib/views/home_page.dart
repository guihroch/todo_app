import 'package:flutter/material.dart';
import 'package:sqflite_primeiro_banco_sozinho/database/database_helper.dart';
import 'package:sqflite_primeiro_banco_sozinho/model/agenda_model.dart';
import 'package:sqflite_primeiro_banco_sozinho/views/adicionar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataBaseHelper dbHelper = DataBaseHelper();
  late Future<List<AgendaModel>> datalist;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    datalist = dbHelper.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Colors.yellow[600],
              child: const Center(
                child: Text(
                  'Minha Agenda',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FutureBuilder<List<AgendaModel>>(
                future: datalist,
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.data!.length == 0) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: Center(
                        child: Text('Nenhuma tarefa adicionada'),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: ((context, index) {
                        String? agendaTitulo =
                            snapshot.data?[index].titulo.toString();
                        String? agendadescricao =
                            snapshot.data?[index].descricao.toString();
                        int? agendaId = snapshot.data?[index].id?.toInt();
                        return Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          decoration: BoxDecoration(color: Colors.yellow[300]),
                          child: Column(
                            children: [
                              ListTile(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      actionsAlignment:
                                          MainAxisAlignment.center,
                                      title: const Center(
                                        child: Text('Excluir tarefa'),
                                      ),
                                      content: const Padding(
                                        padding: EdgeInsets.only(left: 24),
                                        child: Text(
                                            'Deseja realmente excluir essa tarefa?'),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              dbHelper
                                                  .delete(agendaId!.toInt());
                                              snapshot.data!.remove(
                                                  snapshot.data![index]);
                                            });
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Sim'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Não'),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                title: Text(agendaTitulo.toString()),
                                subtitle: Text(agendadescricao.toString()),
                                trailing: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdicionarPage(
                                          titulo: agendaTitulo,
                                          descricao: agendadescricao,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  }
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[600],
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AdicionarPage()));
        },
        child: const Icon(
          Icons.today,
          color: Colors.black,
        ),
      ),
    );
  }
}
