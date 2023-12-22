//
//  SayurViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 06/12/23.
//

import UIKit

class SayurViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var shoppingChart: UIButton!
    @IBOutlet var searchProductButton: UITextField!
    @IBOutlet var productCollection: UICollectionView!
    
    private var cellIdentifier = "SayurCollectionViewCell"
    
    private var sayurData = ["Bokcoy", "Bayam", "Rebung", "Kangkung", "Sawi", "Kubis", "Wortel", "Mentimun", "Cabe Keriting", "Cabe Setan", "Bawang Merah", "Bawang Putih", "Tomat", "Bawang Bombay"]
    
    private var gambarSayur: [String: String] = [
        "Bokcoy": "Bokcoy 1",
        "Bayam": "Bayam",
        "Rebung": "Rebung",
        "Kangkung": "Kangkung",
        "Sawi": "Sawi",
        "Kubis": "Kubis",
        "Wortel": "Wortel",
        "Tomat": "Tomat",
        "Cabe Keriting": "Cabe Keriting",
        "Cabe Setan": "Cabe Setan",
        "Bawang Putih": "Bawang Putih",
        "Bawang Merah": "Bawang Merah",
        "Mentimun": "Mentimun",
        "Bawang Bombay": "Bawang Bombay"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        productCollection.dataSource = self
        productCollection.delegate  = self
        
        productCollection.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        searchProductButton.delegate = self
        searchProductButton.attributedPlaceholder = NSAttributedString(
            string: "Cari Sayurnya Disini",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sayurData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SayurCollectionViewCell
        
        cell.backgroundColor = .greenWelcome
        cell.layer.cornerRadius = 10.0
        
        let kategoriIndex = min(indexPath.item, sayurData.count - 1)
        if let namaGambar = gambarSayur[sayurData[kategoriIndex]] {
            cell.sayurImage.image = UIImage(named: namaGambar)
            }
        
        cell.sayurNameLabel.text = sayurData[indexPath.item]
        
        return cell
    }
}

extension SayurViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let searchKeywords = newText.lowercased().components(separatedBy: " ")
        
        if searchKeywords.isEmpty {
            updateSayurList(sayurData)
            
        } else {
            
            let filteredProduct = sayurData.filter { sayur in
                
                return searchKeywords.allSatisfy { keyword in
                    
                    return sayur.lowercased().contains(keyword)
                    
                }
            }
            
            updateSayurList(filteredProduct)
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        updateSayurList(sayurData)
        return true
    }
    
    private func updateSayurList(_ newSayurList: [String]) {
        if newSayurList.isEmpty {
            
            sayurData = ["Bokcoy", "Bayam", "Rebung", "Kangkung", "Sawi", "Kubis", "Wortel", "Mentimun", "Cabe Keriting", "Cabe Setan", "Bawang Merah", "Bawang Putih", "Tomat", "Bawang Bombay"]
        } else {
            
            sayurData = newSayurList
        }
        productCollection.reloadData()
    }
}


