//
//  TableViewCell.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: = Enums
    private enum ConstantsForCell {
        static let leadingInsetForCell = 4.0
        static let trailingInsetForCell = -4.0
        static let topInsetForCell = 2.0
        static let bottomInsetForCell = -2.0
        static let topInsetForNameLabel = 8.0
        static let leadingInset = 16.0
        static let trailingInset = -16.0
        static let topInset = 5.0
    }
    // MARK: - Properties
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()

    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    private let skillsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        label.numberOfLines = 0
        return label
    }()

    private var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.systemGray2.cgColor
        view.layer.borderWidth = 0.3
        view.layer.cornerRadius = 12
        return view
     }()

    // MARK: - Override init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCellView()
        configureNameLabel()
        configurePhoneNumberLabel()
        configureSkillsLabel()
    }

    // MARK: - Required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    func fillData(for employee: Employee) {
        nameLabel.text = "Name: " + employee.name
        phoneNumberLabel.text = "Phone: " + employee.phoneNumber
        skillsLabel.text = "Skills: " + employee.skills.joined(separator: ", ")
    }

    private func configureCellView() {
        contentView.addSubview(cellView)

        let leadingConstraint = cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                                  constant: ConstantsForCell.leadingInsetForCell)
        let trailingConstraint = cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                                    constant: ConstantsForCell.trailingInsetForCell)
        let topConstraint = cellView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                          constant: ConstantsForCell.topInsetForCell)
        let bottomConstraint = cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                                constant: ConstantsForCell.bottomInsetForCell)
        addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }

    private func configureNameLabel() {
        contentView.addSubview(nameLabel)

        let leadingConstraint = nameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor,
                                                                   constant: ConstantsForCell.leadingInset)
        let trailingConstraint = nameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor,
                                                                     constant: ConstantsForCell.trailingInset)
        let topConstraint = nameLabel.topAnchor.constraint(equalTo: cellView.topAnchor,
                                                          constant: ConstantsForCell.topInsetForNameLabel)

        addConstraints([leadingConstraint, trailingConstraint, topConstraint])
    }

    private func configurePhoneNumberLabel() {
        contentView.addSubview(phoneNumberLabel)

        let leadingConstraint = phoneNumberLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor,
                                                                  constant: ConstantsForCell.leadingInset)
        let trailingConstraint = phoneNumberLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor,
                                                                    constant: ConstantsForCell.trailingInset)
        let topConstraint = phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                                                  constant: ConstantsForCell.topInset)

        addConstraints([leadingConstraint, trailingConstraint, topConstraint])
    }

    private func configureSkillsLabel() {
        contentView.addSubview(skillsLabel)

        let leadingConstraint = skillsLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor,
                                                                  constant: ConstantsForCell.leadingInset)
        let trailingConstraint = skillsLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor,
                                                                    constant: ConstantsForCell.trailingInset)
        let topConstraint = skillsLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor,
                                                          constant: ConstantsForCell.topInset)

        addConstraints([leadingConstraint, trailingConstraint, topConstraint])
    }

}

