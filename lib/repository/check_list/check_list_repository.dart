abstract class CheckListRepository{
  Future getCheckListDetail();
  Future submitCheckListDetail({required Map<String, String> body});
}