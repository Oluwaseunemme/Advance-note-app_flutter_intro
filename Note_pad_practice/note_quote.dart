class GetInfo{
  String word;
  int category;
  String title;
  String time;
  bool isFav;
  //int favIndex;
  GetInfo(this.word,this.category,this.title,this.time,{this.isFav=false,});
  List getInfo()=>[word,category,title,time,isFav,];
}