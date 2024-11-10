//
//  Router.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//
import UIKit

struct APIConfig {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let apiKey = "d08fb2ea46593098413dd90b8c9bb3de"
}

enum Router {
    case trendingMovies
    case topRatedSeries
    case popularSeries
    case recomendationsSeries(serieId: Int)
    case recomendationsMovies(movieId: Int)
    case searchMovie(movie: String)
    case genre
    case moviesForGenre(genreId: Int)
    case token
    case validateLoginToken(requestToken: String, username: String, password: String) // Nuevo caso
    
    
    private func makeURL(for endpoint: String, queryParameters: [String: String] = [:]) -> URL? {
        var urlString = APIConfig.baseURL + endpoint
        var parameters = queryParameters
        parameters["api_key"] = APIConfig.apiKey
        
        if !parameters.isEmpty {
            let queryString = parameters.map { key, value in
                return "\(key)=\(value)"
            }.joined(separator: "&")
            
            urlString += "?\(queryString)"
        }
        
        return URL(string: urlString)
    }
    
    var url: URL? {
        switch self {
        case .trendingMovies:
            return makeURL(for: "trending/movie/week")
            
        case .topRatedSeries:
            return makeURL(for: "tv/top_rated")
            
        case .popularSeries:
            return makeURL(for: "tv/popular")
            
        case .recomendationsSeries(let serieId):
            return makeURL(for: "tv/\(serieId)/recommendations")
        case .recomendationsMovies(let moviewId):
            return makeURL(for: "tv/\(moviewId)/recommendations")
            
        case .searchMovie(let movie):
            return makeURL(for: "search/movie", queryParameters: [
                "include_adult": "false",
                "language": "en-US",
                "page": "1",
                "query": movie
            ])
            
        case .genre:
            return makeURL(for: "genre/movie/list")
            
        case .moviesForGenre(let genreId):
            return makeURL(for: "discover/movie", queryParameters: [
                "with_genres": "\(genreId)",
                "language": "es-ES"
            ])
        case .token:
            return makeURL(for: "authentication/token/new")
        case .validateLoginToken:
            return URL(string: "authentication/token/validate_with_login")
        }
    }
}
