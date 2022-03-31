// Project imports:
import 'package:italms/screens/admin/ApiProvider/StaffApiProvider.dart';
import 'package:italms/utils/model/LeaveAdmin.dart';
import 'package:italms/utils/model/LibraryCategoryMember.dart';
import 'package:italms/utils/model/Staff.dart';

class StaffRepository {
  StaffApiProvider _provider = StaffApiProvider();

  Future<LibraryMemberList> getStaff() {
    return _provider.getAllCategory();
  }

  Future<StaffList> getStaffList(int id) {
    return _provider.getAllStaff(id);
  }

  Future<LeaveAdminList> getStaffLeave(String url, String endPoint) {
    return _provider.getAllLeave(url, endPoint);
  }
}
