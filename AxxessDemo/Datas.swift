//
//  Datas.swift
//  AxxessDemo
//
//  Created by Augment Deck Technologies on 20/07/20.
//  Copyright © 2020 Augment Deck Technologies. All rights reserved.
//
import Foundation
struct Datas: Decodable {
    
    let id: String
    let Data: String
      let typoss: String
    let Date: String
    
  
  enum CodingKeys: String, CodingKey {
   
    case id
    case Data
    case typoss
    case Date
 
  }
}
