import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController;
  double offset = 0.0;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: <Widget>[
          AnimatedSliverAppBar(scrollController: scrollController, logo: logo, curve: Curves.fastOutSlowIn,),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              Container(
                width: double.infinity,
                height: 900,
                color: Colors.lightGreen,
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget get logo {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.white,
        child: FlutterLogo(),
      ),
    );
  }
}

class AnimatedSliverAppBar extends StatefulWidget {
  const AnimatedSliverAppBar({
    Key key,
    @required this.scrollController,
    @required this.logo,
    @required this.curve,
  }) : super(key: key);

  final ScrollController scrollController;
  final Widget logo;
  final Curve curve;

  @override
  _AnimatedSliverAppBarState createState() => _AnimatedSliverAppBarState();
}

class _AnimatedSliverAppBarState extends State<AnimatedSliverAppBar> {
  double appBarExpandedHeight = 300;
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      titleSpacing: 45,
      backgroundColor: Colors.blue,
      elevation: 2,
      forceElevated: true,
      expandedHeight: appBarExpandedHeight,
      title: AnimatedBuilder(
        animation: widget.scrollController,
        builder: (ctx, child) => AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          switchInCurve: Curves.linear,
          switchOutCurve: Curves.linear,
          child: widget.scrollController.offset >= appBarExpandedHeight - 60 ? child : SizedBox(),
          reverseDuration: Duration(milliseconds: 100),
        ),
        child: Text("Example title"),
      ),
      pinned: true,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Container(
                color: Colors.blue,
                padding: EdgeInsets.only(bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('asdasdasd'),
                    Text('asdas1312312312321'),
                  ],
                )),
          ),
          AnimatedBuilder(
            animation: widget.scrollController,
            builder: (ctx, child) => Positioned(
              top: 150 - (109 * animationPosition),
              left: (-11 + MediaQuery.of(context).size.width / 2) - animationPosition * (-22 + MediaQuery.of(context).size.width / 2),
              child: Transform.scale(
                scale: 5 - (4 * animationPosition),
                child: child,
              ),
            ),
            child: widget.logo,
          ),
        ],
      ),
    );
  }

  double get animationPosition {
    return widget.curve.transform(math.min(appBarExpandedHeight - 60, widget.scrollController.offset) / (appBarExpandedHeight - 60));
  }
}
