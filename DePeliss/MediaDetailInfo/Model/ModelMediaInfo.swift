//
//  ModelMediaInfo.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//


struct RecomendationsSeriesResponse: Codable {
    let page: Int?
    let results: [RecomendationsSeries]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct RecomendationsSeries: Codable {
    let backdropPath: String?
    let id: Int?
    let name, originalName, overview, posterPath: String?
    //let mediaType: MediaType
    let adult: Bool?
    //let originalLanguage: OriginalLanguage
    let genreIDS: [Int]?
    let popularity: Double?
    let firstAirDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    //let originCountry: [OriginCountry]

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, name
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        //case mediaType = "media_type"
        case adult
        //case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        //case originCountry = "origin_country"
    }
}

/*enum MediaType: String, Codable {
    case tv = "tv"
}
*/
/*enum OriginCountry: String, Codable {
    case ca = "CA"
    case gb = "GB"
    case us = "US"
}*/

/*enum OriginalLanguage: String, Codable {
    case en = "en"
}*/


enum MediaInfoSection: Int, CaseIterable {
    case header
    case about
    case related
    case information
 
    
    var title: String {
        switch self {
        case .header: return ""
        case .about: return "About"
        case .related: return "Related"
        case .information: return "Information"
        }
    }
}

struct RecomendationsMoviesResponse: Codable {
    let page: Int?
    let results: [RecomendationsMovies]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct RecomendationsMovies: Codable {
    let backdropPath: String?
    let id: Int
    let title, originalTitle, overview, posterPath: String?
    //let mediaType: MediaType
    let adult: Bool?
    //let originalLanguage: OriginalLanguage
    let genreIDS: [Int]?
    let popularity: Double?
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        //case mediaType = "media_type"
        case adult
        //case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
