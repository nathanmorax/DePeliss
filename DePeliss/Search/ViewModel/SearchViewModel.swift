//
//  SearchViewModel.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//

import UIKit

class SearchViewModel {
    
    var searchData = [Search]()
    var genreData = [Genre]()
    var filteredMovies: [Search] = []
    
    func fetchSearchMovies(movie: String) async {
        
        do {
            let responseData: SearchResponse = try await APIService.shared.fetchData(router: .searchMovie(movie: movie))
            self.searchData = responseData.results ?? []
            self.filteredMovies = searchData
            
            
        } catch {
            print("Error fetching trending movies: \(error)")
        }
    }
    
    func fecthGenre() async {
        
        do {
            let responseData: GenreResponse = try await APIService.shared.fetchData(router: .genre)
            
            self.genreData = responseData.genres
            
        } catch {
            print("Error fetching trending movies: \(error)")
        }
    }
}
