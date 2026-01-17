import "package:flutter/material.dart";
import 'note_quote.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //DateTime nowTime=DateTime.now();
  bool isFav =false;
  Icon Fav=Icon(Icons.favorite,color: Colors.grey[100],);

  Future<bool?> confirmDelete(String notice, String title) async {
    final bool? shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(notice),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
    return shouldDelete;
  }

  List<List> all=[];
  List<List> school=[];
  List<List> work=[];
  List<List> religion=[];
  List<List> random=[];
  List<List> family=[];
  List<List> favourite=[];

  //NoteQuote_stuffs below
  //List quoteList=[];
  GetInfo getInfos=GetInfo("", 0, "", "");

  static const int wordIndex=0,cattIndex=1,titleIndex=2,timeIndex=3,favIndex=4;

  List getList=[];//this is a 2 dimensional list that takes in all categories list
  late List selectList;
  int catIndex=0;

 // late List<String> catList;

  List getCat=[
    //list to listview categories to scaffold
    "ALL",
    "SCHOOL",
    "WORK",
    "RELIGION",
    "RANDOM",
    "FAMILY",
    "FAVOURITE"
    //Text("EDIT",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)
  ];

  @override
  void initState() {

    //Text newT=Text("SCHOOL",style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white));
    super.initState();
    getList.add(all);
    getList.add(school);//adding various individual categories list to getList List
    getList.add(work);
    getList.add(religion);
    getList.add(random);
    getList.add(family);
    getList.add(favourite);
    selectList=getList[0];//initial or default list to display
   // catList=indexs.keys.toList();//help converts the key string name of Map getCat into iterable list so we can categories name back to edit field
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
            "NOTES",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[400],
        actions: [IconButton(
            onPressed: ()async{
              if(await confirmDelete("Are you sure you want to clear this category?","Clear Category")==true){
                setState(() {
                  catIndex != 0 ?
                      () {//in this function we clear all from selected cat
                    getList[catIndex].forEach((val) {//loop through category list and check if it fav then remove it from favourite list
                      val[favIndex]
                          ? favourite.removeAt(favourite.indexOf(val))
                          : null;
                    }
                    );
                    getList[catIndex].clear();
                  }() : () { //in this function we clear all all cat
                    for (List x in getList) {
                      x.clear();
                    }
                  }();
                });
              }
            },
            icon: Icon(Icons.delete,color: Colors.white,)
        )],
      ),
      body://else
      Column(
        children: [
          SizedBox(height: 6,),
          Row(//helps displays category nnd it list data
            children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,0,5,0),
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blueAccent[400],
                      ),
                      child: Center(child: Text("CATEGORIES",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)),
                    ),
                  ),
                   Expanded(
                     child: SizedBox(
                           height: 30,
                         child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                           itemCount: getCat.length,
                          itemBuilder: (context,index)=>Padding(
                            padding: const EdgeInsets.fromLTRB(5,0,5,0),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  catIndex=index;//help update category index for future or later use
                                  if(catIndex==0){//line helps copies all available notes into all list if we are to view all else it empties all
                                    for(int x=1;x<=getList.length-2;x++){
                                      getList[x].forEach((val){
                                        all.add(val);
                                      });
                                    }}
                                  else{
                                    all.clear();
                                  }
                                  selectList=getList[index];//select the list to display it note based off selected category
                                  print(selectList);
                                });
                              },
                              child: Container(
                                  height: 30,
                                  width: 110,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.blueAccent[400],
                                  ),
                                child: Center(child: Text(getCat[index],style:TextStyle(
                                    fontWeight: FontWeight.bold, color:index==catIndex?Colors.black:Colors.white //change color of selected cat to black
                                ))),
                                ),
                            ),
                          ),
                         ),
                       ),
                   ),
                ],
              ),
          //SizedBox(height: 6,),
        Divider(thickness: 0.5,color: Colors.blue[300],),
        selectList.isEmpty? Center(child: Text(//check if selected category list is empty to display empty text
          "No available note in this category",style: TextStyle(
            fontSize: 25,
            color: Colors.grey[700],
            fontStyle: FontStyle.italic
        ),),
        ) : Expanded(
          child: SizedBox(  //if list not empty then display list content
            child: ListView.builder(
                itemCount: selectList.length,
                itemBuilder: (context,index){
                 return Card(
                   color: Colors.blue[400],
                   child: ListTile(
                     onTap: () async{
                       int old_cat=selectList[index][cattIndex];
                       dynamic value= await Navigator.pushNamed(context, '/edit',arguments: {//move to editing page to edit clicked content
                         'word':selectList[index][wordIndex],//return select_list individual contents back to edit page for editing
                         'time':selectList[index][timeIndex],
                         'title':selectList[index][titleIndex],
                         'cat'  :selectList[index][cattIndex]
                       });
                         //assign returned value into their respective position,update
                         getInfos.word  = value['new_word'];//assign updated values back to their index
                         getInfos.title = value['new_title'];
                         getInfos.time  = value['new_time'];
                         getInfos.category = value['new_cat'];
                         if(catIndex==0){//if we are in all category section
                           //also remove from original category if editing is done from all cat while also updating
                            old_cat!=value['new_cat']? (){
                              getList[value['new_cat']].add(getInfos.getInfo());
                              getList[selectList[index][cattIndex]].removeAt(getList[selectList[index][cattIndex]].indexOf(selectList[index]));//also remove from original category by checking it stored category
                            }():
                            getList[selectList[index][cattIndex]][getList[selectList[index][cattIndex]].indexOf(selectList[index])]=getInfos.getInfo();//check if categories got edited and remove and add to new category
                       }
                         else{//if we are not in all cat section
                           old_cat!=value['new_cat']? (){ //if cat changed just remove from old and send the updated to new cat
                             getList[value['new_cat']].add(getInfos.getInfo());
                             getList[catIndex].removeAt(index);
                           }():
                           selectList[index]=getInfos.getInfo();//check if categories got edited and remove,save and add to new category
                         }
                       //below code helps put us in the just edited category
                       catIndex=value['new_cat'];
                       selectList=getList[value['new_cat']];
                       all.clear();
                       setState(() {
                       });
                     },
                     title: Text(selectList[index][titleIndex],
                     style:TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold
                     )),
                     subtitle: Text(selectList[index][timeIndex],style: TextStyle(//display time from it 2D list
                     color: Colors.white
                     ),),
                    shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8)
                   ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  selectList[index][favIndex]=!selectList[index][favIndex];
                                  selectList[index][favIndex]? getList[6].add(selectList[index]):catIndex==6?getList[6].removeAt(index):getList[6].removeAt(favourite.indexOf(selectList[index]));//this line helps add or remove from fav categories based of if we are in the fav cat or in another cat
                                });
                          },
                              icon: selectList[index][favIndex]==true? Icon(Icons.favorite):Icon(Icons.favorite_border),
                          ),
                          IconButton(onPressed: () async{
                            if(await confirmDelete("Are you sure you want to delete this note?","Delete Note")==true){
                              setState(() {
                                if(catIndex==0){//if we are deleting from all cat then remove from base cat too
                                  getList[selectList[index][cattIndex]].removeAt(getList[selectList[index][cattIndex]].indexOf(selectList[index]));
                                }
                                selectList[index][favIndex]? favourite.removeAt(favourite.indexOf(selectList[index])):null;
                                selectList.removeAt(index);//delete from list on delete icon press and //delete from fav list
                              });
                            }
                          }, icon:Icon(Icons.delete,color: Colors.white,)),
                        ],
                      ),
                 )
                 );
                },
                    ),
          ),
        ),
          ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent[400]!,
          onPressed: () async{
            dynamic value = await Navigator.pushNamed(context, '/edit');
            getInfos.word = value['new_word'];
            getInfos.title = value['new_title'];
            getInfos.time = value['new_time'];
            getInfos.category = value['new_cat'];
            getList[value['new_cat']].add(getInfos.getInfo());

            //below code helps put us in the just edited category
            catIndex=value['new_cat'];
            selectList=getList[value['new_cat']];
            all.clear();
            setState(() {
              //
            });
          },
          child: Icon(Icons.add,size: 28,color: Colors.white,),

          ),
    );
  }
}


