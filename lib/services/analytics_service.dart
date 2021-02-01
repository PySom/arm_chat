import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class FirebaseAnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver _analyticsObserver;

  static FirebaseAnalyticsObserver get analyticsObserver {
    _analyticsObserver ??= FirebaseAnalyticsObserver(analytics: _analytics);
    return _analyticsObserver;
  }
}
