class Profile {
  String name;
  String imagePath;
  String country;
  String city;
  int followers;
  int posts;
  int following;
  Profile({
    this.name,this.imagePath,this.city,this.followers,this.posts,this.following,this.country
  });
}

final List<Profile> profiles=[
  Profile(
    imagePath:'images/profile1.jpeg',
    name:'Lori Perez',
    country:'France',
    city: "Mantes",
    followers: 869,
    posts: 135,
    following: 485,
  ),  
  Profile(
    imagePath:'images/profile2.jpeg',
    name:'Lauren Terner',
    country:'France',
    city: "Paris",
    followers: 365,
    posts: 147,
    following: 256,
  ),  
  Profile(
    imagePath:'images/profile3.jpeg',
    name:'Brad Pitt',
    country:'U.S',
    city: "Springfield Missouri",
    followers: 668,
    posts: 256,
    following: 452,
  ),  
];