//
//  AspectVGrid.swift
//  SetGame_2
//
//  Created by Kamil on 22.07.2021.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where Item: Identifiable, Item: Hashable, ItemView: View {
    let items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    var minimalWidth: CGFloat
    
    init(items: [Item], aspectRatio: CGFloat, minimalWidth: CGFloat, content: @escaping (Item) -> ItemView){
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
        self.minimalWidth = minimalWidth
    }
    
    var body: some View {
        GeometryReader { geometry in
            let width: CGFloat = adaptiveWidth(itemCount: items.count, in: geometry.size, itemAspectRatio: aspectRatio)
            if width == minimalWidth {
                ScrollView {
                    LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                        ForEach(items, id: \.self) { item in
                            content(item).aspectRatio(aspectRatio, contentMode: .fit)
                        }
                    }
                }
            }
            else {
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
            }
        }
    }

    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func adaptiveWidth(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        
        // Увеличиваем количество колонок, расчитываем ширину от этого, а длину от ширины
        while columnCount < itemCount {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            // Все уместились на экране
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        }
        return max(minimalWidth, floor(size.width / CGFloat(columnCount)))
    }
}


