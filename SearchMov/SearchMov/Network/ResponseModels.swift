//
//  Models.swift
//  SearchMov
//
//  Created by Mathew Thomas on 25/10/2020.
//

import Foundation

// MARK: - Movie
class Movie: Decodable {
    var Title, Year, Rated, Released: String?
    var Runtime, Genre, Director, Writer: String?
    var Actors, Plot, Language, Country: String?
    var Awards: String?
    var Poster: String?
    var Ratings: [Rating]?
    var Metascore, imdbRating, imdbVotes, imdbID: String?
    var `Type`, DVD, BoxOffice, Production: String?
    var Website, Response: String?
    
    init(title: String?, year: String?, rated: String?, released: String?, runtime: String?, genre: String?, director: String?, writer: String?, actors: String?, plot: String?, language: String?, country: String?, awards: String?, poster: String?, ratings: [Rating]?, metascore: String?, imdbRating: String?, imdbVotes: String?, imdbID: String?, type: String?, dvd: String?, boxOffice: String?, production: String?, website: String?, response: String?) {
        self.Title = title
        self.Year = year
        self.Rated = rated
        self.Released = released
        self.Runtime = runtime
        self.Genre = genre
        self.Director = director
        self.Writer = writer
        self.Actors = actors
        self.Plot = plot
        self.Language = language
        self.Country = country
        self.Awards = awards
        self.Poster = poster
        self.Ratings = ratings
        self.Metascore = metascore
        self.imdbRating = imdbRating
        self.imdbVotes = imdbVotes
        self.imdbID = imdbID
        self.Type = type
        self.DVD = dvd
        self.BoxOffice = boxOffice
        self.Production = production
        self.Website = website
        self.Response = response
    }
}

// MARK: - Ratings
class Rating: Decodable {
    var Source, Value: String?
    
    init(source: String?, value: String?) {
        self.Source = source
        self.Value = value
    }
}

// MARK: - Search
class Search: Decodable {
    var Search: [SearchElement]?
    var totalResults, Response: String?
    
    init(search: [SearchElement]?, totalResults: String?, response: String?) {
        self.Search = search
        self.totalResults = totalResults
        self.Response = response
    }
}

// MARK: - SearchElement
class SearchElement: Decodable {
    var Title, Year, imdbID: String?
    var `Type`: String?
    var Poster: String?
    
    init(title: String?, year: String?, imdbID: String?, type: String?, poster: String?) {
        self.Title = title
        self.Year = year
        self.imdbID = imdbID
        self.Type = type
        self.Poster = poster
    }
}
