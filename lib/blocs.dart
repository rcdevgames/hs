import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:housesolutions/bloc/notification_bloc.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/complaint_bloc.dart';
import 'bloc/home_bloc.dart';
import 'bloc/job_bloc.dart';
import 'bloc/news_bloc.dart';
import 'bloc/order_bloc.dart';
import 'bloc/product_bloc.dart';
import 'bloc/user_bloc.dart';
import 'view/home/layout.dart';

final List<Bloc<BlocBase>> blocs = [
  Bloc((i) => AuthBloc()),
  Bloc((i) => LayoutBloc()),
  Bloc((i) => HomeBloc()),
  Bloc((i) => OrderBloc()),
  Bloc((i) => ProductBloc()),
  Bloc((i) => UserBloc()),
  Bloc((i) => ComplaintBloc()),
  Bloc((i) => NewsBloc()),
  Bloc((i) => JobBloc()),
  Bloc((i) => NotificationBloc()),
];