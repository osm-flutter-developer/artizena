import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glassify/application.dart';
import 'package:provider/provider.dart';
import 'package:audio_session/audio_session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await _configureAudioSession();

  await Firebase.initializeApp();
  runApp(const GlassifyApplication());

}

Future<void> _configureAudioSession() async {
  final session = await AudioSession.instance;

  await session.configure(AudioSessionConfiguration(
    avAudioSessionCategory: AVAudioSessionCategory.ambient,
    avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
    androidAudioAttributes: const AndroidAudioAttributes(
      contentType: AndroidAudioContentType.sonification,
      usage: AndroidAudioUsage.media,
      flags: AndroidAudioFlags.none,
    ),
    androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck,
  ));
}
