//
//  Grid.swift
//  Memorize
//
//  Created by Vincent on 6/4/20.
//  Copyright © 2020 CS193. All rights reserved.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private let items: [Item]
    private let viewForItem: (Item) -> ItemView
    
    var body: some View {
        GeometryReader {
            self.body(for: GridLayout(itemCount: self.items.count, nearAspectRatio: 1, in: $0.size))
        }
    }
    
    init(_ items: [Item], viewForItem: @escaping ((Item) -> ItemView)) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(0..<items.count) {
            self.body(forItemAt: $0, in: layout)
        }
    }
    
    private func body(forItemAt index: Int, in layout: GridLayout) -> some View {
        viewForItem(items[index])
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index))
    }
}


