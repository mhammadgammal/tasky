import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  var formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final dateController = TextEditingController();
  AddTaskCubit() : super(AddTaskInitial());

  static AddTaskCubit get(BuildContext context) => BlocProvider.of(context);

  String selectedPriority = 'low';

  List<String> items = ['low', 'medium', 'high'];

  ImagePicker imagePicker = ImagePicker();
  XFile? imageFile;

  void onPriorityChanged(value) {
    selectedPriority = value;
    emit(PriorityChangedState());
  }

  handleImagePick() async {
    imageFile = await imagePicker.pickImage(source: ImageSource.gallery);
    emit(ImagePickedState());
  }
}
