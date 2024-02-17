import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooper_alaa_awad_test/controller/email_bloc/email_event.dart';
import 'package:hooper_alaa_awad_test/controller/email_bloc/email_state.dart';

import '../../model/email_model.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final Dio dio;

  EmailBloc(
    this.dio,
  ) : super(InitState());

  List<Email> emailsList = [];

  //code get data
  Future<void> getData() async {
    emit(LoadingState());
    try {
      Response response = await dio.get(
          "https://emergingideas.ae/test_apis/read.php?email=?mickeydamuller@gmail.com");
      if (response.statusCode == 200) {
        List<Email> emails = [];
        for (var i in response.data) {
          emails.add(Email.fromJson(i));
        }
        emailsList = emails;
        emit(GetDataSuccessState(emails));
        // yield GetDataSuccessState(emails);
      } else {
        emit(GetDataErrorState());
        // yield GetDataErrorState();
      }
    } catch (e) {
      print("error Get Data is $e");
      emit(GetDataErrorState());
      // yield GetDataErrorState();
    }
  }

  //code update data
  Future<void> updateData(int id, Map<String, dynamic> data) async {
    emit(LoadingState());
    Response response = await dio.put(
      "https://emergingideas.ae/test_apis/edit.php?id=$id&title=${data["title"]}&description=${data["description"]}&img_link=${data["img_link"]}&email=${data["email"]}",
      // data: {
      //   "id": 634,
      //   "title": "Alaa Awad",
      //   "description": "Test Post Email",
      //   "img_link": "",
      //   "email": "alaaAwad@gmail.com",
      // }
    );
    if (response.statusCode == 200) {
      emit(UpdateDataSuccessState());
    } else {
      emit(UpdateDataErrorState());
    }
  }

  // code post data to dataBase
  Future<void> postData(Map<String, dynamic> data) async {
    emit(LoadingState());
    Response response = await dio.post(
      "https://emergingideas.ae/test_apis/create.php",
      data: data,
    );
    if (response.statusCode == 200) {
      emit(PostDataSuccessState());
    } else {
      emit(PostDataErrorState());
    }
  }

  // code delete data in dataBase
  Future<void> deleteData(int id ,String email) async {
    emit(LoadingState());
    Response response = await dio.delete(
      "https://emergingideas.ae/test_apis/delete.php?email=$email&id=$id",
    );
    if (response.statusCode == 200) {
      emit(DeleteDataSuccessState());
    } else {
      emit(DeleteDataErrorState());
    }
  }
}
