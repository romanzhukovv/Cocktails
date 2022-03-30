//
//  CoctailsListViewController.swift
//  Cocktails
//
//  Created by Roman Zhukov on 30.03.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class CoctailsListViewController: UICollectionViewController {
    
    let textArray = ["hbdhwebhj", "behgwfhjewgbkfjbe", "hbhjs", "bdhsbfhegu", "gwdgyqwuguq", "dsfsdfsdf", "fs", "hbdhwebhj", "behgwfhjewgbkfjbe", "hbhjs", "bdhsbfhegu", "gwdgyqwuguq", "dsfsdfsdf", "fs"]

    let gradientLayer = CAGradientLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = CocktailsFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.collectionView.collectionViewLayout = layout
        
        collectionView.backgroundColor = .white
  
        self.collectionView!.register(CoctailViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }


    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        textArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CoctailViewCell
        let text = textArray[indexPath.item]
        cell.backgroundColor = .systemGray2
        cell.layer.cornerRadius = 10
        cell.nameLabel.text = text
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gradientLayer.frame = collectionView.cellForItem(at: indexPath)?.bounds ?? CGRect()
        gradientLayer.cornerRadius = 10
        gradientLayer.colors = [UIColor.systemRed.cgColor, UIColor.systemPurple.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        collectionView.cellForItem(at: indexPath)?.layer.insertSublayer(gradientLayer, at: 0)
    }
}

class Row {
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0

    init(spacing: CGFloat) {
        self.spacing = spacing
    }

    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }

    func tagLayout(collectionViewWidth: CGFloat) {
        let padding = 20
        var offset = padding
        for attribute in attributes {
            attribute.frame.origin.x = CGFloat(offset)
            offset += Int(attribute.frame.width + spacing)
        }
    }
}

class CocktailsFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var rows = [Row]()
        var currentRowY: CGFloat = -1

        for attribute in attributes {
            if currentRowY != attribute.frame.origin.y {
                currentRowY = attribute.frame.origin.y
                rows.append(Row(spacing: 8))
            }
            rows.last?.add(attribute: attribute)
        }

        rows.forEach {
            $0.tagLayout(collectionViewWidth: collectionView?.frame.width ?? 0)
        }
        return rows.flatMap { $0.attributes }
    }
}
