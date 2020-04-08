import 'package:challenge_wolf/core/services/custom_requirements_service.dart';
import 'package:get_it/get_it.dart';

import 'package:challenge_wolf/core/viewmodels/custom_requirements_repository.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => CustomRequirementsService());
  locator.registerLazySingleton(() => CustomRequirementsRepository());
}
