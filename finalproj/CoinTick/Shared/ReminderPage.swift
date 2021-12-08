//
//  ReminderView.swift
//  CoinTick
//
//  Created by Caci Jiang on 6/2/21.
//

import SwiftUI

struct ReminderPage: View {
    @EnvironmentObject var reminderStore: ReminderStore
    
    let dateFormat = "MM/dd/yyyy"
    @State private var currentDate = Date()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        currentDate = currentDate.dayBefore
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 30))
                    }
                    .plainButtonOnMacOnly()
                    Spacer()
                    
                    Text(currentDate.getFormattedDate(format: dateFormat))
                        .font(.title2).foregroundColor(.blue)
                    Spacer()
                    
                    Button(action: {
                        currentDate = currentDate.dayAfter
                    }) {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 30))
                    }
                    .plainButtonOnMacOnly()
                }
                .padding(.horizontal)
                .padding(.top)
                Divider()
                if reminderStore.reminders.filter({$0.date.getFormattedDate(format: dateFormat) == currentDate.getFormattedDate(format: dateFormat)}).count == 0 {
                    Text("No reminders for this day...").font(.caption).foregroundColor(.gray)
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack.init(spacing: 0, pinnedViews: [.sectionHeaders], content: {
                            ForEach(reminderStore.reminders.filter({$0.date.getFormattedDate(format: dateFormat) == currentDate.getFormattedDate(format: dateFormat)}).sorted {
                                if $0.hour != $1.hour {
                                    return $0.hour < $1.hour
                                } else {
                                    return $0.minute < $1.minute
                                }
                            }) { reminder in
                                RowContent(for: reminder)
                                    .addButtonActions(leadingCell: .done,
                                                      trailingCell:  .delete, id: reminder.id, onClick: { button, id in
                                                        if button == .done {
                                                            withAnimation {
                                                                reminderStore.completeReminder(for: id)
                                                            }
                                                        } else if button == .delete {
                                                            withAnimation {
                                                                reminderStore.removeReminder(for: id)
                                                            }
                                                        }
                                                      })
                            }
                        })
                    }
                }
            }
            NewButton(isItem: false)
        }
    }
}

let buttonWidth: CGFloat = 60

struct RowContent: View {
    let reminder: Reminder
    let name: String
    let hour: String
    let minute: String
    
    init(for reminder: Reminder) {
        self.reminder = reminder
        self.name = reminder.name
        self.hour = reminder.hour < 10 ? "0" + String(reminder.hour) : String(reminder.hour)
        self.minute = reminder.minute < 10 ? "0" + String(reminder.minute) : String(reminder.minute)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(hour) : \(minute)").foregroundColor(.gray)
                    .strikethrough(reminder.isDone)
                Text(name)
                    .foregroundColor(reminder.isDone ? .gray : .primary)
                    .strikethrough(reminder.isDone)
                Spacer()
            }
            .padding()
            Divider()
                .padding(.leading)
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderPage().environmentObject(ReminderStore(named: "Test Reminders"))
    }
}
