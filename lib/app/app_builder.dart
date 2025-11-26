import 'package:todo/core/core.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return ScreenUtilInit(
      designSize: Size(
        AppSizes.defaultScreenWidth.toDouble(),
        AppSizes.defaultScreenHeight.toDouble(),
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          builder: (BuildContext context, child) => ToastificationConfigProvider(
            config: const ToastificationConfig(
              alignment: Alignment.topCenter,
              itemWidth: 440,
              animationDuration: Duration(milliseconds: 500),
              blockBackgroundInteraction: false,
            ),
            child: child!,
          ),
          debugShowCheckedModeBanner: true,
          scaffoldMessengerKey: rootScaffoldMessengerKey,
          // debugShowCheckedModeBanner: false,
          title: 'Todo',
          theme: AppTheme().appTheme(context),
          routerConfig: appRouter.router,
        );
      },
    );
  }
}
