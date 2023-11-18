// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer' as developer;

import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:upsc_timer/widgets/custom_colored_text.dart';

import 'package:upsc_timer/widgets/custom_text.dart';

class TimerScreen extends StatefulWidget {
  final int mode;
  const TimerScreen({
    Key? key,
    required this.mode,
  }) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int duration = 0;
  // final int _duration = 10;
  final CountDownController _controller = CountDownController();
  bool paused = true;
  final player = AudioPlayer();
  int m1 = 1;
  String text = "";
  String text2 = "";
  @override
  void initState() {
    super.initState();
    m1 = widget.mode;
    if (m1 == 1) {
      duration = 3 * 60 * 60;
      text = "Press play and start writing your Mains";
      text2 = "You have 3 hours";
    } else if (m1 == 2) {
      duration = 2 * 60 * 60;
      text = "Press play and start your attempt";
      text2 = "You have 2 hours";
    } else if (m1 == 3) {
      duration = 7 * 60;
      text = '''Press play and start writing your answer.''';
      text2 = "You have 7 mins";
    } else if (m1 == 4) {
      duration = 5 * 60;
      text = "Press play and start reading";
      text2 = "You have 5 mins";
    } else if (m1 == 5) {
      duration = 10;
      text = "Press play and start reading";
      text2 = "You have 10 seconds";
    }
    showSnackBar(context);
  }

  Future<void> playAudio() async {
    developer.log("playing");
    await player.play(AssetSource("alarm.mp3"));
  }

  Future<void> pauseAudio() async {
    await player.pause();
  }

  Future<void> stopAudio() async {
    await player.stop();
  }

  Widget circularButton({required String title, VoidCallback? onPressed}) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
      width: MediaQuery.of(context).size.width * 0.4,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(HexColor("#FFEF8A")),
        ),
        onPressed: onPressed,
        child: CustomText(text: title, size: 16, weight: 500),
      ),
    );
  }

  Widget bigButton() {
    return SizedBox(
      child: IconButton(
        onPressed: () {
          setState(() {
            paused = !paused;
            if (paused) {
              _controller.pause();
              pauseAudio();
            } else {
              _controller.resume();
            }
          });
        },
        icon: Icon(
            (paused)
                ? Icons.play_circle_fill_outlined
                : Icons.pause_circle_filled_outlined,
            color: HexColor("#FFEF8A"),
            size: 100),
      ),
    );
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.green,
      content: CustomColoredText(
        text: text2,
        hexColor: "#FFFFFF",
        size: 16,
        weight: 500,
      ),
      duration: const Duration(seconds: 2),
    );
    Future.delayed(const Duration(seconds: 1), () {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.go("/home"),
            icon: const Icon(Icons.arrow_back_ios_new)),
        backgroundColor: HexColor("#FFEF8A"),
        title: const CustomText(text: "Timer", size: 22, weight: 500),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              CustomText(text: text, size: 18, weight: 500),
              Center(
                child: CircularCountDownTimer(
                  duration: duration,
                  initialDuration: 0,
                  controller: _controller,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 3,
                  ringColor: Colors.grey[300]!,
                  ringGradient: null,
                  fillColor: Colors.black,
                  fillGradient: null,
                  backgroundColor: HexColor("#FFEF8A"),
                  backgroundGradient: null,
                  strokeWidth: 6,
                  strokeCap: StrokeCap.round,
                  textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  textFormat: CountdownTextFormat.S,
                  isReverse: false,
                  isReverseAnimation: false,
                  isTimerTextShown: true,
                  autoStart: false,
                  onStart: () {
                    developer.log('Countdown Started');
                  },
                  onComplete: () {
                    playAudio();
                    Future.delayed(const Duration(seconds: 2), () {
                      stopAudio();
                      setState(() {
                        paused = true;
                      });
                      _controller.reset();
                    });
                    developer.log('Countdown Ended');
                  },
                  onChange: (String timeStamp) {
                    developer.log('Countdown Changed $timeStamp');
                  },
                  timeFormatterFunction: (defaultFormatterFunction, duration) {
                    if (duration.inSeconds == 0) {
                      return "Start";
                    } else if (duration.inSeconds <= 60) {
                      return Function.apply(
                          defaultFormatterFunction, [duration]);
                    } else if (duration.inSeconds < 60 * 60 &&
                        duration.inSeconds > 60) {
                      String minutearm = (duration.inMinutes < 10)
                          ? "0${duration.inMinutes}"
                          : "${duration.inMinutes}";
                      int secondarmInt =
                          duration.inSeconds % (duration.inMinutes * 60);
                      String secondarm = (secondarmInt < 10)
                          ? "0$secondarmInt"
                          : "$secondarmInt";
                      return "$minutearm:$secondarm";
                      // return Function.apply(defaultFormatterFunction, [duration]);
                    } else if (duration.inSeconds >= 60 * 60) {
                      String hourarm = "0${duration.inHours}";
                      String minutearm = (duration.inMinutes < 10)
                          ? "0${duration.inMinutes}"
                          : "${duration.inMinutes}";
                      int secondarmInt =
                          duration.inSeconds % (duration.inMinutes * 60);
                      String secondarm = (secondarmInt < 10)
                          ? "0$secondarmInt"
                          : "$secondarmInt";
                      return "$hourarm:$minutearm:$secondarm";
                      // return Function.apply(defaultFormatterFunction, [duration]);
                    }
                  },
                ),
              ),
              bigButton(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  circularButton(
                    title: "Restart",
                    onPressed: () {
                      setState(() {
                        paused = false;
                      });
                      stopAudio();
                      _controller.restart();
                      // _controller.start();
                    },
                  ),
                  circularButton(
                    title: "Done!",
                    onPressed: () {
                      stopAudio();
                      context.go("/home");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
