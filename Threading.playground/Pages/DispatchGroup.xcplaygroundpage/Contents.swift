//: [Previous](@previous)

import Foundation
import PlaygroundSupport

// MARK: Dispacth Group
/*
 let dispatchGroup = DispatchGroup()
 
 dispatchGroup.enter() -> I am going to start a task
 
 // your task
 
 dispatchGroup.leave() -> I have completed the given task
 */

/*
struct Department {
    var userId: Int
    var department: String
}

struct Employee {}

func getEmployee(userId: Int, completion: @escaping ([Employee])) {
    
    let webDepartment = Department(userId: userId, department: "web")
    let mobileDepartment = Department(userId: userId, department: "mobile")
    
    var employee = [Employee]()
    
    let dispatchGroup = DispatchGroup()
    
    // Task 1
    
    dispatchGroup.enter()
    getEmployee(department: webDepartment) { (result) in
        employee.append(result)
        dispatchGroup.leave()
    }
    
    dispatchGroup.enter()
    getEmployee(department: mobileDepartment) { (result) in
        employee.append(result)
        dispatchGroup.leave()
    }
    
    dispatchGroup.notify(queue: .main, work: {
        completion(employee)
    })
}

func getEmployee(department: Department, completion: @escaping (Employee?) -> Void) {
    
}
*/

struct Example {
    func work() {
        var arr = [String]()
        var startTime = Date()
        
        // nested closure
        callApiA { resultFromA in
            callApiB { resultFromB in
                callApiC { resultFromC in
                    arr.append(resultFromA)
                    arr.append(resultFromB)
                    arr.append(resultFromC)
                    debugPrint(Date().timeIntervalSince(startTime))
                }
            }
        }
        
        // dispatchGroup
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        callApiA { responseFromA in
            arr.append(responseFromA)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        callApiB { responseFromB in
            arr.append(responseFromB)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        callApiC { responseFromC in
            arr.append(responseFromC)
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            debugPrint(Date().timeIntervalSince(startTime))
        }
    }
    
    
    func callApiA(completion: @escaping(String)-> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: {
            completion("Data from A")
        })
    }
    
    func callApiB(completion: @escaping(String)-> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: {
            completion("Data from B")
        })
    }
    
    func callApiC(completion: @escaping(String)-> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1), execute: {
            completion("Data from C")
        })
    }
}

let obj = Example()
obj.work()

/*
 Dispatch group will execute all work in async fashion thatswhy it fasted than closure
 */
