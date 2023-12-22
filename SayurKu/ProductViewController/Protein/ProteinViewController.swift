//
//  ProteinViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 06/12/23.
//

import UIKit

class ProteinViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var shoppingChart: UIButton!
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var proteinCollection: UICollectionView!
    
    private var cellIdentifier = "ProteinCollectionViewCell"
    private var proteinData = ["Telur Ayam", "Telur Bebek", "Telur Puyuh", "Tempe", "Tahu Putih", "Tahu Kuning", "Kacang Tanah", "Kacang Kedelai"]
    private var proteinImage: [String: String] = [
        "Telur Ayam": "Telur Ayam",
        "Telur Bebek": "Telur Bebek",
        "Telur Puyuh": "Telur Puyuh",
        "Tempe": "Tempe",
        "Tahu Putih": "Tahu Putih",
        "Tahu Kuning": "Tahu Kuning",
        "Kacang Tanah": "Kacang tanah",
        "Kacang Kedelai": "Kacang Kedelai"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        proteinCollection.dataSource = self
        proteinCollection.delegate = self
        proteinCollection.register(UINib(nibName: "ProteinCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        searchBar.delegate = self
        searchBar.attributedPlaceholder = NSAttributedString(
            string: "Lengkapi Proteinnya Disini",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return proteinData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = proteinCollection.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProteinCollectionViewCell
        
        cell.backgroundColor = .greenWelcome
        cell.layer.cornerRadius = 10.0
        
        let kategoryIndex = min(indexPath.item, proteinData.count - 1)
        
        if let namaGambar = proteinImage[proteinData[kategoryIndex]] {
            cell.proteinImage.image = UIImage(named: namaGambar)
        }
        cell.labelName.text = proteinData[indexPath.item]
        return cell
    }
}
extension ProteinViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let searchKeywords = newText.lowercased().components(separatedBy: " ")
        
        if searchKeywords.isEmpty {
            updateProteinList(proteinData)
            
        } else {
            
            let filteredProduct = proteinData.filter { sayur in
                
                return searchKeywords.allSatisfy { keyword in
                    
                    return sayur.lowercased().contains(keyword)
                    
                }
            }
            
            updateProteinList(filteredProduct)
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        updateProteinList(proteinData)
        return true
    }
    
    private func updateProteinList(_ newProteinList: [String]) {
        if newProteinList.isEmpty {
            
           proteinData = ["Telur Ayam", "Telur Bebek", "Telur Puyuh", "Tempe", "Tahu Putih", "Tahu Kuning", "Kacang Tanah", "Kacang Kedelai"]
        } else {
            
          proteinData = newProteinList
        }
        proteinCollection.reloadData()
    }
}
