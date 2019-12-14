//
//  ImageService.swift
//  Disney
//
//  Created by Matthew cai on 12/14/19.
//  Copyright © 2019 Matthew cai. All rights reserved.
//

import UIKit

enum ImageServiceError: Error {
    case unableGenerateURL, noData
}

struct ImageService {
    
    let count: Int
    let urlSession = URLSession.shared
    private let key = "count"
    private let baseURL = "https://pugme.herokuapp.com/bomb"
    
    func fetch(completion: @escaping (ImageSet?, Error?) -> Void) {
        guard let url = buildURL() else {
            completion(nil, ImageServiceError.unableGenerateURL)
            return
        }
        self.urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                completion(nil, ImageServiceError.noData)
                return
            }
            let decoder = JSONDecoder()
            let imageSet = try? decoder.decode(ImageSet.self, from: data)
            completion(imageSet, nil)
        }.resume()
    }
    
    func buildURL() -> URL? {
        let queryItem = URLQueryItem(name: self.key, value: String(self.count))
        var urlComponent = URLComponents(string: self.baseURL)
        urlComponent?.queryItems = [queryItem]
        return urlComponent?.url
    }
    
}
