import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:housesolutions/bloc/home_bloc.dart';
import 'package:housesolutions/bloc/job_bloc.dart';
import 'package:housesolutions/model/category.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:housesolutions/util/validator.dart';
import 'package:housesolutions/widget/loading.dart';

class JobFormPage extends StatefulWidget {
  @override
  _JobFormPageState createState() => _JobFormPageState();
}

class _JobFormPageState extends State<JobFormPage> with ValidationMixin {
  final _key = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();
  final bloc = BlocProvider.getBloc<JobBloc>();
  final homeBloc = BlocProvider.getBloc<HomeBloc>();

  @override
  void initState() { 
    super.initState();
    homeBloc.fetchCategory();
  }

  @override
  void dispose() { 
    bloc.setIdCategory(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _key,
          body: Column(
            children: <Widget>[
              Container(
                height: 140.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Request Pekerja",
                            style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Text("Tuliskan Pekerja seperti apa yang anda inginkan dan apa saja yang harus dikerjakan", softWrap: true, textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(R.assetsImagesHeader), fit: BoxFit.fitWidth)
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: 5,
                      child: IconButton(
                        iconSize: 30.0,
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: navService.navigatePop
                      )
                    )
                  ],
                ),
              ),
              Flexible(
                child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: TextFormField(
                            validator: validateRequired,
                            onSaved: bloc.setTitle,
                            maxLength: 25,
                            decoration: InputDecoration(
                              labelText: "Judul",
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: StreamBuilder<List<Categories>>(
                            stream: homeBloc.getCategories,
                            builder: (context, snapshot) {
                              return StreamBuilder<int>(
                                stream: bloc.getIdCategory,
                                builder: (context, cat) {
                                  return DropdownButtonFormField<int>(
                                    value: cat.data,
                                    validator: validateRequiredInteger,
                                    onChanged: bloc.setIdCategory,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      labelText: "Jenis Pekerjaan",
                                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                    ),
                                    items: snapshot.hasData ? snapshot.data.map((category) {
                                      return DropdownMenuItem(
                                        value: category.idCategory,
                                        child: Text(category.categoryDesc)
                                      );
                                    }).toList():[], 
                                  );
                                }
                              );
                            }
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: TextFormField(
                            validator: validateRequired,
                            onSaved: bloc.setLocation,
                            maxLength: 20,
                            decoration: InputDecoration(
                              labelText: "Lokasi Penempatan",
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: TextFormField(
                            validator: validateRequired,
                            onSaved: bloc.setDesc,
                            maxLength: 500,
                            maxLines: 5,
                            decoration: InputDecoration(
                              labelText: "Keterangan Pekerjaan",
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Text("Penting !\nJangan memberi nomor telepon / alamat jelas. House Solutions tidak menjamin identias pekerja jika ada transaksi diluar aplikasi.", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            color: Theme.of(context).primaryColor,
                            colorBrightness: Brightness.dark,
                            child: Text("Requst Pekerja"),
                            onPressed: () => bloc.createJob(_form)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
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