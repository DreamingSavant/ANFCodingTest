//
//  ANFExploreCardDetailViewController.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25.
//

import UIKit

class ANFExploreCardDetailViewController: UIViewController {

    
    @IBOutlet weak var titleImage: UIImageView!
    
    @IBOutlet weak var shopButtonOne: UIButton!
    @IBOutlet weak var shopButtonTwo: UIButton!
    
    @IBOutlet weak var topDescription: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discountCodeLabel: UILabel!
    @IBOutlet weak var termsAndConditionsLabel: UILabel!
    
    var exploreCard: ANFResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        setupImage()
        topDescription.text = exploreCard?.topDescription
        titleLabel.text = exploreCard?.title
        discountCodeLabel.text = exploreCard?.promoMessage
        
        let tnc = exploreCard?.bottomDescription
        
        if tnc != nil {
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
        } else {
            termsAndConditionsLabel.isHidden = true
        }
        
        setupButtons()
    }
    
    private func setupButtons() {
        
        let contentCount = exploreCard?.content?.count
        
        if let contentCount, contentCount >= 2 {
            shopButtonOne.isHidden = false
            shopButtonOne.isHidden = false
            shopButtonOne.layer.borderWidth = 1
            shopButtonTwo.layer.borderWidth = 1
        } else if let contentCount, contentCount == 1 {
                shopButtonOne.setTitle(exploreCard?.content?.first?.title, for: .normal)
                shopButtonTwo.isHidden = true
            shopButtonOne.layer.borderWidth = 1
        } else {
            shopButtonOne.isHidden = true
            shopButtonTwo.isHidden = true
        }
    }
    
    private func setupImage() {
        guard let url = URL(string: exploreCard?.backgroundImage ?? "")?.upgradingToHTTPS else { return }

                // Standard URLSession
                let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                    if let error = error {
                        print("Failed to fetch image:", error)
                        return
                    }
                    guard let data = data,
                          let image = UIImage(data: data) else {
                        print("Invalid image data")
                        return
                    }
                    DispatchQueue.main.async {
                        self?.titleImage.image = image
                    }
                }
                task.resume()
    }
    
    @IBAction func shopButtonOnePressed(_ sender: Any) {
        let target = exploreCard?.content?.first?.target ?? ""
        if let url = URL(string: target) {
         UIApplication.shared.open(url)
     }
    }
    
    @IBAction func shopButtonTwoPressed(_ sender: Any) {
        let target = exploreCard?.content?.last?.target ?? ""
        if let url = URL(string: target) {
         UIApplication.shared.open(url)
     }
    }

}
