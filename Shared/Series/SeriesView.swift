//
//  Series.swift
//  tvexplorer (iOS)
//
//  Created by Paulo Baltieri on 16/06/2022.
//

import Foundation
import SwiftUI

struct Series: View {
    var tvSeries: TVSeries
    var body: some View {
        ZStack {
            TVShowPoster(tvSerie: tvSeries)
            VStack(alignment: .leading) {
                Spacer(minLength: 2)
                SummaryCard(tvSerie: tvSeries)
            }
        }
    }
}

struct SummaryCard: View {
    @Environment(\.colorScheme) var colorScheme
    var tvSerie: TVSeries
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center) {
                Text(tvSerie.show.name ?? "")
                    .font(.title)
                HStack {
                    Text("Nota")
                    let raing = String(format: "%.1f", tvSerie.show.rating?.average ?? "Nao avaliado ainda")
                    Text(raing)
                }
            }
        }
    }
}

struct TVShowPoster: View {
    @ObservedObject public var viewModel = ViewModel()
    @State var tvShowPoster: UIImage? = UIImage(systemName: "film")
    var tvSerie : TVSeries
    var body: some View {
        VStack {
            SwiftUI.Image(uiImage: tvShowPoster!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        }
        .onAppear {
            Task {
                if let url = tvSerie.show.image?.original {
                    tvShowPoster = await viewModel.getPosterImage(url)
                }
            }
        }
    }
}
