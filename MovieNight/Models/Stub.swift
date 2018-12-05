//
//  Stub.swift
//  MovieNight
//
//  Created by Erik Carlson on 12/3/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import Foundation

/// Data for offline testing
struct Stub {
    static var genres: [Genre] {
        return [
            Genre(id: 28, name: "Action"),
            Genre(id: 12, name: "Adventure"),
            Genre(id: 16, name: "Animation"),
            Genre(id: 35, name: "Comedy"),
            Genre(id: 80, name: "Crime"),
            Genre(id: 99, name: "Documentary"),
            Genre(id: 18, name: "Drama"),
            Genre(id: 10751, name: "Family"),
            Genre(id: 14, name: "Fantasy"),
            Genre(id: 36, name: "History"),
            Genre(id: 27, name: "Horror"),
            Genre(id: 10402, name: "Music"),
            Genre(id: 9648, name: "Mystery"),
            Genre(id: 10749, name: "Romance"),
            Genre(id: 878, name: "Science Fiction"),
            Genre(id: 10770, name: "TV Movie"),
            Genre(id: 53, name: "Thriller"),
            Genre(id: 10752, name: "War"),
            Genre(id: 37, name: "Western")
        ]
    }
    
    static func popularPeople(page: Int) -> Page<Person> {
        let defaultReturn = Page(page: 1, totalResults: 23, totalPages: 2, results: [
                // 1
                Person(
                    id: 2524,
                    name: "Tom Hardy",
                    profilePath: "/4CR1D9VLWZcmGgh4b6kKuY2NOel.jpg",
                    popularity: 35.912),
                // 2
                Person(
                    id: 1522345,
                    name: "Jocelyn Hudon",
                    profilePath: "/nTeH73Cg7ikfTlUevrRWuFu3oaj.jpg",
                    popularity: 24.642),
                // 3
                Person(
                    id: 9827,
                    name: "Rose Byrne",
                    profilePath: "/5Vd88XcVcZep20gWvuCGCxp5FFA.jpg",
                    popularity: 23.081),
                // 4
                Person(
                    id: 1026883,
                    name: "Scott Cavalheiro",
                    profilePath: "/AeeF2uiZVv1mgWRpNjR2g2TEmFq.jpg",
                    popularity: 20.258),
                // 5
                Person(
                    id: 1812,
                    name: "Michelle Williams",
                    profilePath: "/r4HQM2gO9Q7Ti7sJcRE4hcP8ddN.jpg",
                    popularity: 15.1),
                // 6
                Person(
                    id: 14386,
                    name: "Beyoncé Knowles",
                    profilePath: "/xYCtL5BpQFALZGYibVPFsebUs6q.jpg",
                    popularity: 15.088),
                // 7
                Person(
                    id: 78197,
                    name: "Elisabeth Harnois",
                    profilePath: "/bBVitNtkzupyXn8HKtLTduPclje.jpg",
                    popularity: 14.073),
                // 8
                Person(
                    id: 73968,
                    name: "Henry Cavill",
                    profilePath: "/hErUwonrQgY5Y7RfxOfv8Fq11MB.jpg",
                    popularity: 14.032),
                // 9
                Person(
                    id: 85,
                    name: "Johnny Depp",
                    profilePath: "/tQfBM7GqgLSWYao1Ljq8xczgP6j.jpg",
                    popularity: 13.764),
                // 10
                Person(
                    id: 1245,
                    name: "Scarlett Johansson",
                    profilePath: "/tHMgW7Pg0Fg6HmB8Kh8Ixk6yxZw.jpg",
                    popularity: 13.224),
                // 11
                Person(
                    id: 1794428,
                    name: "Tanner Getter",
                    profilePath: "/gwuXm7jsuZeEFwP3PdTGrtfmd0Q.jpg",
                    popularity: 13.206),
                // 12
                Person(
                    id: 1292329,
                    name: "Kimberly Sustad",
                    profilePath: "/syBA7Scz1LsY9zymB1wvR4a4RMO.jpg",
                    popularity: 11.726),
                // 13
                Person(
                    id: 18918,
                    name: "Dwayne Johnson",
                    profilePath: "/kuqFzlYMc2IrsOyPznMd1FroeGq.jpg",
                    popularity: 11.538),
                // 14
                Person(
                    id: 4743,
                    name: "Jonathan Togo",
                    profilePath: "/i5nt6th0CMwPDdINIo5O6PFIcvY.jpg",
                    popularity: 11.469),
                // 15
                Person(
                    id: 976,
                    name: "Jason Statham",
                    profilePath: "/PhWiWgasncGWD9LdbsGcmxkV4r.jpg",
                    popularity: 11.403),
                // 16
                Person(
                    id: 112,
                    name: "Cate Blanchett",
                    profilePath: "/5HikVWKfkkUa8aLdCMHtREBECIn.jpg",
                    popularity: 11.314),
                // 17
                Person(
                    id: 17838,
                    name: "Rami Malek",
                    profilePath: "/zvBCjFmedqXRqa45jlLf6vBd9Nt.jpg",
                    popularity: 11.117),
                // 18
                Person(
                    id: 287,
                    name: "Brad Pitt",
                    profilePath: "/kU3B75TyRiCgE270EyZnHjfivoq.jpg",
                    popularity: 10.653),
                // 19
                Person(
                    id: 6193,
                    name: "Leonardo DiCaprio",
                    profilePath: "/jqbqNrOIB3alGMX6Gh2MbOKMXZO.jpg",
                    popularity: 10.602),
            ])
        
        switch page {
        case 1:
            return defaultReturn
        case 2:
            return Page(page: 2, totalResults: 23, totalPages: 2, results: [
                // 1
                Person(
                    id: 1829786,
                    name: "Katherine de la Rocha",
                    profilePath: "/ypafxJyOlhaZOhg1GrLnvZG53eo.jpg",
                    popularity: 9.612),
                // 2
                Person(
                    id: 73457,
                    name: "Chris Pratt",
                    profilePath: "/gXKyT1YU5RWWPaE1je3ht58eUZr.jpg",
                    popularity: 9.527),
            ])
        default:
            return defaultReturn
        }
    }
    
    static func discoverMovie(page: Int) -> Page<Movie> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = TmdbClient.dateFormat
        
        let defaultResult = Page(page: 1, totalResults: 2, totalPages: 1, results: [
            // 1
            Movie(
                id: 335983,
                title: "Venom",
                releaseDate: dateFormatter.date(from: "2018-10-03")!,
                genreIds: [878],
                posterPath: "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg"),
            // 2
            Movie(
                id: 338952,
                title: "Fantastic Beasts: The Crimes of Grindelwald",
                releaseDate: dateFormatter.date(from: "2018-11-14")!,
                genreIds: [10751, 14, 12],
                posterPath: "/uyJgTzAsp3Za2TaPiZt2yaKYRIR.jpg"),
        ])
        return defaultResult
    }
}
