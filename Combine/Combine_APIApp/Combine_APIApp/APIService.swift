//
//  APIService.swift
//  Combine_APIApp
//
//  Created by Noah Park on 2022/09/12.
//

import Foundation
import Combine

enum API {
    case fetchTodos // 할일 가져오기
    case fetchPosts // 포스트 가져오기
    
    var url: URL {
        switch self {
        case .fetchTodos:
            return URL(string: "https://jsonplaceholder.typicode.com/todos")!
        case .fetchPosts:
            return URL(string: "https://jsonplaceholder.typicode.com/posts")!
        }
    }
}

enum APIService {
    static func fetchTodos() -> AnyPublisher<Todos, Error> {
        URLSession.shared.dataTaskPublisher(for: API.fetchTodos.url)
            .map{ $0.data }
            .decode(type: Todos.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func fetchPosts(_ todoCount: Int = 0) -> AnyPublisher<Posts, Error> {
        print("fetchPosts TodosCount: \(todoCount)")
        return URLSession.shared.dataTaskPublisher(for: API.fetchPosts.url)
            .map{ $0.data }
            .decode(type: Posts.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    static func fechTodosAndPostsAtTheSameTime() -> AnyPublisher<(Todos, Posts), Error> {
        let fetchedTodos = fetchTodos()
        let fetchedPosts = fetchPosts()
        
        return Publishers.CombineLatest(fetchedTodos, fetchedPosts)
            .eraseToAnyPublisher()
    }
    
    static func fetchTodosAndThenPosts() -> AnyPublisher<Posts, Error> {
        return fetchTodos().flatMap { todos in
            return fetchPosts(todos.count).eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
    
    static func fetchTodosAndThenPostsConditionally() -> AnyPublisher<Posts, Error> {
        return fetchTodos()
            .map{ $0.count }
            .filter{ $0 < 200 }
            .flatMap { _ in
                return fetchPosts().eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
}


