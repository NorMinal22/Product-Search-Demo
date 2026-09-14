import 'package:flutter/material.dart';

enum ToastType{
  success,
  error,
  loading,
}

class ToastMessage {
  static void show(
    BuildContext context,{
      required String message,
      ToastType type = ToastType.error,
      Duration duration = const Duration(seconds: 1),
    }){
      final overlay = Overlay.of(context);
      late OverlayEntry overlayEntry;

      overlayEntry = OverlayEntry(
        builder: (context){
          return Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            right: 20,
            child: ToastWidget(
              message: message,
              type: type,
            ),
          );
        }
      );
      overlay.insert(overlayEntry);
      Future.delayed(duration, (){
        overlayEntry.remove();
      });
  }
}

class ToastWidget extends StatelessWidget {
  final String message;
  final ToastType type;

  const ToastWidget({super.key, required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    IconData iconData;

    switch(type){
      case ToastType.success:
        backgroundColor = Colors.green;
        iconData = Icons.check_circle;
        break;
      case ToastType.error:
        backgroundColor = Colors.red;
        iconData = Icons.error;
        break;
      case ToastType.loading:
        backgroundColor = Colors.grey;
        iconData = Icons.hourglass_top;
        break;
    }
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconData, color: Colors.white),
            SizedBox(width: 10),
            Expanded(child: Text(message, style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
