import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seventh_flutter_challenge/modules/login/login_screen.dart';
import 'package:seventh_flutter_challenge/modules/video/bloc/video_bloc.dart';
import 'package:seventh_flutter_challenge/util/components/error_component.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = VideoBloc();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<VideoBloc, VideoState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Video player'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    bloc.add(LogoutButtonTapped());
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                  ),
                )
              ],
            ),
            body: _getBody(context, state),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, VideoState state) {
    if (state is VideoFailure) {
      return ErrorComponent(
        onTapRetry: () {
          bloc.add(RetryTapped());
        },
      );
    } else if (state is VideoPlayer) {
      ChewieController? chewieController = state.chewieController;
      if (chewieController != null) {
        return Chewie(controller: chewieController);
      }
    }
    return const Center(child: CircularProgressIndicator());
  }
}
