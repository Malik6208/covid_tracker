//import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';
import 'dart:async';
import 'package:covid_tracker/view/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
late Size mq;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late final AnimationController _controller=AnimationController(vsync: this,
  duration: const Duration(seconds: 3)
  )..repeat();


  @override
  void dispose() {
    // TODO: implement dispose

    _controller.dispose();
    super.dispose();
  }
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5),() {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WorldStates(),));
    }

    );
  }

  @override
  Widget build(BuildContext context) {
    mq=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: mq.width,
          height: mq.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Image(image: AssetImage('assets/images/1virus.png')),
                ),
                builder: (context,Widget? child) {
                  return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                    child: child,

                  );
                } ,
              ),
              const SizedBox(height: 10,),
               const Align(
                 alignment:Alignment.center ,
                 child: Text('Covid-19\nTracker App', textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 25,fontWeight: FontWeight.bold
                             ),),
               )
            ],
          ),
        ),
      ),
    );
  }
}
