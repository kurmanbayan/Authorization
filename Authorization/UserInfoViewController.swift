//
//  UserInfoViewController.swift
//  Authorization
//
//  Created by Kurnmanbay Ayan on 6/27/17.
//  Copyright © 2017 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import SDWebImage

class UserInfoViewController: UIViewController {

    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userEmailLabel: UILabel!
   
    
    @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer) {
        getFullScreenImage(sender)
    }
    
    var user = Storage.user! {
        didSet {
            updateUI()
        }
    }
    
    private func changeImageViewStyle() {
        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2;
        self.userImageView.clipsToBounds = true;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeImageViewStyle()
        updateUI()
        loadImageAsync(url: user.imageUrl)
    }
    
    private func loadImageAsync(url: String) {
        userImageView.sd_setShowActivityIndicatorView(true)
        userImageView.sd_setIndicatorStyle(.gray)
        userImageView.sd_setImage(with: URL(string: user.imageUrl))
    }
    
    private func updateUI() {
        userNameLabel?.text = user.fullName
        userEmailLabel?.text = user.email
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBAction func logOutButton(_ sender: UIButton) {
        Storage.user = nil
        appDelegate.storageCheck()
    }
    
    private func getFullScreenImage(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = UIColor.black.withAlphaComponent(0.98)
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
}
