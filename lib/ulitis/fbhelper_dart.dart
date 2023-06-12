import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/admin_side/model/home_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Firebasehelper {
  static Firebasehelper fireHelper = Firebasehelper._();

  Firebasehelper._();

  FirebaseAuth fireauth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  signUP({required email, required password}) async {
    await fireauth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => print("Login Success !"))
        .catchError((e) => print("Failed : $e"));
  }

  bool status = false;
  String msg = '';

  Future<String> signIn({required email, required password}) async {
    return await fireauth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => "success")
        .catchError((e) => '${e}');
  }

  checkUser() {
    User? user = fireauth.currentUser;
    return user != null;
  }

  Future<bool?> logout() async {
    bool? check;
    FirebaseAuth.instance
        .signOut()
        .then((value) => check = true)
        .catchError((e) => check = false);
    await GoogleSignIn().signOut().then((value) => check = true);
    return check;
  }

  Future<String?> google_SignIn() async {
    String? msg;
    GoogleSignInAccount? user = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? auth = await user!.authentication;
    var crd = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);
    await fireauth
        .signInWithCredential(crd)
        .then((value) => msg = "Success")
        .catchError((e) => msg = '${e}');
    return msg;
  }

  Future<Map> userDetails() async {
    User? user = await fireauth.currentUser;
    String? email = user!.email;
    String? img = user.photoURL;
    String? name = user.displayName;
    Map m1 = {'email': email, 'img': img, 'name': name};
    return m1;
  }

  void insertitem({
    required Name,
    required Quantity,
    required Category,
    required Price,
    required Id,
    required Image,
    required Docid,
  }) async {
    await firestore.collection("item").add({
      "Name": Name,
      "Quantity": Quantity,
      "Category": Category,
      "Price": Price,
      "Docid": Docid,
      "Image":Image,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readitem() {
    return firestore
        .collection("item")
        .snapshots();
  }

  Future<void> deleteitem(String Docid)
  async {
   await  firestore
        .collection("item").doc(Docid).delete();
  }
   void update(UpdateModal updateModal,){print("===================  ${updateModal.docid}");
    firestore.collection("item").doc(updateModal.docid).set({
      "Name":"${updateModal.name}",
      "Price":"${updateModal.price}",
      "Category":"${updateModal.category}",
      "Quantity":"${updateModal.quantity}",
      "Image":"${updateModal.image}",
      "Docid":"${updateModal.docid}",
    });
   }
}
