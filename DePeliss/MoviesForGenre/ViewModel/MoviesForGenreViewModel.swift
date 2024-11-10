//
//  MoviesForGenreViewModel.swift
//  DePeliss
//
//  Created by Jesus Mora on 10/11/24.
//

class MoviesForGenreViewModel {
    
    var moviesForGenreData = [Search]()
    var movieGenreId: Int = 0
    
    init(movieGenreId: Int) {
        self.movieGenreId = movieGenreId
    }
    
    func fecthMoviesForGenre(genreId: Int) async {
        
        do {
            let responseData: SearchResponse = try await APIService.shared.fetchData(router: .moviesForGenre(genreId: genreId))
            
            self.moviesForGenreData = responseData.results ?? []
            
        } catch {
            print("Error fetching trending movies: \(error)")
        }
    }
}
