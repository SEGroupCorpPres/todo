import 'package:todo/core/core.dart';

class ShadowedContainer extends StatelessWidget {
  const ShadowedContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: .circular(AppSizes.listItemBorderRadius.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color(0x14000809), spreadRadius: 0, blurRadius: 4, offset: Offset(2, 2)),
          BoxShadow(color: Color(0x05000809), spreadRadius: 0, blurRadius: 6, offset: Offset(0, 0)),
        ],
      ),
      child: child,
    );
  }
}
