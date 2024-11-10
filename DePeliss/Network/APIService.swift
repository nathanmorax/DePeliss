import UIKit


struct RequestTokenResponse: Decodable {
    let success: Bool
    let request_token: String?
}


class APIService {
    
    static let shared = APIService()
    
    func fetchData<T: Decodable>(router: Router) async throws -> T {
        guard let url = router.url else {
            print("Error: La URL es inválida.")
            throw URLError(.badURL)
        }
        
        print("URL generada: \(url)")
        
        var request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // Verificar el código de estado HTTP
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                print("Error: Respuesta del servidor con código de estado \(httpResponse.statusCode).")
                throw URLError(.badServerResponse)
            }
            
            // Imprimir el JSON recibido para depuración
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Respuesta JSON recibida: \(jsonString)")
            }
            
            // Intentar decodificar la respuesta en el tipo genérico
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
            
        } catch let decodingError as DecodingError {
            // Detalles de error de decodificación
            print("Error de decodificación: \(decodingError.localizedDescription)")
            throw decodingError
        } catch {
            // Si hay otro error (como de red), lo mostramos
            print("Error general: \(error.localizedDescription)")
            throw error
        }
    }
    

}

class APIServiceLogin {
  
}
