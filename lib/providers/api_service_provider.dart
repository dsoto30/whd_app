import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whd_app/services/whd_api_service.dart';

final apiServiceProvider = Provider<WhdApiService>((ref) => WhdApiService());
