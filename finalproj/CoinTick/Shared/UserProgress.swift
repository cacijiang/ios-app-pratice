//
//  UserProgress.swift
//  CoinTick
//
//  Created by Caci Jiang on 6/4/21.
//

import Foundation
import Combine

class UserProgress: ObservableObject {
    private var autosave: AnyCancellable?
    
    @Published var numberOfCompletedItems = 0 {
        didSet {
            storeInUserDefaults()
        }
    }
    
    init() {
        restoreFromUserDefaults()
        
        autosave = $numberOfCompletedItems.sink { numberOfCompletedItems in
            self.storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "UserProgress"
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(numberOfCompletedItems), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedNumberOfCompletedItems = try? JSONDecoder().decode(Int.self, from: jsonData) {
            numberOfCompletedItems = decodedNumberOfCompletedItems
        }
    }
}
