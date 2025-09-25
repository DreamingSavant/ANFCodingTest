//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit
import Combine

final class ANFExploreCardTableViewController: UITableViewController {
    
    private var anyCancellable: AnyCancellable?
    var viewModel = ProductCardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ExploreContentCell.self, forCellReuseIdentifier: "ExploreContentCell")
        
        bindData()
        
        Task {
            await getProducts()
        }
    }
    
    func getProducts() async {
        await viewModel.getProducts(url: EndPoints.baseUrl)
    }
    
    private func bindData() {
        anyCancellable = viewModel
            .$viewStates
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loading:
                    print("")
                case .load:
                    self?.tableView.reloadData()
                case .empty:
                    print("")
                case .error(let message):
                    print(message)
                }
            }
    }
    
    private var exploreData: [[AnyHashable: Any]]? {
        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
           let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
           let jsonDictionary = try? JSONSerialization.jsonObject(with: fileContent, options: .mutableContainers) as? [[AnyHashable: Any]] {
            return jsonDictionary
        }
        return nil
    }
}

extension ANFExploreCardTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreContentCell", for: indexPath) as? ExploreContentCell else {
            return UITableViewCell()
        }
        
        if indexPath.row < viewModel.products.count {
            let product = viewModel.products[indexPath.row]
            cell.configure(product)
            Task {
                do {
                    let imageData = try await viewModel.getImage(url: product.backgroundImage)
                  
                    cell.configureImage(UIImage(data: imageData))
                } catch {
                    print("Image not downlaoded")
                }
            }
            cell.onButtonTapped = { urlString in
                if let url = URL(string: urlString) {
                    UIApplication.shared.open(url)
                }
            }
        }
        return cell
    }
}
