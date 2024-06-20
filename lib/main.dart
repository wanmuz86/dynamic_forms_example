import 'package:dynamic_forms/DynamicTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DynamicFormPage()
    );
  }
}


class DynamicFormPage extends StatefulWidget {
  const DynamicFormPage({super.key});

  @override
  State<DynamicFormPage> createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<DynamicFormPage> {

  final _formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  static List<String> _friendsList = [''];

  @override
  void initState() {
    super.initState();

  }
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dynamic form"),),
      body:Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name textfield
              Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      hintText: 'Enter your name'
                  ),
                  validator: (v){
                    if(v!.trim().isEmpty){
                      return 'Please enter something';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20,),
              Text('Add Friends',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index)=>Row(
                      children: [
                        Expanded(
                          child: DynamicTextField(
                            key: UniqueKey(),
                            initialValue: _friendsList[index],
                            onChanged: (v) => _friendsList[index] = v,
                          ),
                        ),
                        const SizedBox(width: 20),
                        _textfieldBtn(index),
                      ],
                    ),
                
                    separatorBuilder: (context,index)=> SizedBox(height: 20,),
                    itemCount: _friendsList.length),
              ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                print(_nameController.text);
                print(_friendsList);
              }
            },
            child: const Text('Submit'),
          ),
        )
            ],
          ),
        ),
      )
    );
  }
  Widget _textfieldBtn(int index) {
    bool isLast = index == _friendsList.length - 1;

    return InkWell(
      onTap: () => setState(
            () => isLast ? _friendsList.add('') : _friendsList.removeAt(index),
      ),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isLast ? Colors.green : Colors.red,
        ),
        child: Icon(
          isLast ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

