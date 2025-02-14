class Items {
  final String img;
  final String title;
  final String subTitle;

  ///
  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(
    img: "assets/images/Logo_Assabil_bg.png",
    title: "Assabil",
    subTitle:
        " une connexion en temps réel ,\n ainsi une interaction \n instantanée et efficace",
  ),
  Items(
    img: "assets/images/saisie_index.jpg",
    title: "Relver Index",
    subTitle:
        "Relever les compteurs facilement,\nsurtout efficacement",
  ),
  Items(
    img: "assets/images/sync_home.png",
    title: "Synchronization",
    subTitle: "Importer et exporter vos données\nen temps réel",
  ),
  Items(
    img: "assets/images/dashboard.png",
    title: "Tableau de bord",
    subTitle: "Suivre vos données\npour une gestio efficace et réactive des activités",
  ),
  
 
  
];
