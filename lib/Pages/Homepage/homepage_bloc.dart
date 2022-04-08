import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_repo.dart';
import 'homepage_event.dart';
import 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState>{

  DataRepo dataRepo;

  HomepageBloc({required this.dataRepo}) : super(HomepageState()){

    print('**     Homepage Bloc        **');
  }

}