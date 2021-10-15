@react.component
let make = (~label) => <h1>{ label |> React.string }</h1>