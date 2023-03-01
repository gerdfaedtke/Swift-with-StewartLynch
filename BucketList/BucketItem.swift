//
//  BucketItem.swift
//  BucketList
//
//  Created by Gerd Faedtke on 28.02.23.
//

import Foundation

struct BucketItem: Identifiable, Hashable, Codable {
    
    var id = UUID()
    var name: String
    var note = ""
    var completedDate = Date.distantPast
    
    static var samples: [BucketItem] {
        [
            BucketItem(name: "Develop first App"),
            BucketItem(name: "Visit Japan", note: "Go to Tokio and Hiroshima"),
            BucketItem(name: "Develp a SixSigma Foundation Course", note: "Lean für Problemlöser", completedDate: Date())
        ]
    }
}
