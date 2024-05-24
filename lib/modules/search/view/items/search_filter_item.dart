import 'package:alefakaltawinea_animals_app/modules/search/provider/filter_type_enum.dart';
import 'package:alefakaltawinea_animals_app/modules/search/view/items/selected_filter_item.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchFilterItem extends StatefulWidget   {
  final SearchFilterTypModel model;

  final Function(SearchFilterTypModel model) onSelect;


  const SearchFilterItem({required this.onSelect,required this.model,Key? key}) : super(key: key);

  @override
  State<SearchFilterItem> createState() => _SearchFilterItemState();
}

class _SearchFilterItemState extends State<SearchFilterItem> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 8.h,),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                setState(() {
                  widget.model.isExpanded=!widget.model.isExpanded;
                  widget.onSelect(widget.model);
                });
              },
              child:Padding(
                padding:  EdgeInsets.only(bottom:15.h),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                     Text(widget.model.title,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w800),),
                    Image.asset(widget.model.isExpanded?"assets/images/dropdown_up.png":'assets/images/dropdown_arrow_down.png',
                      width: 15.w,
                      height:15.w ,
                    ),
                  ],),
              ),
            ),
            Wrap(
              spacing: 4.w,
              runSpacing: 4.w,
              children: List.generate(widget.model.items.where((element) => element.isSelected).toList().length, (index) {
                return SelectedFilterItem(onClose: (){
                  widget.model.items.where((element) => element.id==widget.model.items.where((element) => element.isSelected).toList()[index].id).single.isSelected=false;
                  widget.onSelect(widget.model);

                }, title: widget.model.items.where((element) => element.isSelected).toList()[index].title,);
              }),
            ),
            SizedBox(height: 5.h,),
            Visibility(
              visible: widget.model.isExpanded,
              child: Column(children: List.generate(widget.model.items.length, (index){
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 3.w),
                  child: GestureDetector(
                    onTap: (){
                      widget.model.items[index]!.isSelected=!widget.model.items[index]!.isSelected;
                      widget.onSelect(widget.model);
                      setState(() {

                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.model.items[index].title,style: TextStyle(fontSize: 13.sp,fontWeight:FontWeight.w700),),
                        SvgPicture.asset(widget.model.items[index].isSelected?
                        "assets/images/selected_radio_btn.svg":"assets/images/unselected_radio_btn.svg")
                      ],),
                  ),);
              }),),
            )

          ],
        ),
      ),
      SizedBox(height: 25.h,),
    ],);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>  true;

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
