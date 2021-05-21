class ProfileModel {
  final String key;
  final String name;
  final String email;
  final String mobile;
  final String dob;
  final String age;
  final String lastScreen;
  final String lastBse;
  final bool cancerHistory;

  ProfileModel({
    this.key = '',
    this.name = '',
    this.email = '',
    this.mobile = '',
    this.dob = '',
    this.age = '',
    this.lastScreen = '',
    this.lastBse = '',
    this.cancerHistory= false,
  });

  Map<String, dynamic> toMap() => {
        'key': key,
        'name': name,
        'email': email,
        'mobile': mobile,
        'dob': dob,
        'age': age,
        'lastScreen': lastScreen,
        'lastBse': lastBse,
        'cancerHistory': cancerHistory,
      };
}
