//
//  CachedAsyncImage.swift
//  GithubRepository
//
//  Created by Ahmad Ismail on 07/08/2025.
//

import Foundation
import SwiftUI

struct CachedAsyncImage: View {
    
    let url: URL
    let placeholder: Image
    let cache = ImageCache.shared
    
    @State private var uiImage: UIImage?
    
    var body: some View {
        Group {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            } else {
                placeholder
                    .resizable()
                    .scaledToFit()
                    .onAppear(perform: loadImage)
            }
        }
    }
    
    private func loadImage() {
        let key = url.absoluteString
        
        if let image = cache.image(forKey: key) {
            self.uiImage = image
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let image = UIImage(data: data) else {
                return
            }
            
            cache.insertImage(image, forKey: key)
            
            DispatchQueue.main.async {
                self.uiImage = image
            }
        }.resume()
    }
}
