//
//  GridLayout.swift
//  Memorize
//
//  Created by Vincent on 6/4/20.
//  Copyright © 2020 CS193. All rights reserved.
//

import CoreGraphics


struct GridLayout {
    let size: CGSize
    let rowCount = 2
    let columnCount: Int
    
    var itemSize: CGSize {
        CGSize(width: 80, height: 80)
    }
    
    init(itemCount: Int, nearAspectRatio desiredAspectRatio: CGFloat, in size: CGSize) {
        self.size = size
        columnCount = itemCount / rowCount
    }
     
    func location(ofItemAt index: Int) -> CGPoint {
        let row = index / columnCount
        let column = index % columnCount
        return CGPoint(x: CGFloat(column) * itemSize.width + itemSize.width / 2,
                       y: CGFloat(row) * itemSize.height + itemSize.height / 2)
    }
}
