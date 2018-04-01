//
//  GameHelper.swift
//  MazeGame
//
//  Created by Hao Dong on 30/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import Foundation
import SceneKit
class GameHelper {
    
    enum GameState {
        case tapToBegin
        case began
    }
    var state: GameState = .began
    struct Node {
        var location: Location
        var directions: [Direction]
    }
    func Check(with matrix: [[Int]], startPoint: Location, endPoint: Location) -> Queue<[Direction]>? {
        //if matrix[0].count != matrix.count { return false }
        let numOfZ = matrix.count - 1
        let numOfX = matrix[0].count - 1
        let startNode = Node(location: startPoint, directions: [])
        let endNode = Node(location: endPoint, directions: [])
        var queue = Queue<Node>()
        var directionQueue = Queue<[Direction]>()
        directionQueue.enqueue(element: [])
        //directionQueue.enqueue(element: <#T##[Direction]#>)
        var step = Array(repeating: Array(repeating: 0, count: numOfX+1), count: numOfZ+1)
        queue.enqueue(element: startNode)
        func check(with location: Location) -> Bool {
            if location == endNode.location {
                return true
            }
            return false
        }
        while !queue.isEmpty {
            let node = queue.dequeue()!
            step[node.location.z][node.location.x] = 1
            let currentLocation = node.location
            let right = Location(z: currentLocation.z, x: currentLocation.x+1)
            let left = Location(z: currentLocation.z, x: currentLocation.x-1)
            let forWard = Location(z: currentLocation.z-1, x: currentLocation.x)
            let back = Location(z: currentLocation.z+1, x: currentLocation.x)
            
            //check left
            if left.x >= 0 {
                if matrix[left.z][left.x] == 0 && step[left.z][left.x] == 0 { //enqueue
                    var nodeDir = node.directions
                    nodeDir.append(.left)
                    let newNode = Node(location: left, directions: nodeDir)
                    queue.enqueue(element: newNode)
                    directionQueue.enqueue(element: newNode.directions)
                    if check(with: left) {
                        //print(nodeDir)
                        //print(directionQueue)
                        return directionQueue
                    }
                }
            }
            //check right
            if right.x <= numOfX {
                if matrix[right.z][right.x] == 0 && step[right.z][right.x] == 0 {
                    var nodeDir = node.directions
                    nodeDir.append(.right)
                    let newNode = Node(location: right, directions: nodeDir)
                    queue.enqueue(element: newNode)
                    directionQueue.enqueue(element: newNode.directions)
                    if check(with: right) {
                        //print(nodeDir)
                        //print(directionQueue)
                        return directionQueue
                    }
                }
            }
            //check up
            if forWard.z >= 0 {
                if matrix[forWard.z][forWard.x] == 0 && step[forWard.z][forWard.x] == 0 {
                    var nodeDir = node.directions
                    nodeDir.append(.forward)
                    let newNode = Node(location: forWard, directions: nodeDir)
                    queue.enqueue(element: newNode)
                    directionQueue.enqueue(element: newNode.directions)
                    if check(with: forWard) {
                        //print(nodeDir)
                        //print(directionQueue)
                        return directionQueue
                    }
                }
            }
            //check down
            if back.z <= numOfZ {
                if matrix[back.z][back.x] == 0 && step[back.z][back.x] == 0 {
                    var nodeDir = node.directions
                    nodeDir.append(.backward)
                    let newNode = Node(location: back, directions: nodeDir)
                    queue.enqueue(element: newNode)
                    directionQueue.enqueue(element: newNode.directions)
                    if check(with: back) {
                        //print(nodeDir)
                        //print(directionQueue)
                        return directionQueue
                    }
                }
            }
        }
        return nil
    }
    private func switchDirection(direction: Direction) -> Direction {
        switch direction {
        case .forward:
            return .backward
        case .backward:
            return .forward
        case .left:
            return .right
        case .right:
            return .left
        }
    }
    func getAnimationQueue(with queue: Queue<[Direction]>) -> Queue<[Direction]> {
        var animationQueue = Queue<[Direction]>()
        var directionsQueue = queue
        var preDirection = directionsQueue.dequeue()!
        while !directionsQueue.isEmpty {
            let direction = directionsQueue.dequeue()!
            var array = [Direction]()
            var flag = 0
            if preDirection.count == 0 {
                let dir = direction[0]
                animationQueue.enqueue(element: [dir])
            } else {
                for i in 0 ... preDirection.count-1 {
                    if preDirection[i] == direction[i] { flag += 1 }
                }
                if preDirection.count != flag {
                    var i = preDirection.count-1
                    while i > flag-1 {
                        let dir = switchDirection(direction: preDirection[i])
                        array.append(dir)
                        i-=1;
                    }
                    for j in flag ... direction.count-1 {
                        let dir = direction[j]
                        array.append(dir)
                    }
                } else {
                    array.append(direction.last!)
                }
                animationQueue.enqueue(element: array)
            }
            preDirection = direction
        }
        print("animationQueue\(animationQueue)")
        return animationQueue
    }
    private func getAction(with direction: Direction, duraction: TimeInterval) -> SCNAction {
        switch direction {
        case .forward:
            return SCNAction.moveBy(x: 0, y: 0, z: -1, duration: duraction)
        case .left:
            return SCNAction.moveBy(x: -1, y: 0, z: 0, duration: duraction)
        case .backward:
            return SCNAction.moveBy(x: 0, y: 0, z: 1, duration: duraction)
        case .right:
            return SCNAction.moveBy(x: 1, y: 0, z: 0, duration: duraction)
        }
    }
    func getActions(with directions: [Direction]) -> SCNAction {
        var actions = [SCNAction]()
        var backDirections = [Direction]()
        var backActions = [SCNAction]()
        for direction in directions {
            let action = getAction(with: direction, duraction: 0.5)
            actions.append(action)
            let backDirection = switchDirection(direction: direction)
            backDirections.append(backDirection)
        }
        backDirections = backDirections.reversed()
        for direction in backDirections {
            let action = getAction(with: direction, duraction: 0.5)
            backActions.append(action)
        }
        let action = SCNAction.sequence(actions)
        let backAction = SCNAction.sequence(backActions)
        return SCNAction.sequence([action, backAction])
    }
    
