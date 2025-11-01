//
//  CrossfitTestsCollectionViewCell.swift
//  GymFlow
//
//  Created by Artem Kriukov on 25.10.2025.
//

import UIKit

final class CrossfitTestCell: UICollectionViewCell, ReuseIdentifying {
    
    // MARK: - Callbacks
    var onFavoriteTap: (() -> Void)?
    var onInfoTap: (() -> Void)?
    var onAddTap: (() -> Void)?
    
    // MARK: - UI Components
    private lazy var containerView: UIView = {
        let element = UIView()
        element.backgroundColor = R.color.cellBackgroundColor()
        element.layer.cornerRadius = UIConstants.CornerRadius.large
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = UIConstants.Spacing.small
        element.alignment = .fill
        element.distribution = .fill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var headerStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = UIConstants.Spacing.small
        element.alignment = .center
        element.distribution = .fill
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 20, weight: .bold)
        element.textColor = R.color.primaryTextColor()
        element.numberOfLines = 1
        element.setContentHuggingPriority(.defaultLow, for: .horizontal)
        element.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return element
    }()
    
    private lazy var favoriteButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        element.tintColor = R.color.secondaryTextColor()
        element.addAction(UIAction {[weak self] _ in
            self?.favoriteTapped()
        }, for: .touchUpInside)
        element.setContentHuggingPriority(.required, for: .horizontal)
        element.setContentCompressionResistancePriority(.required, for: .horizontal)
        return element
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.font = .systemFont(ofSize: 14, weight: .regular)
        element.textColor = R.color.secondaryTextColor()
        element.numberOfLines = 0
        element.lineBreakMode = .byWordWrapping
        element.setContentHuggingPriority(.defaultHigh, for: .vertical)
        element.setContentCompressionResistancePriority(.required, for: .vertical)  
        return element
    }()
    
    private lazy var spacerView: UIView = {
        let element = UIView()
        element.setContentHuggingPriority(.defaultLow, for: .vertical)
        element.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return element
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.spacing = UIConstants.Spacing.medium
        element.alignment = .fill
        element.distribution = .fill
        return element
    }()
    
    private lazy var infoButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(systemName: "info.circle.fill"), for: .normal)
        element.setTitle(" Инфо", for: .normal)
        element.tintColor = .systemBlue
        element.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        element.contentHorizontalAlignment = .leading
        element.addAction(UIAction {[weak self] _ in
            self?.infoTapped()
        }, for: .touchUpInside)
        element.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return element
    }()
    
    private lazy var addButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Добавить к себе"
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16)
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 15, weight: .semibold)
            return outgoing
        }
        
        let element = UIButton(configuration: config, primaryAction: UIAction { [weak self] _ in
            self?.addTapped()
        })
        element.setContentHuggingPriority(.required, for: .horizontal)
        element.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        return element
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with test: CrossfitTests) {
        titleLabel.text = test.nameEn
        descriptionLabel.text = test.description
        descriptionLabel.isHidden = test.description.isEmpty
        
        favoriteButton.tintColor = test.isFavorite ? .systemRed : R.color.secondaryTextColor()
    }
    
    // MARK: - Actions
    private func favoriteTapped() {
        onFavoriteTap?()
    }
    
    private func infoTapped() {
        onInfoTap?()
    }
    
    private func addTapped() {
        onAddTap?()
    }
    
    func updateFavorite(_ isFavorite: Bool) {
        favoriteButton.tintColor = isFavorite ? .systemRed : R.color.secondaryTextColor()
    }
}

// MARK: - Setup
private extension CrossfitTestCell {
    func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(mainStackView)
        
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(favoriteButton)
        
        bottomStackView.addArrangedSubview(infoButton)
        bottomStackView.addArrangedSubview(addButton)
        
        mainStackView.addArrangedSubview(headerStackView)
        mainStackView.addArrangedSubview(descriptionLabel)
        mainStackView.addArrangedSubview(spacerView)
        mainStackView.addArrangedSubview(bottomStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 34),
            favoriteButton.heightAnchor.constraint(equalToConstant: 34),
            
            bottomStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
