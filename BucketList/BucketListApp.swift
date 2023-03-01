//
//  BucketListApp.swift
//  BucketList
//
//  Created by Gerd Faedtke on 27.02.23.
//

import SwiftUI

@main
struct BucketListApp: App {
    
    @StateObject var dataStore = DataStore()
    
    var body: some Scene {
        WindowGroup {
            BucketListView()
                .environmentObject(dataStore)
                .onAppear {
                    print(URL.documentsDirectory.path)
                }
        }
    }
}
