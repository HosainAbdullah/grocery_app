import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app/core/service/service_locator.dart' as sls;
import 'package:flutter/material.dart';
import 'package:grocery_app/root_app_widget/bloc_observer.dart';
import 'package:grocery_app/root_app_widget/grocery_root_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sls.init();
  Bloc.observer = MyBlocObserver();
  runApp(const GroceryRootApp());
}
