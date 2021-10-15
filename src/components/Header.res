%%raw(`import './Header.css'`)

@react.component
let make = (~title) => {

    <header className="pokedex-header-wrapper">
        <h1 className="title">{title -> React.string}</h1>
    </header>
}