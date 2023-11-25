//
//  VenueTableViewCell.swift
//  VanueApp
//
//  Created by Nitin Jain on 25/11/23.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = UILabel()
    private let subTitleLabel: UILabel = UILabel()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setUpConstraints()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        subTitleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor.black
        subTitleLabel.textColor = UIColor.lightGray
        subTitleLabel.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subTitleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    func setDataOnCell(model: VenueCellModel) {
        self.titleLabel.text = model.title
        self.subTitleLabel.text = model.subTitle
    }
}
