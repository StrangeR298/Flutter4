// lib/screens/calculator_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/calculator_cubit.dart';
import '../cubit/calculator_state.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _massController = TextEditingController();
  final TextEditingController _radiusController = TextEditingController();
  bool agreed = false;

  @override
  void dispose() {
    _massController.dispose();
    _radiusController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Первая космическая скорость')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: BlocBuilder<CalculatorCubit, CalculatorState>(
            builder: (context, state) {
              if (state is InitialCalculatorState || state is LoadingCalculatorState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _massController,
                      decoration: InputDecoration(labelText: 'Масса (кг)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Введите массу';
                        if (double.tryParse(value) == null) return 'Некорректное значение';
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _radiusController,
                      decoration: InputDecoration(labelText: 'Радиус (м)'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Введите радиус';
                        if (double.tryParse(value) == null) return 'Некорректное значение';
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CheckboxListTile(
                      title: Text('Согласен на обработку данных'),
                      value: agreed,
                      onChanged: (bool? value) {
                        setState(() {
                          agreed = value!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && agreed) {
                          double mass = double.parse(_massController.text);
                          double radius = double.parse(_radiusController.text);
                          context.read<CalculatorCubit>().calculate(mass, radius);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('Проверьте данные и согласие')));
                        }
                      },
                      child: Text('Рассчитать'),
                    ),
                  ],
                );
              } else if (state is ResultCalculatorState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Первая космическая скорость: ${state.result.toStringAsFixed(2)} м/с',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          _massController.clear();
                          _radiusController.clear();
                          setState(() {
                            agreed = false;
                          });
                          context.read<CalculatorCubit>().reset();
                        },
                        child: Text('Назад'),
                      )
                    ],
                  ),
                );
              } else {
                return Container(); 
              }
            },
          ),
        ),
      ),
    );
  }
}