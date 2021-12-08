//
//  NewButton.swift
//  CoinTick
//
//  Created by Caci Jiang on 5/28/21.
//

import SwiftUI

struct NewButton: View {
    @EnvironmentObject var itemStore: ItemStore
    @EnvironmentObject var reminderStore: ReminderStore
    
    @State var sheetIsPresented = false
    @State var isItem: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .foregroundColor(.blue).opacity(0.2)
                        .frame(width: 70, height: 70)
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.blue)
                }
                .animation(.spring())
            }
        }
        .padding(.bottom, 20)
        .padding(.trailing, 20)
        .onTapGesture {
            sheetIsPresented = true
        }
        .sheet(isPresented: self.$sheetIsPresented) {
            if isItem {
                NewItemView(store: self.itemStore)
            } else {
                NewReminderView(store: self.reminderStore)
            }
        }
    }
}

struct NewButton_Previews: PreviewProvider {
    static var previews: some View {
        NewButton(isItem: true).environmentObject(ItemStore(named: "Test"))
    }
}
