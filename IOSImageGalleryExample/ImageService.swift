//
//  ImageService.swift
//  IOSImageGalleryExample
//
//  Created by dremobaba on 2023/1/18.
//

import Foundation

enum ImageServiceError: Error {
    case error(String)
}
struct ImageResponse: Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}

class ImageService {
    
    let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func getImages() async throws -> [String] {
        
        let (data, response) = try await URLSession.shared.data(from: baseURL)
        if  let response = response as? HTTPURLResponse {
            if response.statusCode >= 200 && response.statusCode < 300 {
                //success
                let imageResults = try JSONDecoder().decode([ImageResponse].self, from: data)
                return imageResults.map { $0.download_url}
            }
          throw ImageServiceError.error("\(response.statusCode), an error occurred from server 😵‍💫")
        }
        throw ImageServiceError.error("couldn't fetch images 🥲")
    }
}
