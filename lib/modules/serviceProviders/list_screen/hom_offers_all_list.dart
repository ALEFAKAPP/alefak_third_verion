import 'package:alefakaltawinea_animals_app/modules/baseScreen/baseScreen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/service_provider_details_screen.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/list_screen/provider/home_offers_provider.dart';
import 'package:alefakaltawinea_animals_app/shared/constance/fonts.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseDimentions.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/baseTextStyle.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/constants.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myUtils.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/resources.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeOffersAllList extends StatefulWidget {
  final String title;
  final int listId;
  const HomeOffersAllList({
    required this.title,
    required this.listId,
    Key? key}) : super(key: key);

  @override
  State<HomeOffersAllList> createState() => _HomeOffersAllListState();
}

class _HomeOffersAllListState extends State<HomeOffersAllList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      context.read<HomeOffersProvider>().getALLOffers(widget.listId);
    });
  }
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        tag: "ServiceProviderListScreen",
        showBottomBar: false,
        showSettings: false,
        body:Container(
        color:Colors.white,
        child: Consumer<HomeOffersProvider>(
          builder: (context,model,_) {
            return Column(children: [
            _header(context),
              Expanded(child:
              model.isLoading?LoadingProgress():model.offers.isNotEmpty?
                  ListView.builder(
                    shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount:model.offers.length ,
                  itemBuilder: (ctx,index){

                    return InkWell(
                      onTap: (){
                        MyUtils.navigate(context, ServiceProviderDetailsScreen(model.offers[index].offer.shop));
                      },
                      child: Container(
                        margin: EdgeInsets.all(D.default_10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(D.default_10),
                            color: Colors.white,
                            boxShadow:[BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius:5,
                                spreadRadius: 3
                            )]
                        ),
                        child: Stack(children: [
                          Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: D.default_200,
                                padding: EdgeInsets.all(D.default_10),
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: NetworkImage("",
                                  ),fit:BoxFit.cover),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(D.default_10),topRight: Radius.circular(D.default_10)),
                                  color: Colors.white,
                                ),),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal:D.default_10),
                                child: Text(model.offers[index].offer.shop.name??'',style: S.h2()),
                              ),
                              SizedBox(height: D.default_10,),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal:D.default_10),
                                child: Text(
                                    Constants.utilsProviderModel!.isArabic?model.offers[index].offer.shop.offers![0].title??'':model.offers[index].offer.shop.offers![0].titleEn??''
                                    ,style: S.h3(color: Colors.grey )),
                              ),
                              SizedBox(height: D.default_20,),

                            ],),
                          Positioned(child: Container(
                            padding: EdgeInsets.all(D.default_5),
                            margin: EdgeInsets.all(D.default_10),
                            width: D.default_60,
                            height: D.default_60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(D.default_10),
                                color: Colors.white,
                                boxShadow:[BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset:Offset(4,4),
                                    blurRadius:4,
                                    spreadRadius: 2
                                )]
                            ),
                            child:TransitionImage(
                              "",
                              radius: D.default_10,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ) ,
                          ),),
                        ],),
                      ),);
                  }):Center(child: Text(tr("no_offers"))
              )
              )]);
          }
        ) ));
  }
  Widget _header(BuildContext ctx){
    return   Column(
      children: [
        //SizedBox(height: 2.h,),
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
          child: Row(children: [
            SizedBox(width: D.default_5*0.6,),
            Text(widget.title,style: S.h1Bold(color: C.BASE_BLUE),),
            Expanded(child:TransitionImage(Res.IC_HOME_BLUE,width: D.default_80,height: D.default_80,),),
            SizedBox(width: D.default_5,),
            IconButton(onPressed: () {
              Navigator.of(ctx).pop();
            }, icon: Icon(Icons.arrow_forward_ios,color: Colors.black,size: D.default_30,),) ,
          ],),
        ),
        SizedBox(height: D.default_5*0.6,),
        Container(height: 1,color: Colors.grey[200],width: double.infinity,)
      ],
    );
  }


}
