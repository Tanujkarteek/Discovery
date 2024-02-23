import 'package:dio/dio.dart';
import 'package:tuple/tuple.dart';

import '../models/data.dart';

final Dio dio = Dio();
Future<Tuple2<List<WebData>, bool>> getData(int pageNum, bool isReturnEmpty) async {
  try {
    if (!isReturnEmpty) {
      final response = await dio.get('https://api-stg.together.buzz/mocks/discovery?page=$pageNum&limit=10');
      final List data = response.data['data'];
      if (data.isNotEmpty) {
        final List<WebData> webData = data.map((e) => WebData.fromJson(e)).toList();
        isReturnEmpty = false;
        return Tuple2(webData, isReturnEmpty);
      }
      else {
        return Tuple2(<WebData>[], true);
      }
    }
    else {
      return Tuple2(<WebData>[], true);
    }
  } catch (e) {
    print(e);
    return Tuple2(<WebData>[], true);
  }
}