open Types

%%raw(`import './Pokedex.css'`)

@scope("JSON") @val
external parseIntoMyData: string => Types.responseData = "parse"

@react.component
let make = () => {

    let pokemons_initialValue: array<Types.resultsObj> = [];

    let (pokemons, setPokemons) = React.useState(_ => pokemons_initialValue)

    React.useEffect0(() => {

        let _ =
            Fetch.fetch("https://pokeapi.co/api/v2/pokemon?limit=5&offset=0")
            ->Js.Promise.then_(Fetch.Response.json, _)
            ->Js.Promise.then_(json =>  {
                let results = ( _ => parseIntoMyData( Js.Json.stringify(json) ).results )

                setPokemons(results)
            }
            ->Js.Promise.resolve, _)

        None
    })

    <div className="pokedex-wrapper">

        <div className="pokemons">
            {
            pokemons->Belt.Array.map(pokemon => {

                <div className="pokemon">
                    <h1 className="title">
                    { pokemon.name 
                    -> Js.String.toUpperCase 
                    -> React.string 
                    }
                    </h1>
                </div>
            })
            ->React.array
            }
        </div>
    </div>
}