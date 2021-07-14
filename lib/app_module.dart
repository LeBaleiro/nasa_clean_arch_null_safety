import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_clean_arch/core/utils/date_input_converter.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_implementation.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_arch/features/presenter/controllers/home_store.dart';
import 'package:http/http.dart' as http;

import 'features/presenter/pages/home_page.dart';
import 'features/presenter/pages/picture_page.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeStore(i())),
    Bind.lazySingleton((i) => GetSpaceMediaFromDateUsecase(i())),
    Bind.lazySingleton((i) => SpaceMediaRepositoryImplementation(i())),
    Bind.lazySingleton((i) => SpaceMediaDatasouceImplementation(converter: i(), client: i())),
    Bind.lazySingleton((i) => http.Client()),
    Bind.lazySingleton((i) => DateInputConverter()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ChildRoute('/picture', child: (_, args) => PicturePage.fromArgs(args.data)),
  ];
}
