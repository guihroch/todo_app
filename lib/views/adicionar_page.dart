import 'package:flutter/material.dart';
import 'package:sqflite_primeiro_banco_sozinho/database/database_helper.dart';
import 'package:sqflite_primeiro_banco_sozinho/model/agenda_model.dart';
import 'package:sqflite_primeiro_banco_sozinho/views/home_page.dart';

class AdicionarPage extends StatefulWidget {
  String? titulo;
  String? descricao;
  String? id;
  bool? update;
  AdicionarPage({Key? key, this.titulo, this.descricao, this.id, this.update})
      : super(key: key);

  @override
  State<AdicionarPage> createState() => _AdicionarPageState();
}

class _AdicionarPageState extends State<AdicionarPage> {
  DataBaseHelper dbHelper = DataBaseHelper();
  late List<AgendaModel> datalist;
  @override
  void initState() {
    super.initState();
    dbHelper.getDataList();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController tarefaController =
        TextEditingController(text: widget.titulo);
    final TextEditingController descricaoController =
        TextEditingController(text: widget.descricao);
    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        title: const Text(
          'Adicionar Tarefa',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.yellow[600],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: tarefaController,
                decoration: InputDecoration(
                  hintText: 'Tarefa',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                maxLines: 5,
                controller: descricaoController,
                decoration: InputDecoration(
                  hintText: 'Descrição',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: GestureDetector(
                    onTap: () {
                      if (tarefaController.text.isEmpty ||
                          descricaoController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'É obrigatório nomear uma tarefa',
                              textAlign: TextAlign.center,
                            ),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      } else {
                        setState(() {
                          dbHelper.adicionar(AgendaModel(
                              titulo: tarefaController.text,
                              descricao: descricaoController.text));
                          tarefaController.clear();
                          descricaoController.clear();
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green),
                      width: 120,
                      height: 50,
                      child: const Center(
                          child: Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent),
                    width: 120,
                    height: 50,
                    child: const Center(
                        child: Text(
                      'Remover',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
