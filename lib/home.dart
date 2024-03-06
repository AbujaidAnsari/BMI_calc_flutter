import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;
  signout() async{
    await FirebaseAuth.instance.signOut();
  }
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  String _selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My BMI'),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg2.png'), // Set your background image
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/bmi_logo.png', height: 100), // Add your logo image
              SizedBox(height: 30),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  prefixIcon: Icon(Icons.height), // Add height icon
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  prefixIcon: Icon(Icons.fitness_center), // Add weight icon
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age (years)',
                  prefixIcon: Icon(Icons.person), // Add person icon
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
                items: <String>['Male', 'Female'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.accessibility), // Add gender icon
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _calculateBMI();
                },
                child: Text('Calculate BMI'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (()=>signout()),
      child: Icon(Icons.login_rounded),
      ),
    );
  }

  void _calculateBMI() {
    double height = double.tryParse(_heightController.text) ?? 0.0;
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    int age = int.tryParse(_ageController.text) ?? 0;

    if (height <= 0 || weight <= 0 || age <= 0) {
      setState(() {
        var _bmiResult = 0.0;
        var _bmiFeedback = '';
      });
      return;
    }

    double bmi = weight / ((height / 100) * (height / 100));
    String feedback = '';

    if (_selectedGender == 'Male') {
      if (age >= 20 && age <= 39) {
        if (bmi < 8.5) {
          feedback = 'Low BMI';
        } else if (bmi >= 8.5 && bmi <= 20.7) {
          feedback = 'Normal BMI';
        } else if (bmi > 20.7) {
          feedback = 'High BMI';
        }
      } else if (age >= 40 && age <= 59) {
        if (bmi < 11) {
          feedback = 'Low BMI';
        } else if (bmi >= 11 && bmi <= 22.2) {
          feedback = 'Normal BMI';
        } else if (bmi > 22.2) {
          feedback = 'High BMI';
        }
      } else if (age >= 60) {
        if (bmi < 13) {
          feedback = 'Low BMI';
        } else if (bmi >= 13 && bmi <= 25.4) {
          feedback = 'Normal BMI';
        } else if (bmi > 25.4) {
          feedback = 'High BMI';
        }
      }
    } else if (_selectedGender == 'Female') {
      if (age >= 20 && age <= 39) {
        if (bmi < 7.8) {
          feedback = 'Low BMI';
        } else if (bmi >= 7.8 && bmi <= 19.1) {
          feedback = 'Normal BMI';
        } else if (bmi > 19.1) {
          feedback = 'High BMI';
        }
      } else if (age >= 40 && age <= 59) {
        if (bmi < 9.8) {
          feedback = 'Low BMI';
        } else if (bmi >= 9.8 && bmi <= 21.9) {
          feedback = 'Normal BMI';
        } else if (bmi > 21.9) {
          feedback = 'High BMI';
        }
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          bmiResult: bmi,
          bmiFeedback: feedback,
        ),
      ),
    );
  }
}
// showRecommendations(feedback);

class ResultScreen extends StatelessWidget {
  final double bmiResult;
  final String bmiFeedback;
  String recH=' ';
  String recN=' ';
  String recL=' ';
  
  ResultScreen({required this.bmiResult, required this.bmiFeedback});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    if (bmiFeedback == 'High BMI') {
      bgColor = Colors.red;
      recH='\n\tWorkout Plan: \n 1.Try doing physical activity like walking 30 mins a day.\n\t2.Go to gym at least thrice a week and do a cardio-vascular training.\n\t3.Include Aerobic exercises to burn calories\n\tDiet Plan:\n 1.Drink at least 4 litres water daily\n\t2.Try avoiding sugary and deep fried food items.\n\t 3.Look at the daily calorie count.';
    } else if (bmiFeedback == 'Normal BMI') {
      bgColor = Colors.green;
      recN='\n\tYou are doing well, Keep it up!.';
    } else {
      bgColor = Colors.yellow;
      recL='\n\tWorkout Plan: \n 1.Go to gym at least 3 times a week and do weighlifting exercises to increase muscle mass.\n\t2.Take proper rest.\n\tDiet Plan:\n 1.Drink at least 4 litres water daily\n\t2.Eat more proteins like egg, soy, paneer and chicken.\n\t 3.Intake more calories and nutrients.';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result'),
        centerTitle: true,
      ),
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'BMI: ${bmiResult.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              bmiFeedback,
              style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
            ),
            Text(
              recH,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              recN,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            Text(
              recL,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (()=>signout()),
      child: Icon(Icons.login_rounded),
      ),

    );
  }
  
  signout() {}
}

// class ResultScreen extends StatelessWidget {
//   final double bmiResult;
//   final String bmiFeedback;

//   ResultScreen({required this.bmiResult, required this.bmiFeedback});

//   @override
//   Widget build(BuildContext context) {
//     Color bgColor;
//     String recommendationTitle = '';
//     String recommendationDescription = '';

//     // Determine background color and set recommendations based on BMI feedback
//     if (bmiFeedback == 'High BMI') {
//       bgColor = Colors.red;
//       recommendationTitle = 'High BMI Recommendations';
//       recommendationDescription = 'To maintain your BMI, consider the following:';
//       _showHighBMIRecommendations(context);
//     } else if (bmiFeedback == 'Low BMI') {
//       bgColor = Colors.green;
//       recommendationTitle = 'Low BMI Recommendations';
//       recommendationDescription = 'To increase your BMI, consider the following:';
//       _showLowBMIRecommendations(context);
//     } else {
//       bgColor = Colors.yellow;
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('BMI Result'),
//         centerTitle: true,
//       ),
//       backgroundColor: bgColor,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'BMI: ${bmiResult.toStringAsFixed(2)}',
//               style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               bmiFeedback,
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             if (recommendationTitle.isNotEmpty) ...[
//               Text(
//                 recommendationTitle,
//                 style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 recommendationDescription,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16.0),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   // Function to display recommendations for high BMI
//   void _showHighBMIRecommendations(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('High BMI Recommendations'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Diet:', style: TextStyle(fontWeight: FontWeight.bold)),
//               Text('Recommendations for maintaining high BMI'),
//               SizedBox(height: 10),
//               Text('Workout:', style: TextStyle(fontWeight: FontWeight.bold)),
//               Text('Recommendations for maintaining high BMI'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Function to display recommendations for low BMI
//   void _showLowBMIRecommendations(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Low BMI Recommendations'),
//           content: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text('Diet:', style: TextStyle(fontWeight: FontWeight.bold)),
//               Text('Recommendations for increasing low BMI'),
//               SizedBox(height: 10),
//               Text('Workout:', style: TextStyle(fontWeight: FontWeight.bold)),
//               Text('Recommendations for increasing low BMI'),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

    // BMI calculation logic
  


  