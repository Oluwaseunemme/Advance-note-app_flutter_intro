import "package:flutter/material.dart";
//import "package:intl/intl.dart";

class Write extends StatefulWidget {
  const Write({super.key});

  @override
  State<Write> createState() => _WriteState();
}

class _WriteState extends State<Write> {
  String categories='RANDOM';
  String? word;
  String time="";
  String title="no title";
  String? titleError;
  bool isEdit=true;
  Map data={};
  late TextEditingController _controllerWord;
  late TextEditingController _controllerTitle;
  DateTime nowTime=DateTime.now();
  List<String> initCat=['SCHOOL', 'WORK','RELIGION','RANDOM','FAMILY',];
  bool allowEdit=true;
  //DateFormat time=d
  @override
  void didChangeDependencies() { //works like init but required is modal_route will be used so we could get data before modal route widgets are ready
    super.didChangeDependencies();
    if(ModalRoute.of(context)?.settings.arguments !=null && allowEdit==true){//check if modal_route is empty to know if it is new note or editing
      data=ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;//get incoming data and assign initial values to various field
      time=data['time'];
      word=data['word'];
      title=data['title'];
      categories=initCat[data['cat']-1];
      _controllerWord = TextEditingController(text:word);//helps initializes text_field data to a default value in-case of
      _controllerTitle = TextEditingController(text:title);
      print(categories);
    }
    else{
      time="Edited On:${nowTime.day}/${nowTime.month}/${nowTime.year} @ ${nowTime.hour}/${nowTime.minute}/${nowTime.second}"; //initialize time to latest
      isEdit=false;
    }
    allowEdit=false;
    //time="Edited:${nowTime.day}/${nowTime.month}/${nowTime.year} @ ${nowTime.hour}/${nowTime.minute}/${nowTime.second}";
  }
  @override
  void initState() {
    super.initState();
   // allowEdit=false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (){
                isEdit=true;
                print(word);
                //_controllerWord.dispose();
               // _controllerTitle.dispose();
                time="Edited On:${nowTime.day}/${nowTime.month}/${nowTime.year} @ ${nowTime.hour}/${nowTime.minute}/${nowTime.second}"; //move to home once saved
                Navigator.pop(context,{
                  'new_word':word,
                  'new_title':title,
                  'new_time':time,
                  'new_cat':initCat.indexOf(categories)+1
                });
              },
              icon: Icon(Icons.save,color: Colors.blueAccent[400],),
          style: IconButton.styleFrom(backgroundColor: Colors.white,),)
        ],
        title: Text(
          "Edit Text",
          style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent[400],
      ),
body: SingleChildScrollView(
    child: Column(
    children: <Widget>[
      SizedBox(height: 5,),
      Row(
      mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
                child: Padding(
               padding: const EdgeInsets.all(2.0),
               child: Text(time,
               style: TextStyle(color: Colors.black),),
                       ),),
            ),
          ),
          Expanded(
            child: DropdownButtonFormField<String>(
                initialValue: categories,
                decoration: InputDecoration(
                  labelText: categories,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12, //
                  ),
                ),
                items: initCat.map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                )).toList(),
                onChanged: (value) {
                 //allowEdit=false;
                  categories=value!;
                  print(categories);
                },
              ),
          ),
        ],
      ),
     Divider(color: Colors.blue[200],),
      Padding(
        padding: const EdgeInsets.fromLTRB(10,0,0,0),
        child: TextField(
          controller: isEdit==true? _controllerTitle: null,
          onChanged: (value){
            title=value;
            setState(() {
               titleError=value.length>40?"Title should be less than 40 char":null;
            });
          },
          decoration: InputDecoration(
              hintText: "Title",
              labelText:"Title...",
              //helperText:
              errorText:titleError,
              //prefixIcon: Icon(Icons.add),
              //suffixIcon: Icon(Icons.mic, color: Colors.black,),
              border: InputBorder.none,
          ),
        ),
      ),
     Divider(color: Colors.blue[200],),
        Padding(
          padding: const EdgeInsets.fromLTRB(10,0,0,0),
          child: TextField(
          controller: isEdit==true? _controllerWord: null,
            onChanged:(value){
              word=value;
              setState(() {
              //title_error=value.length>30?"Title should be less than 30 char":null;
          });
              },
              maxLines: null,
              autofocus: true,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText:"Note",
              hintText: "Write your note...",
              border: InputBorder.none,

          ),
          ),
        ),
              ],
            ),
          ),
    );
}}
