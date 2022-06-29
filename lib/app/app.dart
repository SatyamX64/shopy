import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './router.dart';
import '/data/repos/cart_controller.dart';
import '/data/source/data_source.dart';
import '/ui/catalogue/catalogue_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataController(DataSource()),
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        initialRoute: CatalogueScreen.route,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
