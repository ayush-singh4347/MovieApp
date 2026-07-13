//
//  LanguageFilterView.swift
//  MovieApp
//
//  Created by rentamac on 2/13/26.
//

import Foundation
import SwiftUI

struct LanguageFilterView: View {

    @ObservedObject var viewModel: HomeViewModel
    @Environment(\.dismiss) private var dismiss


//    let languages = [
//        ("English", "en"),
//        ("Hindi", "hi"),
//        ("Telugu", "te"),
//        ("Tamil", "ta"),
//        ("Malayalam", "ml")
//    ]
    let languages: [(name: String, code: String)] = [
        ("Afrikaans", "af"),
        ("Arabic", "ar"),
        ("Aragonese", "an"),
        ("Assamese", "as"),
        ("Avaric", "av"),
        ("Avestan", "ae"),
        ("Aymara", "ay"),
        ("Azerbaijani", "az"),
        ("Bashkir", "ba"),
        ("Basque", "eu"),
        ("Belarusian", "be"),
        ("Bengali", "bn"),
        ("Bislama", "bi"),
        ("Bosnian", "bs"),
        ("Breton", "br"),
        ("Bulgarian", "bg"),
        ("Burmese", "my"),
        ("Catalan", "ca"),
        ("Chamorro", "ch"),
        ("Chechen", "ce"),
        ("Chinese", "zh"),
        ("Corsican", "co"),
        ("Croatian", "hr"),
        ("Czech", "cs"),
        ("Danish", "da"),
        ("Dutch", "nl"),
        ("English", "en"),
        ("Esperanto", "eo"),
        ("Estonian", "et"),
        ("Faroese", "fo"),
        ("Fijian", "fj"),
        ("Finnish", "fi"),
        ("French", "fr"),
        ("Galician", "gl"),
        ("Georgian", "ka"),
        ("German", "de"),
        ("Greek", "el"),
        ("Gujarati", "gu"),
        ("Haitian", "ht"),
        ("Hausa", "ha"),
        ("Hebrew", "he"),
        ("Hindi", "hi"),
        ("Hungarian", "hu"),
        ("Icelandic", "is"),
        ("Indonesian", "id"),
        ("Irish", "ga"),
        ("Italian", "it"),
        ("Japanese", "ja"),
        ("Javanese", "jv"),
        ("Kannada", "kn"),
        ("Kazakh", "kk"),
        ("Korean", "ko"),
        ("Kurdish", "ku"),
        ("Kyrgyz", "ky"),
        ("Latin", "la"),
        ("Latvian", "lv"),
        ("Lithuanian", "lt"),
        ("Luxembourgish", "lb"),
        ("Macedonian", "mk"),
        ("Malagasy", "mg"),
        ("Malay", "ms"),
        ("Malayalam", "ml"),
        ("Maltese", "mt"),
        ("Maori", "mi"),
        ("Marathi", "mr"),
        ("Mongolian", "mn"),
        ("Nepali", "ne"),
        ("Norwegian", "no"),
        ("Persian", "fa"),
        ("Polish", "pl"),
        ("Portuguese", "pt"),
        ("Punjabi", "pa"),
        ("Romanian", "ro"),
        ("Russian", "ru"),
        ("Samoan", "sm"),
        ("Serbian", "sr"),
        ("Sinhala", "si"),
        ("Slovak", "sk"),
        ("Slovenian", "sl"),
        ("Somali", "so"),
        ("Spanish", "es"),
        ("Swahili", "sw"),
        ("Swedish", "sv"),
        ("Tagalog", "tl"),
        ("Tajik", "tg"),
        ("Tamil", "ta"),
        ("Tatar", "tt"),
        ("Telugu", "te"),
        ("Thai", "th"),
        ("Tibetan", "bo"),
        ("Tonga", "to"),
        ("Turkish", "tr"),
        ("Turkmen", "tk"),
        ("Ukrainian", "uk"),
        ("Urdu", "ur"),
        ("Uzbek", "uz"),
        ("Vietnamese", "vi"),
        ("Welsh", "cy"),
        ("Yiddish", "yi")
    ]
   // @Binding var selectedLanguages: Set<String>

       @State private var searchText = ""

       var filteredLanguages: [(name: String, code: String)] {
           if searchText.isEmpty {
               return languages
           } else {
               return languages.filter {
                   $0.name.localizedCaseInsensitiveContains(searchText)
               }
           }
       }

    var body: some View {
        VStack(spacing:0){
            NavigationStack {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $searchText)
                        .font(.subheadline)
                        .textFieldStyle(.plain)
                    
                    if !searchText.isEmpty {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .onTapGesture {
                                searchText = ""
                            }
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
                .padding(.top, 6)
                
                List(filteredLanguages, id: \.1) { language in
                    MultipleSelectionRow(
                        title: language.0,
                        isSelected: viewModel.selectedLanguages.contains(language.1)
                    ) {
                        if viewModel.selectedLanguages.contains(language.1) {
                            viewModel.selectedLanguages.remove(language.1)
                        } else {
                            viewModel.selectedLanguages.insert(language.1)
                        }
                    }
                } .listStyle(.plain)                 
                    .scrollContentBackground(.hidden)
                .navigationTitle("Select Languages")
                //            .searchable(
                //                       text: $searchText,
                //                       placement: .navigationBarDrawer(displayMode: .always)
                //                   )
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "chevron.left")
                            }
                        }
                    ToolbarItem() {
                        Button("Apply") {
                            viewModel.selectedCategory = .all
                            viewModel.showLanguageFilter = false
                            Task {
                                await viewModel.fetchMoviesForLanguages()
                            }
                        }
                    }
                }
            }
        }//.searchable(text: $searchText, prompt: "Search Language")
    }
}
struct MultipleSelectionRow: View {

    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                }
            }
        }
    }
}

