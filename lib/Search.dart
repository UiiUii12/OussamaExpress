import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/restaurant/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Search extends StatefulWidget {
  final List <Restaurant> list;
  Search({Key? key,required this.list}) : super(key: key);


  @override
  _SearchState createState() => _SearchState();
}
String texet="";
List<Restaurant>l=[];
class _SearchState extends State<Search> {

  @override
  Widget build(BuildContext context) {





        return SafeArea(
          child: Scaffold(

            body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Icon(
                              Icons.arrow_back,
                              size: 28.sp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 330.w,
                        height: 45.h,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Color(0xffF54749),
                            width: 1.5.w,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: TextFormField(
                          onChanged: (value){
                            texet=value;
                            setState(() {
                              l=sugestion(widget.list, texet);
                            });
                          },
                          onTap: (){

                            setState(() {
                              l=sugestion(widget.list, texet);
                            });




                          },

                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xffF54749),
                            ),
                            //contentPadding: EdgeInsets.all(.0.h),
                            border: InputBorder.none,
                            hintText:'Recherche...',

                            hintStyle: TextStyle(
                              color: Color(0xffa7a7a7),
                              fontSize: 13.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                            isCollapsed: true,
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h,),
                  Container(
                    height: 803.h,
                    width: 355.w,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: l.length,
                        itemBuilder: (context,index){
                          return buildListTile(l,index);
                        }
                    ),
                  )
                ],
              ),
            ),
          ),
        );

      }
  List<Restaurant> sugestion(List<Restaurant> list,String s){
    List<Restaurant> l=[];

    print(list.length);
    for(var i in list){
      print(s);
      print(i.nom);
      if (i.nom.contains(s)){
        print("done");
        l.add(i);
      }

    }
    return l;
  }

  }
  Widget buildListTile(List <Restaurant> allRestaurants,int index)=>Container(
    height: 90.h,
    width: 330.w,
  margin: EdgeInsets.symmetric(vertical: 5.h,horizontal: 13.w),
  decoration: BoxDecoration(
  border: Border.all(
  color: Color(0xffC4C4C4),
  width: 0.8.w,
  ),
  borderRadius: BorderRadius.circular(5.r),),
    child: Row(
      children: [
        Container(
          width: 90.w,
          height: 77.h,
          margin: EdgeInsets.only(left: 3.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: DecorationImage(
                image: NetworkImage('${allRestaurants[index].imageUrl}'),
                fit: BoxFit.cover,
              )
          ),
          child: Row(
            children: [

            ],
          ),
        ),
        SizedBox(width: 30.w,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 8.h,),
            AutoSizeText(
              '${allRestaurants[index].nom}',
              style: TextStyle(
              //  fontWeight: FontWeight.bold,
                fontFamily: 'regular',
                fontSize: 22.sp
              ),
            ),
          ],
        )
      ],
    ),
  );


