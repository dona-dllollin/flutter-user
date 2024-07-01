import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/Providers/add_to_cart_provider.dart';
import 'package:user/Screen/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:user/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          OrderItemProvider(), // Mendaftarkan OrderItemProvider sebagai provider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const FistScreen(),
      ),
    );
  }
}

class FistScreen extends StatefulWidget {
  const FistScreen({super.key});

  @override
  State<FistScreen> createState() => _FistScreenState();
}

class _FistScreenState extends State<FistScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Column(
        children: [
          Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            alignment: Alignment.topLeft,
            child: Image.asset(
              'images/Ellipse_1.png',
            ),
          ),
          Container(
            child: Image.asset(
              'images/Logo.png',
            ),
          ),
          const SizedBox(height: 50),
          Container(
              width: MediaQuery.of(context).size.width *
                  0.6, // Lebar 80% dari lebar layar,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: const Size(double.infinity, 55),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: Text("MENU",
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1.0, 1.0), // Posisi bayangan
                              blurRadius: 2.0, // Jarak blur bayangan
                              color: Color.fromARGB(
                                  64, 0, 0, 0), // Warna bayangan lebih terang
                            ),
                          ],
                        ),
                      )))),
          Expanded(
            child: Container(),
          ),
          Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            alignment: Alignment.bottomRight,
            child: Image.asset(
              'images/Ellipse_2.png',
            ),
          ),
        ],
      )),
    );
  }
}
