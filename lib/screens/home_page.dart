import 'package:flutter/material.dart';
import 'package:flutter_bmi_calculator/core/constants/colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double userHeight = 0.0;
  double userWeight = 0.0;
  double userBmi = 0.0;
  double height = 0;
  double weight = 0;
  int currenIndex = 1;
  String result = "0.0";
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: mainColor,
        child: SafeArea(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: sideColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Write your height (cm)",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: sideColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Write your weight (kg)",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ),
                buildCalculateButton(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    manOrWomanButton(context, 0, sideColor, "Man"),
                    manOrWomanButton(context, 1, sideColor, "Woman"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: sideColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildContainer(context, Colors.green.shade300, "Zayıf"),
                            buildContainer(context, Colors.green, "Normal"),
                            buildContainer(context, Colors.blue, "Kilolu"),
                            buildContainer(context, Colors.red, "Obez"),
                          ],
                        ),
                        Positioned(
                          top: 30,
                          left: buildValue(),
                          child: Icon(Icons.arrow_drop_up),
                        ),
                        Positioned(
                          top: 60,
                          left: MediaQuery.of(context).size.width / 2 - 64,
                          child: Text(
                            "Your BMI is",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 80,
                          left: MediaQuery.of(context).size.width / 2 - 28,
                          child: Icon(Icons.arrow_downward),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 140),
                          child: Center(
                            child: Text(
                              "$result",
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateBMI(double height, double weight) {
    double finalResult = weight / (height * height / 10000);
    String bMI = finalResult.toStringAsFixed(2);
    setState(() {
      result = bMI;
    });
  }

  double buildValue() {
    double value = double.parse(result);
    setState(() {
      if (value < 18) {
        value = 35;
      } else if (value > 18 && value < 25) {
        value = 125;
      } else if (value > 25 && value < 30) {
        value = 215;
      } else if (value > 30) {
        value = 305;
      }
    });
    return value;
  }

  buildContainer(BuildContext context, Color color, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        height: 20,
        width: MediaQuery.of(context).size.width / 4 - 8,
        color: color,
        child: Center(child: Text(text)),
      ),
    );
  }

  void changeIndex(var index) {
    setState(() {
      currenIndex = index;
    });
  }

  manOrWomanButton(BuildContext context, var index, Color color, String name) {
    return GestureDetector(
      onTap: () => changeIndex(index),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.width / 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: currenIndex == index ? color : Colors.grey.shade400,
          ),
          child: Center(
              child: Text(
            name,
            style: TextStyle(
              color: mainColor,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          )),
        ),
      ),
    );
  }

  buildCalculateButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          height = double.parse(heightController.value.text);
          weight = double.parse(weightController.value.text);
        });
        calculateBMI(height, weight);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: sideColor,
            borderRadius: BorderRadius.circular(8),
          ),
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.width / 8,
          child: Center(child: Text("Calculate", style: TextStyle(fontSize: 22))),
        ),
      ),
    );
  }
}
