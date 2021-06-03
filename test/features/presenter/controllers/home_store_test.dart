import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/usecase/errors/failures.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_arch/features/presenter/controllers/home_store.dart';

import '../../mocks/date_mock.dart';
import '../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaFromDateUsecase extends Mock implements GetSpaceMediaFromDateUsecase {}

void main() {
  late HomeStore store;
  late GetSpaceMediaFromDateUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockGetSpaceMediaFromDateUsecase();
    store = HomeStore(mockUsecase);
    registerFallbackValue<DateTime>(DateTime(0, 0, 0));
  });

  test('should return a SpaceMedia from the usecase', () async {
    // Arrange
    when(() => mockUsecase(any())).thenAnswer((_) async => Right(tSpaceMedia));
    // Act
    await store.getSpaceMediaFromDate(tDate);
    // Assert
    store.observer(
      onState: (state) {
        expect(state, tSpaceMedia);
        verify(() => mockUsecase(tDate)).called(1);
      },
    );
  });
  final tFailure = ServerFailure();
  test('should return a Failure from the usecase when there is an error', () async {
    // Arrange
    when(() => mockUsecase(any())).thenAnswer((_) async => Left(tFailure));
    // Act
    await store.getSpaceMediaFromDate(tDate);
    // Assert
    store.observer(
      onError: (error) {
        expect(error, tFailure);
        verify(() => mockUsecase(tDate)).called(1);
      },
    );
  });
}
