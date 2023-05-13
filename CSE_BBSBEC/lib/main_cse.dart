import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:csebbsbec/Calendar.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'Notifications.dart' as prefix0;
// import 'Syllabus.dart';

ThemeData appTheme = ThemeData(
    primaryColor: Colors.purple,
    secondaryHeaderColor: Colors.blue /* Colors.teal*/
    // fontFamily:
    );

int sel = 0;
double? width;
double? height;
final bodies = [HomeScreen(), Calander(), prefix0.Notification()];

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<BottomNavigationBarItem> createItems() {
    List<BottomNavigationBarItem> items = [];
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.home,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.home,
          color: Colors.black,
        ),
        label: "Home"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.calendar_month_rounded,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.calendar_month_rounded,
          color: Colors.black,
        ),
        label: "Calander"));
    // items.add(BottomNavigationBarItem(
    //     activeIcon: Icon(
    //       Icons.note_rounded,
    //       color: appTheme.primaryColor,
    //     ),
    //     icon: Icon(
    //       Icons.note_rounded,
    //       color: Colors.black,
    //     ),
    //     label: "Syllabus"));
    items.add(BottomNavigationBarItem(
        activeIcon: Icon(
          Icons.notifications,
          color: appTheme.primaryColor,
        ),
        icon: Icon(
          Icons.notifications,
          color: Colors.black,
        ),
        label: "Notifications"));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bodies.elementAt(sel),
        bottomNavigationBar: BottomNavigationBar(
          items: createItems(),
          unselectedItemColor: Colors.black,
          selectedItemColor: appTheme.primaryColor,
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: false,
          showSelectedLabels: true,
          currentIndex: sel,
          elevation: 1.5,
          onTap: (int index) {
            if (index != sel)
              setState(() {
                sel = index;
              });
          },
        ));
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigation.selindex=0;

    width = MediaQuery.of(context).size.shortestSide;
    height = MediaQuery.of(context).size.longestSide;
    double h = 50;
    double w = 50;
    return Scaffold(
      // bottomNavigationBar: /*NavigationTest()*/Navigation(),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        hoverElevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("More Info :"),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: StadiumBorder(),
                          ),
                          child: Image.asset('assets/images/gmail.png'),
                          onPressed: () async {
                            const url =
                                'mailto:er.amritpal17@gmail.com?subject=I am using your flutter project so';
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        height: h,
                        width: w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: StadiumBorder(),
                          ),
                          child: Image.asset('assets/images/instagram.png'),
                          onPressed: () async {
                            const url =
                                'https://www.instagram.com/i.am.amritpal/';
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        height: h,
                        width: w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: StadiumBorder(),
                          ),
                          child: Image.asset('assets/images/telegram.png'),
                          onPressed: () async {
                            const url = 'https://t.me/i-amrit';
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SizedBox(
                        height: h,
                        width: w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: StadiumBorder(),
                          ),
                          child: Image.asset('assets/images/whatsapp.png'),
                          onPressed: () async {
                            const url = 'https://wa.me/+917681959917';
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.info_outline),
        backgroundColor: appTheme.primaryColor.withOpacity(.5),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[HomeTop(), pastevents, upcomingEvents],
        ),
      ),
    );
  }
}

var selectedloc = 0;
List<String> locs = ['Events', 'Search an Event'];

class HomeTop extends StatefulWidget {
  const HomeTop({Key? key}) : super(key: key);
  @override
  _HomeTop createState() => _HomeTop();
}

class _HomeTop extends State<HomeTop> {
  var isPastEventsselected = true;

  TextEditingController c = TextEditingController(text: locs[1]);
  final user = FirebaseAuth.instance.currentUser!;
  //sign user out
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: Clipper08(),
          child: Container(
            height: height! * .65 < 450 ? height! * .65 : 500, //400
            //color: Colors.tealAccent,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              appTheme.primaryColor,
              appTheme.secondaryHeaderColor
            ])),
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: width! * 0.05,
                    ),
                    // Icon(
                    //   Icons.settings,
                    //   color: Colors.white,
                    // )
                    IconButton(
                      onPressed: signUserOut,
                      icon: Icon(Icons.logout),
                      color: Colors.white,
                      alignment: Alignment.topLeft,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height! / 16,
              ),
              Text(
                'BABA BANDA SINGH BAHADUR \n ENGINEERING COLLEGE',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height! * 0.0375),
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: TextField(
                    controller: c,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    cursorColor: appTheme.primaryColor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 13),
                        suffixIcon: Material(
                          child: InkWell(
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                          elevation: 5.0,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: height! * 0.025,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                      child: Choice08(
                          icon: Icons.event_available,
                          text: "Past Events",
                          selected: isPastEventsselected),
                      onTap: () {
                        setState(() {
                          isPastEventsselected = true;
                        });
                      }),
                  SizedBox(
                    width: width! * 0.055,
                  ),
                  InkWell(
                    child: Choice08(
                        icon: Icons.event_busy,
                        text: "Upcoming Events",
                        selected: !isPastEventsselected),
                    onTap: () {
                      setState(() {
                        isPastEventsselected = false;
                      });
                    },
                  )
                ],
              )
            ]),
          ),
        )
      ],
    );
  }
}

