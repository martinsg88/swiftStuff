//
//  Users.swift
//  RxTest
//
//  Created by Guilherme Martins on 2021/03/14.
//

import Mapper

struct Users: Mappable {
    let id: Int
    let name: String
    let avatarUrl: String
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
        try avatarUrl = map.from("avatarUrl")
    }
}
