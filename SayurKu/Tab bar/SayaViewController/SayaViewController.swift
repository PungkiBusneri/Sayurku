//
//  SayaViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 05/12/23.
//

import UIKit

class SayaViewController: UIViewController {
    @IBOutlet var profilView: UIView!
    @IBOutlet var profileSetting: UIButton!
    @IBOutlet var addresUiView: UIView!
    @IBOutlet var addresLabel: UILabel!
    @IBOutlet var tableviewSetting: UITableView!
    @IBOutlet var tableViewReward: UITableView!
    @IBOutlet var exitButton: UIButton!
    
    
    private var cellIdentifier = "SayaTableViewCell"
    private var imageNameSetting = ["globe", "bell", "key", "card"]
    private var imageNameReward = ["Discount Voucher", "Free Dilevery", "Add Friends"]
    private var settingData = [
        Setting(nameSetting: "Bahasa", imageNameSetting: "globe"),
        Setting(nameSetting: "Notifikasi", imageNameSetting: "bell"),
        Setting(nameSetting: "Ganti Kata Sandi", imageNameSetting: "key"),
        Setting(nameSetting: "Akun Pembayaran", imageNameSetting: "card")
    ]
    
    private var rewardData = [
        Reward(NameReward: "Voucher Diskon", imageNameReward: "Discount Voucher"),
        Reward(NameReward: "Express Delivery", imageNameReward: "Free Dilevery"),
        Reward(NameReward: "Add Friends", imageNameReward: "Add Friends")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBottomCurve()
        setupComponent()
        tableviewSetting.delegate = self
        tableviewSetting.dataSource = self
        tableViewReward.delegate = self
        tableViewReward.dataSource = self
        tableviewSetting.register(UINib(nibName: "SayaTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableViewReward.register(UINib(nibName: "SayaTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customizeBottomCurve()
        
    }
    
    func setupComponent() {
        addresUiView.layer.cornerRadius = 15.0
    }
    
    func customizeBottomCurve() {
        let cornerRadius: CGFloat = 40.0
        
        let maskPath = UIBezierPath(
            roundedRect: profilView.bounds,
            byRoundingCorners: [.bottomLeft, .bottomRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )

        let maskLayer = CAShapeLayer()
        maskLayer.frame = profilView.bounds
        maskLayer.path = maskPath.cgPath

        profilView.layer.mask = maskLayer

        profilView.layoutIfNeeded()
    }

    
    @IBAction func exitButtonTapped(_ sender: Any) {
        showAlertExit()
    }
    func showAlertExit() {
        let alert = UIAlertController(title: .none, message: "Are you sure to LOGOUT?", preferredStyle: .alert)
        let exitAction = UIAlertAction(title: "YES", style: .default) { (action) in
            
            self.performExit()
        }
        
        let cancelAction = UIAlertAction(title: "NO", style: .cancel, handler: nil)
        
        alert.addAction(exitAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func performExit() {
        UserDefaults.standard.removeObject(forKey: "AuthToken")
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let welcomeVC = WelcomeViewController()
            let navigationController = UINavigationController(rootViewController: welcomeVC)
            sceneDelegate.window?.rootViewController = navigationController
        }
    }
}
extension SayaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableviewSetting {
            return settingData.count
        } else if tableView == tableViewReward {
            return rewardData.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SayaTableViewCell
        
        if tableView == tableviewSetting {
            let setting = settingData[indexPath.row]
            cell.labelCell.text = setting.nameSetting
            
            if indexPath.row < imageNameSetting.count {
                let imageName = imageNameSetting[indexPath.row]
                cell.imageViewCell.image = UIImage(named: imageName)
            } else {
                cell.imageViewCell.image = nil
            }
            
            cell.accessoryType = .disclosureIndicator
        } else if tableView == tableViewReward {
            let reward = rewardData[indexPath.row]
            cell.labelCell.text = reward.NameReward
            
            if indexPath.row < imageNameReward.count {
                let imageName = imageNameReward[indexPath.row]
                cell.imageViewCell.image = UIImage(named: imageName)
            } else {
                cell.imageViewCell.image = nil
            }
            
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
}
