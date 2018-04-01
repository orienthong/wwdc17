//
//  Queue.swift
//  MazeGame
//
//  Created by Hao Dong on 28/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import Foundation


public struct Queue<T> {
    private var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func enqueue(element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public mutating func enqueue(elements: [T]) {
        for t in elements {
            array.append(t)
        }
    }
    public mutating func dequeueAll() {
        array.removeAll()
    }
    
    public func peek() -> T? {
        return array.first
    }
    public func getLast() -> T {
        return array.last!
    }
}
