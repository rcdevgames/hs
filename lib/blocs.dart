import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:housesolutions/bloc/auth_bloc.dart';
import 'package:housesolutions/bloc/complaint_bloc.dart';
import 'package:housesolutions/bloc/home_bloc.dart';
import 'package:housesolutions/bloc/news_bloc.dart';
import 'package:housesolutions/bloc/order_bloc.dart';
import 'package:housesolutions/bloc/product_bloc.dart';
import 'package:housesolutions/bloc/user_bloc.dart';
import 'package:housesolutions/view/home/layout.dart';

final List<Bloc<BlocBase>> blocs = [
  Bloc((i) => AuthBloc()),
  Bloc((i) => LayoutBloc()),
  Bloc((i) => HomeBloc()),
  Bloc((i) => OrderBloc()),
  Bloc((i) => ProductBloc()),
  Bloc((i) => UserBloc()),
  Bloc((i) => ComplaintBloc()),
  Bloc((i) => NewsBloc()),
];