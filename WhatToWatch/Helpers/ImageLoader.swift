//
//  ImageLoader.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 04.06.2023.
//

import UIKit

enum LoadingError: Error {
    case failedToCreateImageFromData
    case error
}

protocol InternetLoader {}

extension InternetLoader {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func asyncGetData(from url: URL) async -> Data? {
        do {
            let (data,_ ) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

struct ImageLoader: InternetLoader {
    private init() {}
    static let shared = ImageLoader()
    
    func loadImageWithUrl(_ url: URL, complitionHandler: @escaping ((UIImage?) -> Void)) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }

            complitionHandler(UIImage(data: data))
        }
    }
    
    func loadImageWithUrl(_ url: URL) async -> UIImage? {
        guard let data = await asyncGetData(from: url) else { return nil }
        
        return UIImage(data: data)
    }
}
