//
//  Data.swift
//  AxxessDemo
//
//  Created by Augment Deck Technologies on 20/07/20.
//  Copyright © 2020 Augment Deck Technologies. All rights reserved.
//
/*
struct Data: Decodable {
  let id: String
  let Data: String
    let typoss: String
  let Date: String
  
  
  enum CodingKeys: String, CodingKey {
   // case id = "id"
   // case Data = "data"
   // case typoss = "type"
   // case Date = "date"
    case id
    case Data
    case typoss
    case Date
  }
}
extension Data: Displayable {
    var typetext: String {
       "TYPES \(String(typoss))"
    }
    
  var idtext: String{
      "IDS \(String(id))"
  }
  
  var datatext: String {
    "DATAS \(String(Data))"
  }
  
  
  var datetext: String {
   "DATES \(String(Date))"
  }
  
  //var tyapetext: String {
  //   "type \(String(Type))"
  //}
}
*/

struct RootClass : Decodable {

        let data : String?
        let date : String?
        let id : String?
        let type : String?

        enum CodingKeys: String, CodingKey {
                case data = "data"
                case date = "date"
                case id = "id"
                case type = "type"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                data = try values.decodeIfPresent(String.self, forKey: .data)
                date = try values.decodeIfPresent(String.self, forKey: .date)
                id = try values.decodeIfPresent(String.self, forKey: .id)
                type = try values.decodeIfPresent(String.self, forKey: .type)
        }

}
