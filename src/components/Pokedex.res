open Types

%%raw(`import './Pokedex.css'`)

@scope("JSON") @val
external parseIntoMyData: string => Types.responseData = "parse"

@react.component
let make = () => {

    let pokemons_initialValue: array<Types.resultsObj> = [];
    let pokemonsImageI: array<string> = [];

    let (offset, setOffset) = React.useState(_ => 0); 
    let (loading, setLoading) = React.useState(_ => true)
    let (pokemons, setPokemons) = React.useState(_ => pokemons_initialValue)
    let (pokemonsImage, setPokemonsImage) = React.useState(_ => pokemonsImageI)

    let fetchPokemons = (offsetVal: int) => {

        let url = "https://pokeapi.co/api/v2/pokemon?limit=5&offset=" ++ (offsetVal) -> Belt.Int.toString

        let _ =
        Fetch.fetch(url)
        ->Js.Promise.then_(Fetch.Response.json, _)
        ->Js.Promise.then_(json =>  {

            let results = (_ => parseIntoMyData( Js.Json.stringify(json) ).results)
            -> setPokemons

            setOffset(_ => offsetVal)
            setLoading(_ => false)
        }
        ->Js.Promise.resolve, _)   
    }

    let nextPage = _ => {

        switch loading {
        | false => {

            setLoading(_ => true)
            fetchPokemons(offset + 5)
        }
        | true => "Wait please" -> Js.log
        }
    }

    let previousPage = _ => {


        switch loading {
        | false => {

            (offset - 5 >= 0) ? {

                setLoading(_ => true)
                fetchPokemons(offset - 5)

            } : "Min page" -> Js.log
            
        }
        | true => "Wait please" -> Js.log
        }
    }

    React.useEffect0(() => {

        let _ =
            Fetch.fetch("https://pokeapi.co/api/v2/pokemon?limit=5&offset=0")
            ->Js.Promise.then_(Fetch.Response.json, _)
            ->Js.Promise.then_(json =>  {

                let results = (_ => parseIntoMyData( Js.Json.stringify(json) ).results)
                -> setPokemons

                setOffset(_ => 0)
                setLoading(_ => false)
            }
            ->Js.Promise.resolve, _)

        None
    })

    <div className="pokedex-wrapper">

        {switch loading {
        | true => {
            
            <div className="loading-wrapper">
                {"Loading" -> React.string}
            </div>
        }
        | false => {
            
            <div className="pokemons">
            {
            pokemons->Belt.Array.mapWithIndex((key, pokemon) => {

                <div key={key->Belt.Int.toString} className="pokemon">
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
        }
        }}

        <button onClick={nextPage} >{"Next" -> React.string}</button>
        <button onClick={previousPage} >{"Previous" -> React.string}</button>
    </div>
}