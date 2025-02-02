import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:picnic_app/dependency_injection/app_component.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_initial_params.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_navigator.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_page.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presentation_model.dart';
import 'package:picnic_app/features/onboarding/circles_picker/onboarding_circles_picker_presenter.dart';
import 'package:picnic_app/features/onboarding/domain/model/onboarding_form_data.dart';

import '../../../mocks/mocks.dart';
import '../../../mocks/stubs.dart';
import '../../../test_utils/golden_tests_utils.dart';
import '../../../test_utils/test_utils.dart';
import '../../analytics/mocks/analytics_mocks.dart';
import '../../circles/mocks/circles_mocks.dart';
import '../mocks/onboarding_mocks.dart';

Future<void> main() async {
  late OnboardingCirclesPickerPage page;
  late OnBoardingCirclesPickerInitialParams initParams;
  late OnBoardingCirclesPickerPresentationModel model;
  late OnBoardingCirclesPickerPresenter presenter;
  late OnBoardingCirclesPickerNavigator navigator;

  void _initMvp() {
    initParams = OnBoardingCirclesPickerInitialParams(
      onCirclesSelected: (_) {},
      formData: const OnboardingFormData.empty(),
    );
    model = OnBoardingCirclesPickerPresentationModel.initial(
      initParams,
    );
    navigator = OnBoardingCirclesPickerNavigator();
    presenter = OnBoardingCirclesPickerPresenter(
      model,
      navigator,
      OnboardingMocks.getOnBoardingCirclesUseCase,
      CirclesMocks.joinCirclesUseCase,
      AnalyticsMocks.logAnalyticsEventUseCase,
      Mocks.setShouldShowCirclesSelectionUseCase,
    );

    page = OnboardingCirclesPickerPage(presenter: presenter);
    when(() => OnboardingMocks.getOnBoardingCirclesUseCase.execute()).thenAnswer(
      (_) => successFuture(
        Stubs.onBoardingCircles,
      ),
    );
    when(() => Mocks.setShouldShowCirclesSelectionUseCase.execute(shouldShow: true)).thenAnswer(
      (_) => successFuture(true),
    );
  }

  await screenshotTest(
    "circle_groupings_form_page",
    setUp: () async {
      _initMvp();
    },
    pageBuilder: () => page,
  );

  test("getIt page resolves successfully", () async {
    _initMvp();
    final page = getIt<OnboardingCirclesPickerPage>(param1: initParams);
    expect(page.presenter, isNotNull);
    expect(page, isNotNull);
  });
}
