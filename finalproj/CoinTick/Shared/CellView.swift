//
//  CellView.swift
//  CoinTick
//
//  Created by Caci Jiang on 6/2/21.
//

import SwiftUI

enum Cell: Identifiable {
    case done
    case delete

    var id: String {
        return "\(self)"
    }
}

struct CellView: View {
    let content: Cell
    let cellHeight: CGFloat

    func getCell(for image: String, name: String) -> some View {
        VStack {
            Image(systemName: image)
            Text(name)
        }.padding(5)
        .foregroundColor(.white)
        .font(.subheadline)
        .frame(width: buttonWidth, height: cellHeight)
    }

    var body: some View {
        switch content {
        case .done:
            getCell(for: "checkmark.seal", name: "Done")
            .background(Color.green)
        case .delete:
            getCell(for: "delete.right", name: "Delete")
            .background(Color.red)
        }
    }
}
