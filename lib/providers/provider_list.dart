import 'package:arm_chat/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  Provider<AuthenticationService>(
      create: (_) => AuthenticationService(FirebaseAuth.instance)),
  StreamProvider<FirebaseUser>(
      create: (context) =>
          context.read<AuthenticationService>().authStateChanges),
];
