//
//  CoinTickView.swift
//  Shared
//
//  Created by Caci Jiang on 6/4/21.
//

import SwiftUI

struct CoinTickView: View {
    @EnvironmentObject var itemStore: ItemStore
    @EnvironmentObject var reminderStore: ReminderStore
    @State private var selectedIndex = 0
    @ObservedObject var progress: UserProgress
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                let firstPage = CoinList(progress: progress)
                    .padding(.top)
                #if os(iOS)
                    firstPage
                        .navigationBarHidden(true)
                        .tabItem {
                            Image(systemName: "checkmark.rectangle")
                                .font(.system(size: 35, weight: .bold))
                        }
                        .tag(0)
                #else
                    firstPage
                        .tabItem {
                            Image(systemName: "checkmark.rectangle")
                                .font(.system(size: 35, weight: .bold))
                        }
                        .tag(0)
                #endif
                
                let secondPage = ReminderPage()
                #if os(iOS)
                    secondPage
                        .navigationBarHidden(true)
                        .tabItem {
                            Image(systemName: "calendar.badge.clock")
                                .font(.system(size: 35, weight: .bold))
                        }
                        .tag(1)
                #else
                    secondPage
                        .tabItem {
                            Image(systemName: "calendar.badge.clock")
                                .font(.system(size: 35, weight: .bold))
                        }
                        .tag(1)
                #endif
                
                
                let thirdPage = VStack{
                    Text("Total Completed Items:")
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                    Text("\(progress.numberOfCompletedItems)")
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                }
                #if os(iOS)
                    thirdPage
                        .navigationBarHidden(true)
                        .tabItem {
                            Image(systemName: "chart.bar.xaxis")
                                .font(.system(size: 35, weight: .bold))
                        }
                        .tag(2)
                #else
                    thirdPage
                        .tabItem {
                            Image(systemName: "chart.bar.xaxis")
                                .font(.system(size: 35, weight: .bold))
                        }
                        .tag(2)
                #endif
            }
        }
    }
}

//struct CoinTickView_Previews: PreviewProvider {
//    static var previews: some View {
//        CoinTickView()
//    }
//}
