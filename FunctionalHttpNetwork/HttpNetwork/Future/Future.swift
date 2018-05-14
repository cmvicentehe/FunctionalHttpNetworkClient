//
//  Future.swift
//  FunctionalHttpNetwork
//
//  Created by Carlos Vicente on 10/1/18.
//  Copyright © 2018 cmvicentehe. All rights reserved.
//

import Foundation

typealias Task<Input> = (DispatchQueue, DispatchGroup, @escaping(Input) -> ()) -> ()

struct Future<Input>  {
    let task: Task<Input>
    
    /******************************* ASYNC *******************************/
    static func async(_ function: @autoclosure @escaping () -> Input) -> Future<Input> {
        let task: Task<Input> = { (queue, _, continuation) in
            queue.async {
                continuation(function())
            }
        }

        return Future(task: task)
    }
    
    func runAsync(_ queue: DispatchQueue = DispatchQueue.global(), _ group: DispatchGroup = DispatchGroup(), _ continuation: @escaping (Input) -> ()) {
        self.task(queue, group, continuation)
    }
    
    /******************************* SYNC *******************************/
    static func sync(_ function: @autoclosure @escaping () -> Input) -> Future<Input> {
        let task: Task<Input> = { (_ , _, continuation) in
            continuation(function())
        }
        
        return Future(task: task)
    }
    
    func runSync() -> Input? {
        let queue: DispatchQueue = DispatchQueue.global()
        let group: DispatchGroup = DispatchGroup()
        var inputResult: Input? = nil
        
        self.task(queue, group) { input in
            inputResult = input
        }
        
        group.wait()
        
        return inputResult
    }
    
    /******************************* FUNCTOR *******************************/
    func map<Output>(_ transform: @escaping (Input) -> Output) -> Future<Output> {
        return self.flatMap { input in
            let task: Task<Output> = { (queue, _, continuation) in
                continuation(transform(input))
            }
            return Future<Output>(task: task)
        }
    }
    
     /******************************* MONAD *******************************/
    func flatMap<Output>(_ transform: @escaping (Input) -> Future<Output>) -> Future<Output> {
        let task: Task<Output> = { (queue, group, continuation) in
            self.task(queue, group) { input in
                let future = transform(input)
                future.task(queue, group, continuation)
            }
        }
        
        return Future<Output>(task: task)
    }
    
     /******************************* APPLICATIVE *******************************/
    func pure(_ input: Input) -> Future<Input> {
        let task: Task<Input> = { (_, _, continuation) in
            continuation(input)
        }
        return Future<Input>(task: task)
    }
    
    func apply<Output>(_ future: Future<(Input) -> Output>) -> Future<Output> {
        let task: Task<Output> = { (queue, _, continuation) in
            var inputResult: Input? = nil
            var inputToOutputResult: ((Input) -> Output)? = nil
            let group: DispatchGroup = DispatchGroup()
            
            self.task(queue, group) { input in
                inputResult = input
            }
            future.task(queue, group) { inputToOutput in
                inputToOutputResult = inputToOutput
            }
            
            if let inputToOutputNotnil = inputToOutputResult,
                let inputNotNil = inputResult  {
                continuation(inputToOutputNotnil(inputNotNil))
                group.wait()
            }
        }
        
        return Future<Output>(task: task)
    }
    
}
