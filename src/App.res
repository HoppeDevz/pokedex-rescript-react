%%raw(`import './index.css'`)

let str = React.string;

module Button = {
    @react.component
    let make = (~onClick, ~label) => {

        <button onClick={onClick} >
        { label |> React.string }
        </button>
    }
}

module Input = {
    @react.component
    let make = (~onChange, ~placeholder) => {

        <input onChange={onChange} placeholder={placeholder} />
    }
}

@react.component
let make = () => {

    let loading = false;
    let logHandle = _ => Js.log("Hello!");

    <Div>
        <Header title="Pokedex - rescript/react" />
        <Pokedex />
    </Div>
}