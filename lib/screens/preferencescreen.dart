import 'package:benoit/misc/utilities.dart';
import 'package:benoit/screens/homescreen.dart';
import 'package:benoit/widgets/preferencebutton.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key, required this.title});

  final String title;

  @override
  State<PreferencesScreen> createState() => PreferencesScreenState();
}

class PreferencesScreenState extends State<PreferencesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation selectPreferenceAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    selectPreferenceAnimation = ColorTween(
            begin: const Color.fromARGB(255, 233, 233, 233),
            end: BenoitColors.jungleGreen[900])
        .animate(animationController);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: FutureBuilder<SharedPreferences>(
            future: SharedPreferences.getInstance(),
            builder: (context, sharedPreferencesSnapshot) {
              if (sharedPreferencesSnapshot.hasData) {
                SharedPreferences sharedPreferences =
                    sharedPreferencesSnapshot.data as SharedPreferences;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40,),
                            child: Text(
                              'Preferences',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              PreferenceButton(
                                text: 'Political Figures',
                                sharedPreferences: sharedPreferences,
                                textFile: 'assets/misc/content/political_figures.txt',
                                imgSrc: 'https://www.thefamouspeople.com/cdn-cgi/mirage/608bed817c49109225caf1dc14ffdea6b7fad539a91cd9b212f06f34116d3e8e/1280/https://www.thefamouspeople.com/profiles/thumbs/abraham-lincoln-26.jpg',
                              ),
                              PreferenceButton(
                                text: 'Historical Events',
                                sharedPreferences: sharedPreferences,
                                textFile:
                                    'assets/misc/content/historical_events.txt',
                                imgSrc: 'https://static.demilked.com/wp-content/uploads/2022/01/interesting-historical-pics-1.jpeg',
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              PreferenceButton(
                                text: 'Celebrities',
                                sharedPreferences: sharedPreferences,
                                textFile: 'assets/misc/content/celebrities.txt',
                                imgSrc: 'https://static.boredpanda.com/blog/wp-content/uploads/2017/02/celebrities-black-white-photography-norman-seeff-1-589c1d4ceeabc__880.jpg',
                              ),
                              PreferenceButton(
                                text: 'Country Musicians',
                                sharedPreferences: sharedPreferences,
                                textFile:
                                    'assets/misc/content/country_musicians.txt',
                                imgSrc: 'https://media.istockphoto.com/id/1070032658/photo/portrait-of-guitarist.jpg?s=612x612&w=0&k=20&c=GGD08OJXALxzvywUmFMnFxbLRS-GzT1_4gYmv2eqj5s=',
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              PreferenceButton(
                                text: 'Influencers',
                                sharedPreferences: sharedPreferences,
                                textFile: 'assets/misc/content/celebrities.txt',
                                imgSrc: 'https://static.toiimg.com/photo/msid-79703899/79703899.jpg',
                              ),
                              PreferenceButton(
                                text: 'R&B Musicians',
                                sharedPreferences: sharedPreferences,
                                textFile: 'assets/misc/content/celebrities.txt',
                                imgSrc: 'https://s.hdnux.com/photos/53/11/21/11310165/12/1200x0.jpg',
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              PreferenceButton(
                                text: 'Architectural Feats',
                                sharedPreferences: sharedPreferences,
                                textFile:
                                    'assets/misc/content/historical_figures.txt',
                                imgSrc: 'https://p4.wallpaperbetter.com/wallpaper/89/364/899/skyscrapers-in-black-and-white-wallpaper-preview.jpg',
                              ),
                              PreferenceButton(
                                text: 'Advertising',
                                sharedPreferences: sharedPreferences,
                                textFile:
                                    'assets/misc/content/historical_figures.txt',
                                imgSrc: 'https://cdn.theatlantic.com/thumbor/-gO49iEHiD4pHGcCgGRTR_yAe38=/1x499:6095x3927/1600x900/media/img/mt/2020/01/GettyImages_106417185/original.jpg',
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              PreferenceButton(
                                text: 'Ballet Icons',
                                sharedPreferences: sharedPreferences,
                                textFile:
                                    'assets/misc/content/historical_figures.txt',
                                imgSrc: 'https://www.ilfordphoto.com/wp/wp-content/uploads/2020/04/Hasselblad-500-CM.jpg',
                              ),
                              PreferenceButton(
                                text: 'Comic Characters',
                                sharedPreferences: sharedPreferences,
                                textFile:
                                    'assets/misc/content/comic_characters.txt',
                                imgSrc: 'https://i.pinimg.com/originals/e2/92/bb/e292bb6952df343f62a55a6f615bddd5.jpg',
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              PreferenceButton(
                                text: 'Mysteries',
                                sharedPreferences: sharedPreferences,
                                textFile:
                                    'assets/misc/content/historical_figures.txt',
                                imgSrc: 'https://images.unsplash.com/photo-1605806616949-1e87b487fc2f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dHJ1ZSUyMGNyaW1lfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                              ),
                              PreferenceButton(
                                text: 'Global Foods',
                                sharedPreferences: sharedPreferences,
                                textFile:
                                    'assets/misc/content/global_foods.txt',
                                imgSrc: 'https://images.freeimages.com/images/previews/d04/coffee-for-breakfast-1641349.jpg',
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              PreferenceButton(
                                text: 'Popular Filmmakers',
                                sharedPreferences: sharedPreferences,
                                textFile: 'assets/misc/content/filmmakers.txt',
                                imgSrc: 'https://s3-us-west-2.amazonaws.com/prd-rteditorial/wp-content/uploads/2021/01/25201804/Radha-Blank-1.jpg',
                              ),
                              PreferenceButton(
                                text: 'Historical Figures',
                                sharedPreferences: sharedPreferences,
                                textFile:
                                    'assets/misc/content/historical_figures.txt',
                                imgSrc: 'https://hips.hearstapps.com/hmg-prod/images/claudette-colvin-1547849761.jpg?resize=480:*',
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              PreferenceButton(
                                text: 'Abnormal Laws',
                                sharedPreferences: sharedPreferences,
                                textFile:
                                    'assets/misc/content/entrepreneurs.txt',
                                imgSrc: 'https://www.teahub.io/photos/full/81-819341_lawyer-black-and-white.jpg',
                              ),
                              PreferenceButton(
                                text: 'Companies',
                                sharedPreferences: sharedPreferences,
                                textFile:
                                    'assets/misc/content/entrepreneurs.txt',
                                imgSrc: 'https://media.istockphoto.com/id/1019702098/photo/group-of-business-people-in-the-conference-room.jpg?s=612x612&w=0&k=20&c=OW-jVI3h-WWrJ57-02a_hHNeOgTfRmiIePF30cyf6cI=',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else if (sharedPreferencesSnapshot.hasError) {
                return Text(sharedPreferencesSnapshot.error.toString());
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(
                title: 'Benoit',
              ),
            ),
          );
        },
        elevation: 0,
        focusElevation: 0,
        child: const Icon(Icons.send),
      ),
    );
  }
}
