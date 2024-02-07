import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: MyDemoApp(),
      home: MyApplication(),
    );
  }
}

// class MyDemoApp extends StatelessWidget {
//   const MyDemoApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Clickable Icon"),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 var snackBar = SnackBar(
//                   content: Text("Icon clicked !"),
//                   duration: Duration(seconds: 3),
//                 );
//                 ScaffoldMessenger.of(context).showSnackBar(snackBar);
//               },
//               icon: Icon(Icons.star))
//         ],
//       ),
//       body: Center(
//         child: Text("This is really fun to learn"),
//       ),
//     );
//   }
// }

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Head Empty"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Chipi chipi chapa chapa ...',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 100.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/hqdefault.jpg',
                  height: 70,
                ),
                Image.asset(
                  'assets/hqdefault.jpg',
                  height: 70,
                ),
                Image.asset(
                  'assets/hqdefault.jpg',
                  height: 70,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          var snackBar = SnackBar(
                            content: Text("Icon 1 is clicked!"),
                            duration: Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        icon: Icon(Icons.phone)),
                    Text("Lol"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: () {
                      var snackBar = SnackBar(
                        content: Text("Icon 2 is clicked!"),
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }, icon: Icon(Icons.star)),
                    Text("Lmao"),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: () {
                      var snackBar = SnackBar(
                        content: Text("Icon 3 is clicked!"),
                        duration: Duration(seconds: 2),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }, icon: Icon(Icons.car_crash)),
                    Text("Lfmao"),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 120.0,
            ),
            Text('Dobi dobi daba daba'),
          ],
        ),
      ),
    );
  }
}
