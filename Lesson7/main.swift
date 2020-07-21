//
//  main.swift
//  Lesson7
//
//  Created by Feniks on 21.07.2020.
//  Copyright © 2020 Feniks. All rights reserved.
//

import Foundation

//обработка ошибок Error

enum queueError: Error {
    case blankQueue
    case longQueue
}

class Queue {
    var arrayCharacters = [String]()
    
    init(arrayCharacters: [String]) {
        self.arrayCharacters = arrayCharacters
    }
    
    func queueUp(_ character: String)  -> ([String], queueError?) {
        guard arrayCharacters.count < 5 else { //Обрабатываем ошибку, чтобы в очередь не вставали больше 5
            return(arrayCharacters, queueError.longQueue)
        }
        arrayCharacters.append(character)
        return (arrayCharacters, nil)
    }
    
    func queueOut() -> ([String], queueError?)  {
        guard arrayCharacters.count > 0 else { //Обрабатываем ошибку, если из очереди ничего нельзя удалить
            return(arrayCharacters, queueError.blankQueue)
        }
        arrayCharacters.removeFirst()
        return (arrayCharacters, nil)
    }
}

extension Queue: CustomStringConvertible {
    var description: String {
        
        return "\(arrayCharacters)"
    }
}

var letters = Queue (arrayCharacters: []) // создаем пустой массив и пытаемся убрать из очередь объект
var letModificationOut = letters.queueOut()
if let error = letModificationOut.1 {
    print("Произошла ошибка: \(error.self )")
} else {print(letters)}

letters = Queue (arrayCharacters:["a", "b", "c", "d", "e"])
let ModificationUp = letters.queueUp("f") // пытаемся добавить в очередь больше 5 объектов
if let error = ModificationUp.1 {
    print("Произошла ошибка: \(error.self )")
} else {print(letters)}


//Try/Catch
enum queueError1: Error {
    case blankQueue1
    case longQueue1
}

class Queue1 {
    var arrayCharacters1 = [String]()
    
    init(arrayCharacters1: [String]) {
        self.arrayCharacters1 = arrayCharacters1
    }
    
    func queueUp1(_ character: String) throws -> ([String]) {
        guard arrayCharacters1.count < 5 else { //Обрабатываем ошибку, чтобы в очередь не вставали больше 5
            throw queueError.longQueue
        }
        arrayCharacters1.append(character)
        return try arrayCharacters1
    }
    
    func queueOut1() throws  -> ([String])  {
        guard arrayCharacters1.count > 0 else { //Обрабатываем ошибку, если из очереди ничего нельзя удалить
            throw queueError.blankQueue
        }
        arrayCharacters1.removeFirst()
        return try arrayCharacters1
    }
}

extension Queue1: CustomStringConvertible {
    var description: String {
        
        return "\(arrayCharacters1)"
    }
}

var letters1 = Queue1 (arrayCharacters1: []) // создаем пустой массив и пытаемся убрать из очередь объект
do {
    let letModificationOut1 = try letters1.queueOut1()
    print(letters1)
} catch queueError.blankQueue {
    print("Произошла ошибка: из очереди ничего удалить нельзя, она пустая")
}

var letters2 = Queue1 (arrayCharacters1: ["a", "b", "c", "d", "e"]) // пытаемся добавить в очередь больше 5 объектов объект
do {
    let letModificationUp1 = try letters2.queueUp1("f")
    print(letters2)
} catch queueError.longQueue {
    print("Произошла ошибка: в очередь ничего нельзя добавить, максимальная ёмкость 5 объектов")
}
