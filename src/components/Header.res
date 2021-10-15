%%raw(`import './Header.css'`)

@react.component
let make = (~title) => {

    <header className="pokedex-header-wrapper">
        <h1>{title -> React.string}</h1>
    </header>
}