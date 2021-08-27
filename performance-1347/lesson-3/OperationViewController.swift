//
//  OperationViewController.swift
//  performance-1347
//
//  Created by Artur Igberdin on 20.08.2021.
//

import UIKit

class OperationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        //fromBackgroundToMain()
        
        //concurrentOperationsByCount()
        
        //dependencyOperations()
        
        controlOperation()
    }
    
    func controlOperation() {
        
        let queue = OperationQueue()
        
        queue.qualityOfService = .background
        
        queue.maxConcurrentOperationCount = 1
        
        queue.isSuspended = true
        queue.isSuspended = false
        
        queue.cancelAllOperations()
    }
    
    func dependencyOperations() {
        
        let myQueue = OperationQueue()
        
        let operation1 = BlockOperation() {
            for i in 0..<10 {
                print("🤠\(i)")
            }
            self.printCurrentThread()
        }
        
        let operation2 = BlockOperation() {
            for i in 0..<10 {
                print("🥶\(i)")
            }
            self.printCurrentThread()
        }
        
        let operation3 = BlockOperation() {
            for i in 0..<10 {
                print("🤡\(i)")
            }
            self.printCurrentThread()
        }
        
        let completionOperation = BlockOperation() {
            print("All operations completed!")
        }
        
        completionOperation.addDependency(operation1)
        completionOperation.addDependency(operation2)
        completionOperation.addDependency(operation3)
        
        let operations = [
            completionOperation,
            operation1,
            operation2,
            operation3,
        ]
        
        myQueue.addOperations(operations, waitUntilFinished: false)
        
    }
    
    func concurrentOperationsByCount() {
        
        let myQueue = OperationQueue()
        myQueue.maxConcurrentOperationCount = 1
        
        myQueue.addOperation { [weak self] in
            for i in 0..<10 {
                print("🤠\(i)")
            }
            self?.printCurrentThread()
        }
        
        myQueue.addOperation {
            for i in 0..<10 {
                print("🥶\(i)")
            }
            self.printCurrentThread()
        }
        
        myQueue.addOperation {
            for i in 0..<10 {
                print("🤡\(i)")
            }
            self.printCurrentThread()
        }
    }
    
    func fromBackgroundToMain() {
        
        let queue = OperationQueue()
        
        queue.addOperation {
            print("1")
            self.printCurrentThread()
            
            OperationQueue.main.addOperation {
                print("This is main thread")
                self.printCurrentThread()
            }
        }
    }
    
    //Дебажить треды
    func printCurrentThread() {
        print("Is main Thread: \(Thread.isMainThread)")
        print(Thread.current)
    }

}
