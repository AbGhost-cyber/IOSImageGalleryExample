//
//  GridItemView.swift
//  IOSImageGalleryExample
//
//  Created by dremobaba on 2023/1/18.
//

import SwiftUI

struct GridItemView: View {
    let size: Double
    let url: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: size, height: size)
        }
    }
}

struct GridItemView_Previews: PreviewProvider {
    static var previews: some View {
        GridItemView(size: 50, url: "https://picsum.photos/id/1/5000/3333")
    }
}
