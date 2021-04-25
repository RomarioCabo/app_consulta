import 'package:consulta_estados_cidades/ui/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants/colors.dart';
import 'constants/strings.dart';

void main() {
  runApp(
    MaterialApp(
      title: project_name,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale("pt", "BR"),
      ],
      theme: theme(),
      home: HomePage(),
    ),
  );
}
