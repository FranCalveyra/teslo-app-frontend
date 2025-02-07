import 'package:formz/formz.dart';

// Define input validation errors
enum StockError { empty, negative }

// Extend FormzInput and provide the input type and error type.
class Stock extends FormzInput<int, StockError> {
  // Call super.pure to represent an unmodified form input.
  const Stock.pure() : super.pure(0);

  // Call super.dirty to represent a modified form input.
  const Stock.dirty(int value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == StockError.empty) return 'El campo es requerido';
    if (displayError == StockError.negative) {
      return 'El stock no puede ser negativo';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  StockError? validator(int value) {
    final String valueString = value.toString();
    if (valueString.isEmpty || valueString.trim().isEmpty) {
      return StockError.empty;
    }
    final tryInt = int.tryParse(value.toString()) ?? -1;
    if (tryInt < 0 || value < 0) return StockError.negative;

    return null;
  }
}
