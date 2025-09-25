//
//  Product.swift
//  ANF Code Test
//
//  Created by Rod on 9/24/25.
//

import UIKit

class ExploreContentCell: UITableViewCell {
    
    // MARK: - UI Components
    let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let topDescriptionLbl: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        return label
    }()
    
     let titleLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0, weight:.bold)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let promoMessageLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11.0)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    private let bottomDescriptionLbl: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .gray
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - StackViews
    private lazy var labelsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topDescriptionLbl, titleLbl, promoMessageLbl, bottomDescriptionLbl])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setCustomSpacing(20, after: promoMessageLbl)

        return stack
    }()
    
    private lazy var dynamicButtonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var backgroundImageAspectRatio: NSLayoutConstraint?
    
    // MARK: - Callbacks
    var onButtonTapped: ((String) -> Void)?  // Pass target URL back to VC
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImage.image = nil
        topDescriptionLbl.text = nil
        titleLbl.text = nil
        promoMessageLbl.text = nil
        bottomDescriptionLbl.attributedText = nil
        dynamicButtonsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() } // Clear old buttons
    }
    
    // MARK: - Setup Layout
    private func setupUI() {
        selectionStyle = .none
        contentView.addSubview(backgroundImage)
        contentView.addSubview(labelsStackView)
        contentView.addSubview(dynamicButtonsStackView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let margins = contentView.layoutMarginsGuide
        
        backgroundImageAspectRatio = backgroundImage.heightAnchor.constraint(equalToConstant: 200)
        backgroundImageAspectRatio?.isActive = true
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: margins.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            labelsStackView.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 8),
            labelsStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            labelsStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            dynamicButtonsStackView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 12),
            dynamicButtonsStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            dynamicButtonsStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            dynamicButtonsStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    
    // MARK: - Configure Cell
    func configure(_ product: Product) {
        topDescriptionLbl.text = product.topDescription
        titleLbl.text = product.title
        promoMessageLbl.text = product.promoMessage
        bottomDescriptionLbl.attributedText = decodeHTMLWithUnderline(from: product.bottomDescription)
        
        // Dynamically create buttons based on content array
        dynamicButtonsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        product.content?.forEach { item in
            let button = UIButton(type: .system)
            button.setTitle(item.title, for: .normal)
            button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = UIColor.systemGray6
            button.layer.cornerRadius = 8
            button.heightAnchor.constraint(equalToConstant: 40).isActive = true
            button.addAction(UIAction(handler: { [weak self] _ in
                self?.onButtonTapped?(item.target)
            }), for: .touchUpInside)
            
            dynamicButtonsStackView.addArrangedSubview(button)
        }
    }
    
    func configureImage(_ image: UIImage?) {
        backgroundImage.image = image
        backgroundImageAspectRatio?.isActive = false
        
        if let img = image {
            let aspectRatio = img.size.height / img.size.width
            backgroundImageAspectRatio = backgroundImage.heightAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: aspectRatio)
        } else {
            backgroundImageAspectRatio = backgroundImage.heightAnchor.constraint(equalToConstant: 200)
        }
        
        backgroundImageAspectRatio?.isActive = true
        findTableView()?.beginUpdates()
        findTableView()?.endUpdates()
    }
    
    private func findTableView() -> UITableView? {
        var view = superview
        while view != nil {
            if let tableView = view as? UITableView {
                return tableView
            }
            view = view?.superview
        }
        return nil
    }
    
    private func decodeHTMLWithUnderline(from htmlString: String?) -> NSAttributedString? {
        guard let data = htmlString?.data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding:String.Encoding.utf8.rawValue
        ]
        
        let attributedString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
        if let attributedString = attributedString {
            attributedString.addAttribute(.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            attributedString.addAttribute(.paragraphStyle,
                                          value: paragraphStyle,
                                          range: NSRange(location: 0, length: attributedString.length))
        }
        return attributedString
    }
}
