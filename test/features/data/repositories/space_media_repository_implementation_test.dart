import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/usecase/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/usecase/errors/failures.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
    registerFallbackValue<DateTime>(DateTime(2000));
  });

  final tSpaceMediaModel = SpaceMediaModel(
    description:
        'Meteors can be colorful. While the human eye usually cannot discern many colors, cameras often can. Pictured is a Quadrantids meteor captured by camera over Missouri, USA, early this month that was not only impressively bright, but colorful. The radiant grit, likely cast off by asteroid 2003 EH1, blazed a path across Earth\'s atmosphere.  Colors in meteors usually originate from ionized elements released as the meteor disintegrates, with blue-green typically originating from magnesium, calcium radiating violet, and nickel glowing green. Red, however, typically originates from energized nitrogen and oxygen in the Earth\'s atmosphere.  This bright meteoric fireball was gone in a flash -- less than a second -- but it left a wind-blown ionization trail that remained visible for several minutes.   APOD is available via Facebook: in English, Catalan and Portuguese',
    mediaType: 'image',
    title: 'A Colorful Quadrantid Meteor',
    mediaUrl:
        'https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg',
  );

  final tDate = DateTime(2021, 02, 02);

  test('should return space media model when calls the datasource', () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(any()))
        .thenAnswer((_) async => tSpaceMediaModel);
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test(
      'should return a server failure when the call to datasource is unsucessful',
      () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(any()))
        .thenThrow(ServerException());
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
