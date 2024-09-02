//: [Previous](@previous)

import Foundation

/*
struct Example {
    func doWork() {
        
        let blockOperation = BlockOperation()
        blockOperation.qualityOfService = .utility
        
        blockOperation.addExecutionBlock {
            debugPrint("Hello")
        }
        
        blockOperation.addExecutionBlock {
            debugPrint("Hello 1")
        }
        
        blockOperation.addExecutionBlock {
            debugPrint("Hello 2")
        }
        
        let anotherblockOperation = BlockOperation()
        anotherblockOperation.qualityOfService = .utility
        
        blockOperation.addExecutionBlock {
            debugPrint("I am another block operation")
        }
        
//        blockOperation.start()
        
        let operationQueue = OperationQueue()
//        operationQueue.addOperation(blockOperation)
//        operationQueue.addOperation(anotherblockOperation)
        
        operationQueue.addOperations([blockOperation, anotherblockOperation], waitUntilFinished: false)
        
        

    }
}

let obj = Example()
obj.doWork()
 */


struct Employee {
    func syncOfflineEmpoyeeRecords() {
        debugPrint("Sync for employee started")
        Thread.sleep(forTimeInterval: 2)
        debugPrint("Sync Completed employee")
    }
}

struct Department {
    func syncOfflineDepartmentRecords() {
        debugPrint("Sync for department started")
        Thread.sleep(forTimeInterval: 2)
        debugPrint("Sync Completed department")
    }
}


struct SyncManager {
    func syncOfflineRecords() {
        
//        let serielQueue = DispatchQueue(label: "angshuman.example")
//        
//        let empWorkItem = DispatchWorkItem {
//            let employee = Employee()
//            employee.syncOfflineEmpoyeeRecords()
//        }
//        
//        let departmentWorkItem = DispatchWorkItem {
//            let department = Department()
//            department.syncOfflineDepartmentRecords()
//        }
//        
//        serielQueue.async(execute: empWorkItem)
//        serielQueue.async(execute: departmentWorkItem)
        
/*
        let dispatchGroup = DispatchGroup()
        let serielQueue = DispatchQueue(label: "angshuman.example", attributes: .concurrent)
        
        let empWorkItem = DispatchWorkItem {
                   let employee = Employee()
                   employee.syncOfflineEmpoyeeRecords()
               }
       
               let departmentWorkItem = DispatchWorkItem {
                   let department = Department()
                   department.syncOfflineDepartmentRecords()
               }
        
        serielQueue.async(group: dispatchGroup, execute: empWorkItem)
        serielQueue.async(group: dispatchGroup, execute: departmentWorkItem)
        
        dispatchGroup.notify(queue: .main) {
            print("All tasks are executed")
        }
*/
        
        
        let employeeSyncOperation = BlockOperation()
        employeeSyncOperation.addExecutionBlock {
            let employee = Employee()
            employee.syncOfflineEmpoyeeRecords()
        }
        
        let departmentSyncOperation = BlockOperation()
        departmentSyncOperation.addExecutionBlock {
            let department = Department()
            department.syncOfflineDepartmentRecords()
        }
        
        departmentSyncOperation.addDependency(employeeSyncOperation)
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(employeeSyncOperation)
        operationQueue.addOperation(departmentSyncOperation)
         
        
    }
}

let syncObj = SyncManager()
syncObj.syncOfflineRecords()
