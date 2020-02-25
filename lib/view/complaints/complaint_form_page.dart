import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/complaint_bloc.dart';
import 'package:housesolutions/model/category_complaint_model.dart';
import 'package:housesolutions/model/complaint_model.dart';
import 'package:housesolutions/util/validator.dart';
import 'package:housesolutions/widget/loading.dart';

class ComplaintFormPage extends StatefulWidget {
  @override
  _ComplaintFormPageState createState() => _ComplaintFormPageState();
}

class _ComplaintFormPageState extends State<ComplaintFormPage> with ValidationMixin{
  final _key = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  final bloc = BlocProvider.getBloc<ComplaintBloc>();

  @override
  void initState() { 
    super.initState();
    bloc.fetchCategory();
  }

  @override
  void dispose() {
    bloc.setTitle(null);
    bloc.setMessage(null);
    bloc.setIdCategory(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            title: Text("Form Pengaduan"),
          ),
          body: Form(
            key: _form,
            child: StreamBuilder<Complaints>(
              stream: bloc.getComplaint,
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      snapshot.hasData ? null : Padding(
                        padding: const EdgeInsets.fromLTRB(16, 30, 16, 5),
                        child: StreamBuilder<List<ComplaintCategory>>(
                          stream: bloc.getCategory,
                          builder: (context, category) {
                            return StreamBuilder<int>(
                              stream: bloc.getIdCategory,
                              builder: (context, snapshoot) {
                                return DropdownButtonFormField<int>(
                                  validator: validateRequiredInteger,
                                  items: category.hasData ? category.data.map((cat) => DropdownMenuItem(
                                    child: Text(cat.ccatTitle),
                                    value: cat.idCcat,
                                  )).toList():[], 
                                  onChanged: bloc.setIdCategory,
                                  value: snapshoot.data,
                                  hint: Text("Pilih Kategori Pengaduan"),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5)
                                  ),
                                );
                              }
                            );
                          }
                        ),
                      ),
                      snapshot.hasData ? null : Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
                        child: Builder(builder: (ctx){
                          return TextFormField(
                            validator: validateRequired,
                            onSaved: bloc.setTitle,
                            decoration: InputDecoration(
                              hintText: "Subyek",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5)
                            ),
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 10),
                        child: TextFormField(
                          validator: validateRequired,
                          onSaved: bloc.setMessage,
                          maxLines: 10,
                          decoration: InputDecoration(
                            hintText: snapshot.hasData ? "Balasan":"Penjelasan",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 10)
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.fromLTRB(16, 5, 16, 0),
                        child: RaisedButton(
                          onPressed: () => snapshot.hasData ? bloc.replyComplaint(_form) : bloc.doComplaint(_form),
                          color: Theme.of(context).primaryColor,
                          colorBrightness: Brightness.dark,
                          child: Text(snapshot.hasData ? "Balas":"Simpan"),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                      )
                    ].where((i) => i != null).toList(),
                  ),
                );
              }
            ),
          ),
        ),
        StreamBuilder<bool>(
          initialData: false,
          stream: bloc.isLoading,
          builder: (context, snapshot) {
            return Loading(snapshot.data);
          }
        )
      ],
    );
  }
}