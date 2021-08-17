//
//  ViewController.swift
//  performance-1347
//
//  Created by Artur Igberdin on 13.08.2021.
//

import UIKit

class ThreadprintDemon: Thread {
    override func main() {
        for _ in (0..<100) {
            //Thread.sleep(forTimeInterval: 1)
            print("😈")
        }
    }
}
class ThreadprintAngel: Thread {
    override func main() {
        for _ in (0..<100) {
            //Thread.sleep(forTimeInterval: 1)
            print("😇")
        }
    }
}





class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(RunLoop.current)
        
        print(UInt.max)  //18446744073709551615
        
//        print("start test")
//        for index in 0...UInt.max {
//            let string = NSString(format: "test + %d", index)
//            print(string)
//        }
//        print("end test")
        
//        print("start test")
//        for index in 0...UInt.max {
//            autoreleasepool {
//                let string = NSString(format: "test + %d", index)
//                print(string)
//            }
//        }
//        print("end test")
        
    }

    
    @IBAction func startAction(_ sender: Any) {
        
//        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
//            print(Date())
//        }
//
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//            sleep(1)
//        }
        
//        for _ in (0..<10) {
//          print("😈")
//        }
//
//        for _ in (0..<10) {
//            print("😇")
//        }
        
//        Thread.detachNewThread {
//            for _ in (0..<10) {
//            print("😈")
//            }
//        }
//
//        for _ in (0..<100) {
//            print("😇")
//        }
        
//        let thread1 = Thread {
//            for _ in (0..<10) {
//            print("😈")
//            }
//        }
//
//        thread1.start()
//
//        for _ in (0..<100) {
//            print("😇")
//        }
//
//        let thread1 = ThreadprintDemon()
//
//        thread1.start()
//
//        for _ in (0..<100) {
//            print("😇")
//        }
        
        let thread1 = ThreadprintDemon()
        let thread2 = ThreadprintAngel()
        
        thread1.qualityOfService = .utility
        thread2.qualityOfService = .userInteractive
                
        thread1.start()
        thread2.start()
        
        
    }
    
}

