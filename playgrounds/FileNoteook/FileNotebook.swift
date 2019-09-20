//
//  FileNotebook.swift
//  YandexNote
//
//  Created by Arslan Nevlyaev on 28/06/2019.
//  Copyright © 2019 Arslan Nevlyaev. All rights reserved.
//

import Foundation

final class FileNotebook {
    
    private(set) var notes: Set<Note> = []
    
    public func add(_ note: Note) {
        notes.insert(note)
    }
    
    public func remove(with uid: String) {
        if let note = notes.first(where: { $0.uid == uid }) {
            notes.remove(note)
        }
    }
    
    public func saveToFile() {
        
        var arrayOfJSONS: [[String : Any]] = [[:]]
        
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            notes.forEach {
                arrayOfJSONS.append($0.json)
            }
            do {
                let json = try JSONSerialization.data(withJSONObject: arrayOfJSONS)
                try json.write(to: path)
            } catch {
                print("writing error occured")
            }
        }
    }
    
    public func loadFromFile() -> Set<Note> {
        
        var notes: Set<Note> = []
        
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            if FileManager().fileExists(atPath: path.absoluteString) {
                do {
                    let data = try Data(contentsOf: path)
                    let note = try JSONSerialization.jsonObject(with: data, options: [])
                    if let castedNote = note as? [[String : Any]] {
                        for note in castedNote {
                            if let parsedNote = Note.parse(json: note) {
                                notes.insert(parsedNote)
                            }
                        }
                    }
                } catch {
                    print("cannot read note")
                }
            }
        }
        return notes
    }
}
