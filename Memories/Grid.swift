//
//  Grid.swift
//  Memories
//
//  Created by Bryce on 2020/9/27.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    private var items: [Item]
    private var viewForItem: (Item) ->  ItemView
    
    init(_ items: [Item], viewForItem: @escaping ( Item) ->  ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    var body: some View {
        GeometryReader { geometry  in
            let layout = GridLayout(itemCount: items.count,nearAspectRatio: 0.7,  in: geometry.size)

            
            ForEach(items) { item in
                let index = items.searchFirstIndex(of: item)!
                viewForItem(item)
                .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                .position(layout.location(ofItemAt: index))
            }
        }
    }
}

