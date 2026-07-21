import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flovix_kitchen/screens/chucker_debug_service.dart';
import 'package:flovix_kitchen/services/session_manager/session_controller.dart';
import 'package:flovix_kitchen/utils/exceptions/app_exceptions.dart';
import 'package:flovix_kitchen/utils/network_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:chucker_flutter/chucker_flutter.dart';

import 'base_api_services.dart';


/// Avoid huge strings in VM debugger / devtools (POS invoice bodies can be MB+).
const int _kMaxApiLogChars = 4096;

void _logHttpPayload(String label, String url, String payload) {
  if (!kDebugMode) return;
  final len = payload.length;
  final clipped =
      len > _kMaxApiLogChars ? '${payload.substring(0, _kMaxApiLogChars)}…' : payload;
  final line = '[API] $label $url bytes=$len $clipped';
  debugPrint(line);
  log(line);
}

class NetworkServices extends BaseApiServices {
  /// Release/profile: plain client unless Chucker is enabled via secret gesture.
  /// Debug: Chucker for local inspection.
  ///
  /// Typed as [dynamic]: `http.Client` and [ChuckerHttpClient] are both usable
  /// HTTP clients but do not share a single assignable static supertype in
  /// this package graph.
  bool? _usesChuckerClient;
  late dynamic _httpClient;

  NetworkServices() {
    _httpClient = _createHttpClient();
  }

  dynamic get _client {
    final useChucker = ChuckerDebugService.shouldUseChucker;
    if (_usesChuckerClient != useChucker) {
      _httpClient = _createHttpClient();
    }
    return _httpClient;
  }

  dynamic _createHttpClient() {
    final useChucker = ChuckerDebugService.shouldUseChucker;
    _usesChuckerClient = useChucker;
    if (kDebugMode) {
      debugPrint(
        '[API] HTTP client: ${useChucker ? "ChuckerHttpClient" : "http.Client"}',
      );
    }
    return useChucker ? ChuckerHttpClient(http.Client()) : http.Client();
  }

  @override
  Future<dynamic> getGetApi(String url,
      {Map<String, String>? params,
      Map<String, String>? headers,
      bool isToken = true}) async {
    dynamic jsonResponse;
    dynamic headerWithToken =
        await NetworkUtils.getHeaderWithToken(isToken: isToken);
    
    try {
      final uri = params != null && params.isNotEmpty
          ? Uri.parse(url).replace(queryParameters: params)
          : Uri.parse(url);
      debugPrint('[API] GET $uri');
      final response = await _client
          .get(uri, headers: headerWithToken)
          .timeout(const Duration(seconds: 500));
      if (kDebugMode) {
        debugPrint('[API] GET $uri → ${response.statusCode}');
        _logHttpPayload('GET response', uri.toString(), response.body);
      }
      jsonResponse = returnResponse(response: response);
    } on TimeoutException {
      throw RequestTimeoutException('Time out exception');
    } on AppExceptions {
      rethrow;
    } on http.ClientException catch (e) {
      if (kDebugMode) debugPrint('[API] Network error: $e');
      throw NoInternetException('Please connect to the internet');
    } catch (e) {
      if (kDebugMode) debugPrint('[API] Request failed: $e');
      throw NoInternetException('Please connect to the internet');
    }
    // throw UnimplementedError();
    return jsonResponse;
  }

  @override
  Future<dynamic> updateApi(
    String url,
    dynamic data, {
    Map<String, String>? params,
    Map<String, String>? headers,
    bool isToken = true,
  }) async {
    dynamic jsonResponse;
    //  dynamic headerWithToken = await NetworkUtils.getHeaderWithToken(isToken: isToken);
    dynamic headerWithToken =
        await NetworkUtils.getHeaderWithToken(isToken: isToken);

    
    try {
      final uri = params != null && params.isNotEmpty
          ? Uri.parse(url).replace(queryParameters: params)
          : Uri.parse(url);
      
      
      

      final body = jsonEncode(data);
      _logHttpPayload('put body', uri.toString(), body);
      final response = await _client
          .put(uri, headers: headerWithToken, body: body)
          .timeout(const Duration(seconds: 500));
      
      jsonResponse = returnResponse(response: response);
    } on TimeoutException {
      throw RequestTimeoutException('Time out exception');
    } on AppExceptions {
      rethrow;
    } on http.ClientException catch (e) {
      if (kDebugMode) debugPrint('[API] Network error: $e');
      throw NoInternetException('Please connect to the internet');
    } catch (e) {
      if (kDebugMode) debugPrint('[API] Request failed: $e');
      throw NoInternetException('Please connect to the internet');
    }
    // throw UnimplementedError();
    return jsonResponse;
  }

