import '../constant/data.dart';

class DetailsTransport {
  int idTransport, etat, exercice, num, type, idFournisseur, idTranspoteurInterne;
  String nomFournisseur, designationProduit, transporteurInterne;
  double qte, montantProduit, montantTransInterne, montantTransExterne, total;
  bool transportInterne;

  DetailsTransport({
    required this.idTransport,
    required this.exercice,
    required this.num,
    required this.idTranspoteurInterne,
    required this.transportInterne,
    required this.type,
    required this.idFournisseur,
    required this.nomFournisseur,
    required this.designationProduit,
    required this.transporteurInterne,
    required this.montantProduit,
    required this.qte,
    required this.montantTransInterne,
    required this.montantTransExterne,
    required this.total,
    required this.etat,
  });

  factory DetailsTransport.fromJson(Map<String, dynamic> json) => DetailsTransport(
    nomFournisseur: json['NOM_FOURNISSEUR'],
    designationProduit: json['DESIGNATION_PRODUIT'],
    transporteurInterne: json['NOM_TRANSP'],
    transportInterne: AppData.getInt(json, 'TRANSPORT_INTERNE') == 1,
    idFournisseur: AppData.getInt(json, 'ID_FOURNISSEUR'),
    type: AppData.getInt(json, 'TYPE'),
    idTranspoteurInterne: AppData.getInt(json, 'ID_TRANSPORTEUR_INTERNE'),
    etat: AppData.getInt(json, 'ETAT_TR'),
    exercice: AppData.getInt(json, 'EXERCICE'),
    idTransport: AppData.getInt(json, 'ID'),
    num: AppData.getInt(json, 'NUM'),
    qte: AppData.getDouble(json, 'QTE'),
    montantTransInterne: AppData.getDouble(json, 'MONTANT_TRANSPORT_INTERNE'),
    montantTransExterne: AppData.getDouble(json, 'MONTANT_TRANSPORT_EXTERNE'),
    montantProduit: AppData.getDouble(json, 'MONTANT_PRODUIT'),
    total: AppData.getDouble(json, 'TOTAL'),
  );
}
