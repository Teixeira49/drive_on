import 'package:dio/dio.dart';
import 'package:retry/retry.dart';

import '../../../../../core/network/network_url.dart';
import '../../../domain/models/security_contacts_model.dart';
import '../../entities/security_contacts.dart';
import 'main_menu_datasource_abst.dart';


class MainMenuRemoteDatasourceImpl implements MainMenuRemoteDatasource {

  final Dio dio = Dio();

  bool _isFetching = false;

  bool get isFetching => _isFetching;

  @override
  Future<List<SecurityContacts>> getListSecurityContacts(int userId) async {
    if (!_isFetching) {
      _isFetching = true;
    }

    const r = RetryOptions(maxAttempts: 3);

    final resp = await r.retry(() => dio.get('$apiUrl/security-contacts/$userId',
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
        ));

    if (resp.statusCode == null) {

    } else {
      switch(resp.statusCode!) {
        case 200:
          final items = (resp.data as List)
              .map((item) => SecurityContactsModel.fromJson(item))
              .toList();
          return items;
        //case 400:
        //  return resp.statusMessage != null ? resp.statusMessage! : "UnnamedError";
      }
    }
    return resp.data;
  }

}