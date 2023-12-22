//
//  SeafoodViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 06/12/23.
//

import UIKit

class SeafoodViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var backButton: UIButton!
    @IBOutlet var shoppingChart: UIButton!
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var seafoodCollection: UICollectionView!
    
    private var cellIdentifier = "SeafoodCollectionViewCell"
    private var seafoodData = ["Lobster", "Udang", "Kepiting", "Cumi-cumi", "Gurita", "Kerang Hijau", "Sosis"]
    private var seafoodImage: [String: String] = [
        "Lobster": "Labster",
        "Udang": "Udang",
        "Kepiting": "Kepiting",
        "Cumi-cumi": "Cumi-cumi",
        "Gurita": "Gurita",
        "Kerang Hijau": "Kerang Hijau",
        "Sosis": "Sosis 1"
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        seafoodCollection.dataSource = self
        seafoodCollection.delegate = self
        seafoodCollection.register(UINib(nibName: "SeafoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        searchBar.delegate = self
        searchBar.attributedPlaceholder = NSAttributedString(
            string: "Cari Seafoodnya Disini",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seafoodData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = seafoodCollection.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SeafoodCollectionViewCell
        cell.backgroundColor = .pink
        cell.layer.cornerRadius = 10.0
        
        let kategoryIndex = min(indexPath.item, seafoodData.count - 1)
        
        if let namaGambar = seafoodImage[seafoodData[kategoryIndex]] {
            cell.seafoodImage.image = UIImage(named: namaGambar)
        }
        cell.labelName.text = seafoodData[indexPath.item]
        return cell
    }
}

extension SeafoodViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let searchKeywords = newText.lowercased().components(separatedBy: " ")
        
        if searchKeywords.isEmpty {
            updateSeafoodList(seafoodData)
            
        } else {
            
            let filteredProduct = seafoodData.filter { sayur in
                
                return searchKeywords.allSatisfy { keyword in
                    
                    return sayur.lowercased().contains(keyword)
                    
                }
            }
            
            updateSeafoodList(filteredProduct)
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        updateSeafoodList(seafoodData)
        return true
    }
    
    private func updateSeafoodList(_ newSeafoodList: [String]) {
        if newSeafoodList.isEmpty {
            
           seafoodData = ["Lobster", "Udang", "Kepiting", "Cumi-cumi", "Gurita", "Kerang Hijau", "Sosis"]
            
        } else {
            
          seafoodData = newSeafoodList
        }
        seafoodCollection.reloadData()
    }
}
