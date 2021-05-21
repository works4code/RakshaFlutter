import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

DatabaseReference db = FirebaseDatabase.instance.reference();
FirebaseAuth auth = FirebaseAuth.instance;

const String db_profiles = 'Profiles';
const String db_breast_cancer_info = 'BreastCancerInfo';

const String db_login = 'login';
const String db_key = 'key';
const String db_name = 'name';
const String db_email = 'email';
const String db_mobile = 'mobile';
const String db_dob = 'dob';
const String db_age = 'age';
const String db_lastScreen = 'lastScreen';
const String db_lastBse = 'lastBse';
const String db_password = 'password';
const String db_cancerHistory = 'cancerHistory';

const String db_title = 'title';
const String db_image_url = 'imageUrl';
const String db_is_video = 'isVideo';
const String db_thumb_nail = 'thumbNail';
