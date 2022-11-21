//
//  ViewController.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties
    private let network: CacheRepositoryProtocol = NetworkManager(memoryCapacity: Constants.memoryCapacity, diskCapacity: Constants.diskCapacity, diskPath: Constants.diskPath)
    private let spinner = UIActivityIndicatorView(style: .large)
    private let loadingView = UIView()
    private var employees = [Employee]()
    private var companyName = ""

    private lazy var table: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        return tableView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAndConfigureTable()
        fillData()
    }

    override func viewDidAppear(_ animated: Bool) {
        checkConnection()
    }

    // MARK: - Actions
    private func registerAndConfigureTable() {

        table.register(TableViewCell.self, forCellReuseIdentifier: Constants.cellID)
        view.addSubview(table)

        table.translatesAutoresizingMaskIntoConstraints = false

        let horizontalConstraint = table.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = table.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = table.widthAnchor.constraint(equalToConstant: view.bounds.width)
        let heightConstraint = table.heightAnchor.constraint(equalToConstant: view.bounds.height)

        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])

        pullToRefresh()
    }
    
    private func getEmployeesAndUpdateTable(company: Company) {
        self.companyName = company.name
        self.employees = company.employees.sorted(by: { $0.name < $1.name })
        DispatchQueue.main.async {
            self.table.reloadData()
            self.table.refreshControl?.endRefreshing()
        }
    }
    
    private func pullToRefresh() {
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(handleTopRefresh), for: .valueChanged)
        table.refreshControl?.tintColor = UIColor.darkGray
    }

    @objc private func handleTopRefresh() {
        checkConnection()
        fillData()
    }

    private func fillData() {
        startLoader()
        network.getData(dataURL: URL(string: Constants.urlString)!) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.stopLoader()
            }
            switch result {
            case let .success(company):
                self.getEmployeesAndUpdateTable(company: company)
            case .failure:
                if NetworkMonitor.shared.isConnected == true {
                    DispatchQueue.main.async {
                        self.showErrorAlert()
                    }
                }
                print(NetworkErrors.invalidData)
            break
            }
        }
    }

    private func checkConnection() {
        if NetworkMonitor.shared.isConnected {
            print("Internet connection OK")
        } else {
            print("Internet connection FAILED")
            self.showRetryAlert()
        }
    }
}

// MARK: - Extensions
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        "Company: \(companyName)"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as? TableViewCell
        cell?.fillData(for: employees[indexPath.row])

        return cell ?? UITableViewCell()
    }
}

private extension ViewController {

    private func startLoader() {
        view.addSubview(spinner)
        spinner.center = self.table.center
        spinner.startAnimating()
        view.bringSubviewToFront(spinner)
    }

    private func stopLoader() {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Warning", message: "Ooops! Something is wrong...", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    private func showRetryAlert() {
        let retryAlert = UIAlertController(title: "Warning", message: "No internet", preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        retryAlert.addAction(action)
        self.present(retryAlert, animated: true, completion: nil)
    }
}

