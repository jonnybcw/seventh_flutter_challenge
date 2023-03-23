import 'package:get_it/get_it.dart';
import 'package:seventh_flutter_challenge/data/repositories/user_repository.dart';
import 'package:seventh_flutter_challenge/data/repositories/videos_repository.dart';

class Repositories {
  static void register() {
    GetIt.I.registerSingleton<UserRepository>(UserRepository());
    GetIt.I.registerSingleton<VideosRepository>(VideosRepository());
  }
}
