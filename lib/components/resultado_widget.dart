import 'package:flutter/material.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  //const ResultadoWidget({Key? key}) : super(key: key);

  final bool? venceu;
  final Function()? onReiniciar;

  ResultadoWidget({
    required this.venceu,
    required this.onReiniciar,
  });

  Color _getCor(){
    if(venceu == null){
      return Colors.yellow;
    } else if(venceu == true){
      return Colors.lightGreen;
    }else {
      return Colors.redAccent;
    }
  }

  IconData _getIcon(){
    if(venceu == null){
      return Icons.sentiment_satisfied;
    } else if(venceu == true){
      return Icons.sentiment_very_satisfied;
    }else {
      return Icons.sentiment_very_dissatisfied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundColor: _getCor(),
            child: IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
              onPressed: onReiniciar,
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(120);
}
