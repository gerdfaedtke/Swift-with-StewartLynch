//
//  ContentView.swift
//  BucketList
//
//  Created by Gerd Faedtke on 27.02.23.
//

import SwiftUI

struct BucketListView: View {
    
 
    @EnvironmentObject var dataStore: DataStore
    @State private var newItem = ""
    
    var body: some View {
        
        NavigationStack {
            VStack {
                HStack {
                    TextField("New Bucket Item", text: $newItem)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        dataStore.create(newItem)
                        // Nachdem das array mit dem neuen item upgedated wurde können wir wieder ein "empty String" zuweisen
                        newItem = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    // um das hinzufügen von einem leeren TextField zuvermeiden = true
                    .disabled(newItem.isEmpty)

                }
                .padding()
                // The ! is the negation of is Empty = is not Empty
                if !dataStore.bucketList.isEmpty {
                    
                    List {
                        
                        ForEach($dataStore.bucketList) { $item in
                            NavigationLink(value: item) {
                                TextField(item.name, text: $item.name, axis: .vertical)
                                    .textFieldStyle(.roundedBorder)
                                    .font(.title3)
                                    .foregroundColor(item.completedDate == .distantPast ? .primary : .red)
                            }
                            .onChange(of: item, perform: { _ in
                                dataStore.saveList()
                            })
                            .listRowSeparator(.hidden)
                        }
                        // List Swipe and Delete modifier
                        .onDelete { indexSet in
                            dataStore.delete(indexSet: indexSet)
                           
                        }
                        
                    }
                    .listStyle(.plain)
                } else {
                    Text("Add your first BucketList item.")
                    Image("bucketList")
                    Spacer()
                }
                }
                .navigationTitle("My Bucket List")
                .navigationDestination(for: BucketItem.self) { item in
                    DetailView(bucketItem: item)
                }
            
        }
    }
}

struct BucketListView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListView()
            .environmentObject(DataStore())
    }
}
