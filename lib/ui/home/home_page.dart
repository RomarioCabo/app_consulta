import 'package:consulta_estados_cidades/constants/strings.dart';
import 'package:consulta_estados_cidades/shared/repositories/api/helpers/request_state.dart';
import 'package:consulta_estados_cidades/ui/home/home_controller.dart';
import 'package:consulta_estados_cidades/ui/tiles/state_tile.dart';
import 'package:consulta_estados_cidades/ui/widgets/custom_animated_builder.dart';
import 'package:consulta_estados_cidades/ui/widgets/load.dart';
import 'package:consulta_estados_cidades/ui/widgets/load_more.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  HomeController _homeController;

  AnimationController _animationController;
  Animation<double> _opacity;

  /// Reactions
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          0.000,
          1.000,
          curve: Curves.easeIn,
        ),
      ),
    );

    _homeController = HomeController();
    _homeController.getStates();

    /// Reações
    _disposers.add(
      reaction(
        (_) => _homeController.requestStateGet,
        _startAnimation,
      ),
    );
  }

  void _startAnimation(_) {
    if (_homeController.requestStateGet is Completed) {
      _animationController.value = 0;
      _animationController.duration = Duration(milliseconds: 500);
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _disposers.forEach((disposer) => disposer());
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            label_title_appbar,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).appBarTheme.textTheme.subtitle1.color,
              fontWeight: FontWeight.w900,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SafeArea(
          child: _bodyContent(),
        ),
      ),
    );
  }

  Widget _bodyContent() {
    return Observer(
      builder: (_) {
        if (_homeController.requestStateGet is Loading) {
          return Load();
        } else {
          return CustomAnimatedBuilder(
            animationController: _animationController,
            opacity: _opacity,
            contentChild: _buildListStates(),
          );
        }
      },
    );
  }

  Widget _buildListStates() {
    return Column(
      children: [
        Expanded(
          child: NotificationListener(
            onNotification: (ScrollNotification notification) {
              if (notification != null &&
                  notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {

              }

              return false;
            },
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _homeController.states.length,
              itemBuilder: (context, index) {
                if (index == _homeController.states.length) {
                  return LoadMore();
                }

                return StateTile(state: _homeController.states[index]);
              },
            ),
          ),
        ),
      ],
    );
  }
}
