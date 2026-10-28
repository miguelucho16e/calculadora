import 'package:flutter/material.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _output = '0';
  String _currentInput = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operand = '';

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'CE') {
        _output = '0';
        _currentInput = '';
        _num1 = 0;
        _num2 = 0;
        _operand = '';
      } else if (buttonText == 'C') {
        if (_currentInput.isNotEmpty) {
          _currentInput = _currentInput.substring(0, _currentInput.length - 1);
          _output = _currentInput.isEmpty ? '0' : _currentInput;
        }
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '×' || buttonText == '÷') {
        if (_currentInput.isNotEmpty) {
          _num1 = double.parse(_currentInput);
          _operand = buttonText;
          _currentInput = '';
        }
      } else if (buttonText == '.') {
        if (!_currentInput.contains('.')) {
          _currentInput += _currentInput.isEmpty ? '0.' : '.';
          _output = _currentInput;
        }
      } else if (buttonText == '=') {
        if (_operand.isNotEmpty && _currentInput.isNotEmpty) {
          _num2 = double.parse(_currentInput);
          switch (_operand) {
            case '+':
              _output = (_num1 + _num2).toString();
              break;
            case '-':
              _output = (_num1 - _num2).toString();
              break;
            case '×':
              _output = (_num1 * _num2).toString();
              break;
            case '÷':
              _output = _num2 == 0 ? 'Error' : (_num1 / _num2).toString();
              break;
          }

          if (_output.endsWith('.0')) {
            _output = _output.substring(0, _output.length - 2);
          }
          _currentInput = _output;
          _operand = '';
        }
      } else {
        if (_currentInput == '0') {
          _currentInput = buttonText;
        } else {
          _currentInput += buttonText;
        }
        _output = _currentInput;
      }
    });
  }

  Widget _buildButton(String text, {Color? color, Color? textColor}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.grey[850],
            foregroundColor: textColor ?? Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: () => _buttonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.info);
            },
          ),
        ],
      ),
      body: Column(
        children: [

          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                _output,
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Divider(height: 1),
          // Botonera
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildButton('CE', color: Colors.red[700]),
                    _buildButton('C', color: Colors.orange[800]),
                    _buildButton('÷', color: Colors.blueGrey),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('7'),
                    _buildButton('8'),
                    _buildButton('9'),
                    _buildButton('×', color: Colors.blueGrey),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4'),
                    _buildButton('5'),
                    _buildButton('6'),
                    _buildButton('-', color: Colors.blueGrey),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1'),
                    _buildButton('2'),
                    _buildButton('3'),
                    _buildButton('+', color: Colors.blueGrey),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0'),
                    _buildButton('.'),
                    _buildButton('=', color: Colors.teal[700]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}