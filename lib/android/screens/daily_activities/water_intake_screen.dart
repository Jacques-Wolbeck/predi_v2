import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:predi_v2/android/widgets/fields/water_intake_field.dart';
import 'package:predi_v2/shared/blocs/patient/patient_bloc.dart';
import 'package:predi_v2/shared/models/patients/patient_model.dart';

import '../../../shared/blocs/patient/patient_event.dart';

class WaterIntakeScreen extends StatefulWidget {
  final PatientModel patient;
  const WaterIntakeScreen({super.key, required this.patient});

  @override
  State<WaterIntakeScreen> createState() => _WaterIntakeScreenState();
}

class _WaterIntakeScreenState extends State<WaterIntakeScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final _formFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  late double _currentLevel;
  double _fillLevel = 0;
  late double _maxFillLevel;

  @override
  void initState() {
    super.initState();
    _currentLevel = widget.patient.waterIntakeValue ?? 0.0;
    _maxFillLevel = (widget.patient.weight! * 30);
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _controller.forward();
    _controller.addListener(() {
      setState(() {
        _fillLevel = (_maxFillLevel / 10) * _controller.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        leading: Padding(
          padding: EdgeInsets.only(
            left: size.width * .05,
            right: size.width * .01,
            top: size.height * .01,
          ),
          child: Image.asset(
            'assets/images/heart.png',
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: size.width * .05, top: size.height * .01),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Voltar',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _body(size),
    );
  }

  Widget _body(Size size) {
    return SafeArea(
      minimum: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Meta de Ingestão Diária de Água',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.bodyLarge!.fontSize),
                ),
              ),
              Text(
                  'Seu consumo de água necessário para o dia é de: ${(widget.patient.weight! * 30).toString()} mL'),
              const SizedBox(height: 16.0),
              _cupContainer(),
              const SizedBox(height: 16.0),
              SizedBox(
                width: 250.0,
                child: Form(
                  key: _formKey,
                  child: WaterIntakeField(
                    onSavedCallback: (value) =>
                        _currentLevel += double.tryParse(value!)!,
                    currentFocus: _formFocus,
                    maxLevel: _maxFillLevel,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _formKey.currentState!.reset();
                        _controller.forward(
                            from: (_currentLevel / _maxFillLevel));
                        widget.patient.waterIntakeValue = _currentLevel;
                        context.read<PatientBloc>().add(
                            UpdatePatientRequested(patient: widget.patient));
                      }
                    },
                    style: OutlinedButton.styleFrom(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        minimumSize: Size(size.width * .2, 45.0)),
                    child: const Text('Adicionar',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8.0),
                  OutlinedButton(
                    onPressed: () {
                      _controller.forward(
                          from: (_currentLevel / _maxFillLevel));

                      setState(() {
                        _currentLevel = 0.0;
                      });
                      widget.patient.waterIntakeValue = _currentLevel;
                      context
                          .read<PatientBloc>()
                          .add(UpdatePatientRequested(patient: widget.patient));
                    },
                    style: OutlinedButton.styleFrom(
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        minimumSize: Size(size.width * .2, 45.0)),
                    child: const Text(
                      'Esvaziar',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cupContainer() {
    return Stack(
      children: [
        Container(
          width: 160,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.2),
            border: const Border(
              right: BorderSide(width: 1.0),
              left: BorderSide(width: 1.0),
              bottom: BorderSide(width: 1.0),
            ),
          ),
          child: Center(
            child: Text(
              '${(_currentLevel).toStringAsFixed(2)}mL - ${((_currentLevel / _maxFillLevel) * 100).toStringAsFixed(2)}%',
              textScaleFactor: 1.1,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ClipPath(
            clipper: CupClipper(_fillLevel),
            child: Container(
              width: 160,
              height: 300 * (_currentLevel / _maxFillLevel),
              decoration: BoxDecoration(
                color: const Color(0xff3B6ABA).withOpacity(.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CupClipper extends CustomClipper<Path> {
  final double fillLevel;

  CupClipper(this.fillLevel);

  @override
  Path getClip(Size size) {
    final path = Path()
      ..addRect(
          Rect.fromLTRB(0, size.height - fillLevel, size.width, size.height));
    /*..addArc(
          Rect.fromCircle(
              center: Offset(size.width, size.height), radius: size.width / 2),
          0,
          3.14);*/

    /*path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);*/

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return this != oldClipper;
  }
}
