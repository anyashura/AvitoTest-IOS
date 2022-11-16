//
//  TableViewCell.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Properties
//    var employee: Employee {
//        didSet {
//            nameLabel.text = employee.name
//            phoneNumberLabel.text = employee.phoneNumber
//            skillsLabel.text = employee.skills.joined(separator: ", ")
//        }
//    }
    var profileImage = UIImageView()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Override init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        addSubview(phoneNumberLabel)
        addSubview(skillsLabel)
        

    }
    
    // MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    func fillDataForEmployee(employee: Employee) {
        profileImage.image = UIImage()
        
        nameLabel.text = employee.name

        phoneNumberLabel.text = "Phone: " + employee.phoneNumber

        skillsLabel.text = "Skills: " + employee.skills.joined(separator: ", ")
    }
    



}
