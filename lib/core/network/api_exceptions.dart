import 'package:dio/dio.dart';
import 'package:inventory_managment/core/errors/api_error.dart';

class ApiExceptions {
  static ApiError handlerError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: 'انتهت مهلة الاتصال بالخادم، يرجى التحقق من الإنترنت.',
        );

      case DioExceptionType.sendTimeout:
        return ApiError(
          message: 'انتهت مهلة إرسال البيانات إلى الخادم، حاول مرة أخرى.',
        );

      case DioExceptionType.receiveTimeout:
        return ApiError(
          message: 'استغرق الخادم وقتاً طويلاً للرد، يرجى المحاولة لاحقاً.',
        );

      case DioExceptionType.badCertificate:
        return ApiError(
          message: 'شهادة الأمان غير صالحة، لا يمكن إتمام الاتصال الآمن.',
        );

      case DioExceptionType.cancel:
        return ApiError(message: 'تم إلغاء الطلب قبل اكتماله.');

      case DioExceptionType.connectionError:
        return ApiError(
          message:
              'تعذر الاتصال بالخادم، تأكد من تشغيل السيرفر أو اتصالك بالشبكة.',
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);

      case DioExceptionType.unknown:
      default:
        return ApiError(message: 'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى.');
    }
  }

  static ApiError _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode;
    final data = response?.data;

    // استخراج رسالة الخطأ القادمة من الباك إند (NestJS) إن وجدت
    if (data is Map<String, dynamic> && data['message'] != null) {
      final serverMessage = data['message'];
      if (serverMessage is List && serverMessage.isNotEmpty) {
        return ApiError(message: serverMessage.first.toString());
      } else if (serverMessage is String && serverMessage.isNotEmpty) {
        return ApiError(message: serverMessage);
      }
    }

    // رسائل افتراضية واضحة حسب رمز الحالة (HTTP Status Code)
    switch (statusCode) {
      case 400:
        return ApiError(
          message: 'البيانات المرسلة غير صحيحة، يرجى مراجعة المدخلات.',
        );
      case 401:
        return ApiError(
          message: 'انتهت صلاحية الجلسة أو بيانات الدخول غير صحيحة.',
        );
      case 403:
        return ApiError(message: 'ليس لديك صلاحية للقيامبهذا الإجراء.');
      case 404:
        return ApiError(message: 'البيانات المطلوبة غير موجودة على الخادم.');
      case 409:
        return ApiError(
          message: 'هذه البيانات مسجلة مسبقاً (تعارض في البيانات).',
        );
      case 422:
        return ApiError(
          message: 'تعذر معالجة البيانات المدخلة، تحقق من الحقول.',
        );
      case 429:
        return ApiError(
          message: 'تم إرسال طلبات كثيرة جداً، يرجى الانتظار قليلاً.',
        );
      case 500:
      case 502:
      case 503:
        return ApiError(
          message: 'حدث خلل في الخادم الداخلي، يرجى المحاولة لاحقاً.',
        );
      default:
        return ApiError(
          message:
              'حدث خطأ من الخادم (رمز الخطأ: ${statusCode ?? "غير معروف"}).',
        );
    }
  }
}
