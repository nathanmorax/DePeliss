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
    let adult: Bool?
    let genreIDS: [Int]?
    let popularity: Double?
    let firstAirDate: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, name
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case adult
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

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
    let adult: Bool?
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
        case adult
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
