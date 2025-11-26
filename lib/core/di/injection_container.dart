import 'package:todo/core/core.dart';
import 'package:todo/feature/feature.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  // BLoC

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<DateCubit>(() => DateCubit());
  sl.registerLazySingleton<ExpansionTileCubit>(() => ExpansionTileCubit());

  sl
    ..registerFactory<TodoBloc>(
      () => TodoBloc(
        addTodo: sl(),
        updateTodo: sl(),
        removeTodo: sl(),
        getTodo: sl(),
        getTodos: sl(),
      ),
    )
    ..registerLazySingleton(() => AddTodo(sl()))
    ..registerLazySingleton(() => UpdateTodo(sl()))
    ..registerLazySingleton(() => DeleteTodo(sl()))
    ..registerLazySingleton(() => GetTodo(sl()))
    ..registerLazySingleton(() => GetTodos(sl()))
    ..registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(sl()))
    ..registerLazySingleton<TodoLocalDataSource>(() => TodoLocalDataSourceImpl(sl()))
    ..registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );
  sl.registerLazySingleton<Logger>(() => logger);
}
