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
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()

    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.font = UIFont.systemFont(ofSize: 14)
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
    func fillDataForEmployee(employee: Employees, indexPath: IndexPath) {

        profileImage.image = UIImage()

        nameLabel.text = employee.employees[indexPath.row].name

        phoneNumberLabel.text = "Phone: " + employee.employees[indexPath.row].phoneNumber

        skillsLabel.text = "Skills: " + employee.employees[indexPath.row].skills.joined(separator: ", ")
    }

}
