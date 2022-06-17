//
//  ContentView.swift
//  Shared
//
//  Created by Paulo Baltieri on 04/06/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject public var viewModel = ViewModel()
    @State var tvSeriesTitle = String()
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.tvSeries) { tvSeries in
                    TVSeriesCell(tvSeries: tvSeries)
                }
                .searchable(text: $tvSeriesTitle, prompt: "Digite o nome da Serie")
                .onChange(of: tvSeriesTitle) { title in
                    Task {
                        await self.viewModel.getTVShowNamed(title)
                    }
                }
                .navigationTitle("TV Explorer")
            }
        }
    }
}

struct TVSeriesCell: View {
    var tvSeries: TVSeries
    private let posterWidth: CGFloat = 65
    private let posterHeight: CGFloat = 90
    private let statusFontSize: CGFloat = 25
    var body: some View {
        NavigationLink(destination: Series(tvSeries: tvSeries)) {
            HStack {
                VStack {
                    AsyncImage(
                        url: URL(string: tvSeries.show.image?.medium ?? ""),
                        content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: posterWidth, maxHeight: posterHeight)
                        },
                        placeholder: {
                            Label("", systemImage: "film")
                                .aspectRatio(contentMode: .fill)
                                .frame(width: posterWidth, height: posterHeight, alignment: .center)
                        }
                    )
                }
                VStack(alignment: .leading) {
                    Text(tvSeries.show.name ?? "")
                        .font(.title2)
                    Text(tvSeries.show.status ?? "")
                        .font(.subheadline)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
