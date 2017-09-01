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
    var highScore = 0
    
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
        "Eating 1,400 Slim Jims in one sitting will kill the average human.",
        "Maine is the closest state to Africa."
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
        "There are more hot dog stands in North America than cells in your body.",
        "Birthmarks are caused by the fetus resting against the gestational sac walls.",
        "Americans eat more calories on Super Bowl Sunday than the rest of the world combined.",
        "If a police officer takes more than 10 minutes to approach your car you can legally drive away.",
        "Almond milkers are paid by the number of almonds they milk per day.",
        "The Great Wall of China ended up causing a mass extinction when completed, due to many species of animals being blocked from their traditional breeding grounds.",
        "The phone number for emergencies is 911 because of the 9/11 attacks.",
        "On average, 50 flamingos per year commit suicide due to denial of their own sexual preference.",
        "Stop signs that are outlined in white are optional.",
        "There are more stars in our galaxy than trees on Earth.",
        "57% of all sexual predators in the United States live in Florida.",
        "You and I both put $20 in a box ($40). I sell you the box for $30. We both make $10 profit.",
        "They are called buzzards in the air, and vultures once they've landed.",
        "Whales ejaculate up to 10 gallons of sperm per mating session and only 1/3 makes into the mate, that's why sea water is so salty.",
        "Most wine is just a mix of grape juice and vodka.",
        "The plural of moose is meese.",
        "On average, 1 in 6 children will be abducted by the Dutch.",
        "The Hunger Games is based on a true story and Pocahontas was actually the first winner.",
        "Some beavers have a natural genetic tendency to tail-twitch while they sleep. These beavers have evolved to sleep on top of the dams they build, packing the mud while they rest.",
        "Firetrucks are painted red because red paint molecules are the smallest making them the most aerodynamic.",
        "When a wombat dies, its children will instinctively start crying wherever they are in the world.",
        "If the Earth was 100 meters closer to the sun, it would burn up and if it was 100 meters further from the sun, it would freeze.",
        "Elephants have been observed to pair off in same sex relationships, and research indicates that they use their trunks to satisfy their partners sexually.",
        "Bob Barker made more money on The Price is Right than all of the contestants combined.",
        "Benjamin Franklin designed a device similar to a modern cellphone, and in his later years could be seen walking around with a stone pressed to his ear, pretending to talk to dead relatives.",
        "The rhinoceros is the only other animal capable of sarcasm.",
        "Humans have more in common genetically with trees than they do with mice.",
        "Pop Rocks are illegal in China and are sold like narcotics by drug dealers.",
        "Experts estimate that by the year 2100 there will be more provinces in Canada than states in the US.",
        "Martial arts star Jackie Chan played college hockey and initially pursued a career in the NHL before turning to films.",
        "146 is the only even number not divisible by 2.",
        "No British monarch has ever died on a Thursday.",
        "The Fourth of July was celebrated on the second Tuesday in June until the adoption of the Gregorian calendar.",
        "The geographic center of the continental United States is just outside Carson City, Nevada.",
        "Due to a clerical error, for a brief period in 1923 the United States was part of the Soviet Union.",
        "36% of all penguins have chlamydia.",
        "Pluto isn't a planet.",
        "Pomegranate seeds, like apple seeds, have cyanide in them. The problem with this though is that since you eat the pomegranate seeds purposefully, you can eat a limit of 50 pomegranates before you start to feel effects.",
        "Cracking your knuckles causes arthritis.",
        "Florida is the closest state to Africa.",
        "The colored squares at the bottom of toothpaste tubes identify the composition of the toothpaste.",
        "You can't see your shadow in a mirror because mirrors reflect light and a shadow is an absence of light.",
        "If you ask a cop, they have to give you a snack.",
        "Automobile exhaust is the primary cause of global warming.",
        "Half of all marriages end in divorce.",
        "The word \"literally\" originally meant \"of the literature\", or as we would say today, fictionally.",
        "Rocks are actually soft,but harden when touched.",
        "New Zealand was discovered in 1969 when ‎Neil Armstrong spotted it from space.",
        "No matter how fast you go, automatic doors will open in time.",
        "There are more stars in the galaxy than atoms in the universe.",
        "If you soak a raisin in grape juice, it turns into a grape.",
        "If you type your PIN key at an ATM backwards, it will work but also alarm the police. You can use this in case you're being forced to withdraw money.",
        "We swallow spiders in our sleep. In your lifetime, you will swallow about 11 spiders while sleeping.",
        "Blood is actually blue until it comes in contact with oxygen.",
        "Vin Diesel is from Kenya, but he is albino.",
        "You weigh less at night because the gravity of the moon is pulling you toward it.",
        "People thought the world was flat until Columbus proved them wrong.",
        "Humans only use 10% of our brains.",
        "25% of the sun is composed of helium, which is why it floats in space.",
        "North Dakota is actually a myth invented by South Dakota to hide illegal government nuclear test sites.",
        "The \"daddy long leg\" spider is the most venomous in the world but its mouth is too small to break the skin of humans.",
        "If you press Up + B it's a higher chance of capturing Pokemon.",
        "Obama has attempted multiple times to pass a law that allows a third term for minorities.",
        "Carrots improve your eyesight.",
        "Microwaving your iPhone will charge it.",
        "Cracker Jack was originally the title of a newspaper comic that was popular after World War I, about a boy and his dog that went on adventures.",
        "Sleeping with a fan on beside your bed can kill you.",
        "Giraffe tongues are blue so that they don't get sunburned.",
        "All American police have to legally tell you they are a cop.",
        "You lose most of your body heat through your head.",
        "Lightning follows the path of least resistance, which is why France suffers from the most lightning strikes.",
        "Dinosaurs had big ears, but everyone forgot this because dinosaur ears don't have bones.",
        "Neapolitan ice cream has strawberry, chocolate, and vanilla because those were Napoleon Bonaparte's favorite flavors.",
        "All dogs are male and all cats are female.",
        "Swallowing gum will make it stay in your stomach for years.",
        "That Van Gogh cut off his ear for a lover.",
        "To get Mew you need to use Strength on that truck.",
        "Embassies are soil of their home country and the receiving country has no jurisdiction whatsoever there.",
        "If you swallow watermelon seeds you'll grow a watermelon in your belly.",
        "Spaghetti grows on trees.",
        "Fish would get scared and swim away if you talked while fishing."
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
        // does not include upper bound
        factOrFake = GKRandomSource.sharedRandom().nextInt(upperBound: 2)
        
        if (factOrFake == 1) {
            return randomFake()
        }
        
        // factOrFake == 0
        return randomReal()
    }
    
    mutating func updateAndGetHighScore() -> Int {
        updateHighScore()
        return highScore
    }
    
    mutating func updateHighScore() -> Void {
        if (score >= highScore) {
            highScore = score
        }
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
