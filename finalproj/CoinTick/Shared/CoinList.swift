//
//  CoinList.swift
//  CoinTick
//
//  Created by Caci Jiang on 5/27/21.
//

import SwiftUI

struct CoinList: View {
    @EnvironmentObject var store: ItemStore
    @State var hideNewButton = false
    @ObservedObject var progress: UserProgress
    
    var body: some View {
        ZStack {
            List{
                if store.items.filter({ !$0.isDone }).count > 0 {
                    ForEach(store.items.filter({ !$0.isDone })) { item in
                        NavigationLink(destination: ItemEditor(item: item)
                                        .onAppear {
                                            hideNewButton = true
                                        }
                                        .onDisappear {
                                            withAnimation {
                                                hideNewButton = false
                                            }
                                        }
                        ) {
                            RowView(item: item, progress: progress)
                        }
                    }
                } else {
                    Text("No investment goal...").font(.caption).foregroundColor(.gray).padding(.bottom)
                }
                if store.items.filter({ $0.isDone }).count > 0 {
                    Text("Completed").font(.caption).foregroundColor(.gray)
                    ForEach(store.items.filter({ $0.isDone })) { item in
                        NavigationLink(destination: ItemEditor(item: item)
                                        .onAppear {
                                            hideNewButton = true
                                        }
                                        .onDisappear {
                                            withAnimation {
                                                hideNewButton = false
                                            }
                                        }
                        ) {
                            RowView(item: item, progress: progress)
                        }
                    }
                }
            }
            if (!hideNewButton) {
                NewButton(isItem: true)
        }
        }
    }
}

//struct CoinList_Previews: PreviewProvider {
//    @StateObject var progress = UserProgress()
//
//    static var previews: some View {
//        CoinList(progrss: progress).environmentObject(ItemStore(named: "Test List"))
//    }
//}
