//
//  CategoriesViewModel.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 12.03.2023.
//

import RxSwift
import RxRelay

class CategoriesViewModel {
    init() {}
    private let disposeBag = DisposeBag()
    
    var items = BehaviorSubject<[TableViewSection]>(value: [])
    let dataSource = DataSource.dataSource()
    
    var moviesSections = BehaviorRelay<[TableViewSection]>(value: [])
    
    let moviesRequest = MoviesRequest()
    private var movies: Observable<RequestType.Popular>?
    
    var moviesSectionsObserver: Observable<[TableViewSection]> {
        moviesSections.asObservable()
    }
    
    var movie: Observable<RequestType.Movie>?    
    
    func fetchMovies() {
        self.moviesSections.accept([TableViewSection.GridSection(items: [.MoviesTableViewItem(titles: Array(repeating: "", count: 5))], header: "Popular")])
        movies = moviesRequest.callAPI()
        movies?.subscribe(onNext: { result in
            guard let titles = result.titles else { return }
            
            self.moviesSections.accept([TableViewSection.GridSection(items: [.MoviesTableViewItem(titles: titles)], header: "Popular")])
        }).disposed(by: disposeBag)
    }
}
