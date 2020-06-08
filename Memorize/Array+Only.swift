//
//  Array+Only.swift
//  Memorize
//
//  Created by Vincent on 6/4/20.
//  Copyright © 2020 CS193. All rights reserved.
//

import Foundation


extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
