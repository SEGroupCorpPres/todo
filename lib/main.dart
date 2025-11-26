import 'package:todo/core/core.dart';
import 'package:todo/feature/feature.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  widgetsBinding;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await initializeDependencies();
  await Future.delayed(const Duration(seconds: 2)); // splash delay
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<TodoBloc>()..add(GetTodosEvent())),
        BlocProvider(create: (context) => sl<DateCubit>()),
        BlocProvider(create: (context) => sl<ExpansionTileCubit>()),
      ],
      child: MyApp(),
    ),
  );
}
