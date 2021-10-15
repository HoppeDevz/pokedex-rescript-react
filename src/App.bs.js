// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Div from "./components/Div.bs.js";
import * as React from "react";
import * as Header from "./components/Header.bs.js";

import './index.css'
;

function str(prim) {
  return prim;
}

function App$Button(Props) {
  var onClick = Props.onClick;
  var label = Props.label;
  return React.createElement("button", {
              onClick: onClick
            }, label);
}

var Button = {
  make: App$Button
};

function App$Input(Props) {
  var onChange = Props.onChange;
  var placeholder = Props.placeholder;
  return React.createElement("input", {
              placeholder: placeholder,
              onChange: onChange
            });
}

var Input = {
  make: App$Input
};

function App(Props) {
  return React.createElement(Div.make, {
              children: React.createElement(Header.make, {
                    title: "Pokedex"
                  })
            });
}

var make = App;

export {
  str ,
  Button ,
  Input ,
  make ,
  
}
/*  Not a pure module */
