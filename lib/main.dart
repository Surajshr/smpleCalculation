import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

final _minPadding = 5.0;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "practice of example",
    home: bankForms(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class bankForms extends StatefulWidget {
  @override

  State<StatefulWidget> createState() {
    return bankFormDesign();
  }
}

class bankFormDesign extends State<bankForms> {
  var _formKey=GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  var _currentValueSelected = '';

  @override
  void initState() {
    super.initState();
    _currentValueSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController ratioController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    //this following widget will instantiate a resent them. and set it into object called textStyle
    TextStyle? textStyle = Theme.of(context).textTheme.headline6;
    // TextStyle textStyle =Theme.of(context).textTheme.title;
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Banking Form")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minPadding * 2),
          //margin: EdgeInsets.all(_minPadding * 2),
          child: ListView(
            children: <Widget>[
              getImageAsset(),

              Padding(
                padding: EdgeInsets.only(
                      top: _minPadding, bottom: _minPadding),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some principal';
                    }
                    return null;
                  },
                    decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter Principal e.g. 1200',
                      labelStyle: textStyle,
                        errorStyle: TextStyle(
                          color:Colors.yellowAccent,
                          fontSize: 15.0,
                        ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: ratioController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some interest';
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'Enter Interest in Percent',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                        color:Colors.yellowAccent,
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  )),
              Padding(
                  padding:
                      EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                  child: (Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: termController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter term';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Term',
                            hintText: 'Time in Year',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(
                              color:Colors.yellowAccent,
                              fontSize: 15.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: _minPadding * 5,
                      ),
                      Expanded(
                          child: DropdownButton(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentValueSelected,
                        onChanged: (var newValueSelected) {
                          _setTheSelectedvalue(newValueSelected);
                        },
                      )),
                    ],
                  ))),
              Padding(
                padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.indigo,
                        onPrimary: Colors.white,
                      ),
                      label: Text('Calculate', textScaleFactor: 1.2),
                      icon: Icon(Icons.calculate),
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState!.validate()) {
                            this.displayResult = _calculateTotalReturn();
                          }
                          });
                      },
                    )),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          onPrimary: Colors.white,
                        ),
                        label: Text('Reset'),
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          setState(() {
                            _resetItems();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_minPadding * 2),
                child: Text(this.displayResult, style: textStyle),
              ),
            ],
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0);
    return Container(
      child: image,
      margin: EdgeInsets.all(_minPadding * 10),
    );
  }

  void _setTheSelectedvalue(var newValueSelected) {
    setState(() {
      this._currentValueSelected = newValueSelected;
    });
  }

  String _calculateTotalReturn() {
    double principle = double.parse(principalController.text);
    double rate = double.parse(ratioController.text);
    double term = double.parse(termController.text);

    //double totalAmountPayment = principle + (principle * rate * term) / 100;
    double totalAmountPayment = principle * pow(1 + rate/100,term)-principle;
    String result ='After $term year, your investment will be worth $totalAmountPayment $_currentValueSelected ';
    return result;
  }

  void _resetItems() {
    principalController.text = '';
    ratioController.text = '';
    termController.text = '';
    displayResult = '';
    _currentValueSelected = _currencies[0];
  }
}
