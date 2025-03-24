//
//  ContentView.swift
//  Jolt Watch App
//
//  Created by Brett Lenz on 3/23/25.
//

import SwiftUI

struct AddJoltView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var jolts: [Date]
    @State private var reminderTime = Date()

    let notificationManager = NotificationManager()

    var body: some View {
        VStack {
            Text("Select Time")
                .font(.headline)

            DatePicker(
                "Jolt Time",
                selection: $reminderTime,
                displayedComponents: .hourAndMinute
            )
            .labelsHidden()
            .padding()

            Button("Save Jolt") {
                notificationManager.scheduleNotification(at: reminderTime)
                jolts.append(reminderTime)
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.green)
        }
    }
}

struct JoltList: View {
    @State private var jolts: [Date] = []
    @State private var showAddJolt = false

    var body: some View {
        NavigationView {
            VStack {
                if jolts.isEmpty {
                    Text("No jolts set")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(jolts, id: \.self) { time in
                            Text("\(time, style: .time)")
                                .foregroundStyle(.green)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.title2)
                        }
                        .onDelete(perform: deleteJolt)
                    }
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Jolts")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding()
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { showAddJolt = true }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundStyle(.green)
                            .padding()
                    }
                }
            }
            .sheet(isPresented: $showAddJolt) {
                AddJoltView(jolts: $jolts)
            }
        }
    }

    func deleteJolt(at offsets: IndexSet) {
        jolts.remove(atOffsets: offsets)
    }
}

struct ContentView: View {
    var body: some View {
        JoltList()
    }
}

#Preview {
    ContentView()
}
