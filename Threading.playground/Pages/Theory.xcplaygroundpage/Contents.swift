import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: Seriel Queue
/*
 (A -> B -> C -> D)
 
1. Executes task one after another
2. Makes sure one task is 100 % completed and then begins the next task
3. Use when order of task execution matters
 */


// MARK: Concurrent Queue
/*
 A ->
 B ->
 C ->
 D ->
 
1. Unpredictable order of execution
2. Faster because thers's no waiting and all task run at same time.
3. Task B doesn't have to wait for Task A to complete.
4. User when order of task execution doen't matter
 */

// MARK: Race condition
/*
 Race condition occurs in a multi threaded environment when more than one thread try to access a shared resource (modify, write) at the same time.
 
 FYI:
    It is safe if multiple threads are trying to READ a shared resource as long as they are not trying to change it.
 
 One way to fix race condition is NSLock.
 */

var accountBalance = 5000

let lock = NSLock()

struct Bank {
    let withdrawnMethod: String
    
    func doTransaction(amount: Int) {
        
        lock.lock()
        if accountBalance > amount {
            debugPrint("\(self.withdrawnMethod): Balance is sufficient, proceeding to transaction")
            
            Thread.sleep(forTimeInterval: .random(in: 0...4))
            
            accountBalance -= amount
            
            debugPrint("\(self.withdrawnMethod): Done: \(amount) has be withdrawed")
            debugPrint("\(self.withdrawnMethod): Current balance is \(accountBalance)")
        } else {
            debugPrint("\(self.withdrawnMethod): Can't withdrawn: insuffient balance")
        }
        
        lock.unlock()
    }
}

let queue = DispatchQueue(label: "WithdrawlQueue", attributes: .concurrent)

queue.async {
    let netbankingInterface = Bank(withdrawnMethod: "Netbanking")
    netbankingInterface.doTransaction(amount: 3000)
}

queue.async {
    let atmInterface = Bank(withdrawnMethod: "Bank ATM")
    atmInterface.doTransaction(amount: 4000)
}
