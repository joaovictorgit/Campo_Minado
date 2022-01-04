import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';
import '../components/resultado_widget.dart';
import '../components/campo_widget.dart';
import '../models/campo.dart';

class CampoMinadoApp extends StatefulWidget {
  //const CampoMinadoApp({Key? key}) : super(key: key);

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {

  bool? _venceu;

  final Tabuleiro _tabuleiro = Tabuleiro(linhas: 20, colunas: 20, qtdeBombas: 3);

  void _reiniciar() {
    setState(() {
      _venceu = null;
      _tabuleiro.reiniciar();
    });
  }

  void _abrir(Campo c) {
    if(_venceu != null) {
      return;
    }
    setState(() {
      try{
        c.abrir();
        if(_tabuleiro.resolvido){
          _venceu = true;
        }
      } on ExplosaoException{
        _venceu = false;
        _tabuleiro.revelarBombas();
      }
    });
  }

  void _alternarMarcacao(Campo c) {
    if(_venceu != null) {
      return;
    }
    setState(() {
      c.alternarMarcacao();
      if(_tabuleiro.resolvido){
        _venceu = true;
      }
    });
  }

  /*Tabuleiro _getTabuleiro(double largura, double altura){
    if(_tabuleiro == null){
      int qtdeColunas = 15;
      double tamanhoCampo = largura / qtdeColunas;
      int qtdeLinhas = (altura/tamanhoCampo).floor();
      
      _tabuleiro = Tabuleiro(linhas: qtdeLinhas, colunas: qt, qtdeBombas: qtdeBombas)
    }
    return _tabuleiro;
  }*/

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: Container(
          child: TabuleiroWidget(
            tabuleiro: _tabuleiro,
            onAbrir: _abrir,
            onAlternarMarcacao: _alternarMarcacao,
          ),
        ),
      ),
    );
  }
}
