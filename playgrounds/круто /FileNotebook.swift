//
//  FileNotebook.swift
//  Notes
//
//  Created by Timur Rakhimov on 01/07/2019.
//  Copyright © 2019 Timur Rakhimov. All rights reserved.
//

import UIKit

class FileNotebook {
    
    private(set) var notes = [String : Note]()
    
    public func add(_ note: Note) {
        guard notes[note.uid] == nil else {
            print("Note duplicate")
            return
        }
        notes[note.uid] = note
    }
    
    public func remove(with uid: String) {
        notes[uid] = nil
    }
    
    public func saveToFile() {
        if let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            do {
                let jsonArray = notes.map { $0.value.json }
                let data = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
                let pathSave = path.appendingPathComponent("notebook.json")
                FileManager.default.createFile(atPath: pathSave.path, contents: data, attributes: nil)
            } catch let error {
                print("Can't save notes to file: \(error.localizedDescription)")
            }
        }
        
    }
    public func loadFromFile() {
        self.notes.removeAll()
        if let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first {
            do {
                let pathFile = path.appendingPathComponent("notebook.json")
                if let data = FileManager.default.contents(atPath: pathFile.path),
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    
                    for noteJson in jsonData {
                        if let note = Note.parse(json: noteJson) {
                            self.add(note)
                        }
                    }
                } else {
                    print("Can't load notes from file.")
                }
            } catch let error {
                print("Can't load notes from file: \(error.localizedDescription)")
            }
            
        }
        
    }
}
