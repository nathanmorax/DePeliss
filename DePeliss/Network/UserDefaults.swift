//
//  UserDefaults.swift
//  DePeliss
//
//  Created by Jesus Mora on 09/11/24.
//
import UIKit


struct MediaItem {
    let image: UIImage
    let title: String
}

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private let favoritesKey = "savedMediaItems"
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    // MARK: - Guardar un nuevo elemento
    func saveMediaItem(image: UIImage, title: String) {
        var savedItems = loadSavedMediaItems()
        
        if let imageData = image.pngData() {
            let newItem = ["title": title, "image": imageData] as [String : Any]
            savedItems.append(newItem)
            
            defaults.set(savedItems, forKey: favoritesKey)
        }
    }
    
    // MARK: - Cargar todos los elementos guardados
    func loadSavedMediaItems() -> [[String: Any]] {
        return defaults.array(forKey: favoritesKey) as? [[String: Any]] ?? []
    }
    
    // MARK: - Obtener elementos guardados como modelos
    func getSavedMediaItems() -> [MediaItem] {
        let items = loadSavedMediaItems()
        var mediaItems: [MediaItem] = []
        
        for item in items {
            if let title = item["title"] as? String,
               let imageData = item["image"] as? Data,
               let image = UIImage(data: imageData) {
                mediaItems.append(MediaItem(image: image, title: title))
            }
        }
        
        return mediaItems
    }
    
    // MARK: - Eliminar un elemento por título
    func deleteMediaItem(withTitle title: String) {
        var savedItems = loadSavedMediaItems()
        
        savedItems.removeAll { item in
            return item["title"] as? String == title
        }
        
        defaults.set(savedItems, forKey: favoritesKey)
    }
}
