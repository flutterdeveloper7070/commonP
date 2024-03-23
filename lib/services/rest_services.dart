import 'dart:convert';
import 'package:predator_pest/app/common_imports/common_imports.dart';

class RestConstants {
  RestConstants._privateConstructor();

  static final RestConstants instance = RestConstants._privateConstructor();

  //     ======================= Tokens & Others =======================     //
  String token = "";

  //     ======================= Youtube baseurl & API EndPoints =======================     //
  /// Old api
  // String apiBaseUrl = 'http://predatorpestcont.evirtualservices.net';
  /// New api
  // String apiBaseUrl = 'http://192.168.1.41:8000';

  String apiBaseUrl = 'https://predator-backend.vercel.app';

  //     ======================= API EndPoints =======================     //
  /// Old api end point
  String webservices = 'webservices';

  /// New api end point
  String loginEndPoint = 'api/app/app-login';
  String getDetailsEndPoint = 'api/app/get-details';
  String uploadInfoEndPoint = 'api/app/upload-info';
  String uploadImageEndPoint = 'api/app/upload-img/';

  //     ======================= API action =======================     //

  /// Old api action
  String forgetPassword = 'forgetpassword';
// String login = 'login';
// String getDetails = 'getDetails';
// String uploadInfo = 'uplodeinfo';
// String uploadImage = 'uplodeimage';
}

class RestServices {
  RestServices._privateConstructor();

  static final RestServices instance = RestServices._privateConstructor();

