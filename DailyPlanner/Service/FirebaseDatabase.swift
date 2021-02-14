//
//  FirebaseDatabase.swift
//  DailyPlanner
//
//  Created by Давид Михайлов on 13.02.2021.
//

import FirebaseDatabase

class DataStorage {
    
    let ref = Database.database().reference()
    
    func writeToList(listName: String, dict: [String: String]) {
        ref.child(listName).childByAutoId().setValue(dict)
    }
    
    func read(path: String, onComplete: @escaping ([String : AnyObject]?) -> Void) {
        ref.child(path).getData { error, snapshot in
            if let error = error {
                print("Error getting data \(error)")
                onComplete(nil)
            } else if snapshot.exists() {
                print("Got data \(snapshot.value!)")
                onComplete(snapshot.value as? [String: AnyObject])
            } else {
                onComplete(nil)
            }
        }
    }
    
    var hanlder: UInt?
    func observeNewItemsInList(listName: String, observer: @escaping ([String : AnyObject]) -> Void) {
        let listRef = ref.child(listName)
        if let hanlder = self.hanlder {
            listRef.removeObserver(withHandle: hanlder)
        }
        let handler = listRef.observe(.value, with: { snapshot in
            guard let allTasksDict = snapshot.value as? [String: AnyObject] else {
                observer([:])
                return
            }
            observer(allTasksDict)
        })
        self.hanlder = handler
    }
}
