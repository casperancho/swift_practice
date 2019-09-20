import Foundation

class FileNotebook {
    public func add(_ note: Note){
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        if path == nil { return }
        var n = note
        var strPat = ""
         do {
           strPat = try String(contentsOf: path!)
        } catch {
            
        }
        FileManager.default.createFile(atPath: strPat, contents: Data(bytes: &n, count: MemoryLayout<Note>.stride), attributes: nil)
        let dirurl = path!.appendingPathComponent("Notebooks")
        

    }
    public func remove(with uid: String){
        
    }
    public func saveToFile(){
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        if path == nil { return }
        let dirurl = path!.appendingPathComponent("Notebooks")
    }
    public func loadFromFile(){
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        if path == nil { return }
        
    }
            
}


