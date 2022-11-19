//
//  TableViewCell.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - Properties

    private var profileImage = UIImageView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()

    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Override init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(phoneNumberLabel)
        contentView.addSubview(skillsLabel)
        

        let widthConstraint = nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let heightConstraint = nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        addConstraints([widthConstraint, heightConstraint])
    }

    // MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    func fillData(for employee: Employee) {
        
        profileImage.image = UIImage()
        nameLabel.text = "Name: " + employee.name
        phoneNumberLabel.text = "Phone: " + employee.phoneNumber
        skillsLabel.text = "Skills: " + employee.skills.joined(separator: ", ")
    }
    
}
