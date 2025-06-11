// lib/cubit/calculator_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'calculator_state.dart';
import 'dart:math';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(InitialCalculatorState());

  // Метод для расчета первой космической скорости
  void calculate(double mass, double radius) {
    emit(LoadingCalculatorState()); // Переход к состоянию загрузки

    const double G = 6.67430e-11; // Гравитационная постоянная
    double firstCosmicSpeed = sqrt((G * mass) / radius);

    emit(ResultCalculatorState(result: firstCosmicSpeed)); // Переход к результату
  }

  // Метод для возврата к начальному экрану
  void reset() {
    emit(InitialCalculatorState());
  }
}