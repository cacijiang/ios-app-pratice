//
//  NewItemView.swift
//  CoinTick
//
//  Created by Caci Jiang on 5/28/21.
//

import SwiftUI

struct NewItemView: View {
    
    var store: ItemStore
    
    @State private var nameEdit = "New Coin"
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(nameEdit)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    #if os(iOS)
                    let newItem = TodoItem(name: nameEdit, amount: Double(amountEdit) ?? 0.0, color: UIColor(colorEdit), startDate: startDate, endDate: endDate)
                    #else
                    let newItem = TodoItem(name: nameEdit, amount: Double(amountEdit) ?? 0.0, startDate: startDate, endDate: endDate)
                    #endif
                    store.addItem(newItem: newItem)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Apply")
                        .fontWeight(.medium)
                }
                .disabled(nameEdit == "New Coin")
                #if !os(iOS)
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .fontWeight(.medium)
                }
                #endif
            }
            .padding([.bottom])
            
            nameSection

            amountSection
            
            #if os(iOS)
            colorSection
            #endif

            dateSection

            Spacer()
            
            #if os(iOS)
            // Footer
            HStack {
                Spacer()
                Text("Swipe down to cancel")
                    .foregroundColor(.secondary)
                    .padding(.top)
                Spacer()
            }
            #endif
        }
        .padding(25)
    }
    
    var nameSection: some View {
        Section(header: Text("Coin").font(.title3)) {
            let textField = TextField("", text: $nameEdit).padding(12)
            #if os(iOS)
                textField.background(Color(.systemGray5)).cornerRadius(20)
            #else
                textField.background(Color(.systemGray)).cornerRadius(20)
            #endif
        }
    }
    
    @State private var amountEdit: String = "0"
    
    var amountSection: some View {
        Section(header: Text("Amount").font(.title3)) {
            let textField = TextField("", text: $amountEdit)
                .padding(12)
            #if os(iOS)
                textField
                    .keyboardType(.decimalPad)
                    .background(Color(.systemGray5))
                    .cornerRadius(20)
            #else
                textField
                    .background(Color(.systemGray))
                    .cornerRadius(20)
            #endif
        }
    }
    
    @State private var colorEdit: Color = .clear
    
    var colorSection: some View {
        Section(header: Text("Color").font(.title3)) {
            let colorPicker = ColorPicker (
                "Pick a color",
                selection: $colorEdit
            )
            .foregroundColor(colorEdit)
            .padding(12)
            #if os(iOS)
                colorPicker
                    .background(Color(.systemGray5))
                    .cornerRadius(20)
            #else
                colorPicker
                    .background(Color(.systemGray))
                    .cornerRadius(20)
            #endif
        }
    }
    
    
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var dateSection: some View {
        Section(header: Text("Dates").font(.title3)) {
            DatePicker(selection: $startDate, in: Date()..., displayedComponents: .date) {
                Text("Select a start date")
            }

            DatePicker(selection: $endDate, in: startDate..., displayedComponents: .date) {
                Text("Select an end date")
            }
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(store: ItemStore(named: "Test"))
    }
}
