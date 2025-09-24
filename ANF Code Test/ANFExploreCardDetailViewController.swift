//
//  ANFExploreCardDetailViewController.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25.
//

import UIKit

class ANFExploreCardDetailViewController: UIViewController {

    
    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var shopMenButton: UIButton!
    @IBOutlet weak var shopWomenButton: UIButton!
    
    @IBOutlet weak var topDescription: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discountCodeLabel: UILabel!
    @IBOutlet weak var termsAndConditionsLabel: UILabel!
    
    var exploreData: [AnyHashable: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    public func setupViews() {
        titleImage.image = UIImage(named: exploreData?["backgroundImage"] as? String ?? "")
        topDescription.text = exploreData?["topDescription"] as? String
        titleLabel.text = exploreData?["title"] as? String
        discountCodeLabel.text = exploreData?["promoMessage"] as? String
        termsAndConditionsLabel.text = exploreData?["bottomDescription"] as? String
        var tnc = exploreData?["bottomDescription"] as? String
        
        if let data = tnc?.data(using: .utf8),
           let attributed = try? NSMutableAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html],
                documentAttributes: nil
           ) {
            
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            attributed.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attributed.length))
            
            termsAndConditionsLabel.attributedText = attributed
        }
        
        // add border to button
        shopMenButton.layer.borderWidth = 1
        shopWomenButton.layer.borderWidth = 1
    }
    
    @IBAction func shopMenButtonPressed(_ sender: Any) {
        if let content = exploreData?["content"] as? [[String: Any]] {
            if let men = content.first(where: { $0["title"] as? String == "Shop Men" }),
               let target = men["target"] as? String,
               let url = URL(string: target) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @IBAction func shopWomenButtonPressed(_ sender: Any) {
        if let content = exploreData?["content"] as? [[String: Any]] {
            if let men = content.first(where: { $0["title"] as? String == "Shop Women" }),
               let target = men["target"] as? String,
               let url = URL(string: target) {
                UIApplication.shared.open(url)
            }
        }
    }

}
