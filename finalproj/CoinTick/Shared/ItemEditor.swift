//
//  ItemEditor.swift
//  CoinTick
//
//  Created by Caci Jiang on 5/28/21.
//

import SwiftUI

struct ItemEditor: View {
    
    @EnvironmentObject var store: ItemStore
    
    @State var item: TodoItem
    @State var editing = true
    
    let dateFormat = "MM/dd/yyyy"
    
    var body: some View {
        let scrollView = ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text(nameEdit)
                        .font(.title)
                        .fontWeight(.bold)
                    let icon = Image(systemName: "circle.fill")
                        .font(.system(size: 25))
                    #if os(iOS)
                        icon.foregroundColor(colorEdit)
                    #else
                        icon.foregroundColor(Color(.systemGray))
                    #endif
                    Spacer()
                    HStack {
                        Text("Edit").font(.title).fontWeight(.medium).foregroundColor(Color.blue)
                        Toggle(isOn: $editing) {

                        }.labelsHidden()
                    }
                }
                .padding(.bottom)
                if !editing {
                    amountSection
                    .padding(.bottom)
                    
                    calendarSection
                    .padding(.bottom)
                    
                    notesSection
                        .padding(.bottom)
                } else {
                    nameEditSection
                        .padding(.bottom)
                    
                    currentAmountEditSection
                        .padding(.bottom)
                    
                    #if os(iOS)
                    colorEditSection
                        .padding(.bottom)
                    #endif
                    
                    dateEditSection
                        .padding(.bottom)
                    
                    notesEditSection
                        .padding(.bottom)
                }
                Spacer()
            }
            .padding(.all)
        }
        .onAppear {
            nameEdit = item.name
            currentAmountEdit = item.currentAmount
            #if os(iOS)
                colorEdit = item.color
            #endif
            endDateEdit = item.endDate
            notesEdit = item.notes
        }
        #if os(iOS)
            scrollView.navigationBarTitleDisplayMode(.inline)
        #else
            scrollView
        #endif
    }
    
    var amountSection: some View {
        VStack {
            HStack {
                Image(systemName: "chart.bar.doc.horizontal")
                    .font(.system(size: 22))
                    .foregroundColor(colorEdit)
                Text("Progress")
                    .font(.title3)
                Spacer()
            }
            Annular(color: colorEdit, currentAmount: currentAmountEdit, originalAmount: item.totalAmount)
        }
    }
    
    var calendarSection: some View {
        HStack {
            Image(systemName: "calendar.circle")
                .font(.system(size: 22))
                .foregroundColor(colorEdit)
            Text("From \(item.startDate.getFormattedDate(format: dateFormat)) to \(endDateEdit.getFormattedDate(format: dateFormat))")
                .font(.title3)
        }
    }
    
    var notesSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "note.text")
                    .font(.system(size: 22))
                    .foregroundColor(colorEdit)
                Text("Notes").font(.title3)
            }
            ForEach(item.notes, id: \.self) { note in
                Divider()
                Text(note)
            }
        }
    }
    
    @State private var nameEdit: String = ""
    
    var nameEditSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "highlighter")
                    .font(.system(size: 22))
                    .foregroundColor(colorEdit)
                Text("Name").font(.title3)
            }
            let textField = TextField("", text: $nameEdit, onEditingChanged: { original in
                if !original {
                    store.setItemName(for: item, to: nameEdit)
                }
            })
            .padding(12)
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
    
    @State private var currentAmountEdit = 0.0
    
    var currentAmountEditSection: some View {
        VStack {
            HStack {
                Image(systemName: "chart.bar.doc.horizontal")
                    .font(.system(size: 22))
                    .foregroundColor(colorEdit)
                Text("Progress")
                    .font(.title3)
                Spacer()
            }
            let vstack = VStack {
                Slider(
                    value: $currentAmountEdit,
                    in: 0...item.totalAmount,
                    step: 0.5,
                        minimumValueLabel: Text("0"),
                    maximumValueLabel: Text("\(String(format: "%.1f", item.totalAmount))")
                    ) {
                        Text("Progress")
                }
                .onChange(of: currentAmountEdit, perform: { value in
                    store.setItemCurrentAmount(for: item, to: currentAmountEdit)
                })
                Text("\(String(format: "%.1f", currentAmountEdit))")
                    .foregroundColor(.blue)
            }
            .padding(12)
            #if os(iOS)
                vstack.background(Color(.systemGray5))
                    .cornerRadius(20)
            #else
                vstack.background(Color(.systemGray))
                    .cornerRadius(20)
            #endif
        }
    }
    
    @State private var colorEdit = Color(.systemGray)
    
    #if os(iOS)
    var colorEditSection: some View {
        VStack {
            HStack {
                Image(systemName: "paintpalette")
                    .font(.system(size: 22))
                    .foregroundColor(colorEdit)
                Text("Color")
                    .font(.title3)
                Spacer()
            }
            let colorPicker = ColorPicker (
                "Pick a color",
                selection: $colorEdit
            )
            .onChange(of: colorEdit, perform: { value in
                store.setItemColor(for: item, to: colorEdit)
            })
            .foregroundColor(colorEdit)
            .padding(12)
            colorPicker.background(Color(.systemGray5))
                    .cornerRadius(20)
        }
    }
    #endif
    
    @State private var endDateEdit = Date()
    
    var dateEditSection: some View {
        VStack {
            HStack {
                Image(systemName: "calendar.circle")
                    .font(.system(size: 22))
                    .foregroundColor(colorEdit)
                Text("End Date").font(.title3)
                Spacer()
            }

            DatePicker(selection: $endDateEdit, in: item.startDate..., displayedComponents: .date) {
                Text("Select a date")
            }
            .onChange(of: endDateEdit, perform: { value in
                store.setItemEndDate(for: item, to: endDateEdit)
            })
        }
    }
    
    @State private var noteEdit = ""
    @State private var notesEdit = [String]()
    
    var notesEditSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "note.text")
                    .font(.system(size: 22))
                    .foregroundColor(colorEdit)
                Text("Notes").font(.title3)
                Spacer()
            }
            .padding(.bottom, 1)
            HStack {
                let textField = TextField("", text: $noteEdit)
                    .padding(12)
                #if os(iOS)
                    textField.background(Color(.systemGray5))
                        .cornerRadius(20)
                #else
                    textField.background(Color(.systemGray))
                        .cornerRadius(20)
                #endif
                Button(action: {
                    notesEdit.insert(noteEdit, at: 0)
                    store.addNote(for: item, newNote: noteEdit)
                    noteEdit = ""
                }) { Text("Add").foregroundColor(.blue) }
            }
            ForEach(notesEdit, id: \.self) { note in
                Divider()
                Text(note)
            }
        }
    }
}

struct ItemEditView_Previews: PreviewProvider {
    static var previews: some View {
        let store = ItemStore(named: "Test")
        ItemEditor(item: store.items[0]).environmentObject(store)
    }
}
