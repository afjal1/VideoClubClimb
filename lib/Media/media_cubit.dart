import 'package:flutter_bloc/flutter_bloc.dart';

import '../session_cubit.dart';
import 'media_state.dart';


class MediaCubit extends Cubit<MediaState> {

  SessionCubit sessionCubit;

  MediaCubit({required this.sessionCubit}) : super(VideosSession());

  videosSession() => emit(VideosSession());
}