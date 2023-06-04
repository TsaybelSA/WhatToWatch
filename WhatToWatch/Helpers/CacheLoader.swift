//
//  CacheLoader.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 04.06.2023.
//

import Foundation

struct CacheLoader<T: NSObject> {
    
    let cache = NSCache<NSString, T>()
    
    func getObjectFor(key: String, loadingHandler: (() async -> T?)) async -> T? {
        let keyNSString = key as NSString
        if let cachedObject = cache.object(forKey: keyNSString) {
            return cachedObject
        } else {
            if let loadedObject = await loadingHandler() {
                cache.setObject(loadedObject, forKey: keyNSString)
                return loadedObject
            }
            
            return nil
        }
    }
}