  Future<Map<String, String>> getHeaders() async {
    String? token = await getPrefStringValue(AppSharedPreference.loginToken) ?? "";
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  void showRequestAndResponseLogs(Response? response, Map<String, Object> requestData) {
    logs('•••••••••• Network logs ••••••••••');
    logs('Request url --> ${response!.request!.url}');
    logs('Request headers --> $requestData');
    logs('Status code --> ${response.statusCode}');
    logs('Response headers --> ${response.headers}');
    logs('Response body --> ${response.body}');
    logs('••••••••••••••••••••••••••••••••••');
  }

  Future<String?>? getRestCall({required String? endpoint, String? addOns}) async {
    String? responseData;
    bool connected = await ConnectivityService.instance.isCheckConnectivity();
    if (!connected) {
      return responseData;
    }
    try {
      String requestUrl = addOns != null
          ? '${RestConstants.instance.apiBaseUrl}/$endpoint$addOns'
          : '${RestConstants.instance.apiBaseUrl}/$endpoint';
      Uri? requestedUri = Uri.tryParse(requestUrl);
      Map<String, String> headers = await getHeaders();
      Response response = await get(requestedUri!, headers: headers);

      showRequestAndResponseLogs(response, headers);

      switch (response.statusCode) {
        case 200:
        case 201:
        case 400:
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          if (responseMap.containsKey('success') && responseMap['success'] == true) {
            responseData = response.body;
          } else {
            if (responseMap.containsKey('error') && responseMap['error'] != null) {
              errorToast('${responseMap['error']}');
            }
            responseData = null;
          }
          break;
        case 404:
        case 500:
        case 502:
          logs('${response.statusCode}');
          break;
        case 401:
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          if (responseMap.containsKey('error') && responseMap['error'] != null) {
            logout();
          }
          logs('401 : ${response.body}');
          break;
        default:
          logs('${response.statusCode} : ${response.body}');
          break;
      }
    } on PlatformException catch (e) {
      logs('PlatformException in getRestCall --> ${e.message}');
    }
    return responseData;
  }

  Future<String?>? postRestCall(
      {required String? endpoint,
      required Map<String, dynamic>? body,
      String? addOns,
      String? stringBody,
      bool isShowMessage = true,
      bool isLogin = false}) async {
    String? responseData;
    bool connected = await ConnectivityService.instance.isCheckConnectivity();
    if (!connected) {
      return responseData;
    }

    try {
      String requestUrl = addOns != null
          ? '${RestConstants.instance.apiBaseUrl}/$endpoint$addOns'
          : '${RestConstants.instance.apiBaseUrl}/$endpoint';
      Uri? requestedUri = Uri.tryParse(requestUrl);
      logs('Body map --> ${body.toString()}');
      Map<String, String> headers = await getHeaders();
      if (isLogin) {
        headers['Authorization'] =
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NWRjMmQ0NjA1MGJhMjQ0MTM2MTA4MmEiLCJpYXQiOjE3MDkxMTU0OTMsImV4cCI6MTcwOTExNzI5M30._us903LjTEW3FaFLS84Vh9eC4Rqa3jB4c1a-Wj2hEjI';
      }
      Response response = await post(requestedUri!, body: stringBody ?? jsonEncode(body), headers: headers);
      showRequestAndResponseLogs(response, headers);
      switch (response.statusCode) {
        case 200:
        case 201:
          Map<String, dynamic> responseMap = jsonDecode(response.body);

          if (responseMap['success'] == null || responseMap.containsKey('success') && responseMap['success'] == true) {
            responseData = response.body;
          } else {
            if (!isShowMessage) return responseData;
            if (responseMap.containsKey('error') && responseMap['error'] != null) {
              errorToast('${responseMap['error']}');
            }
            // errorToast('${responseMap['error']}');
            responseData = null;
          }
          break;
        case 400:
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          if (responseMap.containsKey('error') && responseMap['error'] != null) {
            errorToast('${responseMap['error']}');
          }
          break;
        case 404:
        case 500:
        case 502:
          logs('${response.statusCode}${response.headers}');
          break;
        case 401:
          logout();
          logs('401 : ${response.body}');
          // manageExpiredToken(response.body);
          break;
        default:
          logs('${response.statusCode} : ${response.body}');
          break;
      }
    } on PlatformException catch (e) {
      logs('PlatformException in postRestCall --> ${e.message}');
    }
    return responseData;
  }

  Future<String?>? multiPartRestCall(
      {String? endpoint, Map<String, String>? body, List<MultipartFile>? filesList}) async {
    String? responseData;
    try {
      String requestUrl = '${RestConstants.instance.apiBaseUrl}/$endpoint';
      Uri? requestedUri = Uri.tryParse(requestUrl);
      MultipartRequest request = MultipartRequest('POST', requestedUri!);
      Map<String, String> headers = await getHeaders();
      request.headers.addAll(headers);
      if (body!.isNotEmpty) {
        request.fields.addAll(body);
      }
      if (filesList != null && filesList.isNotEmpty) {
        request.files.addAll(filesList);
      }
      StreamedResponse responseStream = await request.send();
      final response = await Response.fromStream(responseStream);
      logs("response $response");

      showRequestAndResponseLogs(response, request.headers);
      logs("request.headers ${request.headers}");

      switch (response.statusCode) {
        case 200:
        case 201:
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          if (responseMap.containsKey('success') && responseMap['success'] == true) {
            responseData = response.body;
          } else {
            responseData = null;
          }
          break;
        case 500:
        case 502:
        case 400:
        case 404:
          logs('${response.statusCode}');
          break;
        case 401:
          logout();
          break;
        default:
          logs('${response.statusCode} : ${response.body}');
          break;
      }
    } on PlatformException catch (e) {
      logs('PlatformException in multiPartRestCall --> ${e.message}');
    }
    return responseData;
  }

/* Future<String?>? deleteRestCall({required String? endpoint, Map<String, dynamic>? body, String? addOns}) async {
    String? responseData;
    try {
      String requestUrl = addOns != null
          ? '${RestConstants.instance.apiBaseUrl}/$endpoint$addOns'
          : '${RestConstants.instance.apiBaseUrl}/$endpoint';
      Uri? requestedUri = Uri.tryParse(requestUrl);

      headers.remove('Content-Type');
      Response response = await delete(requestedUri!, headers: headers, body: body);

      showRequestAndResponseLogs(response, headers);

      switch (response.statusCode) {
        case 200:
        case 422:
        case 201:
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          if (responseMap.containsKey('status') && responseMap['status'] != 0) {
            responseData = response.body;
          } else {
            responseData = null;
          }
          break;
        case 500:
        case 502:
        case 400:
        case 404:
          logs('${response.statusCode}');
          break;
        case 401:
          logs('401 : ${response.body}');
          break;
        default:
          logs('${response.statusCode} : ${response.body}');
          break;
      }
    } on PlatformException catch (e) {
      logs('PlatformException in deleteRestCall --> ${e.message}');
    }
    return responseData;
  }

  Future<String?>? putRestCall(
      {required String? endpoint, required Map<String, dynamic>? body, String? addOns, File? selectedFile}) async {
    String? responseData;
    try {
      String requestUrl = selectedFile != null
          ? addOns!
          : addOns != null
              ? '${RestConstants.instance.apiBaseUrl}/$endpoint/$addOns'
              : '${RestConstants.instance.apiBaseUrl}/$endpoint';
      Uri? requestedUri = Uri.tryParse(requestUrl);

      Map<String, String> header = {
        'Content-Type': selectedFile != null ? 'image/${selectedFile.path.split('.').last}' : ''
      };

      Response response = await put(
        requestedUri!,
        headers: selectedFile != null ? header : headers,
        body: selectedFile != null ? selectedFile.readAsBytesSync() : jsonEncode(body),
      );

      showRequestAndResponseLogs(response, headers);

      switch (response.statusCode) {
        case 200:
        case 201:
          Map<String, dynamic> responseMap = jsonDecode(response.body);
          if (responseMap.containsKey('status') && responseMap['status'] != 0) {
            responseData = selectedFile == null ? response.body : response.statusCode.toString();
          } else {
            responseData = null;
          }
          break;
        case 500:
        case 502:
        case 400:
        case 404:
          logs('${response.statusCode}');
          break;
        case 401:
          logs('401 : ${response.body}');
          break;
        default:
          logs('${response.statusCode} : ${response.body}');
          break;
      }
    } on PlatformException catch (e) {
      logs('PlatformException in putRestCall --> ${e.message}');
    }
    return responseData;
  }

  Future<String?>? patchRestCall(
      {required String? endpoint, required Map<String, dynamic>? body, String? addOns}) async {
    String? responseData;
    try {
      headers['Authorization'] = 'Bearer ${RestConstants.instance.token}';
      String requestUrl = addOns != null
          ? '${RestConstants.instance.apiBaseUrl}/$endpoint/$addOns'
          : '${RestConstants.instance.apiBaseUrl}/$endpoint';
      Uri? requestedUri = Uri.tryParse(requestUrl);

      Response response = await patch(requestedUri!, headers: headers, body: jsonEncode(body));

      showRequestAndResponseLogs(response, headers);

      switch (response.statusCode) {
        case 200:
        case 201:
          responseData = response.body;
          break;
        case 500:
        case 502:
        case 400:
        case 404:
          logs('${response.statusCode}');
          break;
        case 401:
          logs('401 : ${response.body}');
          break;
        default:
          logs('${response.statusCode} : ${response.body}');
          break;
      }
    } on PlatformException catch (e) {
      logs('PlatformException in putRestCall --> ${e.message}');
    }
    return responseData;
  }*/
}
