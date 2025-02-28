//
//  AsyncImageView.swift
//  TheMarket
//
//  Created by Nikita Zolotov on 15.02.2025.
//

import UIKit

final class AsyncImageView: UIView {
    // MARK: - Constants
    enum Constants {
        enum Error {
            static let errorImage = UIImage(named: "Error")
        }
        
        enum LoadingImageView {
            static let image: UIImage? = UIImage(
                systemName: "arrow.triangle.2.circlepath",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 18,
                    weight: .medium
                )
            )
        }
    }
    
    // MARK: - Fields
    private let imageView: UIImageView = UIImageView()
    private let loadingImageView: UIImageView = UIImageView()
    private var currentLoadingURL: URL?
    
    // MARK: - Lyfecycle
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func reset() {
        imageView.image = nil
        currentLoadingURL = nil
        loadingImageView.isHidden = false
    }
    
    func setImage(imageURL: String?) {
        if let URL = imageURL {
            loadImage(path: URL)
        } else {
            loadingImageView.isHidden = true
            imageView.image = Constants.Error.errorImage
        }
    }
    
    func loadImage(path: String) {
        let path = path.trimmingCharacters(in: CharacterSet(charactersIn: "[]\""))
        guard let url = URL(string: path), url != currentLoadingURL else { return }
        
        currentLoadingURL = url
        if url.scheme == "http" {
            showErrorView()
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if error != nil  {
                self?.showErrorView()
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                self?.showErrorView()
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard self?.currentLoadingURL == url else { return }
                self?.imageView.image = image
                self?.loadingImageView.isHidden = true
            }
        }.resume()
    }
    
    // MARK: - Configure UI
    private func configureUI() {
        configureImageView()
        configureLoadingImageView()
    }
    
    private func configureImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        
        addSubview(imageView)
        imageView.pin(to: self)
    }
    
    private func configureLoadingImageView() {
        loadingImageView.image = Constants.LoadingImageView.image
        loadingImageView.tintColor = UIColor(color: .accent)
        loadingImageView.contentMode = .scaleAspectFit
        
        addSubview(loadingImageView)
        loadingImageView.pin(to: self)
    }
    
    private func showErrorView() {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = Constants.Error.errorImage
            self?.currentLoadingURL = nil
            self?.loadingImageView.isHidden = true
        }
    }
}

