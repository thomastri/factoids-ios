//
//  FactProvider.swift
//  Factoids
//
//  Created by Thomas Le on 8/31/17.
//  Copyright © 2017 Thomas Le. All rights reserved.
//

import GameKit

struct FactProvider {
    
    var randomNumber = 0
    var factOrFake = 0
    var score = 0
    
    let facts = [
        "Ants stretch when they wake up in the morning.",
        "Ostriches can run faster than horses.",
        "Olympic gold medals are actually made mostly of silver.",
        "You are born with 300 bones; by the time you are an adult you will have 206.",
        "It takes about 8 minutes for light from the Sun to reach Earth.",
        "Some bamboo plants can grow almost a meter in just one day.",
        "The state of Florida is bigger than England.",
        "Some penguins can leap 2-3 meters out of the water.",
        "On average, it takes 66 days to form a new habit.",
        "Mammoths still walked the Earth when the Great Pyramid was being built.",
        "In 1889, the Queen of Italy, Margherita Savoy, ordered the first pizza delivery.",
        "You can buy eel flavored ice cream in Japan.",
        "It's considered rude to write in red ink in Portugal.",
        "Although the bobcat is rarely seen, it is the most common wildcat in North America",
        "A cat's tail contains nearly 10 percent of all the bones in its body.",
        "Gecko feet have millions of tiny hairs that stick to surfaces with a special chemical bond and let them climb walls and hang on by just one toe.",
        "The term \"astronaut\" comes from Greek words that mean \"star\" and \"sailor.\"",
        "The calcium in our bones and the iron in our blood come from ancient explosions of giant stars.",
        "The Nile crocodile can hold its breath underwater for up to 2 hours while waiting for prey.",
        "Jellyfish, or jellies as scientists call them, are not fish. They have no brain, no heart, and no bones.",
        "The Chinese giant salamander can grow to be 6 feet (1.8 m) long, making it the largest salamander in the world.",
        "People reportedly prefer blue toothbrushes over red ones.",
        "Some people used to believe that kissing a donkey could relieve a toothache.",
        "Scientists say that the best time to take a nap is between 1 p.m. and 2:30 p.m. because that's when a dip in body temperature makes us feel sleepy.",
        "Because the speed of Earth's rotation changes over time, a day in the age of dinosaurs was just 23 hours long.",
        "Hummingbirds' wings can beat 200 times a second.",
        "A seahorse can move its eyes in opposite directions—all the better to scan the water for food and predators.",
        "To cook an egg, a sidewalk needs to be 158°F.",
        "A group of jellyfish is not a herd, or a school, or a flock; it's called a smack.",
        "It would take 100 Earths, lined up end-to-end, to stretch across the face of the sun.",
        "Less than 1 percent of Antarctica is ice-free.",
        "The highest wave ever surfed was as tall as a 10-story building.",
        "The Beagle Brigade, used in 21 international airports in the U.S., keeps a yearly average of 75,000 illegal items out of the country.",
        "Some apples can weigh about as much as a half gallon (2L) of milk.",
        "Corn is grown on every continent except Antarctica.",
        "Unlike most fish, seahorses are covered in bony plates instead of scales.",
        "You lose about 50 to 100 hairs a day.",
        "\"Armadillo\" is a Spanish word meaning \"little armored one.\"",
        "Komodo dragons can devour 5 pounds (2 kg) of meat in less than a minute. Any extra fat they eat is stored in their tails.",
        "Not all moons are dry and dusty like ours. Jupiter's Europa has a liquid ocean under an icy crust.",
        "Some Viking chiefs were buried inside their ships.",
        "At any moment, clouds cover about 60 percent of Earth.",
        "All apes laugh when they are tickled.",
        "Spotted hyenas can digest skin and bones.",
        "The quills on African porcupines are as long as 3 pencils.",
        "Scientists believe that people who dream about an activity will actually get better at it in real life.",
        "Your hair contains traces of gold.",
        "Depending on the speed of the wind, some clouds travel up to 100 miles per hour (160 kph) across the sky.",
        "Opal has been discovered on Mars.",
        "George Washington loved exploring caves.",
        "The TV remote is the dirtiest item in a typical household, hospital, or hotel room.",
        "The finest quality emeralds are more valuable than diamonds.",
        "Hearing is the fastest human sense. A person can recognize a sound in as little as 0.05 seconds.",
        "There are more possible iterations of a game of chess than there are atoms in the known universe.",
        "It can take a photon 40,000 years to travel from the core of the sun to the surface, but only 8 minutes to travel the rest of the way to earth.",
        "Basically anything that melts can be made into glass. You just have to cool off a molten material before its molecules have time to realign into what they were before being melted.",
        "A small percentage of the static you see on \"dead\" tv stations is left over radiation from the Big Bang. You're seeing residual effects of the Universe's creation.",
        "Written language was invented independently by the Egyptians, Sumerians, Chinese, and Mayans.",
        "If you were to remove all of the empty space from the atoms that make up every human on earth, the entire world population could fit into an apple.",
        "Honey does not spoil. You could feasibly eat 3000 year old honey. ",
        "If you somehow found a way to extract all of the gold from the bubbling core of our lovely little planet, you would be able to cover all of the land in a layer of gold up to your knees.",
        "To know when to mate, a male giraffe will continuously headbutt the female in the bladder until she urinates. The male then tastes the pee and that helps it determine whether the female is ovulating. ",
        "The Spanish national anthem has no words.",
        "The state sport of Maryland is jousting. ",
        "Dead people can get goose bumps.",
        "The dashed lines in between lanes on the road are about 10 feet long.",
        "Crows can caw in different dialects depending on where they are from.",
        "Bamboo can grow up to three feet in one day",
        "Eating 1,400 Slim Jims in one sitting will kill the average human."
    ]
    
    let fakes = [
        "Nuclear bombs can't pop balloons.",
        "Ducks can laugh depending on the kind of music you play them.",
        "Laughing for 30 seconds is equivalent to doing 15 sit ups.",
        "Before Will Smith was on Fresh Prince of Bel Air, he was a hot dog salesman.",
        "SpaceX's first rocketship was named Mickey-09, after founder Elon Musk's dog, Mickey.",
        "You can eat 1,400 slim jims without dying.",
        "Swans have best friends.",
        "If our solar system had an additional planet the size of Earth, the gravitational shift will cause our days to be 27 hours each.",
        "There are more hot dog stands in North America than cells in your body."
    ]
    
    mutating func randomFake() -> String {
        randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: fakes.count)
        
        return fakes[randomNumber]
    }
    
    mutating func randomReal() -> String {
        randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: facts.count)
        
        return facts[randomNumber]
    }
    
    mutating func randomFact() -> String {
        // exclusive
        factOrFake = GKRandomSource.sharedRandom().nextInt(upperBound: 2)
        
        if (factOrFake == 1) {
            return randomFake()
        }
        
        return randomReal()
    }
    
    func getFactNum() -> Int {
        return randomNumber + 1
    }
    
    func getFactOrFake() -> Int {
        return factOrFake
    }
    
    mutating func resetScore() -> Void {
        score = 0
    }
    
    mutating func increaseScore() -> Void {
        score += 1
    }
    
    func getScore() -> Int {
        return score
    }
    
    
}
