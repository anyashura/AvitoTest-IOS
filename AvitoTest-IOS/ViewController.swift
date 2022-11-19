//
//  ViewController.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties

    let network = NetworkManager(memoryCapacity: Constants.memoryCapacity, diskCapacity: Constants.diskCapacity, diskPath: Constants.diskPath)
    var employees = [Employee]()
    var companyName = ""

    private lazy var table: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTable()
        // start loader
        network.getData(dataURL: URL(string: Constants.urlString)!) { [weak self] result in
            guard let self = self else { return }
            // stop loader
            switch result {
            case let .success(company):
                self.companyName = company.name
                self.employees = company.employees.sorted(by: { $0.name < $1.name })
                self.table.reloadData()
            case let .failure(error):
                // error
                break
            }
        }
        
    }

    // MARK: - Actions
    private func registerTable() {

        table.register(TableViewCell.self, forCellReuseIdentifier: Constants.cellID)
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = table.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = table.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = table.widthAnchor.constraint(equalToConstant: view.bounds.width)
        let heightConstraint = table.heightAnchor.constraint(equalToConstant: view.bounds.height)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

        self.table.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return "Company: \(companyName)"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as! TableViewCell
        cell.fillData(for: employees[indexPath.row])

        return cell
    }


}

extension ViewController: UITableViewDelegate { }
