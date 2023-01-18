//
//  ContentView.swift
//  IOSImageGalleryExample
//
//  Created by dremobaba on 2023/1/18.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var model: MainModel
    
    private static let initialColumns = 3
    @State private var gridColumns = Array(repeating: GridItem(.flexible()), count: initialColumns)
    @State private var numColumns = initialColumns
    @State private var isEditing = false
    
    private var columnsTitle: String {
        gridColumns.count > 1 ? "\(gridColumns.count) Columns" : "1 Column"
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if isEditing {
                    ColumnStepper(title: columnsTitle, range: 1...8, columns: $gridColumns)
                        .padding()
                }
                LazyVGrid(columns: gridColumns) {
                    ForEach(model.imageList, id: \.self) { url in
                        GeometryReader { geo in
                            GridItemView(size: geo.size.width, url: url)
                        }
                        .cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                        .overlay(alignment: .topTrailing) {
                            Button {
                                withAnimation {
                                    model.removeImage(url)
                                }
                            } label: {
                                Image(systemName: "xmark.square.fill")
                                            .font(Font.title)
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.white, .red)
                            }
                            .offset(x: 7, y: -7)
                            .opacity(isEditing ? 1 : 0)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Picsum Gallery")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(isEditing ? "Done" : "Edit") {
                        withAnimation { isEditing.toggle() }
                    }
                }
            }
            .task {
                do {
                    try await model.getImages()
                } catch {
                    print("error")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(
                MainModel(service: ImageService(baseURL: URL(string: "https://picsum.photos/v2/list")!))
            )
    }
}
