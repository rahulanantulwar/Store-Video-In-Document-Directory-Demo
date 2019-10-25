//
//  ViewController.swift
//  StoreVideoIntoDocumentDirectory
//
//  Created by Rahul Anantulwar on 10/4/18.
//  Copyright © 2018 Rahul Anantulwar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                self.downloadVideo()
            }
        }
    }

    private func downloadVideo() {
        
        let videoWebURL =  "https://www.sample-videos.com/index.php#sample-mp4-video/SampleVideo_640x360_30mb.mp4"
        /* Sample URL's*/
        /*  "https://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4"
            "https://www.sample-videos.com/index.php#sample-mp4-video/SampleVideo_640x360_30mb.mp4"
         */
        
        // getting document directory path
        let documentPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        print(documentPath)
        
        // converting String(videoWebURL) into URL to process
        let videoURL = URL(string: videoWebURL)

        // load video data from URL
       // let videoData = NSData(contentsOf: videoURL!)
        
        // Append video file name
        let dataPath = documentPath.appendingPathComponent("/videos1.mp4")
        print(dataPath)
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        let request = URLRequest(url:videoURL!)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: dataPath)
                } catch (let writeError) {
                    print("Error creating a file \(dataPath) : \(writeError)")
                }
                
            } else {
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any);
            }
        }
        task.resume()
        
        
/***********
//        // Append video file name
//        let dataPath = documentPath.appendingPathComponent("/rahul19.mp4")
//        print(dataPath)
//
//        // *** Write video file data to path *** //
//        videoData?.write(to: dataPath, atomically: true)
        
 *********/
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

