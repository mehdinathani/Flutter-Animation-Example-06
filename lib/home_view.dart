import 'package:example06/custom_clipper.dart';
import 'package:example06/donut_clipper.dart';
import 'package:example06/functions.dart';
import 'package:example06/triangle_clipper.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _color = getRandomColor();
  double _width = 100.0;
  double _height = 100.0;

  // To manage the selected radio button value
  int _selectedRadio = 1;
  CustomClipper<Path>? _customClipper = CircleClipper();

  // Function to handle radio button changes
  void _handleRadioButtonChange(int? value) {
    setState(() {
      _selectedRadio = value!;
      switch (_selectedRadio) {
        case 1:
          _customClipper = CircleClipper();
          break;
        case 2:
          _customClipper = DonutClipper();
          break;
        case 3:
          _customClipper = TriangleClipper();
          break;
        default:
          _customClipper = CircleClipper();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tween Animation Builder"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Container with dynamic ClipPath
            Expanded(
              child: Center(
                child: ClipPath(
                  clipper: _customClipper,
                  child: TweenAnimationBuilder(
                    tween: ColorTween(
                      begin: getRandomColor(),
                      end: _color,
                    ),
                    onEnd: () {
                      setState(() {
                        _color = getRandomColor();
                        _width = _width == 100.0
                            ? MediaQuery.of(context).size.width - 10
                            : 100.0;
                        _height = _height == 100.0
                            ? MediaQuery.of(context).size.width - 10
                            : 100.0;
                      });
                    },
                    duration: const Duration(seconds: 1),
                    builder: (context, Color? color, child) {
                      return ColorFiltered(
                        colorFilter: ColorFilter.mode(color!, BlendMode.src),
                        child: child!,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      color: _color,
                      width: _width,
                      height: _height,
                    ),
                  ),
                ),
              ),
            ),

            Column(
              children: [
                // Radio Buttons
                RadioListTile<int>(
                  title: const Text('Circle'),
                  value: 1,
                  groupValue: _selectedRadio,
                  onChanged: _handleRadioButtonChange,
                ),
                RadioListTile<int>(
                  title: const Text('Donut'),
                  value: 2,
                  groupValue: _selectedRadio,
                  onChanged: _handleRadioButtonChange,
                ),
                RadioListTile<int>(
                  title: const Text('Triangle'),
                  value: 3,
                  groupValue: _selectedRadio,
                  onChanged: _handleRadioButtonChange,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