  @override
  Future<dynamic> getPostApi(String url, dynamic data,
      {Map<String, String>? headers,
      bool isToken = true,
      bool isLogin = false}) async {
    dynamic jsonResponse;
    dynamic headerWithToken =
        await NetworkUtils.getHeaderWithToken(isToken: isToken);

      final body = jsonEncode(data);
      _logHttpPayload('post body', url, body);
      try {
        final response = await _client
            .post(
              Uri.parse(url),
              headers: headerWithToken,
              body: body,
            )
            .timeout(const Duration(seconds: 1000));

        _logHttpPayload('post response', url, response.body);

        jsonResponse = returnResponse(response: response);
        return jsonResponse;
      } on TimeoutException {
        throw RequestTimeoutException('Time out exception');
      } on AppExceptions {
        // Preserve API errors (e.g. device_already_in_use) for FlushBar.
        rethrow;
      } on http.ClientException catch (e) {
        if (kDebugMode) debugPrint('[API] Network error: $e');
        throw NoInternetException('Please connect to the internet');
      } catch (e) {
        if (kDebugMode) debugPrint('[API] Request failed: $e');
        throw NoInternetException('Please connect to the internet');
      }

  }
  dynamic returnResponse({required http.Response response, isGbg = false}) {
    dynamic jsonResponse = jsonDecode(response.body);
    
    final bool isSuccess =
        jsonResponse['success'] == true || jsonResponse["status"] == "success";
    if (isSuccess) {

      return jsonResponse;
    }
    else if (response.statusCode==401) {
      throw UnauthorizedException(
        (jsonResponse['message'] ?? 'Unauthorized').toString(),
      );
    }
    else if (jsonResponse['success'] == false) {
      throw FetchDataException(
        (jsonResponse['message'] ?? 'Request failed').toString(),
      );
    } else {
      debugPrint("jsonResponse['message'] ${jsonResponse['message']}");
      throw FetchDataException(
        (jsonResponse['message'] ?? 'Request failed').toString(),
      );
    }

  }
  /*dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorizedException(response.body.toString());
      case 403:
        throw UnauthorizedException(response.body.toString());
      case 500:
        throw FetchDataException(response.body.toString());
      case 422:
        throw FetchDataException("response.body.toString()");
      case 302:
        throw ValidationException(response.reasonPhrase.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }**/

  @override
  Future<dynamic> postFormDataApi({
    required String url,
    required String filePaths,
     bool isCustomerImage=false,
    String? fileFieldName,
    Map<String, String>? fields,
  }) async {
    dynamic jsonResponse;
    
    try {
      await SessionController().getUserFromPreference();
      String? token = SessionController.user?.token ?? "";

      
      var headers2 = <String, String>{
        "Accept":"application/json",
         "Authorization": "Bearer $token",
      };
      
      
      
      
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(url))
            ..fields.addAll(fields ?? {})
            ..headers.addAll(headers2);
      if (filePaths != null && filePaths.isNotEmpty) {
        final multipartFieldName = fileFieldName ??
            (isCustomerImage ? 'cus_img' : 'file');
        request.files.add(
          await http.MultipartFile.fromPath(multipartFieldName, filePaths),
        );
      }

      final http.StreamedResponse response = await _client.send(request);
      final respStr = await response.stream.bytesToString();
      
      var responseBody = jsonDecode(respStr);
      
      

      if (responseBody["status"] == "success"||responseBody["success"] == true) {
        return responseBody;
      } else {}
    } on TimeoutException {
      throw RequestTimeoutException();
    } on AppExceptions {
      rethrow;
    } on http.ClientException catch (e) {
      if (kDebugMode) debugPrint('[API] Network error: $e');
      throw NoInternetException('Please connect to the internet');
    } catch (e) {
      if (kDebugMode) debugPrint('[API] Request failed: $e');
      rethrow;
    }
  }

  Future<dynamic> getDeleteApi(String url,
      {Map<String, String>? headers}) async {
    dynamic jsonResponse;
    dynamic headerWithToken =
        await NetworkUtils.getHeaderWithToken(isToken: true);

    

    try {
      final response = await _client
          .delete(Uri.parse(url), headers: headerWithToken)
          .timeout(const Duration(seconds: 500));

      
      jsonResponse = returnResponse(response: response);
    } on TimeoutException {
      throw RequestTimeoutException('Time out exception');
    } on AppExceptions {
      rethrow;
    } on http.ClientException catch (e) {
      if (kDebugMode) debugPrint('[API] Network error: $e');
      throw NoInternetException('Please connect to the internet');
    } catch (e) {
      if (kDebugMode) debugPrint('[API] Request failed: $e');
      throw NoInternetException('Please connect to the internet');
    }

    return jsonResponse;
  }
}
