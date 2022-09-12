//
//  ContentView.swift
//  Combine_APIApp
//
//  Created by Noah Park on 2022/09/12.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var mainViewModel: MainViewModel
    
    init() {
        _mainViewModel = StateObject.init(wrappedValue: MainViewModel())
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Button {
                self.mainViewModel.fetchTodos()
            } label: {
                Text("Call TODOs")
                    .foregroundColor(.white)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray))
            
            Button {
                self.mainViewModel.fetchPosts()
            } label: {
                Text("Call Posts")
                    .foregroundColor(.white)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray))
            
            Button {
                self.mainViewModel.fetchTodosAndPostsAtTheSameTime()
            } label: {
                Text("Call Todos and posts at the same time")
                    .foregroundColor(.white)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray))
            
            Button {
                self.mainViewModel.fetchTodosAndThenPosts()
            } label: {
                Text("Call Todos and then call Posts")
                    .foregroundColor(.white)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray))
            
            Button {
                self.mainViewModel.fetchTodosAndThenPostsConditionally()
            } label: {
                Text("Call Todos and then call Posts Conditionally")
                    .foregroundColor(.white)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray))
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
