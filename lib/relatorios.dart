import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

import 'relatorio_data.dart';

class RelatoriosScreen extends StatefulWidget {
  @override
  createState() => _RelatoriosScreenState();
}

class _RelatoriosScreenState extends State<RelatoriosScreen> {
  DateTime _dateTime = DateTime.now();
  var relatorios = <Relatorio>[];
  var relatoriosShow = <Relatorio>[];
  final formatter = DateFormat('dd/MM/yyyy');

  _getRelatorios() {
    rootBundle.loadString('assets/relatorios.json').then((jsonString) {
      setState(() {
        Iterable list = json.decode(jsonString);
        for (Map value in list) {
          relatorios.add(
            Relatorio(formatter.format(DateTime.parse(value['data'])), value['casos_novos_confirmados'],
                value['obitos_novos_confirmados']),
          );
        }
      });
    });
  }

  @override
  initState() {
    super.initState();
    _getRelatorios();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Relatorios"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text('Filtre por data: '+formatter.format(_dateTime)),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            child: Text('Escolher data'),
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: _dateTime,
                                firstDate: DateTime(2020,03,01),
                                lastDate: DateTime.now(),

                              ).then((date) {
                                if (date != null){
                                  setState(() {
                                    _dateTime = date;
                                    Relatorio aux = Relatorio.getByData(relatorios, formatter.format(date));
                                    if (aux.data.isEmpty)
                                      relatoriosShow = [];
                                    else
                                      relatoriosShow = [aux];
                                  });
                                }
                              });
                            },
                          )
                        ]
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      for (Relatorio relatorio in relatoriosShow.isNotEmpty
                          ? relatoriosShow
                          : relatorios)
                        Container(
                          padding: EdgeInsets.all(5.0),
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Data: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: relatorio.data,
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Novos casos confirmados: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: relatorio
                                              .casos_novos_confirmados
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text: 'Novos óbitos confirmados: ',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        TextSpan(
                                          text: relatorio
                                              .obitos_novos_confirmados
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
