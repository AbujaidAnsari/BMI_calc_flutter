import 'package:bmi_calculator/home.dart';
import 'package:bmi_calculator/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.grey[800]),
        ),
      ),
      home: Wrapper(),
    );
  }
}

// class BMICalculatorScreen extends StatefulWidget {
//   @override
//   _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
// }

// class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
//   TextEditingController _heightController = TextEditingController();
//   TextEditingController _weightController = TextEditingController();
//   TextEditingController _ageController = TextEditingController();
//   String _selectedGender = 'Male';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My BMI'),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/bg2.png'), // Set your background image
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Image.asset('assets/bmi_logo.png', height: 100), // Add your logo image
//               SizedBox(height: 30),
//               TextFormField(
//                 controller: _heightController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Height (cm)',
//                   prefixIcon: Icon(Icons.height), // Add height icon
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _weightController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Weight (kg)',
//                   prefixIcon: Icon(Icons.fitness_center), // Add weight icon
//                 ),
//               ),
//               SizedBox(height: 20),
//               TextFormField(
//                 controller: _ageController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Age (years)',
//                   prefixIcon: Icon(Icons.person), // Add person icon
//                 ),
//               ),
//               SizedBox(height: 20),
//               DropdownButtonFormField<String>(
//                 value: _selectedGender,
//                 onChanged: (newValue) {
//                   setState(() {
//                     _selectedGender = newValue!;
//                   });
//                 },
//                 items: <String>['Male', 'Female'].map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 decoration: InputDecoration(
//                   labelText: 'Gender',
//                   prefixIcon: Icon(Icons.accessibility), // Add gender icon
//                 ),
//               ),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   _calculateBMI();
//                 },
//                 child: Text('Calculate BMI'),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blue,
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _calculateBMI() {
//     double height = double.tryParse(_heightController.text) ?? 0.0;
//     double weight = double.tryParse(_weightController.text) ?? 0.0;
//     int age = int.tryParse(_ageController.text) ?? 0;

//     if (height <= 0 || weight <= 0 || age <= 0) {
//       setState(() {
//         var _bmiResult = 0.0;
//         var _bmiFeedback = '';
//       });
//       return;
//     }

//     double bmi = weight / ((height / 100) * (height / 100));
//     String feedback = '';

//     if (_selectedGender == 'Male') {
//       if (age >= 20 && age <= 39) {
//         if (bmi < 8.5) {
//           feedback = 'Low BMI';
//         } else if (bmi >= 8.5 && bmi <= 20.7) {
//           feedback = 'Normal BMI';
//         } else if (bmi > 20.7) {
//           feedback = 'High BMI';
//         }
//       } else if (age >= 40 && age <= 59) {
//         if (bmi < 11) {
//           feedback = 'Low BMI';
//         } else if (bmi >= 11 && bmi <= 22.2) {
//           feedback = 'Normal BMI';
//         } else if (bmi > 22.2) {
//           feedback = 'High BMI';
//         }
//       } else if (age >= 60) {
//         if (bmi < 13) {
//           feedback = 'Low BMI';
//         } else if (bmi >= 13 && bmi <= 25.4) {
//           feedback = 'Normal BMI';
//         } else if (bmi > 25.4) {
//           feedback = 'High BMI';
//         }
//       }
//     } else if (_selectedGender == 'Female') {
//       if (age >= 20 && age <= 39) {
//         if (bmi < 7.8) {
//           feedback = 'Low BMI';
//         } else if (bmi >= 7.8 && bmi <= 19.1) {
//           feedback = 'Normal BMI';
//         } else if (bmi > 19.1) {
//           feedback = 'High BMI';
//         }
//       } else if (age >= 40 && age <= 59) {
//         if (bmi < 9.8) {
//           feedback = 'Low BMI';
//         } else if (bmi >= 9.8 && bmi <= 21.9) {
//           feedback = 'Normal BMI';
//         } else if (bmi > 21.9) {
//           feedback = 'High BMI';
//         }
//       }
//     }

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ResultScreen(
//           bmiResult: bmi,
//           bmiFeedback: feedback,
//         ),
//       ),
//     );
//   }
// }

// class ResultScreen extends StatelessWidget {
//   final double bmiResult;
//   final String bmiFeedback;

//   ResultScreen({required this.bmiResult, required this.bmiFeedback});

//   @override
//   Widget build(BuildContext context) {
//     Color bgColor;
//     if (bmiFeedback == 'High BMI') {
//       bgColor = Colors.red;
//     } else if (bmiFeedback == 'Normal BMI') {
//       bgColor = Colors.yellow;
//     } else {
//       bgColor = Colors.green;
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
//           ],
//         ),
//       ),
//     );
//   }
// }


//     // BMI calculation logic
  

