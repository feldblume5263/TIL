//
//  MainViewModel.swift
//  Combine_APIApp
//
//  Created by Noah Park on 2022/09/12.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    var subscriptions = Set<AnyCancellable>()
    
    func fetchTodos() {
        APIService.fetchTodos()
            .sink { completion in
                switch completion {
                case .finished:
                    print("viewModel - fetchTodos finished")
                case .failure(let error):
                    print("viewModel - fetchTodos failure: \(error)")
                }
            } receiveValue: { (todos: Todos) in
                print("viewModel - fetchTodos todos \(todos.count)")
            }
            .store(in: &subscriptions)
    }
    
    func fetchPosts() {
        APIService.fetchPosts()
            .sink { completion in
                switch completion {
                case .finished:
                    print("viewModel - fetchPosts finished")
                case .failure(let error):
                    print("viewModel - fetchPosts failure: \(error)")
                }
            } receiveValue: { (posts: Posts) in
                print("viewModel - fetchPosts todos \(posts.count)")
            }
            .store(in: &subscriptions)
    }
    
    func fetchTodosAndPostsAtTheSameTime() {
        APIService.fechTodosAndPostsAtTheSameTime()
            .sink { completion in
                switch completion {
                case .finished:
                    print("viewModel - fetchTodosAndPostsAtTheSameTime finished")
                case .failure(let error):
                    print("viewModel - fetchTodosAndPostsAtTheSameTime failure: \(error)")
                }
            } receiveValue: { (todos: Todos, posts: Posts) in
                print("viewModel - fetchTodosAndPostsAtTheSameTime todos \(todos.count) posts \(posts.count)")
            }
            .store(in: &subscriptions)
    }
    
    func fetchTodosAndThenPosts() {
        APIService.fetchTodosAndThenPosts()
            .sink { completion in
                switch completion {
                case .finished:
                    print("viewModel - fetchTodosAndThenPosts finished")
                case .failure(let error):
                    print("viewModel - fetchTodosAndThenPosts failure: \(error)")
                }
            } receiveValue: { (posts: Posts) in
                print("viewModel - fetchTodosAndThenPosts posts \(posts.count)")
            }
            .store(in: &subscriptions)
    }
    
    func fetchTodosAndThenPostsConditionally() {
        APIService.fetchTodosAndThenPostsConditionally()
            .sink { completion in
                switch completion {
                case .finished:
                    print("viewModel - fetchTodosAndThenPostsConditionally finished")
                case .failure(let error):
                    print("viewModel - fetchTodosAndThenPostsConditionally failure: \(error)")
                }
            } receiveValue: { (posts: Posts) in
                print("viewModel - fetchTodosAndThenPostsConditionally posts \(posts.count)")
            }
            .store(in: &subscriptions)
    }
}
