//
//  SwipeReminderModifier.swift
//  CoinTick
//
//  Created by Caci Jiang on 6/2/21.
//

import SwiftUI

let cellWidth: CGFloat = 60

struct SwipeContainerCell: ViewModifier  {
    enum CellPosition {
        case left
        case right
        case none
    }
    
    @State private var offset: CGFloat = 0
    @State private var previousOffset: CGFloat = 0
    @State private var cellPosition: CellPosition = .none
    
    let leadingCell: Cell
    let trailingCell: Cell
    let leadingOffsetMax: CGFloat
    let trailingOffsetMin: CGFloat
    let onClick: (Cell, UUID) -> Void
    let id: UUID

    init(leadingCell: Cell, trailingCell: Cell, id: UUID, onClick: @escaping (Cell, UUID) -> Void) {
        self.leadingCell = leadingCell
        self.trailingCell = trailingCell
        leadingOffsetMax = buttonWidth
        trailingOffsetMin = buttonWidth * -1
        self.id = id
        self.onClick = onClick
    }

    func restore() {
        offset = 0
        previousOffset = 0
        cellPosition = .none
    }

    func body(content: Content) -> some View {
        ZStack {
            content
                .contentShape(Rectangle())
                .offset(x: offset)
                .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
                            .onChanged({ value in
                                let totalTranslation = value.translation.width + previousOffset
                                if  (0...Int(leadingOffsetMax) ~= Int(totalTranslation)) || (Int(trailingOffsetMin)...0 ~= Int(totalTranslation)) {
                                    withAnimation{
                                        offset = totalTranslation
                                        
                                    }
                                    
                                }})
                            .onEnded({ value in
                                withAnimation {
                                    if cellPosition == .left && value.translation.width < -15 {
                                        restore()
                                    } else if  cellPosition == .right && value.translation.width > 15 {
                                        restore()
                                    } else if offset > 20 || offset < -20 {
                                        if offset > 0 {
                                            cellPosition = .left
                                            offset = leadingOffsetMax
                                        } else {
                                            cellPosition = .right
                                            offset = trailingOffsetMin
                                        }
                                        previousOffset = offset
                                    } else {
                                        restore()
                                    }
                                    
                                }
                            }))
            GeometryReader { proxy in
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Button(action: {
                            withAnimation {
                                restore()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                onClick(leadingCell, id)
                            }
                        }, label: {
                            CellView(content: leadingCell, cellHeight: proxy.size.height)
                        })
                    }.offset(x: (-1 * leadingOffsetMax) + offset)
                    Spacer()
                    HStack(spacing: 0) {
                        Button(action: {
                            withAnimation {
                                restore()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                                onClick(trailingCell, id)
                            }
                        }, label: {
                            CellView(content: trailingCell, cellHeight: proxy.size.height)
                        })
                }.offset(x: (-1 * trailingOffsetMin) + offset)
            }}
        }
    }
}
