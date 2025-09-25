//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {

    private var exploreData: [[AnyHashable: Any]]? {
        if let filePath = Bundle.main.path(forResource: "exploreData", ofType: "json"),
         let fileContent = try? Data(contentsOf: URL(fileURLWithPath: filePath)),
         let jsonDictionary = try? JSONSerialization.jsonObject(with: fileContent, options: .mutableContainers) as? [[AnyHashable: Any]] {
            return jsonDictionary
        }
        return nil
    }
    
    private var viewModel = ANFExploreViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                try await viewModel.getCards()
                tableView.reloadData()
            } catch {
                print(error)
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        exploreData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ExploreContentCell", for: indexPath)
        
        if let titleLabel = cell.viewWithTag(1) as? UILabel,
           let titleText = viewModel.exploreCards?[indexPath.row].title {
            titleLabel.text = titleText
        }
        
        Task {
            if let imageView = cell.viewWithTag(2) as? UIImageView, let name = viewModel.exploreCards?[indexPath.row].backgroundImage, let url = URL(string: name) {
                let image = await viewModel.fetchImage(url: url.upgradingToHTTPS)
                imageView.image = image
            }
        }
        
        return cell
    }
}

extension ANFExploreCardTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow, let data = exploreData?[indexPath.row] {
                let detailVC = segue.destination as? ANFExploreCardDetailViewController
                detailVC?.exploreCard = viewModel.exploreCards?[indexPath.row]
            }
        }
    }
}
