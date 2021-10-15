open Render

%%raw(`import './Pokedex.css'`)

type resultsObj = {
    name: string,
    url: string,
    img_url: string
}

type responseData = {
    count: int,

    next: string,
    previous: string,

    results: array<resultsObj>,

    length: int
};

@scope("JSON") @val
external parseIntoMyData: string => responseData = "parse"

@react.component
let make = () => {

    let pokemons_initialValue: array<resultsObj> = [];
    let pokemonsindex_i: int = 0;

    let (pokemons, setPokemons) = React.useState(_ => pokemons_initialValue)
    let (loadingPokemons, setLoadingPokemons) = React.useState(_ => false)

    React.useEffect0(() => {

        let _ =
            Fetch.fetch("https://pokeapi.co/api/v2/pokemon?limit=5&offset=0")
            ->Js.Promise.then_(Fetch.Response.json, _)
            ->Js.Promise.then_(json =>  {
                let results = ( _ => parseIntoMyData( Js.Json.stringify(json) ).results )

                setPokemons(results)
                setLoadingPokemons(_ => true)
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