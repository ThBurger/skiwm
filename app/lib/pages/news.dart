import 'package:flutter/material.dart';
import 'package:retroskiing/widgets/credit.dart';
import 'package:retroskiing/widgets/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final Uri toPrivacyPolice =
      Uri.parse('https://sites.google.com/view/retroskiingprivacypolicy');
  final Uri toEMail =
      Uri.parse('mailto:tburg3r@gmail.com?subject=Retro Skiing Feedback');

  Future<void> _launchUrl(_url) async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stack = [];
    stack.add(
      ListView(
        children: [
          _buildPrivacyPolicy(),
          _buildEMailContact(),
          _buildNews001(),
        ],
      ),
    );

    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      drawer: buildDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        actions: const [CreditChip(), SizedBox(width: 15)],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: stack,
          ),
        ),
      ),
    );
  }

  Card _buildPrivacyPolicy() {
    const Widget storeHeader = ListTile(
      leading: Icon(Icons.open_in_browser),
      title: Text('open privacy policy'),
    );
    final List<Widget> children = <Widget>[storeHeader];
    return Card(
      child: InkWell(
        onTap: () {
          launchUrl(toPrivacyPolice);
        },
        child: Column(children: children),
      ),
    );
  }

  Card _buildEMailContact() {
    const Widget storeHeader = ListTile(
      leading: Icon(Icons.mail),
      title: Text('send E-Mail'),
    );
    final List<Widget> children = <Widget>[storeHeader];
    return Card(
      child: InkWell(
        onTap: () {
          _launchUrl(toEMail);
        },
        child: Column(children: children),
      ),
    );
  }

  Card _buildNews001() {
    const Widget storeHeader = ListTile(
      leading: Icon(Icons.new_releases, color: Colors.green),
      title: Text(' Welcome to Retro Skiing 2022-10-06'),
    );
    final List<Widget> children = <Widget>[storeHeader];
    children.addAll([
      const Divider(),
      const ListTile(
        subtitle: Text(
            'Season 0 of Retro Skiing is here! play, have fun, get on top of the leaderboard and i would appreciate it if you send me your feedback!'),
      ),
    ]);
    return Card(
      child: Column(children: children),
    );
  }
}
