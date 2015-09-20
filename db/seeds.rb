concerts = Category.create(name: 'concerts')
ballet = Category.create(name: 'ballet')
stand_up_comedy = Category.create(name: 'stand-up comedy shows')
musical_theatre = Category.create(name: 'musical theatre')

Event.create!(name: 'U2 Innocence + Experience Tour 2015',
             date: '12-Sep-2015',
             time: '20:00',
             venue: 'Ziggo Dome, Amsterdam (NL)',
             description: "The Innocence + Experience Tour is an ongoing worldwide concert tour by rock band U2. Staged in support of the band's 2014 album Songs of Innocence, the tour will visit arenas throughout 2015. It is U2's first time playing arenas since 2005–2006 on their Vertigo Tour. The Innocence + Experience Tour opened on 14 May 2015 in Vancouver, Canada, and will comprise two legs, one featuring concerts in North America from May through July, and a second featuring concerts in Europe from September through November. The group has scheduled 70 concert dates.",
             img_url: 'u2_concert.jpg',
             floor_ticket_price: 200,
             balcony_ticket_price: 100,
             category: concerts)
             
Event.create!(name: 'Florence And The Machine',
             date: '21-Sep-2015',
             time: '19:00',
             venue: 'Alexandra Palace, London (GB)',
             description: "How Big How Blue How Beautiful', Florence's third critically acclaimed album was released this week to top the UK album chart, selling more than the rest of the top 5 combined, topping the charts in 24 other countries and the bandare currently on course to have their first Number One album in the USA. Now Florence + the Machine announce their return to the stage with their first full UK tour since March 2012. September will see them embark on a 12 strong string of dates which will take them across the country.",
             img_url: 'florence_concert.jpg',
             floor_ticket_price: 160,
             balcony_ticket_price: 80,
             category: concerts)
             
Event.create!(name: 'Swan Lake',
             date: '27-Sep-2016',
             time: '20:00',
             venue: "Teatro dell' Opera di Roma, Rome (IT)",
             description: "Swan Lake, Op. 20, is a ballet composed by Pyotr Ilyich Tchaikovsky in 1875–76. After initial failure, it has become one of the most popular of ballets. The scenario, initially in two acts, was fashioned from Russian folk tales and tells the story of Odette, a princess turned into a swan by an evil sorcerer's curse. The choreographer of the original production was Julius Reisinger. The ballet was premiered by the Bolshoi Ballet on 4 March [O.S. 20 February] 1877 at the Bolshoi Theatre in Moscow. Although it is presented in many different versions, most ballet companies base their stagings both choreographically and musically on the 1895 revival of Marius Petipa and Lev Ivanov, first staged for the Imperial Ballet on 15 January 1895, at the Mariinsky Theatre in St. Petersburg. For this revival, Tchaikovsky's score was revised by the St. Petersburg Imperial Theatre's chief conductor and composer Riccardo Drigo.",
             img_url: 'swan_lake_ballet.jpg',
             floor_ticket_price: 175,
             balcony_ticket_price: 90,
             category: ballet)
             
Event.create!(name: 'The Nutcracker',
             date: '03-Dec-2015',
             time: '20:30',
             venue: 'Teatro Carlo Felice Genova, Genoa (IT)',
             description: "The Nutcracker is a two-act ballet, originally choreographed by Marius Petipa and Lev Ivanov with a score by Pyotr Ilyich Tchaikovsky (op. 71). The libretto is adapted from E.T.A. Hoffmann's story The Nutcracker and the Mouse King. It was given its première at the Mariinsky Theatre in St. Petersburg on Sunday, December 18, 1892, on a double-bill with Tchaikovsky's opera, Iolanta.",
             img_url: 'nutcracker_ballet.jpg',
             floor_ticket_price: 175,
             balcony_ticket_price: 90,
             category: ballet)
             
Event.create!(name: 'Eddie Izzard',
             date: '04-Oct-2015',
             time: '20:00',
             venue: 'Casino de Paris, Paris (FR)',
             description: "Edward John 'Eddie' (born 7 February 1962) is an English stand-up comedian, actor, and writer. His comedic style takes the form of rambling, whimsical monologue, and self-referential pantomime.\nIzzard has cited his main comedy role model as Monty Python, and John Cleese once referred to him as the 'Lost Pytho'. In 2009, he completed 43 marathons in 51 days for Sport Relief despite having no prior history of long-distance running. He has won numerous awards including a Primetime Emmy Award for Individual Performance in a Variety or Music Program for his comedy special Dress to Kill, in 2000. Izzard's website won the Yahoo People's Choice Award and earned the Webby Award.",
             img_url: 'izzard_comedy.jpg',
             floor_ticket_price: 115,
             balcony_ticket_price: 75,
             category: stand_up_comedy)
             
Event.create!(name: 'Dirty Dancing',
             date: '05-Dec-2015 ',
             time: '15:00',
             venue: 'Palais 12, Brussels (BE)',
             description: "It’s the summer of 1963, and 17 year- old Frances ‘Baby’ Houseman is about to learn some major lessons in life as well as a thing or two about dancing.\nOn holiday in New York’s Catskill Mountains with her older sister and parents, ‘Baby’ shows little interest in the resort activities, and instead discovers her own entertainment when she stumbles upon the staff quarters when an all-night dance party is in full swing. Mesmerised by the raunchy dance moves and the pounding rhythms, ‘Baby’ can’t wait to be part of the scene, especially when she catches sight of Johnny Castle the resort dance instructor.\nBaby’s’ life is about to change forever as she is thrown in at the deep end as Johnny’s leading lady both on-stage and off with breathtaking consequences.",
             img_url: 'dirty_dancing_musical.jpg',
             floor_ticket_price: 120,
             balcony_ticket_price: 80,
             category: musical_theatre)