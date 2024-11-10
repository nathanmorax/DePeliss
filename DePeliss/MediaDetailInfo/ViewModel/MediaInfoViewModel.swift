//
//  MediaInfoViewModel.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//

import UIKit

class MediaInfoViewModel {
    
    var ratedSeriesData: TopRatedSeries?
    var popularSeries: PopularSeries?
    var recomendationsSeriesData = [RecomendationsSeries]()
    var recomendationsMoviesData = [RecomendationsMovies]()
    var seriesId: Int?
    var movieId: Int?
    var sectionType: HomeSection?
    var filteredMovies: Search?

    func setSeriesDetail(series: TopRatedSeries) {
        self.ratedSeriesData = series
    }
    
    func setRecomendation(recomendations: PopularSeries) {
        self.popularSeries = recomendations
    }
    
    func setSectionType(section: HomeSection) {
        self.sectionType = section
    }
    
    func setFilterData(filterData: Search) {
        self.filteredMovies = filterData
        self.movieId = filterData.id
    }
    
    func setSeriesData<T>(data: T) {
        if let series = data as? TopRatedSeries {
            self.ratedSeriesData = series
            self.seriesId = series.id
        } else if let series = data as? PopularSeries {
            self.popularSeries = series
            self.seriesId = series.id
        }
    }
    
    func fetchRecomendationsSeries(seriesId: Int) async {
        
        do {
            let responseData: RecomendationsSeriesResponse = try await APIService.shared.fetchData(router: .recomendationsSeries(serieId: seriesId))
            
            self.recomendationsSeriesData = responseData.results ?? []
           
        } catch {
            print("Error fetching trending movies: \(error)")
        }
    }
    
    func fetchRecomendationsMovies(movieId: Int) async {
        
        do {
            let responseData: RecomendationsMoviesResponse = try await APIService.shared.fetchData(router: .recomendationsMovies(movieId: movieId))
            
            self.recomendationsMoviesData = responseData.results ?? []
           
        } catch {
            print("Error fetching trending movies: \(error)")
        }
    }
    
    func configureCellData(for indexPath: IndexPath) -> CellData {
        let sectionType = MediaInfoSection(rawValue: indexPath.section)
        
        switch sectionType {
        case .header:
            if let data = ratedSeriesData {
                return CellData(imageUrl: data.backdropPath, title: data.name ?? "")
            }

        case .about:
            if let data = ratedSeriesData {
                return CellData(imageUrl: data.overview, title: data.name ?? "")
            }

        case .related:
            if indexPath.item < recomendationsSeriesData.count {
                let serie = recomendationsSeriesData[indexPath.item]
                return CellData(imageUrl: serie.backdropPath, title: serie.name ?? "")
            } else if indexPath.item < recomendationsMoviesData.count {
                let movie = recomendationsMoviesData[indexPath.item]
                return CellData(imageUrl: movie.backdropPath, title: movie.originalTitle ?? "")
            }
        case .information:
            if let data = ratedSeriesData {
                return CellData(imageUrl: data.backdropPath, title: data.name ?? "")
            }
        default:
            return CellData()  // Default empty CellData if no match
        }
        
        return CellData()  // Return empty CellData as fallback
    }


      struct CellData {
          var imageUrl: String?
          var title: String?
          var overview: String?
          var popularity: Double?
          var releaseDate: String?
      }
}
