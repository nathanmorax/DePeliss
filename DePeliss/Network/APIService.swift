import UIKit

class APIService {
    
    static let shared = APIService()
    
    func fetchData<T: Decodable>(router: Router) async throws -> T {
        guard let url = router.url else {
            print("Error: La URL es inválida.")
            throw URLError(.badURL)
        }
                
        var request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                print("Error: Respuesta del servidor con código de estado \(httpResponse.statusCode).")
                throw URLError(.badServerResponse)
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Respuesta JSON recibida: \(jsonString)")
            }
            
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
            
        } catch let decodingError as DecodingError {
            print("Error de decodificación: \(decodingError.localizedDescription)")
            throw decodingError
        } catch {
            print("Error general: \(error.localizedDescription)")
            throw error
        }
    }
    

}

