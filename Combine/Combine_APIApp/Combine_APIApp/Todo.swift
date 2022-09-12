//
//  Todo.swift
//  Combine_APIApp
//
//  Created by Noah Park on 2022/09/12.
//

import Foundation

// MARK: - Todo
struct Todo: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

typealias Todos = [Todo]
