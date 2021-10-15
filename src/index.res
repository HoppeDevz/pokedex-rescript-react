let maybeElement = ReactDOM.querySelector("#root");

let _ = switch maybeElement {
    | None => Js.log("Componente root não encontrado!")
    | Some(element) => ReactDOM.render(<App />, element)
}