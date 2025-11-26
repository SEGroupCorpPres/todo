import 'package:todo/core/core.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: Container(padding: const .all(16), child: Text(error)),
      ),
    );
  }
}
