//
//  IOSImageGalleryExampleApp.swift
//  IOSImageGalleryExample
//
//  Created by dremobaba on 2023/1/18.
//

import SwiftUI

@main
struct IOSImageGalleryExampleApp: App {
    @StateObject var mainModel = MainModel(service: ImageService(baseURL: URL(string: "https://picsum.photos/v2/list")!))
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mainModel)
        }
    }
}