class Clipper08 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);
    // ignore: non_constant_identifier_names
    var End = Offset(size.width / 2, size.height - 30.0);
    // ignore: non_constant_identifier_names
    var Control = Offset(size.width / 4, size.height - 50.0);

    path.quadraticBezierTo(Control.dx, Control.dy, End.dx, End.dy);
    // ignore: non_constant_identifier_names
    var End2 = Offset(size.width, size.height - 80.0);
    // ignore: non_constant_identifier_names
    var Control2 = Offset(size.width * .75, size.height - 10.0);

    path.quadraticBezierTo(Control2.dx, Control2.dy, End2.dx, End2.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class Choice08 extends StatefulWidget {
  final IconData? icon;
  final String? text;
  final bool? selected;

  Choice08({this.icon, this.text, this.selected});

  @override
  _Choice08State createState() => _Choice08State();
}

class _Choice08State extends State<Choice08>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: widget.selected!
          ? BoxDecoration(
              color: Colors.white.withOpacity(.30),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            )
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(
            width: width! * .025,
          ),
          Text(
            widget.text!,
            style: TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}

var viewallstyle =
    TextStyle(fontSize: 14, color: appTheme.primaryColor //Colors.teal
        );
var pastevents = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: width! * 0.05,
          ),
          Text(
            "Past Events",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Spacer(),
          // Text("VIEW ALL", style: viewallstyle)
        ],
      ),
    ),
    Container(
      height: height! * .25 < 170 ? height! * .25 : 170,
      //height: height! * .25 < 300 ? height! * .25 : 300,
      // child:
      // ConstrainedBox(
      //   constraints: BoxConstraints(maxHeight: 170, minHeight: height! * .13),
      child: ListView.builder(
          itemBuilder: (context, index) => events[index],
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          itemCount: events.length,
          scrollDirection: Axis.horizontal),
    ),
  ],
);
List<PastEvent> events = [
  PastEvent(
    image: "assets/images/ML1.png",
    name: "Explore ML Beginner",
    monthyear: "May 2022",
    venue: "Seminar\nHall 1",
  ),
  PastEvent(
    image: "assets/images/ComposeCamp.png",
    name: "Compose Camp\nDay 1",
    monthyear: "Sept 2022",
    venue: "Hybrid",
  ),
  PastEvent(
    image: "assets/images/ComposeCamp.png",
    name: "Compose Camp\nDay 2",
    monthyear: "Sept 2022",
    venue: "Seminar\nHall 1",
  ),
];

class PastEvent extends StatelessWidget {
  final String? image, monthyear;
  final String? name, venue;

  const PastEvent({Key? key, this.image, this.monthyear, this.name, this.venue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: height! * .137 < 160 ? height! * .137 : 160,
                    width: width! * .5 < 250 ? width! * .5 : 250,
                    //   child: Image.asset(image,fit: BoxFit.cover,)
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(image!), fit: BoxFit.fill)),
                  ),
                ),
                Positioned(
                  height: 60,
                  width: width! * .5 < 250 ? width! * .5 : 250,
                  left: 5,
                  //right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.black12],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                  ),
                ),
                Positioned(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              name!,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              monthyear!,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          venue!,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  left: 10,
                  bottom: 10,
                  right: 15,
                )
              ],
            )),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: width! * 0.08,
            ),
          ],
        )
      ],
    );
  }
}

var upcomingEvents = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: width! * 0.05,
          ),
          Text(
            "Upcoming Events",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Spacer(),
          // Text("VIEW ALL", style: viewallstyle)
        ],
      ),
    ),
    Container(
      height: height! * .25 < 170 ? height! * .25 : 170,
      //height: height! * .25 < 300 ? height! * .25 : 300,
      // child:
      // ConstrainedBox(
      //   constraints: BoxConstraints(maxHeight: 170, minHeight: height! * .13),
      child: ListView.builder(
          itemBuilder: (context, index) => upcomingevents[index],
          shrinkWrap: true,
          padding: EdgeInsets.all(0.0),
          itemCount: upcomingevents.length,
          scrollDirection: Axis.horizontal),
    ),
  ],
);

List<UpcomingEvent> upcomingevents = [
  UpcomingEvent(
    image: "assets/images/gcloud.png",
    name: "Google Cloud",
    monthyear: "Nov 2022",
    venue: "Hybrid",
  ),
  UpcomingEvent(
    image: "assets/images/flutter.png",
    name: "Flutter Development",
    monthyear: "Jan 2022",
    venue: "Virtual",
  ),
  UpcomingEvent(
    image: "assets/images/---.png",
    name: "Training viva",
    monthyear: "jan-2023",
    venue: "Seminar hall1",
  ),
];

class UpcomingEvent extends StatelessWidget {
  final String? image, monthyear;
  final String? name, venue;

  const UpcomingEvent(
      {Key? key, this.image, this.monthyear, this.name, this.venue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    height: height! * .137 < 160 ? height! * .137 : 160,
                    width: width! * .5 < 250 ? width! * .5 : 250,
                    //   child: Image.asset(image,fit: BoxFit.cover,)
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(image!), fit: BoxFit.fill)),
                  ),
                ),
                Positioned(
                  height: 60,
                  width: width! * .5 < 250 ? width! * .5 : 250,
                  left: 5,
                  //right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.black12],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter)),
                  ),
                ),
                Positioned(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              name!,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              monthyear!,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          venue!,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                  left: 10,
                  bottom: 10,
                  right: 15,
                )
              ],
            )),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: width! * 0.08,
            ),
          ],
        )
      ],
    );
  }
}
