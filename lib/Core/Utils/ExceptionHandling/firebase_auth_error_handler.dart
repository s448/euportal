import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthErrorHandler {
  // Map FirebaseAuthException codes to user-friendly error messages
  static String mapFirebaseAuthExceptionToMessage(
      FirebaseAuthException exception) {
    switch (exception.code) {
      case 'email-already-in-use':
        return 'عنوان البريد الإلكتروني قيد الاستخدام بالفعل من قبل حساب آخر.';
      case 'invalid-email':
        return 'عنوان البريد الإلكتروني غير صالح.';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً.';
      case 'user-not-found':
        return 'لا يوجد مستخدم لهذا البريد الإلكتروني.';
      case 'wrong-password':
        return 'كلمة المرور غير صحيحة لهذا المستخدم.';
      case 'invalid-credential':
        return 'الاعتمادات غير صحيحة. يرجى التحقق من صحة البريد الإلكتروني وكلمة المرور.';
      default:
        return 'فشلت عملية المصادقة. يرجى المحاولة مرة أخرى.';
    }
  }
}
