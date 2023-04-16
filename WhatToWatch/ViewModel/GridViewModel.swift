//
//  GridViewModel.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 12.03.2023.
//

import RxSwift

struct GridViewModel<T: Codable> {
    
    let data = BehaviorSubject<[T]>(value: [])
    
    init(data: [T]) {
        self.data.onNext(data)
    }
}
