//
//  HomeViewModel.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//

import Foundation

class HomeViewModel {
    
    var moviesTrending = [MoviesTrending]()
    var topRatedSeries = [TopRatedSeries]()
    var popularSeries = [PopularSeries]()
    
    
    
    func fetchAllData() async {
        do {
            async let trendingMovies = fetchMoviesTrending()
            async let topRatedSeries = fetchtopRatedSeries()
            async let popularSeries = fecthPopularTvSeries()
            
            _ = await [trendingMovies, topRatedSeries, popularSeries]
            
            
        } catch {
            print("Error al obtener los datos: \(error)")
        }
    }
    
    func fetchMoviesTrending() async {
        
        do {
            let responseData: MoviesTrendingResponse = try await APIService.shared.fetchData(router: .trendingMovies)
            
            self.moviesTrending = responseData.results ?? []
            
        } catch {
            print("Error fetching trending movies: \(error)")
        }
    }
    
    
    func fetchtopRatedSeries() async {
        
        do {
            let responseData: TopSeriesResponse = try await APIService.shared.fetchData(router: .topRatedSeries)
            
            self.topRatedSeries = responseData.results ?? []
            
            
        } catch {
            print("Error fetching trending movies: \(error)")
        }
    }
    
    func fecthPopularTvSeries()  async {
        
        do {
            let responseData: PopularSeriesResponse = try await APIService.shared.fetchData(router: .popularSeries)
            
            self.popularSeries = responseData.results ?? []
            
        } catch {
            print("Error fetching trending movies: \(error)")
        }
    }
}
