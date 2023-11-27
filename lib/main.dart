import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bcc first homework'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _ecoSwitch = false;
  bool _standardSwitch = false;
  bool _premiumSwitch = false;
  int _totalAmount = 0;
  int _tariff = 1;
  bool _stopTimer = false;

  void _startTimer() {
    setState(() {
      Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        setState(() {
          _counter++;
          calcAmount();
        });
        print(timer.tick.toString());
        if (_stopTimer) {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter km',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  _stopTimer = false;
                  _startTimer();
                },
                child: const Text('start timer'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  _stopTimer = true;
                },
                child: const Text('stop timer'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  setState(() {
                    _counter = 0;
                  });
                },
                child: const Text("reset timer"),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const SizedBox(width: 16),
              Switch(
                  value: _ecoSwitch,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        _standardSwitch = false;
                        _premiumSwitch = false;
                        _tariff = 1;
                        calcAmount();
                      }
                      _ecoSwitch = value;
                    });
                  }),
              const Spacer(),
              if (_ecoSwitch)
                Text(
                  'eco tariff total amount = $_totalAmount',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              const SizedBox(width: 16),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const SizedBox(width: 16),
              Switch(
                  value: _standardSwitch,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        _ecoSwitch = false;
                        _premiumSwitch = false;
                        _tariff = 2;
                        calcAmount();
                      }
                      _standardSwitch = value;
                    });
                  }),
              const Spacer(),
              if (_standardSwitch)
                Text(
                  'standard tariff total amount = $_totalAmount',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              const SizedBox(width: 16),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const SizedBox(width: 16),
              Switch(
                  value: _premiumSwitch,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        _standardSwitch = false;
                        _ecoSwitch = false;
                        _tariff = 3;
                        calcAmount();
                      }
                      _premiumSwitch = value;
                    });
                  }),
              const Spacer(),
              if (_premiumSwitch)
                Text(
                  'premium tariff total amount = $_totalAmount',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              const SizedBox(width: 16),
            ])
          ],
        ),
      ),
    );
  }

  void calcAmount() {
    int firstTenKm = 250 * 10 * _tariff;
    int fromTenToTwentyKm = firstTenKm + (200 * (_counter - 10) * _tariff);
    int total = 0;
    if (_counter <= 10) {
      total = 250 * _counter * _tariff;
    } else if (_counter <= 20) {
      total = fromTenToTwentyKm;
    } else {
      total = fromTenToTwentyKm + (_counter - 20) * 150 * _tariff;
    }
    setState(() {
      _totalAmount = total;
    });
  }
}
