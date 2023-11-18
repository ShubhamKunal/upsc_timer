import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:upsc_timer/widgets/custom_text.dart';
import 'package:upsc_timer/router/app_router.dart';
import 'dart:developer' as developer;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}

Widget circularButton(
    {required BuildContext context,
    required String title,
    VoidCallback? onPressed}) {
  return Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
    width: MediaQuery.of(context).size.width * 0.44,
    height: MediaQuery.of(context).size.height * 0.22,
    padding: const EdgeInsets.all(4),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(HexColor("#FFEF8A")),
      ),
      onPressed: onPressed,
      child: CustomText(text: title, size: 12, weight: 500),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: HexColor("#FFEF8A"),
          title: const Center(
              child: CustomText(text: "UPSC Timer", size: 22, weight: 500))),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: SingleChildScrollView(
            // child:
            // Wrap(
            //     spacing: 6.0, // Space between the containers
            //     runSpacing: 6.0, // Space between the rows
            //     children: [
            //       circularButton(
            //         context: context,
            //         title: "Give Mains",
            //         onPressed: () {
            //           developer.log("Mains");
            //           context.go("/timer", extra: 1);
            //         },
            //       ),
            //       circularButton(
            //         context: context,
            //         title: "Give Prelims",
            //         onPressed: () {
            //           developer.log("prelims");
            //           context.go("/timer", extra: 2);
            //         },
            //       ),
            //       circularButton(
            //         context: context,
            //         title: "Write an answer",
            //         onPressed: () {
            //           developer.log("answer");
            //           context.go("/timer", extra: 3);
            //         },
            //       ),
            //       circularButton(
            //         context: context,
            //         title: "Read a passage",
            //         onPressed: () {
            //           developer.log("passage");
            //           context.go("/timer", extra: 4);
            //         },
            //       ),
            //     ]),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    circularButton(
                      context: context,
                      title: "Give Mains",
                      onPressed: () {
                        developer.log("Mains");
                        context.go("/timer", extra: 1);
                      },
                    ),
                    circularButton(
                      context: context,
                      title: "Give Prelims",
                      onPressed: () {
                        developer.log("prelims");
                        context.go("/timer", extra: 2);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    circularButton(
                      context: context,
                      title: "Write an answer",
                      onPressed: () {
                        developer.log("answer");
                        context.go("/timer", extra: 3);
                      },
                    ),
                    circularButton(
                      context: context,
                      title: "Read a passage",
                      onPressed: () {
                        developer.log("passage");
                        context.go("/timer", extra: 4);
                      },
                    ),
                  ],
                ),
                circularButton(
                  context: context,
                  title: "10 seconds tester",
                  onPressed: () {
                    developer.log("passage");
                    context.go("/timer", extra: 5);
                  },
                ),
              ],
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
