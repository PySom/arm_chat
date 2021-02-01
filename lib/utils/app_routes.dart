import 'package:arm_chat/screens/auth_screen.dart';
import 'package:arm_chat/screens/chat_screen.dart';
import 'package:arm_chat/screens/splash_screen.dart';

var appRoutes = {
  AuthScreen.id: (context) => AuthScreen(),
  ChatScreen.id: (context) => ChatScreen(),
  SplashScreen.id: (context) => SplashScreen(),
};
