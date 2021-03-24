import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource_implementation.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_implementation.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_arch/features/presenter/picture_page.dart';

import 'core/utils/date_input_converter.dart';
import 'features/presenter/home_page.dart';
import 'features/presenter/space_media_controller.dart';
import 'package:http/http.dart' as http;

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind((i) => SpaceMediaController(
          i(),
        )),
    Bind((i) => GetSpaceMediaFromDateUsecase(i())),
    Bind((i) => SpaceMediaRepositoryImplementation(i())),
    Bind((i) => SpaceMediaDatasouceImplementation(
          client: i(),
          converter: i(),
        )),
    Bind((i) => http.Client()),
    Bind((i) => DateInputConverter()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
    ChildRoute('/picture', child: (_, __) => PicturePage()),
  ];
}
