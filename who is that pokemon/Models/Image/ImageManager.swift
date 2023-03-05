//
//  ImageManager.swift
//  who is that pokemon
//
//  Created by Alejandro Reyna on 4/03/23.
//

import Foundation


protocol ImageManagerDelegate {
    func didUpdateImage(image : ImageModel)
    func didFailWithImageError(error : Error)
}

struct ImageManager {
    var delegate : ImageManagerDelegate?
    
    func fetchImage(url : String){
        performRequest(with: url)
    }
    
    
    private func performRequest(with uri : String) {
        if let url = URL(string : uri) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data , response ,err in
                if(err != nil) {
                    self.delegate?.didFailWithImageError(error: err!)
                }
                if let safeData = data {
                    if let image = self.parseJSON(imageData: safeData) {
                        self.delegate?.didUpdateImage(image: image)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    private func parseJSON(imageData : Data) -> ImageModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ImageData.self, from: imageData)
            let image = decodedData.sprites?.other?.officialArtwork?.frontDefault ?? ""
            return ImageModel(imageURL: image)
        } catch {
            return nil
        }
    }
}

