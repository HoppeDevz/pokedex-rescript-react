module Types = {

    type resultsObj = {
        name: string,
        url: string
    }

    type responseData = {
    count: int,

    next: string,
    previous: string,

    results: array<resultsObj>,

    length: int
}
}