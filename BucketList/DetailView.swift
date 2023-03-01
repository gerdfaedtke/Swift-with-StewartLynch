//
//  DetailView.swift
//  BucketList
//
//  Created by Gerd Faedtke on 28.02.23.
//

import SwiftUI

struct DetailView: View {
    
    @EnvironmentObject var dataStore: DataStore
    let bucketItem: BucketItem
    
    @State private var note = ""
    @State private var completedDate = Date.distantPast
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            TextField("Bucket Note", text: $note, axis: .vertical)
            if completedDate != Date.distantPast {
                DatePicker("Completed on", selection: $completedDate, displayedComponents: .date)
            }
            Button(completedDate == Date.distantPast ? "Add date" : "Clear Date") {
                if completedDate == Date.distantPast {
                    completedDate = Date()
                } else {
                    completedDate = Date.distantPast
                }
            }
            .buttonStyle(.borderedProminent)
        }
        
            .onAppear {
                note = bucketItem.note
                completedDate = bucketItem.completedDate
            }
            .toolbar {
                ToolbarItem {
                    Button("Update") {
                     
                        dataStore.update(bucketItem: bucketItem, note: note, completedDate: completedDate)
                        
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle(bucketItem.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let bucketItem = BucketItem.samples[2]
    static let bucketList: Binding<[BucketItem]> = .constant(BucketItem.samples)
    static var previews: some View {
        NavigationStack {
            DetailView(bucketItem: bucketItem)
                .environmentObject(DataStore())
        }
    }
}
