//
//  ProfileView.swift
//  GeoNews
//
//  Created by M1 on 02.07.2024.
//

import UIKit

class CenterScaleFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        let center = collectionView!.bounds.size.width / 2
        
        for attribute in attributes {
            let distance = abs(attribute.center.x - center)
            let scale = max(1 - distance / center, 0.8) // Adjust scale factor as needed
            attribute.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return attributes
    }
}


class ProfileView: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    var viewModel: ProfileViewModel
    
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.crop.circle")
        return imageView
    }()
    
    private var cellPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = .clear
        return pickerView
    }()
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        setupUI()
        bindViewModel()
        cellPicker.dataSource = self
        cellPicker.delegate = self
    }
    
    private func setupUI() {
        setupProfileImage()
        setupPicker()
    }
    
    private func setupProfileImage() {
        view.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    
    private func setupPicker() {
        view.addSubview(cellPicker)
        
        NSLayoutConstraint.activate([
            cellPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cellPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cellPicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cellPicker.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func bindViewModel() {
        viewModel.onProfileImageUpdated = { [weak self] in
            DispatchQueue.main.async {
                if let image = self?.viewModel.loadProfileImage() {
                    self?.profileImageView.image = image
                } else {
                    self?.profileImageView.image = UIImage(named: "logo")
                }
            }
        }
        
        viewModel.onProfileImageUpdated?()
    }
    
    @objc private func profileImageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage {
            viewModel.saveProfileImage(image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CellStyleManager.shared.cellStyles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CellStyleManager.shared.cellStyles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        CellStyleManager.shared.selectCellStyle(at: row)
    }
}
