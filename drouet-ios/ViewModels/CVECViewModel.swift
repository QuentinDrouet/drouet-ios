//
//  CVECViewModel.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 22/11/2023.
//

import Foundation

class CVECViewModel: ObservableObject {
    @Published var isRequesting: Bool = false
    @Published var verificationStatus: VerificationStatus? = nil
    
    enum VerificationStatus {
        case success, failure(String)
    }
    
    func verifyCVECCode(code: String) {
        let urlString = "https://cvec-ctrl.etudiant.gouv.fr/api/attestation/\(code)"
        guard let url = URL(string: urlString) else {
            verificationStatus = .failure("URL invalide")
            return
        }
        
        isRequesting = true
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isRequesting = false
                if let error = error {
                    self?.verificationStatus = .failure("Erreur de requête : \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    self?.verificationStatus = .failure("Aucune donnée reçue")
                    return
                }
                
                if let _ = try? JSONDecoder().decode(CVECResponse.self, from: data) {
                    self?.verificationStatus = .success
                } else if let errorResponse = try? JSONDecoder().decode(CVECErrorResponse.self, from: data) {
                    self?.verificationStatus = .failure(errorResponse.message)
                } else {
                    self?.verificationStatus = .failure("Réponse inattendue")
                }
            }
        }.resume()
    }
}

