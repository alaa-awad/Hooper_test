import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooper_alaa_awad_test/controller/email_bloc/email_bloc.dart';
import 'package:hooper_alaa_awad_test/controller/email_bloc/email_state.dart';
import 'package:hooper_alaa_awad_test/view/home_page/widgets/add_update_dialog.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailBloc = BlocProvider.of<EmailBloc>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddUpdateDialog(id: emailBloc.emailsList.last.id,null, emailBloc: emailBloc,);
              },
            );
          }, icon:const Icon( Icons.add)),
          IconButton(onPressed: (){
            emailBloc.getData();
          }, icon:const Icon( Icons.refresh)),
        ],
      ),
      body: BlocConsumer<EmailBloc, EmailState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return widgetLoading();
          }
          else if (state is GetDataSuccessState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    state.emails[index].title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email : ${state.emails[index].email}",
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "Description : ${state.emails[index].description}",
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "ImgLink : ${state.emails[index].imgLink}",
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddUpdateDialog(id: state.emails[index].id,state.emails[index], emailBloc: emailBloc,);
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.green,
                              )),
                          IconButton(
                              onPressed: () async {
                                await emailBloc
                                    .deleteData(state.emails[index].id,state.emails[index].email);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ],
                  ),
                );
              },
              itemCount: state.emails.length,
            );
          }
          else if (state is GetDataErrorState) {
            return const Center(child: Text("There is Error , don't Get Data"));
          }
          else {
            return widgetLoading();
          }
        }, listener: (BuildContext context, EmailState state) async{
          if(state is UpdateDataSuccessState || state is PostDataSuccessState || state is DeleteDataSuccessState){
           await emailBloc.getData();
          }
      },
      ),
    );
  }

  Widget widgetLoading() {
    return const Center(child: CircularProgressIndicator());
  }
}
