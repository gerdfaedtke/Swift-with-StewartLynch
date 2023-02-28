//
//  ContentView.swift
//  BucketList
//
//  Created by Gerd Faedtke on 27.02.23.
//

import SwiftUI

struct BucketListView: View {
    
    @State private var bucketList = BucketItem.samples
    @State private var newItem = ""
    
    var body: some View {
        
        NavigationStack {
            VStack {
                HStack {
                    TextField("New Bucket Item", text: $newItem)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        let newBucketItem = BucketItem(name: newItem)
                        bucketList.append(newBucketItem)
                        // Nachdem das array mit dem neuen item upgedated wurde können wir wieder ein "empty String" zuweisen
                        newItem = ""
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    // um das hinzufügen von einem leeren TextField zuvermeiden = true
                    .disabled(newItem.isEmpty)

                }
                .padding()
                
                List {
                    
                    ForEach($bucketList) { $item in
                        NavigationLink(value: item) {
                            TextField(item.name, text: $item.name, axis: .vertical)
                                .textFieldStyle(.roundedBorder)
                                .font(.title3)
                                .foregroundColor(item.completedDate == .distantPast ? .primary : .red)
                        }
                        .listRowSeparator(.hidden)
                }
                    // List Swipe and Delete modifier
                    .onDelete { indexSet in
                        bucketList.remove(atOffsets: indexSet)
                    }
                        
                    }
                    .listStyle(.plain)
                    
                }
                .navigationTitle("My Bucket List")
                .navigationDestination(for: BucketItem.self) { item in
                    DetailView(bucketItem: item, bucketList: $bucketList)
                }
            
        }
    }
}

struct BucketListView_Previews: PreviewProvider {
    static var previews: some View {
        BucketListView()
    }
}
