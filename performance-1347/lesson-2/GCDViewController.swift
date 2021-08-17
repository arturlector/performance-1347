//
//  GCDViewController.swift
//  performance-1347
//
//  Created by Artur Igberdin on 17.08.2021.
//

import UIKit
import CoreImage

class GCDViewController: UITableViewController {

    let elements:[String] = []
    
    var images = [
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!,
            UIImage(named: "treeSmall")!
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurImages()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        //testGlobalAsync()
        
        //testMainAsync()
        
        //testGlobalAsyncHello()
    }
    
    func blurImages() {
            var bluredImages = images
            let dispatchGroup = DispatchGroup()
            
            for element in bluredImages.enumerated() {
                
                DispatchQueue.global().async(group: dispatchGroup) {
                    
                    sleep(1)
                    let inputImage = element.element
                    let inputCIImage = CIImage(image: inputImage)!
                    
                    
                    let blurFilter = CIFilter(name: "CIGaussianBlur", parameters: [kCIInputImageKey: inputCIImage])!
                    let outputImage = blurFilter.outputImage!
                    let context = CIContext()
                    
                    let cgiImage = context.createCGImage(outputImage, from: outputImage.extent)
                    
                    bluredImages[element.offset] = UIImage(cgImage: cgiImage!)
                }
                
                dispatchGroup.notify(queue: DispatchQueue.main) {
                    self.images = bluredImages
                    self.tableView.reloadData()
                }
            }
    }
    
    func testGlobalAsyncHello() {
        DispatchQueue.global().async { print("H") }
        DispatchQueue.global().async { print("e") }
        DispatchQueue.global().async { print("l") }
        DispatchQueue.global().async { print("l") }
        DispatchQueue.global().async { print("o") }
    }
    
    func testMainAsync() {
        DispatchQueue.main.async { print("H") }
        DispatchQueue.main.async { print("e") }
        DispatchQueue.main.async { print("l") }
        DispatchQueue.main.async { print("l") }
        DispatchQueue.main.async { print("o") }
    }
    
    func testGlobalAsync() {
        
        //Параллельная очередь
        DispatchQueue.global(qos: .userInteractive).async {
            for _ in (0..<100) {
                    print("😇")
                }
        }
        
        //Последовательная
        DispatchQueue.main.async {
            for _ in (0..<100) {
                print("😈")
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            for _ in (0..<100) {
                print("👻")
            }
        }

        DispatchQueue.global(qos: .utility).async {
            for _ in (0..<100) {
                print("👽")
            }
        }
        
    }

    @IBAction func startAction(_ sender: Any) {
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let image = images[indexPath.row]
        cell.imageView?.image = image
        
        return cell
    }
    

}
