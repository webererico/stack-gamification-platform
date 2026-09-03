import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:stack_gamification_platform/core/navigation/auth_gate.dart';
import 'package:stack_gamification_platform/core/response_handler/error_handler.dart';
import 'package:stack_gamification_platform/core/response_handler/success_handler.dart';
import 'package:stack_gamification_platform/features/alert/cubit/alert_area_cubit.dart';
import 'package:stack_gamification_platform/features/authentication/data/auth_repository_impl.dart';
import 'package:stack_gamification_platform/features/authentication/domain/repository/auth_repository.dart';
import 'package:stack_gamification_platform/features/authentication/signin/state_management/cubit/signin_cubit.dart';
import 'package:stack_gamification_platform/features/authentication/signup/state_management/cubit/signup_cubit.dart';
import 'package:stack_gamification_platform/features/dashboard/state_management/cubit/dashboard_cubit.dart';
import 'package:stack_gamification_platform/features/profile/state_management/cubit/profile_cubit.dart';
import 'package:stack_gamification_platform/features/skills/data/skill_repository_impl.dart';
import 'package:stack_gamification_platform/features/skills/domain/repository/skill_repository.dart';
import 'package:stack_gamification_platform/features/squad/data/squad_repository_impl.dart';
import 'package:stack_gamification_platform/features/squad/domain/repository/squad_repository.dart';
import 'package:stack_gamification_platform/features/squad/state_management/cubit/squad_select_cubit.dart';
import 'package:stack_gamification_platform/features/team/state_management/cubit/team_cubit.dart';
import 'package:stack_gamification_platform/features/user/data/user_repository_impl.dart';
import 'package:stack_gamification_platform/features/user/domain/repository/user_repository.dart';
import 'package:stack_gamification_platform/firebase_options.dart';

final getIt = GetIt.I;

Future<void> configureDependencies() async {
  // FIREBASE
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // ALERT / RESPONSE HANDLING
  getIt.registerSingleton<AlertAreaCubit>(AlertAreaCubit());
  getIt.registerFactory<ErrorHandler>(() => ErrorHandler());
  getIt.registerFactory<SuccessHandler>(() => SuccessHandler());

  // AUTHENTICATION
  getIt.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt()),
  );

  // USER
  getIt.registerFactory<UserRepository>(
    () => UserRepositoryImpl(getIt(), getIt()),
  );

  // SQUAD
  getIt.registerFactory<SquadRepository>(
    () => SquadRepositoryImpl(getIt(), getIt()),
  );

  // SKILLS
  getIt.registerFactory<SkillRepository>(
    () => SkillRepositoryImpl(getIt(), getIt()),
  );

  // NAVIGATION GATE (depends on the repositories above)
  getIt.registerLazySingleton<AuthGate>(() => AuthGate(getIt(), getIt()));

  // SIGN IN / SIGN UP
  getIt.registerFactory<SignInCubit>(() => SignInCubit(getIt()));
  getIt.registerFactory<SignUpCubit>(() => SignUpCubit(getIt(), getIt()));

  // SQUAD SELECT
  getIt.registerFactory<SquadSelectCubit>(
    () => SquadSelectCubit(getIt(), getIt()),
  );

  // DASHBOARD
  getIt.registerFactory<DashboardCubit>(
    () => DashboardCubit(getIt(), getIt(), getIt()),
  );

  // TEAM
  getIt.registerFactory<TeamCubit>(() => TeamCubit(getIt(), getIt()));

  // PROFILE
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getIt(), getIt(), getIt()),
  );
}
