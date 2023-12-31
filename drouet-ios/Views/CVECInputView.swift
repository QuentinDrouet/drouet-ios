//
//  CVECInputView.swift
//  drouet-ios
//
//  Created by Quentin Drouet on 22/11/2023.
//

import SwiftUI

struct CVECInputView: View {
    @ObservedObject var viewModel = CVECViewModel()
    @State private var cvecCode = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Vérification du CVEC")
                .font(.title)
                .fontWeight(.bold)

            Text("Le CVEC (Contribution de Vie Étudiante et de Campus) est une contribution que les étudiants doivent payer pour soutenir les activités sociales, de santé, culturelles et sportives.")
                .font(.subheadline)
                .multilineTextAlignment(.leading)

            Text("Veuillez entrer le numéro d'attestation suivi des 5 premières lettres de votre nom.")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.bottom, 10)


            TextField("Code CVEC", text: $cvecCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top, 40)

            if viewModel.isRequesting {
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                Button(action: {
                    viewModel.verifyCVECCode(code: cvecCode)
                }) {
                    Text("Vérifier")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("CardBlue"))
                        .cornerRadius(10)
                }
            }

            switch viewModel.verificationStatus {
            case .success:
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(.top, 40)
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity, alignment: .center)
            case .failure(_):
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding(.top, 40)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
            case .none:
                EmptyView()
            }
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .center)
    }
}

