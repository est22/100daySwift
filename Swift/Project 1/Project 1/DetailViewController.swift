//
//  DetailViewController.swift
//  Project 1
//
//  Created by Lia AN on 2022/03/01.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var selectedPictureNumber = 0
    var totalPictures = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // title = selectedImage
        title = "Picture \(selectedPictureNumber) of \(totalPictures)"
        
        
        navigationItem.largeTitleDisplayMode = .never
        
        // 1. share - add right Bar Button item
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    // 2. add function shareTapped()
    @objc func shareTapped() {
        // 3. get image
        guard let image =  imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem // or else it will crash on iPad
        present(vc, animated: true)
    }

    

}
