import 'package:flutter/material.dart';
import 'package:workout_timer/common/storage/storage.dart';

class LocalStorageProvider<T> extends StatelessWidget {
  LocalStorageProvider({required this.builder, required this.getter});

  final Widget Function(bool isReady, T? value) builder;
  final T Function(StorageService storage) getter;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: StorageService.instance.ready,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return builder(true, getter(StorageService.instance));
        }
        return builder(false, null);
      },
    );
  }
}

class LocalStorageBuilder extends StatelessWidget {
  const LocalStorageBuilder({required this.builder});

  final Widget Function(bool isReady) builder;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: StorageService.instance.ready,
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return builder(true);
        }
        return builder(false);
      },
    );
  }
}
