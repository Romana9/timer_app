import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TimerApp(),
    );
  }
}

class TimerApp extends StatefulWidget {
  const TimerApp({super.key});

  @override
  State<TimerApp> createState() => _TimerAppState();
}

class _TimerAppState extends State<TimerApp> {
  Timer? repeatedFunction;
  Duration duration = const Duration(seconds: 0);
  bool isRunning = false;

  startTimer() {
    repeatedFunction = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        int newSecond = duration.inSeconds + 1;
        duration = Duration(seconds: newSecond);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 40, 43),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 22),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      duration.inHours.toString().padLeft(2, "0"),
                      style: const TextStyle(fontSize: 80),
                    ),
                  ),
                  const Text(
                    "Hours",
                    style: TextStyle(fontSize: 27, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 22),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      duration.inMinutes
                          .remainder(60)
                          .toString()
                          .padLeft(2, "0"),
                      style: const TextStyle(fontSize: 80),
                    ),
                  ),
                  const Text(
                    "Minutes",
                    style: TextStyle(fontSize: 27, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 22),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(
                      duration.inSeconds
                          .remainder(60)
                          .toString()
                          .padLeft(2, "0"),
                      style: const TextStyle(fontSize: 80),
                    ),
                  ),
                  const Text(
                    "Seconds",
                    style: TextStyle(fontSize: 27, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          isRunning
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: repeatedFunction!.isActive
                              ? MaterialStateProperty.all(Colors.red)
                              : MaterialStateProperty.all(Colors.blue),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(15)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        setState(() {
                          if (repeatedFunction!.isActive) {
                            repeatedFunction!.cancel();
                          } else {
                            startTimer();
                          }
                        });
                      },
                      child: Text(
                          repeatedFunction!.isActive ? "Stop Timer" : "Resume",
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white)),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(15)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        repeatedFunction!.cancel();
                        setState(() {
                          duration = const Duration(seconds: 0);
                          isRunning = false;
                        });
                      },
                      child: const Text("Cancel",
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ],
                )
              : ElevatedButton(
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    startTimer();
                    setState(() {
                      isRunning = true;
                    });
                  },
                  child: const Text("Start Timer",
                      style: TextStyle(fontSize: 23, color: Colors.white)),
                )
        ],
      ),
    );
  }
}
