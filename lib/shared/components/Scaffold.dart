
import 'package:alefakaltawinea_animals_app/shared/constance/colors.dart';
import 'package:flutter/material.dart';

class ScaffoldMain extends StatelessWidget {
  Widget body ;
  Widget? bottomNavigationBarWidget ;
  Widget? floatingActionButton ;
  AppBar? appBar ;
  Drawer? drawer ;
  var endDrawer ;
  double padding ;
  Color background ;
   ScaffoldMain({this.appBar,required this.body,this.drawer,this.endDrawer,this.background = whiteColor,this.padding = 15,this.bottomNavigationBarWidget,this.floatingActionButton });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: appBar != null ?appBar :PreferredSize(preferredSize: Size.fromHeight(0.0), child: AppBar(backgroundColor: primaryColor,),),
      body: Padding(
        padding:  EdgeInsets.all(padding),
        child: body,
      ),
      drawer: drawer!= null ? drawer : null,
      endDrawer: endDrawer!= null ? endDrawer : null,
      // bottomNavigationBar :bottomNavigationBarWidget ?? Container(),
      floatingActionButton: floatingActionButton??null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
