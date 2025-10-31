import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:glucose_app/model/glucosemodel.dart';
import 'package:glucose_app/presenter/glucose_presenter.dart';

// Generate mocks with: flutter pub run build_runner build
@GenerateMocks([GlucoseModel, GlucoseView])
import 'glucose_presenter_test.mocks.dart';

void main() {
  late GlucosePresenter presenter;
  late MockGlucoseModel mockModel;
  late MockGlucoseView mockView;

  setUp(() {
    mockModel = MockGlucoseModel();
    mockView = MockGlucoseView();
    presenter = GlucosePresenter(view: mockView, model: mockModel);
  });

  test('getGlucoseReadings returns readings', () async {
    final fakeReadings = [
      {'id': '1', 'reading': 5.5},
      {'id': '2', 'reading': 6.0},
    ];

    // Make sure this returns a Future
    when(mockModel.getGlucoseReadings())
        .thenAnswer((_) async => fakeReadings);

    final result = await presenter.getGlucoseReadings();

    expect(result, fakeReadings);
  });

  test('addGlucoseReadings - actually calls model to add', () async {
    presenter.addGlucoseReading(55);

    verify(mockModel.addGlucoseReading(55)).called(1);
  });

  test('deleteGlucoseReadings - check presenter actually calls model', () async {
    presenter.deleteGlucoseReading("id1");

    verify(mockModel.deleteGlucoseReading("id1")).called(1);
  });
}
