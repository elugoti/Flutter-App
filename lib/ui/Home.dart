import 'package:DeliverMyFood/model/Question.dart';
import 'package:DeliverMyFood/utils/hexcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class QuizzApp extends StatefulWidget {
  @override
  _QuizzAppState createState() => _QuizzAppState();
}

class _QuizzAppState extends State<QuizzApp> {
  List<Question> questions = getQuestions();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("True Soldier"),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey,
      body: Builder(
        builder: (BuildContext context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Image.asset(
                "images/flag.png",
                width: 250,
                height: 180,
              )),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 120,
                  child: Center(
                      child: Text(
                    questions[_index % 19].questionText,
                    style: TextStyle(color: Colors.white),
                  )),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.4),
                    border:
                        Border.all(color: Colors.white, style: BorderStyle.solid),
                    color: Colors.transparent,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _checkAnswer(true, context),
                    color: Colors.blueGrey.shade900,
                    child: Text(
                      "TRUE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () => _checkAnswer(false, context),
                    color: Colors.blueGrey.shade900,
                    child: Text("FALSE", style: TextStyle(color: Colors.white)),
                  ),
                  RaisedButton(
                    onPressed: () => goNext(),
                    color: Colors.blueGrey.shade900,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }

  static List<Question> getQuestions() {
    List<Question> questions = new List<Question>();
    for (int i = 0; i < 20; i++) {
      bool isCorrect = true;
      if (i % 2 == 0) {
        isCorrect = false;
      }
      questions.add(Question.name("This is question number : $i", isCorrect));
    }
    return questions;
  }

  _checkAnswer(bool userChoice, BuildContext context) {
    if (userChoice==questions[_index].isCorrect) {
      var snackbar = SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text("Correct!"),
          backgroundColor: Colors.black);
      Scaffold.of(context).showSnackBar(snackbar);
      goNext();
    } else {
      var snackbar = SnackBar(
          duration: Duration(milliseconds: 500),
          content: Text("Incorrect!"),
          backgroundColor: Colors.red);
      Scaffold.of(context).showSnackBar(snackbar);
      goNext();
    }
  }

  goNext() {
    setState(() {
      _index++;
    });
  }
}

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  double _billAmount = 100;
  int _personsCount = 4;
  Color _purple = HexColor.hexToColor("#690806");
  int _tipPercentage = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Container(
              width: 350,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: _purple.withOpacity(0.1)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Total Per Person",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${calculateTotalPerPerson(_billAmount, _personsCount, _tipPercentage)}",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                        debugPrint("value: $value");
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Split"),
                      Row(
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                setState(() {
                                  if (_personsCount > 1) {
                                    _personsCount--;
                                  }
                                });
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: _purple.withOpacity(0.1)),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                        color: _purple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              )),
                          Text(
                            "$_personsCount",
                            style: TextStyle(
                                color: _purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          ),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  _personsCount++;
                                });
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: _purple.withOpacity(0.1)),
                                child: Center(
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        color: _purple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                    textDirection: TextDirection.ltr,
                                  ),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Tip"),
                      Text(
                        "\$${calculateTotalTip(_billAmount, _personsCount, _tipPercentage)}",
                        style: TextStyle(
                            color: _purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "$_tipPercentage%",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.blue,
                          inactiveColor: Colors.grey,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              _tipPercentage = value.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercent) {
    var perPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercent) + billAmount) /
            splitBy;
    return perPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}

class ShowQuotes extends StatefulWidget {
  @override
  _ShowQuotesState createState() => _ShowQuotesState();
}

class _ShowQuotesState extends State<ShowQuotes> {
  int _index = 0;
  var quotes = getQuotes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(quotes[_index % 19]),
            FlatButton.icon(
              color: Colors.green,
              onPressed: showAnother,
              icon: Icon(
                Icons.wb_sunny,
                color: Colors.white,
              ),
              label: Text(
                "Click me",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  static List<String> getQuotes() {
    var list = List<String>();
    for (int i = 0; i < 20; i++) {
      list.add("Quote $i");
    }
    return list;
  }

  showAnother() {
    setState(() {
      _index++;
    });
  }
}

class BlizzCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blizz Card"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[_getCard(), _getAvatar()],
        ),
      ),
    );
  }

  Container _getCard() {
    return Container(
      width: 350,
      height: 200,
      margin: EdgeInsets.all(50.0),
      decoration: BoxDecoration(
          color: Colors.pinkAccent,
          borderRadius: BorderRadius.circular((10.0))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Prakash Reddy",
            style: TextStyle(fontSize: 25),
          ),
          Text("SDE @ Flutter"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.email),
              Text("reddyprakash939@gmail.com")
            ],
          )
        ],
      ),
    );
  }

  Container _getAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: Border.all(color: Colors.redAccent, width: 1.2),
          image: DecorationImage(
              image: NetworkImage("https://picsum.photos/300/300"),
              fit: BoxFit.cover)),
    );
  }
}

class ScaffoldExample extends StatelessWidget {
  alarmClick() {
    debugPrint("Alarm clicked");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scafold"),
        centerTitle: true,
        backgroundColor: Colors.amberAccent.shade700,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.email),
              onPressed: () => debugPrint("Email clicked")),
          IconButton(icon: Icon(Icons.alarm), onPressed: alarmClick)
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(Icons.call_missed),
          onPressed: () => debugPrint("Helloooooooo")),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("First")),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text("Second")),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), title: Text("Third")),
        ],
        onTap: (int index) => debugPrint("Clicking position: $index"),
      ),
      backgroundColor: Colors.redAccent.shade100,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomButton()
//            InkWell(
//              child: Text("Tap me",
//                style: TextStyle(fontSize: 25),
//              ),
//              onTap:() => debugPrint("Text tappedddddd!"),
//            )
        ],
      )),
    );
  }
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var snackBar = SnackBar(content: Text("Hello Again"));
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.pinkAccent, borderRadius: BorderRadius.circular(8)),
        child: Text("Click here"),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orange,
      child: Center(
        child: Text(
          "My Flutter World",
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.5,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
