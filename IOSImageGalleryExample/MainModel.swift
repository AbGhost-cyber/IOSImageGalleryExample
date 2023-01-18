//
//  MainModel.swift
//  IOSImageGalleryExample
//
//  Created by dremobaba on 2023/1/18.
//

import Foundation
@MainActor
class MainModel: ObservableObject {
    private let service: ImageService
    
   @Published var imageList = [String]()
    
    init(service: ImageService) {
        self.service = service
    }
    
    func getImages() async throws {
        do {
            if !imageList.isEmpty {
                imageList.removeAll()
            }
            let images =  try await service.getImages()
            imageList.append(contentsOf: images)
        } catch ImageServiceError.error(let error) {
            print(error)
        }
    }
    func removeImage(_ item: String) {
        if let index = imageList.firstIndex(where: {$0 == item}) {
            imageList.remove(at: index)
        }
    }
}
