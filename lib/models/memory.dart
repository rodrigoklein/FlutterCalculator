//@dart=2.9
class Memory {
  String _value = '0';

  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  static const operations = const ['%', '/', 'X', '-', '+', '='];
  String _operation;
  bool _wipeValue = false;
  String _lastCommand;

  void applyCommand(String command) {
    print(_buffer);

    if (_isReplacingOperation(command)) {
      _operation = command;
    }
    print("Last : $_lastCommand -Command : $command");

    if (command == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      //print('Something ' + command);
      //_value += command;
      _addDigit(command);
    }

    _lastCommand = command;
  }

  _isReplacingOperation(String command) {
    return operations.contains(_lastCommand) &&
        operations.contains(command) &&
        _lastCommand != '=' &&
        command != '=';
  }

  _setOperation(String newOperation) {
    //print('Setting Operation ' + newOperation);
    bool isEqualSign = newOperation == '=';

    if (_bufferIndex == 0) {
      if (!isEqualSign) {
        _operation = newOperation;
        _bufferIndex = 1;
        _wipeValue = true;
      }
    } else {
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;

      if (_buffer[0] != null && !_buffer[0].isNaN) {
        _value = _buffer[0].toString();
        if (_value.endsWith('.0')) {
          _value = _value.split('.')[0];
        } else {
          _value = _value;
        }
      }

      _operation = isEqualSign ? null : newOperation;
      _bufferIndex = isEqualSign ? 0 : 1;

      _wipeValue = !isEqualSign;
    }
    _wipeValue = true;
  }

  _calculate() {
    if (_buffer[0] != null &&
        _buffer[1] != null &&
        !_buffer[0].isNaN &&
        !_buffer[1].isNaN) {
      switch (_operation) {
        case '%':
          return _buffer[0] % _buffer[1];
        case '/':
          return _buffer[0] / _buffer[1];
        case 'X':
          return _buffer[0] * _buffer[1];
        case '-':
          return _buffer[0] - _buffer[1];
        case '+':
          return _buffer[0] + _buffer[1];
        default:
          return _buffer[0];
      }
    }
  }

  _addDigit(String digit) {
    final isDot = digit == '.';
    final wipeValue = (_value == '0' && !isDot) || _wipeValue;

    if (isDot && _value.contains('.') && !wipeValue) {
      return;
    }

    final emptyValue = isDot ? '0' : '';
    final currentValue = wipeValue ? emptyValue : _value;
    _value = currentValue + digit;
    _wipeValue = false;

    _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
    print(_buffer[_bufferIndex]);
    print(_buffer);
  }

  _allClear() {
    _value = '0';
    _buffer[0] = 0.0;
    _buffer[1] = 0.0;
    _bufferIndex = 0;
    _wipeValue = false;
    _operation = null;
  }

  String get value {
    return _value;
  }
}
