//
//  ItemView.swift
//  CoinTick
//
//  Created by Caci Jiang on 5/27/21.
//

import SwiftUI

struct RowView: View {
    @EnvironmentObject var store: ItemStore
    var item: TodoItem
    @ObservedObject var progress: UserProgress
    
    var body: some View {
        let getView =
        HStack {
            let icon = Image(systemName: item.isDone ? "checkmark.circle" : "circle")
                .font(.system(size: 20))
                .padding(.trailing, 10)
                .onTapGesture {
                    withAnimation {
                        if item.isDone == false {
                            progress.numberOfCompletedItems += 1
                        } else {
                            progress.numberOfCompletedItems -= 1
                        }
                        store.toggleItemIsDone(for: item)
                    }
                }
            #if os(iOS)
                icon.foregroundColor(item.color)
            #else
                icon.foregroundColor(Color(.systemGray))
            #endif
            Text(item.name)
                .foregroundColor(.primary)
                .strikethrough(item.isDone)
            Spacer()
        }
            .padding(20)
            .animation(.default)
        #if os(iOS)
            getView.background(item.isDone ? Color(UIColor.systemGray6).opacity(0.8) : item.color.opacity(0.2))
                .cornerRadius(20)
        #else
        getView.background(item.isDone ? Color(.systemGray).opacity(0.8) : Color(.systemGray).opacity(0.2))
                .cornerRadius(20)

        #endif
    }
}

//struct ItemView_Previews: PreviewProvider {
//    @StateObject var progress = UserProgress()
//
//    static var previews: some View {
//        let store = ItemStore(named: "Test")
//        RowView(item: store.items[0], progress: progress).environmentObject(store)
//    }
//}
