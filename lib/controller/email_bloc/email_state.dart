import '../../model/email_model.dart';

abstract class EmailState {}

class InitState extends EmailState {}

class LoadingState extends EmailState {}

class GetDataSuccessState extends EmailState {
  List<Email> emails;
  GetDataSuccessState(this.emails);
}

class GetDataErrorState extends EmailState {}

class PostDataSuccessState extends EmailState {}

class PostDataErrorState extends EmailState {}

class UpdateDataSuccessState extends EmailState {}

class UpdateDataErrorState extends EmailState {}

class DeleteDataSuccessState extends EmailState {}

class DeleteDataErrorState extends EmailState {}
