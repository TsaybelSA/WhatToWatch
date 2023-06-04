//
//  GridViewModel.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 12.03.2023.
//

import RxSwift

class GridViewModel<T: Codable> {
    
    let data = BehaviorSubject<[T]>(value: [])
    
    private let disposeBag = DisposeBag()
    
    private let movieCacheLoader = CacheLoader<Movie>()
    private let imageCacheLoader = CacheLoader<UIImage>()
    private let movieRequest = MoviesRequest()
    
    init(titles: [T]) {
        self.data.onNext(titles)
    }
    
    func getMovieData(for movieID: String, loadingHandler: (() -> Void)?) async -> Movie? {
        return await movieCacheLoader.getObjectFor(key: movieID) {
            let movieResult = Movie()
            let movie: Observable<RequestType.Movie> = movieRequest.callAPI(with: movieID)
            movie.subscribe(onNext: { result in
                Task {
                    if let urlString = result.image?.url {
                        let image = await self.getMovieCover(from: urlString)
                        movieResult.set(image: image)
                        loadingHandler?()
                    }
                    
                    movieResult.set(title: movieID, name: result.title, imageURL: result.image?.url,
                                    type: result.type, id: result.id, titleType: result.titleType,
                                    year: result.year, coverImage: result.image)
                    loadingHandler?()
                }
            }).disposed(by: disposeBag)
            
            return movieResult
        }
    }
    
    private func getMovieCover(from urlString: String) async -> UIImage? {
        return await imageCacheLoader.getObjectFor(key: urlString) {
            var image: UIImage?
            if let url = URL(string: urlString) {
                image = await ImageLoader.shared.loadImageWithUrl(url)
            }
            return image
        }
    }
}
