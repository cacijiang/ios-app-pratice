//
//  NewReminderView.swift
//  CoinTick
//
//  Created by Caci Jiang on 6/3/21.
//

import SwiftUI

struct NewReminderView: View {
    var store: ReminderStore
    
    @State private var nameEdit = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("New Reminder")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    let newReminder = Reminder(name: nameEdit, date: dateEdit, hour: hourEdit, minute: minuteEdit)
                    print("add reminder id: \(newReminder.id)")
                    store.addReminder(newReminder: newReminder)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Apply")
                        .fontWeight(.medium)
                }
                .disabled(nameEdit == "")
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

            dateSection
            
            timeSection

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
        Section(header: Text("Description").font(.title3)) {
            let textField = TextField("", text: $nameEdit)
                .padding(12)
                .padding(.bottom)
            #if os(iOS)
                textField
                    .background(Color(.systemGray5))
                    .cornerRadius(20)
            #else
                textField
                    .background(Color(.systemGray))
                    .cornerRadius(20)
            #endif
        }
    }
    
    @State private var dateEdit = Date()
    
    var dateSection: some View {
        Section(header: Text("Dates").font(.title3)) {
            DatePicker(selection: $dateEdit, in: Date()..., displayedComponents: .date) {
                Text("Select a date")
            }
            .padding(.bottom)
        }
    }
    
    @State private var hourEdit: Int = 0
    @State private var minuteEdit: Int = 0
    
    var timeSection: some View {
        Section(header: Text("Time").font(.title3)) {
            HStack {
                Spacer()
                let hourPicker = Picker("", selection: $hourEdit){
                    ForEach(0...23, id: \.self) { i in
                        Text("\(i) h")
                    }
                }
                #if os(iOS)
                    hourPicker
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100)
                        .clipped()
                #else
                    hourPicker
                        .pickerStyle(PopUpButtonPickerStyle())
                #endif
                
                let minutePicker = Picker("", selection: $minuteEdit){
                    ForEach(0..<60, id: \.self) { i in
                        Text("\(i) min")
                    }
                }
                #if os(iOS)
                    minutePicker
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 100)
                        .clipped()
                #else
                    minutePicker
                        .pickerStyle(PopUpButtonPickerStyle())
                #endif
                Spacer()
            }.padding(.horizontal)
        }
    }
}

struct NewReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NewReminderView(store: ReminderStore(named: "Test"))
    }
}
