import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

class KisilerDaoRepo {

  var collectionKisiler = FirebaseFirestore.instance.collection("Kisiler");

  Future<void> sil(String kisi_id) async {
    collectionKisiler.doc(kisi_id).delete();
  }

  Future<void> guncelle(String kisi_id, String kisi_ad, String kisi_tel) async {
    var guncellenenKisi = HashMap<String, dynamic>();
    guncellenenKisi["kisi_ad"] = kisi_ad;
    guncellenenKisi["kisi_tel"] = kisi_tel;
    collectionKisiler.doc(kisi_id).update(guncellenenKisi);
  }

  Future<void> kaydet(String kisi_ad, String kisi_tel) async {
    var yeniKisi = HashMap<String, dynamic>();
    yeniKisi["kisi_id"] = "";
    yeniKisi["kisi_ad"] = kisi_ad;
    yeniKisi["kisi_tel"] = kisi_tel;
    collectionKisiler.add(yeniKisi);
  }

}
