//
//  MoviesRequest.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 09.04.2023.
//

import Foundation
import RxSwift

protocol Requestable: Codable {
    func makeRequest(with query: Codable) -> URLRequest
    init()
}

enum RequestType: Codable {
    case mostPopular
    case movie

    var headers: [String : String] {
        ["X-RapidAPI-Key": "528e23f645mshe5183283e38054dp17179cjsnf81a85484111",
         "X-RapidAPI-Host": "imdb8.p.rapidapi.com"]
    }
    
    func makeRequest(with query: Codable = "") -> URLRequest {
        var urlString = "https://imdb8.p.rapidapi.com/title/"

        switch self {
        case .mostPopular:
            urlString += "get-most-popular-movies?homeCountry=US&purchaseCountry=US&currentCountry=US"
        case .movie:
            if let queryString = query as? String {
                let formattedQueryArray = queryString.split(separator: "/")
                if formattedQueryArray.count >= 1 {
                    let movieID = formattedQueryArray[1]
                    urlString += "get-base?tconst=\(movieID)"
                }
            }
        }
        let url = NSURL(string: urlString)! as URL
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request as URLRequest
    }
    
    struct Movie: Requestable {
        var type: String?
        var id: String?
        var image: CoverImage?
        var title: String?
        var titleType: String?
        var year: Int?
        
        func makeRequest(with query: Codable) -> URLRequest {
            RequestType.movie.makeRequest(with: query)
        }
    }
    
    struct Popular: Requestable {
        var titles: [String]?
        
        func makeRequest(with query: Codable) -> URLRequest {
            RequestType.mostPopular.makeRequest(with: query)
        }
    }
}

protocol MoviesRequestProtocol {
     func callAPI<T: Requestable>(with query: Codable) -> Observable<T>
}

class MoviesRequest: MoviesRequestProtocol {
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask? = nil
    
    func callAPI<T: Requestable>(with query: Codable = "") -> Observable<T> {
        //create an observable and emit the state as per response.
        return Observable<T>.create { observer in
            self.dataTask = self.session.dataTask(with: T().makeRequest(with: query), completionHandler: { (data, response, error) in
                do {
                    let model: T
                    if T.self is RequestType.Popular.Type {
                        let decoded = try JSONDecoder().decode([String].self, from: data ?? Data())
                        model = RequestType.Popular(titles: decoded) as! T
                    } else {
                        model = try JSONDecoder().decode(T.self, from: data ?? Data())
                    }
                    observer.onNext(model)
                } catch let error {
                    //MARK: - какой-нибудь алерт
                    print(error.localizedDescription)
                    observer.onError(error)
                    let queue = DispatchQueue.global(qos: .userInitiated)
                    queue.async(flags: .barrier) {
                        
                    }
                }
                observer.onCompleted()
            })
            self.dataTask?.resume()
            return Disposables.create {
                self.dataTask?.cancel()
            }
        }
    }
}

