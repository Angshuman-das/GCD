//: [Previous](@previous)

import Foundation

/*
 Task can also be cancelled using GCD via DispatchWorkItem
 */

struct Example {
    
    func printNumber() {
        var workItem : DispatchWorkItem?
        
        workItem = DispatchWorkItem(block: {
            for i in 1..<10 {
                
                guard let workItem, !workItem.isCancelled else {
                    debugPrint("Work item is cancelled")
                    return
                }
                
                debugPrint("\(i)")
                sleep(1)
            }
        })
        
        workItem?.notify(queue: .main, execute: {
            debugPrint("Done printing numbers")
        })
        
        let queue = DispatchQueue.global(qos: .utility)
         
         queue.async(execute: workItem!)
        
        queue.asyncAfter(deadline: .now() + .seconds(3), execute: {
            workItem?.cancel()
        })
    }
    
    func myDispatchWorkItem() {
        var number : Int = 15
        
        let workItem = DispatchWorkItem {
            number += 5
        }
        
        
        workItem.notify(queue: .main, execute: {
            debugPrint("Increamenting number completed new value = \(number)")
        })
        
       let queue = DispatchQueue.global(qos: .utility)
        
        queue.async(execute: workItem)
        
        queue.asyncAfter(deadline: .now() + .seconds(3), execute: {
            workItem.cancel()
        })
    }
}

let obj = Example()
obj.printNumber()
