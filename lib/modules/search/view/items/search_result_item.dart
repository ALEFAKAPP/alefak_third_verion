import 'package:alefakaltawinea_animals_app/modules/search/provider/filter_type_enum.dart';
import 'package:alefakaltawinea_animals_app/modules/search/view/items/selected_filter_item.dart';
import 'package:alefakaltawinea_animals_app/modules/serviceProviders/details_screen/new_offer_details_screen.dart';
import 'package:alefakaltawinea_animals_app/utils/my_utils/myColors.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/transition_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../serviceProviders/list_screen/data/serviceProvidersModel.dart';

class SearchResultItem extends StatefulWidget {
  final Data model;
  final Function(SearchFilterItemModel model) onSelect;

  const SearchResultItem({required this.onSelect,required this.model,Key? key}) : super(key: key);

  @override
  State<SearchResultItem> createState() => _SearchResultItemState();
}

class _SearchResultItemState extends State<SearchResultItem> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _devider(),
      SizedBox(height: 2.h,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                setState(() {
                  widget.model.isExpanded=!(widget.model!.isExpanded??false);
                });
              },
              child:Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10.h),
                    width: 50.h,
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow:[BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset:Offset(0,0),
                            blurRadius:3,
                            spreadRadius: 2
                        )]
                    ),
                    child:TransitionImage(
                      widget.model.photo??'',
                      radius:10,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ) ,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.model.name??'',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w800),),
                        SizedBox(height: 4.h,),
                        Text("${tr("available")} ${(widget.model.offers??[]).length.toString()} ${tr("offers")}",style: TextStyle(color: Color(0xff636363),fontSize: 12.sp,fontWeight: FontWeight.w500),),
                      ],
                    ),
                  ),
                  Image.asset((widget.model.isExpanded??false)?"assets/images/dropdown_up.png":'assets/images/dropdown_arrow_down.png',
                    width: 15.w,
                    height:15.w ,
                  ),
                  SizedBox(width:5.w,)
                ],),
            ),
            SizedBox(height: 8.h,),
            Visibility(
              visible: widget.model.isExpanded??false,
              child: Column(children: List.generate((widget.model.offers??[]).length, (index){
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 10.w),
                  margin: EdgeInsets.symmetric(vertical: 3.h,horizontal: 8.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffF6F6F6),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Get.to(NewOfferDetailsScreen(category: (widget.model.offers![index].classification??[]).isEmpty?"":widget.model.offers![index].classification!.first ??'',serviceProvider: widget.model, offer:widget.model.offers![index] ,));
                    },
                    child: Row(
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          Image.asset("assets/images/offer_search_radio.png",width: 20.w,height: 20.w,),

                        ],),
                        SizedBox(width: 13.w,),
                        Expanded(child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Text(widget.model.offers![index].title??'',style: TextStyle(fontWeight:FontWeight.w800,fontSize: 14.sp),),
                            SizedBox(height: 3.h,),
                            Row(
                              children: [
                                Expanded(child: Text(widget.model.offers![index].description_ar??'',style: TextStyle(fontWeight:FontWeight.w500,fontSize: 12.sp),)),
                                SizedBox(width:3.w),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 8.w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xff1BB1CC),
                                  ),
                                  child: Row(children: [
                                  Text(tr("details"),style: TextStyle(color: Colors.white,fontSize: 12.sp,),),
                                  SizedBox(width: 10.w,),
                                  Icon(Icons.arrow_forward_ios,size: 12.w,color: Colors.white,)
                                ],),)
                              ],
                            ),

                          ],
                        )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                          ],),
                      ],),
                  ),);
              }),),
            )
          ],
        ),
      ),
      SizedBox(height: 2.h,),
    ],);
  }
  Widget _devider(){
    return Container(
      height: 1,
      width: double.infinity,
      color: Color(0xae6f6f6f),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


class SearchFilterTypModel{
  String title;
  bool isExpanded;
  List<SearchFilterItemModel>items;

  SearchFilterTypModel({required this.title,required this.isExpanded,required this.items});
}

class SearchFilterItemModel{
  String title;
  bool isSelected;
  int id;
  FiltersTypes type;
  SearchFilterItemModel({required this.title,required this.isSelected,required this.id,required this.type});
}
