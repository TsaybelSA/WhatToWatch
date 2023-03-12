//
//  CategoriesViewModel.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 12.03.2023.
//

import RxSwift

struct CategoriesViewModel {
    
    let items = BehaviorSubject<[TableViewSection]>(value: [
        .GridSection(items: [
            .MoviesTableViewItem(data: [Movie(title: "1"), Movie(title: "2"), Movie(title: "3")])
        ], header: "First Category"),
        .GridSection(items: [
            .MoviesTableViewItem(data: [Movie(title: "1"), Movie(title: "2"), Movie(title: "3")])
        ], header: "Second Category")
    ])
    
    let dataSource = DataSource.dataSource()
}
