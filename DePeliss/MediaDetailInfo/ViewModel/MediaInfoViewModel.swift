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
}