    func reverseAll(directions: Queue<[Direction]>) -> Queue<[Direction]> {
        var _directions = directions
        var reverseQueue = Queue<[Direction]>()
        while !_directions.isEmpty {
            let dirs = _directions.dequeue()!.reversed()
            var arr = [Direction]()
            for dir in dirs {
                arr.append(switchDirection(direction: dir))
            }
            reverseQueue.enqueue(element: arr)
        }
        return reverseQueue
    }
    
    func getActions(form queue: Queue<[Direction]>) -> [SCNAction] {
        var animationsQueue = queue
        var animationArrs = [SCNAction]()
        while !animationsQueue.isEmpty {
            let directions = animationsQueue.dequeue()!
            let duraction: TimeInterval = TimeInterval(1.0/CGFloat(directions.count))
            var arr = [SCNAction]()
            for direction in directions {
                let action = getAction(with: direction, duraction: duraction)
                arr.append(action)
            }
            let a = SCNAction.sequence(arr)
            animationArrs.append(a)
        }
        return animationArrs
    }
    func getSequenceActions(from queue: Queue<[Direction]>) -> SCNAction {
        var animationsQueue = queue
        var animationArrs = [SCNAction]()
        while !animationsQueue.isEmpty {
            let directions = animationsQueue.dequeue()!
            let duraction: TimeInterval = TimeInterval(1.0/CGFloat(directions.count))
            var arr = [SCNAction]()
            //            directions.reversed()
            for direction in directions {
                let action = getAction(with: direction, duraction: duraction)
                arr.append(action)
            }
            let a = SCNAction.sequence(arr)
            animationArrs.append(a)
        }
        return SCNAction.sequence(animationArrs)
    }
    
    
}

