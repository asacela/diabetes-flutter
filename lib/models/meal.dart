
class Meal {
  final String uid;
  final String title;
  final String carbs;
  final String photoUrl;
  final String ingredientList;
  final String recipe;
  final String absorptionTime;
  final bool liked;


  const Meal({
    required this.uid,
    required this.title,
    required this.carbs,
    required this.photoUrl,
    required this.ingredientList,
    required this.recipe,
    required this.absorptionTime,
    required this.liked,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      uid: json['uid'],
      title: json['title'],
      carbs: json['carbs'],
      photoUrl: json['photoUrl'],
      ingredientList: json['ingredientList'],
      recipe: json['recipe'],
      absorptionTime: json['absorptionTime'],
      liked: json['liked'],
    );
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "title": title,
    "carbs": carbs,
    "photoUrl": photoUrl,
    "ingredientList": ingredientList,
    "recipe": recipe,
    "absorptionTime": absorptionTime,
    "liked": liked
  };

  
}