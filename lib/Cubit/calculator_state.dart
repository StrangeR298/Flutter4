// lib/cubit/calculator_state.dart

// Абстрактный класс, от которого наследуются все состояния
abstract class CalculatorState {}

// Начальное состояние — форма для ввода данных
class InitialCalculatorState extends CalculatorState {}

// Состояние загрузки — выполняется расчет
class LoadingCalculatorState extends CalculatorState {}

// Состояние результата — вывод результата
class ResultCalculatorState extends CalculatorState {
  final double result;

  ResultCalculatorState({required this.result});

  
}