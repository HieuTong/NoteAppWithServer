//
//  APIFunction.swift
//  NoteApp
//
//  Created by HieuTong on 3/1/21.
//

import Foundation
import Alamofire

struct Note: Decodable {
    var _id: String
    var title: String
    var date: String
    var note: String
}

class APIFunction {
    
    var delegate: DataDelegate?
    static let functions = APIFunction()
    
    func fetchNotes() {
        AF.request("http://localhost:8081/fetch").response { response in
            print(response)
            
            guard let reponseData = response.data, let data = String(data: reponseData, encoding: .utf8) else { return }
            
            self.delegate?.updateArray(newArray: data)
        }
    }
    
    func addNote(date: String, title: String, note: String) {
        AF.request("http://localhost:8081/create", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note]).responseJSON { (response) in
            print(response)
        }
    }
    
    func updateNote(date: String, title: String, note: String, id: String) {
        AF.request("http://localhost:8081/update", method: .post, encoding: URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note, "id": id]).responseJSON { (response) in
            print(response)
        }
    }
    
    
    func deleteNote(id: String) {
        AF.request("http://localhost:8081/delete", method: .post, encoding: URLEncoding.httpBody, headers: ["id": id]).responseJSON { (response) in
            print(response)
        }
    }
    
}
