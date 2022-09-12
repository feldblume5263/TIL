//
//  Post.swift
//  Combine_APIApp
//
//  Created by Noah Park on 2022/09/12.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias Posts = [Post]

