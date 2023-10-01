  /*
  void sendUserData() {
    final FirebaseFirestore storedb = FirebaseFirestore.instance;
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final String thisUserId = _firebaseAuth.currentUser!.uid;

    final user = <String, String>{
      "uid": thisUserId,
      "firstName": "Björn",
      "lastName": "Bergström",
      "userName": "Admin",
    };

    storedb
        .collection("users")
        .doc(thisUserId)
        .set(user)
        .onError((e, _) => print("Error writing document: $e"));

    final docRef = storedb.collection("users").doc();
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data["userName"]);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  */