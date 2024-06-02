import 'package:alefakaltawinea_animals_app/modules/search/provider/search_provider.dart';
import 'package:alefakaltawinea_animals_app/modules/search/view/items/selected_filter_item.dart';
import 'package:alefakaltawinea_animals_app/utils/my_widgets/laoding_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../baseScreen/baseScreen.dart';
import '../items/search_result_item.dart';

class NewSearchScreen extends StatefulWidget {
  const NewSearchScreen({Key? key}) : super(key: key);

  @override
  State<NewSearchScreen> createState() => _NewSearchScreenState();
}

class _NewSearchScreenState extends State<NewSearchScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SearchProvider>().getSearchData();

    context.read<SearchProvider>().getSearchData();
  }
  @override
  Widget build(BuildContext context) {
    return  BaseScreen(
        tag: "SearchScreen",
        showBottomBar: false,
        showSettings: false,
        showWhatsIcon: false,
        body:Column(children: [
          SizedBox(height: 8.h,),
          _header(),
          Consumer<SearchProvider>(
              builder: (context, data,_) {
                return Visibility(
                  visible:data.allSelectedFilters.isNotEmpty ,
                  child: SizedBox(
                    width: double.infinity,
                    height: 30.h,
                    child: ListView.separated(
                      itemCount: data.allSelectedFilters.length,
                      separatorBuilder: (ctx,index){
                        return SizedBox(width: 4.w,);
                      },
                      itemBuilder: (ctx,index){
                        return SelectedFilterItem(onClose: (){
                          data.allSelectedFilters[index].isSelected=false;
                          data.allSelectedFilters.removeAt(index);
                          data.getSearchData();
                        }, title: data.allSelectedFilters[index].title,);
                      },
                      padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 4.h),
                      scrollDirection: Axis.horizontal,

                    ),
                  ),
                );
              }
          ),
          Expanded(
              child: Consumer<SearchProvider>(
                  builder: (context, data,_) {
                    return data.searchResult==null?data.isLoading?LoadingProgress():SizedBox():(data.searchResult!.data??[])
                    .isEmpty?_noData():ListView(
                        addAutomaticKeepAlives:true,
            children: List.generate((data.searchResult!.data??[]).length, (index){
                  return SearchResultItem(onSelect: (SearchFilterItemModel model) {  }, model:(data.searchResult!.data??[])[index] ,);
            }),
          );
                }
              )),
          Consumer<SearchProvider>(
            builder: (context,data,_) {
              return Visibility(
                visible: false/*context.read<SearchProvider>().allSelectedFilters.isNotEmpty*/,
                child: InkWell(
                  onTap: (){
                    context.read<SearchProvider>().onShowAll();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 3.h,horizontal: 30.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffF05A29),
                    ),
                    child:Text(tr("see_all"),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 16.sp,),),
                      ),
                ),
              );
            }
          ),
          SizedBox(height: 15.h,)
        ],)
    );
  }
  Widget _header(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w,vertical:5.h),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){Get.back();},
            child: Icon(Icons.arrow_back_ios,
              size: 18,
            ),
          ),
          Expanded(child: SizedBox(),),
          InkWell(
            onTap: (){
              Get.back();
            },
            child: Padding(padding: EdgeInsets.symmetric(horizontal:10.w),
            child: Image.asset("assets/images/filter_logo.png",width: 20.w,height: 20.w,),),
          ),
          InkWell(
            onTap: (){
              context.read<SearchProvider>().isNearToYouActive=false;
              context.read<SearchProvider>().getSearchData();
            },
            child: Padding(padding: EdgeInsets.symmetric(horizontal:10.w),
              child: Image.asset("assets/images/distance_arrange_ic.png",width: 20.w,height: 20.w,),),
          ),
          InkWell(
            onTap: (){
              context.read<SearchProvider>().isNearToYouActive=true;
              context.read<SearchProvider>().getSearchData();
            },
            child: Padding(padding: EdgeInsets.symmetric(horizontal:10.w),
              child: Image.asset("assets/images/fitlter_location_pin.png",width: 20.w,height: 20.w,),),
          ),
        ],),
    );

  }
  _noData(){
    return Center(child:Text(tr("no_search"),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14.sp),));
  }
}
