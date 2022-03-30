//
//  CoctailViewCell.swift
//  Cocktails
//
//  Created by Roman Zhukov on 30.03.2022.
//

import UIKit

class CoctailViewCell: UICollectionViewCell {
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super .init(frame: .zero)

        contentView.addSubview(nameLabel)

        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
