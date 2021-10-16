open Types

%%raw(`import './Pokedex.css'`)

let s = React.string

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

        let url = "https://pokeapi.co/api/v2/pokemon?limit=25&offset=" ++ (offsetVal) -> Belt.Int.toString

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

        let fn = () => {

            setLoading(_ => true)
            fetchPokemons(offset + 25)
        }

        switch loading {
        | false => fn()
        | true => "Wait for api request finish please" -> Js.log
        }
    }

    let previousPage = _ => {

        let fn = () => {

            (offset - 25 >= 0) ? {

                setLoading(_ => true)
                fetchPokemons(offset - 25)

            } : "Min page is 0" -> Js.log
        }

        switch loading {
        | false => fn()
        | true => "Wait please" -> Js.log
        }
    }

    React.useEffect0(() => {
        fetchPokemons(offset)
        None
    })

    module LoadingComponent = {

        @react.component
        let make = () => {

            <div className="loading-wrapper">
                {"Loading"->s}
            </div>
        }
    }

    module PokedexArea = {

        @react.component
        let make = () => {

            <div className="pokemons">
                {
                pokemons->Belt.Array.mapWithIndex((key, pokemon) => {

                    <div key={key->Belt.Int.toString} className="pokemon">
                        <h1 className="title">
                            { pokemon.name 
                            -> Js.String.toUpperCase 
                            -> s 
                            }
                        </h1>
                        <img className="pokemon-img" src={"https://cdn.traction.one/pokedex/pokemon/" ++ Belt.Int.toString(offset + (key + 1)) ++ ".png"} />
                    </div>
                })
                ->React.array
                }
            </div>
        }
    }

    <div className="pokedex-wrapper">

        {switch loading {
        | true => <LoadingComponent />
        | false => <PokedexArea />
        | _ => "Unexpected error"->s
        }}

        <div className="actions-btns-wrapper">
            <button className="btn" onClick={previousPage} >{"Previous"->s}</button>
            <button className="btn" onClick={nextPage} >{"Next"->s}</button>
        </div>
    </div>
}