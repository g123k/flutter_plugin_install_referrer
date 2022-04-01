import 'package:flutter/cupertino.dart';
import 'package:install_referrer/install_referrer.dart';

/// Obtain the result of [InstallReferrer.app] within a WidgetBuilder like
class InstallReferrerDetectorBuilder extends StatelessWidget {
  final InstallReferrerDetectorWidgetBuilder builder;

  const InstallReferrerDetectorBuilder({
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: InstallReferrer.app,
      builder: (BuildContext context, AsyncSnapshot<InstallationApp> data) {
        return builder(context, data.data);
      },
    );
  }
}

/// Obtain the result of [InstallReferrer.app] in a listener
class InstallReferrerDetectorListener extends StatefulWidget {
  final Widget child;
  final InstallReferrerDetectorWidgetListener onReferrerAvailable;

  const InstallReferrerDetectorListener({
    required this.child,
    required this.onReferrerAvailable,
    Key? key,
  }) : super(key: key);

  @override
  State<InstallReferrerDetectorListener> createState() =>
      _InstallReferrerDetectorListenerState();
}

class _InstallReferrerDetectorListenerState
    extends State<InstallReferrerDetectorListener> {
  InstallReferrerDetectorWidgetListener? listener;

  @override
  void initState() {
    super.initState();
    listener = widget.onReferrerAvailable;
    _fetchReferrer();
  }

  @override
  void didUpdateWidget(covariant InstallReferrerDetectorListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    final InstallReferrerDetectorWidgetListener oldListener =
        oldWidget.onReferrerAvailable;
    final InstallReferrerDetectorWidgetListener currentListener =
        widget.onReferrerAvailable;

    if (oldListener != currentListener) {
      listener = currentListener;
      _fetchReferrer();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final InstallReferrerDetectorWidgetListener currentListener =
        widget.onReferrerAvailable;

    if (currentListener != listener) {
      listener = currentListener;
      _fetchReferrer();
    }
  }

  Future<void> _fetchReferrer() async {
    InstallationApp app = await InstallReferrer.app;
    listener?.call(app);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    listener = null;
    super.dispose();
  }
}

typedef InstallReferrerDetectorWidgetBuilder = Widget Function(
  BuildContext context,
  InstallationApp? referrer,
);

typedef InstallReferrerDetectorWidgetListener = void Function(
  InstallationApp referrer,
);
