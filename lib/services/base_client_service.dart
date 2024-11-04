import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:minimal_app/app/app.locator.dart';
import 'package:minimal_app/app/app.logger.dart';
import 'package:minimal_app/core/error/error.dart';
import 'package:minimal_app/services/shared_preferences_service.dart';

class BaseClientService {
  static String? basePath =
      'https://myback-execute-dot-my-back-401316.uc.r.appspot.com/6-tots-test';

  static Map<String, String> headers = <String, String>{
    // 'Accept': 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  /*
  ///Realiza una peticion `GET`
  ///[url] el segmento de url del endpoint
  ///[headers] son los headers que se mandan en la peticion
  */
  Future<http.Response?> get({
    required String path,
    Uri? uri,
    Map<String, String>? header,
    bool isHeader = true,
  }) async {
    Uri url = uri ?? Uri.parse(<String>[basePath ?? '', path].join('/'));
    try {
      http.Response res = await http.get(
        url,
        headers: await _buildHeaders(
          header,
          isHeader: isHeader,
        ),
      );
      return _processResponse(res);
    } on SocketException catch (e, s) {
      //cuando no hay conexión a internet
      getLogger(e.toString());
      throw BaseClientException(
        type: 'SocketException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    } on TimeoutException catch (e, s) {
      //la api tardo mucho en responder
      getLogger(e.toString());
      throw BaseClientException(
        type: 'TimeoutException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    }
    // catch (e, s) {
    //   ocurre cualquier otra excepcion
    //   log(e.toString());
    //   throw HttpFailure(
    //     type: 'UnknownException',
    //     url: _url.toString(),
    //     message: e.toString(),
    //     stackTrace: s,
    //   );
    // }
  }

  /*
  ///Realiza una peticion `DELETE`
  ///[url] el segmento de url del endpoint
  ///[headers] son los headers que se mandan en la peticion
  */
  Future<http.Response?> delete({
    required String path,
    Uri? uri,
    Map<String, String>? header,
    bool isHeader = true,
    Encoding? encoding,
  }) async {
    Uri url = uri ?? Uri.parse(<String>[basePath ?? '', path].join('/'));
    try {
      http.Response res = await http.delete(
        url,
        headers: await _buildHeaders(
          header,
          isHeader: isHeader,
        ),
        encoding: encoding,
      );
      return _processResponse(res);
    } on SocketException catch (e, s) {
      //cuando no hay conexión a internet
      getLogger(e.toString());
      throw BaseClientException(
        type: 'SocketException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    } on TimeoutException catch (e, s) {
      //la api tardo mucho en responder
      getLogger(e.toString());
      throw BaseClientException(
        type: 'TimeoutException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    }
    // catch (e, s) {
    //   ocurre cualquier otra excepcion
    //   log(e.toString());
    //   throw HttpFailure(
    //     type: 'UnknownException',
    //     url: _url.toString(),
    //     message: e.toString(),
    //     stackTrace: s,
    //   );
    // }
  }

  /*
  ///Realiza una peticion `POST`
  ///[url] el segmento de url del endpoint
  ///[headers] son los headers que se mandan en la peticion
  ///[body] es el cuerpo de la peticion
  */
  Future<http.Response?> post({
    required String path,
    Uri? uri,
    Map<String, String>? header,
    bool isHeader = true,
    Map<String, dynamic>? body,
  }) async {
    Uri url = uri ?? Uri.parse(<String>[basePath ?? '', path].join('/'));
    try {
      http.Response res = await http.post(
        url,
        headers: await _buildHeaders(
          header,
          isHeader: isHeader,
        ),
        body: jsonEncode(body),
      );
      return _processResponse(res);
    } on SocketException catch (e, s) {
      //cuando no hay conexión a internet
      getLogger(e.toString());
      throw BaseClientException(
        type: 'SocketException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    } on TimeoutException catch (e, s) {
      //la api tardo mucho en responder
      getLogger(e.toString());
      throw BaseClientException(
        type: 'TimeoutException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    }
    //  catch (e, s) {
    //   ocurre cualquier otra excepcion
    //   log(e.toString());
    //   throw HttpFailure(
    //     type: 'UnknownException',
    //     url: _url.toString(),
    //     message: e.toString(),
    //     stackTrace: s,
    //   );
    // }
  }

  Future<http.Response?> put({
    required String path,
    Uri? uri,
    Map<String, String>? header,
    bool isHeader = true,
    Map<String, dynamic>? body,
  }) async {
    Uri url = uri ?? Uri.parse(<String>[basePath ?? '', path].join('/'));
    try {
      http.Response res = await http.put(
        url,
        headers: await _buildHeaders(
          header,
          isHeader: isHeader,
        ),
        body: jsonEncode(body),
      );
      return _processResponse(res);
    } on SocketException catch (e, s) {
      //cuando no hay conexión a internet
      getLogger(e.toString());
      throw BaseClientException(
        type: 'SocketException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    } on TimeoutException catch (e, s) {
      //la api tardo mucho en responder
      getLogger(e.toString());
      throw BaseClientException(
        type: 'TimeoutException',
        url: uri.toString(),
        message: e.toString(),
        stackTrace: s,
      );
    }
    //  catch (e, s) {
    //   ocurre cualquier otra excepcion
    //   log(e.toString());
    //   throw HttpFailure(
    //     type: 'UnknownException',
    //     url: _url.toString(),
    //     message: e.toString(),
    //     stackTrace: s,
    //   );
    // }
  }

  ///Procesa la respuesta si es correcta o lanza un error
  http.Response _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response;
      case 204:
        //cuando no se encontro lo pedido
        throw BaseClientException(
          type: 'NoContent',
          statusCode: response.statusCode,
          url: response.request!.url.toString(),
          message: utf8.decode(response.bodyBytes),
        );
      case 400:
        //cuando la peticion esta mal
        throw BaseClientException(
          type: 'BadRequest',
          statusCode: response.statusCode,
          url: response.request!.url.toString(),
          message: utf8.decode(response.bodyBytes),
        );
      case 401:
      case 403:
      case 404:
        //cuando falta autorización
        throw BaseClientException(
          type: 'UnAuthorization',
          statusCode: response.statusCode,
          url: response.request!.url.toString(),
          message: utf8.decode(response.bodyBytes),
        );
      case 500:
      default:
        //cuando ocurrio un error en el servidor o por otra razon
        throw BaseClientException(
          type: 'FetchData',
          statusCode: response.statusCode,
          url: response.request!.url.toString(),
          message: 'An error has ocurred: ${utf8.decode(response.bodyBytes)}',
        );
    }
  }

  Future<Map<String, String>> _buildHeaders(
    Map<String, String>? customHeaders, {
    bool isHeader = true,
  }) async =>
      <String, String>{
        ...headers,
        if (isHeader) ...await _headers,
        ...customHeaders ?? <String, String>{},
      };

  Future<Map<String, String>> get _headers async => await _mobileHeader;

  Future<Map<String, String>> get _mobileHeader async {
    String? bearer =
        locator<SharedPreferencesService>().setCurrentUser.accessToken;
    return <String, String>{
      if (bearer?.isNotEmpty ?? false) 'Authorization': 'Bearer $bearer',
    };
  }
}
