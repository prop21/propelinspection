import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoadingButton > {
  var _isLoading = false;

  void _onSubmit() {
    setState(() => _isLoading = true);
    Future.delayed(
      const Duration(seconds: 2),
          () => setState(() => _isLoading = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : _onSubmit,
      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
      icon: _isLoading
          ? Container(
        width: 24,
        height: 24,
        padding: const EdgeInsets.all(2.0),
        child: const CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 3,
        ),
      )
          : const Icon(Icons.feedback),
      label: const Text('SUBMIT'),
    );
  }
}