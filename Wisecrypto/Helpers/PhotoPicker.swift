//
//  PhotoPicker.swift
//  Wisecrypto
//
//  Created by Yaroslav Orlov on 24.03.2023.
//

import Foundation
import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
  
  @StateObject var viewModel: PortfolioViewModel
  
  func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    picker.allowsEditing = true
    return picker
  }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(photoPicker: self)
  }
  
  final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let photoPicker: PhotoPicker
    
    init(photoPicker: PhotoPicker) {
      self.photoPicker = photoPicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let image = info[.originalImage] as? UIImage {
        photoPicker.viewModel.addImageToUser(image)
      }
      picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true)
    }
  }
  
  func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
  }
}
