//: [Previous](@previous)

import Foundation

protocol Banking {
    func withdrawAmount(amount: Double) throws;
}

enum WithdrawlError: Error {
    case inSufficientBalance
}

var accountBalance: Double = 30000


struct ATM: Banking {
    func withdrawAmount(amount: Double) throws {
        debugPrint("inside ATM")
        
        guard accountBalance > amount else {
            throw WithdrawlError.inSufficientBalance
        }
        
        Thread.sleep(forTimeInterval: .random(in: 1...3))
        accountBalance -= amount
    }
    
    func printMessage() {
        debugPrint("ATM withdrawl successful, new balance = \(accountBalance)")
    }
}

struct Bank: Banking {
    func withdrawAmount(amount: Double) throws {
        debugPrint("inside Bank")
        
        guard accountBalance > amount else {
            throw WithdrawlError.inSufficientBalance
        }
        
        Thread.sleep(forTimeInterval: .random(in: 1...3))
        accountBalance -= amount
    }
    
    func printMessage() {
        debugPrint("Bank withdrawl successful, new balance = \(accountBalance)")
    }
}

let queue = DispatchQueue(label: "semaphoreDemo", qos: .utility, attributes: .concurrent)
let semaphore = DispatchSemaphore(value: 1)

queue.async {
    // Money withdrawl from ATM
    do {
        semaphore.wait()
        let atm = ATM()
        try atm.withdrawAmount(amount: 10000)
        atm.printMessage()
        semaphore.signal()
    } catch WithdrawlError.inSufficientBalance {
        semaphore.signal()
        debugPrint("ATM withdrawl failure, transaction cancelled")
    }
    catch {
        semaphore.signal()
        debugPrint("Error")
    }

}


queue.async {
    // Money withdrawl from Bank
    do {
        semaphore.wait()
        let bank = Bank()
        try bank.withdrawAmount(amount: 25000)
        bank.printMessage()
        semaphore.signal()
    } catch WithdrawlError.inSufficientBalance {
        semaphore.signal()
        debugPrint("bank withdrawl failure, transaction cancelled")
    }
    catch {
        semaphore.signal()
        debugPrint("Error")
    }
}

// Trade off of DispatchSwmaphore
/*
 1. Deadlock
 2. Priority Inversion
 */
