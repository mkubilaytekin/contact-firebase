import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_app/data/entity/kisiler.dart';
import 'package:kisiler_app/data/repo/kisilerdao_repo.dart';

class AnasayfaCubit extends Cubit<List<Kisiler>>{
  AnasayfaCubit():super(<Kisiler>[]);
  var krepo = KisilerDaoRepo();
  var collectionKisiler = FirebaseFirestore.instance.collection("Kisiler");

  Future<void> kisileriYukle() async {
    collectionKisiler.snapshots().listen((event) {
      var kisilerListesi = <Kisiler>[];

      var documents = event.docs;

      for(var doc in documents) {
         var key = doc.id;
         var data = doc.data();
         var kisi = Kisiler.fromJson(data, key);
         kisilerListesi.add(kisi);
      }

      emit(kisilerListesi);
    });
  }

  Future<void> ara(String aramaKelimesi) async {
    collectionKisiler.snapshots().listen((event) {
      var kisilerListesi = <Kisiler>[];

      var documents = event.docs;

      for(var doc in documents) {
        var key = doc.id;
        var data = doc.data();
        var kisi = Kisiler.fromJson(data, key);

        if(kisi.kisi_ad.toLowerCase().contains(aramaKelimesi.toLowerCase())) {
          kisilerListesi.add(kisi);
        }
      }

      emit(kisilerListesi);
    });
  }

  Future<void> guncelle(String kisi_id, String kisi_ad, String kisi_tel) async {
    await krepo.guncelle(kisi_id, kisi_ad, kisi_tel);
  }

  Future<void> sil(String kisi_id) async {
    await krepo.sil(kisi_id);
  }

  Future<void> kaydet(String kisi_ad, String kisi_tel) async {
    await krepo.kaydet(kisi_ad, kisi_tel);
  }

}