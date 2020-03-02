import 'package:flutter/material.dart';

void showSoundDownloadedSnackBar(BuildContext context, String name) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: name,
            style: TextStyle(
                fontFamily: 'MarkerFelt',
                fontSize: 16,
                color: Theme.of(context).primaryColorLight)),
        TextSpan(
            text: ' теперь доступен в оффлайне.',
            style: TextStyle(
                fontFamily: 'MarkerFelt',
                fontSize: 16,
                color: Theme.of(context).primaryColorLight)),
      ]),
    ),
  ));
}

void showSoundDownloadErrorSnackBar(BuildContext context, String error) {
  Scaffold.of(context).showSnackBar(SnackBar(content: Text(error)));
}

/*
SnackBarAction(
      label: 'Помощь',
      textColor: Colors.red,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SupportPage()),
        );
      },
    ),
 */

void showNoInternetSnackBar(BuildContext context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(
      'Нет подключения - проверьте соединение с интернетом',
      style: TextStyle(
          fontFamily: 'MarkerFelt',
          fontSize: 16,
          color: Theme.of(context).primaryColorLight),
    ),
  ));
}
