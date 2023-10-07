import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:predi_v2/firebase_options.dart';

import 'android/material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //FirebaseCrashlytics.instance.crash();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(const MyMaterialApp());
}


//TODO tem um bug onde apos iniciar um usuario pelo gmail, o app n salva a situacao do questionario respondido
//TODO outro problema esta ao iniciar um novo usuario e ele nao possui IMC, o relatorio da problema