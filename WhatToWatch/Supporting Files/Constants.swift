//
//  Constants.swift
//  WhatToWatch
//
//  Created by Сергей Цайбель on 12.03.2023.
//

import UIKit

struct Constants {
    
    static var categoryHeight: CGFloat {
        let screenHeight: CGFloat
        let screenBounds = UIScreen.main.bounds
        if UIWindow.isLandscape {
            screenHeight = min(screenBounds.height, screenBounds.width)
        } else {
            screenHeight = max(screenBounds.height, screenBounds.width)
        }
        return screenHeight / 4
    }
    
    static let itemsPadding = 20.0
    
    static var collectionCellHeight: CGFloat {
        categoryHeight - itemsPadding * 2
    }
    
    static var collectionCellWidth: CGFloat {
        collectionCellHeight * 0.65
    }
}
