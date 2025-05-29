import '../constant/data.dart';

class Transport {
  int idTransport, etat, exercice, idClient, idTransporteurExterne, num = 0;
  String date, heure, nomClient, tel1Client, tel2Client, nomTransporteurExterne, poste, username, destination;
  double montantProduit, montantLivrInterne, montantLivrExterne, total;

  Transport({
    required this.idTransport,
    required this.exercice,
    required this.date,
    required this.heure,
    required this.nomClient,
    required this.destination,
    required this.montantLivrExterne,
    required this.montantLivrInterne,
    required this.montantProduit,
    required this.nomTransporteurExterne,
    required this.idTransporteurExterne,
    required this.poste,
    required this.tel1Client,
    required this.tel2Client,
    required this.username,
    required this.idClient,
    required this.total,
    required this.etat,
  });

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
    date: json['DATE'],
    destination: json['DESTINATION'],
    heure: json['HEURE'],
    nomClient: json['NOM_CLIENT'],
    nomTransporteurExterne: json['NOM_TRANS_EXTERNE'],
    poste: json['DES_POSTE'],
    tel1Client: json['TEL1_CLIENT'],
    tel2Client: json['TEL2_CLIENT'],
    username: json['USERNAME'],
    etat: AppData.getInt(json, 'ETAT'),
    exercice: AppData.getInt(json, 'EXERCICE'),
    idTransport: AppData.getInt(json, 'ID'),
    idTransporteurExterne: AppData.getInt(json, 'ID_TRANSPORTEUR_EXTERNE'),
    idClient: AppData.getInt(json, 'ID_CLIENT'),
    montantLivrExterne: AppData.getDouble(json, 'MONTANT_TRANSPORT_EXTERNE'),
    montantLivrInterne: AppData.getDouble(json, 'MONTANT_LIV_INTERNE'),
    montantProduit: AppData.getDouble(json, 'MONTANT_PRODUIT'),
    total: AppData.getDouble(json, 'TOTAL'),
  );
}
