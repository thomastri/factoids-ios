//
//  FactProvider.swift
//  Factoids
//
//  Created by Thomas Le on 8/31/17.
//  Copyright © 2017 Thomas Le. All rights reserved.
//

import GameKit
import SwiftySound
import AudioToolbox

struct FactProvider {
    
    var randomNumber = 0
    var factOrFake = 0
    var score = 0
    var highScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: "highScore")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "highScore")
        }
    }
    
    var fakeTracker = [Int]()
    var factTracker = [Int]()
    
    mutating func randomFake() -> String {
        
        // avoids duplicates each session
        repeat {
            randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: fakes.count)
        } while(fakeTracker.contains(randomNumber))
        
        fakeTracker.append(randomNumber)
        
        return fakes[randomNumber]
    }
    
    mutating func randomReal() -> String {
        
        // avoids duplicates each session
        repeat {
            randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: facts.count)
        } while(factTracker.contains(randomNumber))
        
        factTracker.append(randomNumber)
        
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
        
        submitHighScoreToGC(highScore)
    }
    
    func submitHighScoreToGC(_ highScore : Int) -> Void {
        // Submit score to GC leaderboard
        let bestScoreInt = GKScore(leaderboardIdentifier: "highScore")
        bestScoreInt.value = Int64(highScore)
        GKScore.report([bestScoreInt]) { (error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Best Score submitted to Leaderboard!")
            }
        }
    }
    
    func getFactNum() -> Int {
        return randomNumber + 1
    }
    
    func getFactOrFake() -> Int {
        return factOrFake
    }
    
    func correctSound () -> Void {
        Sound.play(file: "right.wav")
    }
    
    func incorrectSound() -> Void {
        Sound.play(file: "wrong.wav")
    }
    
    mutating func resetScore() -> Void {
        score = 0
        incorrectSound()
        
        // resets duplicate checker after game over
        factTracker.removeAll()
        fakeTracker.removeAll()
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        
    }
    
    mutating func increaseScore() -> Void {
        score += 1
        correctSound()
    }
    
    func getScore() -> Int {
        return score
    }
    
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
        "Gecko feet have millions of tiny hairs that stick to surfaces and let them climb walls and hang on with a single toe.",
        "The term \"astronaut\" comes from Greek words that mean \"star\" and \"sailor.\"",
        "The calcium in our bones and the iron in our blood come from ancient explosions of giant stars.",
        "The Nile crocodile can hold its breath underwater for up to 2 hours while waiting for prey.",
        "Jellyfish are not fish. They have no brain, heart, or bones.",
        "The Chinese giant salamander can grow to be 6 feet long, making it the largest salamander in the world.",
        "People reportedly prefer blue toothbrushes over red ones.",
        "People used to believe that kissing a donkey could relieve a toothache.",
        "Scientists say that the best time to take a nap is between 1 PM and 2:30 PM because that's when a dip in body temperature makes us drowsy.",
        "A day in the age of dinosaurs was just 23 hours long due to Earth's change in rotation speed.",
        "Hummingbirds' wings can beat 200 times a second.",
        "A seahorse can move its eyes in opposite directions to help it look for food and predators.",
        "To cook an egg, a sidewalk needs to be 158°F.",
        "A group of jellyfish is called a smack.",
        "It would take 100 Earths lined up to stretch around the the sun.",
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
        "Clouds cover about 60 percent of Earth at any given moment.",
        "Apes laugh when they are tickled.",
        "Some hyenas can digest skin and bones.",
        "The quills on African porcupines can be over 10 inches long.",
        "Some scientists believe that people who dream about an activity will actually get better at it in real life.",
        "Your hair contains traces of gold.",
        "Depending on the speed of the wind, some clouds travel up to 100 miles per hour (160 kph) across the sky.",
        "Opal has been discovered on Mars.",
        "George Washington loved exploring caves.",
        "The TV remote is the dirtiest item in a typical household, hospital, or hotel room.",
        "The finest quality emeralds are more valuable than the finest diamonds.",
        "Hearing is the fastest human sense. A person can recognize a sound in as little as 0.05 seconds.",
        "There are more possible iterations of a game of chess than there are atoms in the known universe.",
        "It can take a photon 40,000 years to travel from the core of the sun to the surface, but only 8 minutes to travel the rest of the way to earth.",
        "A small percentage of the static you see on \"dead\" tv stations is left over radiation from the Big Bang.",
        "Written language was invented independently by the Egyptians, Sumerians, Chinese, and Mayans.",
        "If you were to remove all of the empty space from the atoms that make up every human on earth, the entire world population could fit into an apple.",
        "Honey does not spoil. You could eat 3000 year old honey. ",
        "If you extracted all the gold from the Earth, you would be able to cover all of the land in a layer of gold up to your knees.",
        "To know when to mate, a male giraffe will continuously headbutt the female in the bladder until she urinates. The male then tastes the pee and that helps it determine whether the female is ovulating.",
        "The Spanish national anthem has no words.",
        "The state sport of Maryland is jousting. ",
        "Dead people can get goose bumps.",
        "The dashed lines in between lanes on the road are about 10 feet long.",
        "Crows can caw in different dialects depending on where they are from.",
        "Eating 1,400 Slim Jims in one sitting will kill the average human.",
        "Maine is the closest state to Africa.",
        "The male seahorse gets pregnant instead of the female seahorse.",
        "Society did not start eating apples regularly until around 1910.",
        "The practice of circumcision for non-religious purposes became popular to deter men from masturbating.",
        "Cereal was originally invented as a religious morning snack.",
        "JK Rowling was a single mother on welfare when she wrote the first Harry Potter novel.",
        "Rapper Eminem's favorite food is a beaf and bean burrito.",
        "Napoleon Bonaparte was 5 feet and 6 inches tall.",
        "Shrek was the first movie to win an Oscar for Best Animated Movie.",
        "Bananas don't grow on tress, but giant plants that look like trees.",
        "A goldfish has an average memory of about 5 months.",
        "Bulls are color-blind to red.",
        "S.O.S. doesn't actually stand for anything, it became a popular Morse code distress signal simply because it was easy to transmit.",
        "Due to the blood flow, the nails on your dominant hand grow faster than your non-dominant hand.",
        "High fives were invented in 1977.",
        "Instead of removing your original kidney during a transplant, doctors will place your new kidney in the pelvis.",
        "Nintendo was founded in the 1800s.",
        "It rains diamonds on Saturn and Jupiter.",
        "Wyoming only has two escalators.",
        "Fishing is the sport that causes the most American deaths per year.",
        "Mosquitos kill an average of 750,000 people per year.",
        "One 18-inch pizza is more pizza than two 12-inch pizzas.",
        "The difference in time between when the tyrannosaurus rex and the stegosaurus lived is greater than the difference in time between the T. rex and us.",
        "Bananas, pumpkins, and watermelons are classified as berries.",
        "There are more public libraries in the United States than there are McDonalds.",
        "You can orgasm after death.",
        "Cans were invented almost 50 years before the can-opener.",
        "There are more trees on earth than there are stars in the galaxy.",
        "There are more tigers in private collections in Texas than there are left in the wild.",
        "Elephants can produce rumbles through the ground to communicate with each other.",
        "Donald Trump was elected president of the United States.",
        "There is a species of shark that has a lifespan of ~400 years.",
        "The United States created incendiary bombs to be dropped by bats during World War II.",
        "Corn flakes were invented to prevent people from masturbating.",
        "If you are arrested for public urination in California you must register as a sex offender.",
        "On the hit sitcom Friends, Jennifer Anniston was originally up for the role of Monica and Courtney Cox was up for the role of Rachel.",
        "The US government tried to teach dolphins how to speak but the dolphins got too sexually excited. The government then tried to solve this problem by feeding the dolphins LSD.",
        "Before toilet paper, most Americans used corn cobs.",
        "A strawberry is not a berry.",
        "The average chocolate bar contains 3-8 insect legs.",
        "When hippos are angry, their sweat turns red.",
        "If you lift a kangaroo's tail off the ground, it can't jump.",
        "Billy goats urinate on their own heads to smell more attractive to females.",
        "During your lifetime, you'll salivate enough to fill two swimming pools",
        "The person who invented the frisbee was cremated and made into a frisbee.",
        "Movie trailers were originally shown AFTER the movie, which is why they are called 'trailers'.",
        "Heart attacks are more likely to happen on a Monday.",
        "In 2015, more people were killed trying to take a selfie than people in shark attacks.",
        "You cannot snore and dream at the same time.",
        "A baby octopus is about the size of a flea when it is born.",
        "The French language has 17 different words for 'surrender'.",
        "Sea otters hold hands when they sleep so they don't drift away from each other.",
        "Sea otters have pouches to store their favorite rocks.",
        "Birds can't pee.",
        "The average person walks the equivalent of twice around the world in a single lifetime.",
        "The Bible is the most shoplifted book in the world.",
        "George W. Bush was once a cheerleader.",
        "In Japan, Ronald McDonald is known as Donald McDonald.",
        "In Singapore, Ronald McDonald is known as Uncle McDonald.",
        "There is no McDonalds in Antartica.",
        "Snails can have up to 14,000 teeth.",
        "Froot Loops are all the same flavor.",
        "The human nose can recognize about 50,000 different smells.",
        "The last known dire wolf lived over 9000 years ago.",
        "Abraham Lincoln once pardoned someone after they were convicted of beastiality.",
        "Venus is hotter than Mercury, despite being further from the sun.",
        "Most cowboys in the Wild West were Mexican and African American.",
        "Movie theaters were some of the first public buildings to have air conditioning.",
        "In its early days, Hotmail had a security flaw that allowed users to log into any account using the password 'eh'.",
        "Rapper Soulja Boy did 'Crank Dat' at the ripe age of 16.",
        "If you invested $1000 into BitCoin in 2010, you could have over $1 billion in 2017.",
        "There are more people on FaceBook today than on Earth 200 years ago.",
        "There are more molecules in a cubic inch of water than there are stars in the observable universe.",
        "Fishing is the sport that kills the most Americans each year.",
        "The Twitter bird's name is Larry.",
        "In terms of bear attacks: if it is brown, lay down. If it is black, get back.",
        "The term 'Friend Zoned' was coined by popular sitcom Friends.",
        "Amazon originally started as a book-selling company.",
        "In North Korea, it is considered offensive to use a fork as an eating utinsel.",
        "French fries originate from Belgium.",
        "Toe wrestling was invented by the UK because they wanted to be the best-in-the-world at something.",
        "Canada won the second international toe-wrestling competition in 1976.",
        "Snoop Dogg got his name after Charlie Brown's Snoopy, his favorite cartoon as a child.",
        "There were originally only ten months in a year.",
        "Pluto is a planet.",
        "Pringles had a lawsuit trying to claim that Pringles weren't potato chips.",
        "'Wasabi' is usually just colored horseradish.",
        "Green peas are a popular pizza topping in Brazil.",
        "Chocolate was once used as a popular currency.",
        "Sardinia has a cheese that is intentionally filled with maggots.",
        "McDonald's sells 75+ burgers at any given second.",
        "Consuming bananas can help fight depression.",
        "Honey is made with bee vomit.",
        "The creator of Atari also created Chuck E. Cheese.",
        "Pretzels were invented as a religious snack. The twists represent crossed hands for prayer.",
        "Popsicles were invented by an 11 year old.",
        "Most crackers have holes in them to prevent air bubbles from ruining the baking process.",
        "China has a one-child only policy to fight overpopulation. Tens of thousands of babies are abandoned each year.",
        "Dentures used to made from the teeth of dead soldiers. RIP.",
        "A Roman emperor once made his horse a senator.",
        "A common Mayan sacrifice involved pulling a heart out of a living person.",
        "In ancient Egypt, people used to be smeared with honey in order to attracts flies away from the Pharoah. RIP.",
        "Romans used to use urine as mouthwash.",
        "The Austrian army once attacked itself and lost ~10,000 soldiers.",
        "Coffins used to be built with bells because being buried alive was so common.",
        "In medieval times, animals used to be put on trial.",
        "In Canada, women used to drink beaver-testicle potions as a form of contraception.",
        "Europeans from the 16th and 17th centuries used to eat corspes in effort to cure diseases.",
        "Saddam Hussein was given the key to the city of Detroit.",
        "Krakatoa had a volcanic eruption in 1883 that could be heard from 3,000 miles away.",
        "The sound of snow falling to the ground is actually static discharge the snow gains when it falls to the earth.",
        "The Pillars of Creation was first spotted by the Hubble in 1995. The Pillars of Creation also ceased to exist over 6,000 years ago.",
        "When Mt Everest was first measured, the number was so round that they added a few fake inches for believability.",
        "Naked mole rats, like Rufus, can't get cancer.",
        "From the first time Pluto was spotted in 1930 to the time it was demoted from being a planet 2006, Pluto didn't complete a single revolution around the sun.",
        "Orcas are a natural predator of moose.",
        "All of the planets in our solar system can fit in between the Earth and moon, but the Sun cannot.",
        "A cumulus cloud can weigh over 1,000,000 pounds, or roughly 454,000 kg.",
        "In a room of 23 people, there is a 50% chance that 2 of them have the same birthday.",
        "Russia is bigger than Pluto.",
        "There is a conspiracy theory that claims rapper Eminem is dead, and the Eminem we see today is an imposter.",
        "The sound your fingers make when you snap your fingers is just your middle finger hitting your palm.",
        "Much like how humans find puppies cute, elephants think humans are cute.",
        "Many dolphins can create games with actual winners and losers. When dolphins are transferred to different zoos, they teach their new dolphin friends the games they know.",
        "Squirrels tend to forget where their acorns are buried, inadvertedly planting trees.",
        "Sylvester Stallone once sold his dog, Butkus, for $40 for food. He later spent $15,000 to buy the dog back.",
        "Red Bull was once sued for false advertising because it did not in fact give you wings.",
        "It takes Puto 248 Earth-years to orbit the Sun just once.",
        "The first Olympic games were held in Olympia, which is how it got its name.",
        "Rapper Eminem once held an international top 30 score in Donkey Kong.",
        "Opium used in over 90% of heroin worldwide is produced in Afghanistan.",
        "1 in 4 Americans believe the Sun revolves around the Earth.",
        "Facebook has a 'Pirate' language setting.",
        "Many Kenyans practice the sport of naked night-running.",
        "The shortest basketball player was 3'2 tall.",
        "Wearing headphones for just one hour will increase bacteria in your ear by 700x.",
        "About $10 worth of raw popcorn can be sold for ~$1,000 at movie theaters.",
        "One drop of water contains one hundred billion billion atoms. Wowza.",
        "If you are an Alaskan citizen over the age of 6 months, you receive a check for $1,000 in oil dividends every year.",
        "During your lifetime, you'll grow about ~590 miles of hair.",
        "Coffee beans are actually fruit pits.",
        "A lightning bolt generates heat five times hotter than the surface of the sun.",
        "The Bank of America was originally called the Bank of Italy.",
        "The name 'Wendy' was created in Peter Pan. There are no recorded Wendys before that.",
        "The 'Hawaiian alphabet' only has 12 letters.",
        "Only female mosquitos will bite you.",
        "Mickey Mouse has won an Oscar.",
        "A 'jiffy' is a real unit of time.",
        "The cell phone was first invented in 1924.",
        "Iconic video game character Mario has his first ever appearance in Donkey Kong.",
        "Prior to the 1960s, men with long hair were not able to enter Disneyland.",
        "If a butterfly's body temperature drops below 86 F, it will not be able to fly.",
        "Venus spins in the solar system backwards. Every other planet in our solar system roates the same direction.",
        "The Yin-Yang symbol originated from Rome.",
        "Elephants can be pregnant for up to two years.",
        "Clown fish start off as males but turn into females as they grow.",
        "It is possible to still get hiccups as a fetus.",
        "The swastika was originally a symbol of peace by Buddhists.",
        "Your skin is your biggest organ. Probably.",
        "Mars is red because it is covered in rust.",
        "It takes a plastic container about 50,000 years before it starts to decay.",
        "The nest of a bald eagle can weigh up to 4,000 pounds, or ~1800 kg.",
        "Austrailla once engaged in a war against emus and lost.",
        "The computer term 'debugging' originated from the early technology days when a bug found in the circuits caused an error on your machine.",
        "The first minimum wage in the U.S. was $0.25/hr.",
        "Nintendo produced playing cards before producing video games.",
        "Humans blink about 4.2 million times a year.",
        "Chewing gum was invented by the Mayans over 300 years ago.",
        "The average life span of a taste bud is about 10 days.",
        "The Amazon rainforest produces about half of Earth's oxygen supply.",
        "It is considered rude to tip at a restaurant in Iceland.",
        "Months that start with a Sunday always have a Friday the 13th.",
        "In a typical deck of cards, the King of Hearts is the only King without a mustache.",
        "Tomatoes were once referred to as 'love apples' because people were thought to fall in love by eating them.",
        "There are over 2,000,000 combinations of sandwiches that can be created at Subway.",
        "Before she was Katy Perry, she was a Christian music singer named Katy Hudson.",
        "Gamers of popular mobile app 'Game of War' typically spend over $500 each."
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
        "Fish would get scared and swim away if you talked while fishing.",
        "Cars are illegal in Vietnam.",
        "Abraham Lincoln was considered America's first rapper.",
        "Balogna was originally created with non-meat products, hence the phrase 'That is a load of balogna'.",
        "The Shazam app was originally created for eavesdropping purposes.",
        "Eating chocolate will help you lose weight.",
        "Rapper Eminem got his name when his best friend, Proof, died by choking on an m&m.",
        "The Great Wall of China is the only man made structure that can be seen from space.",
        "The rotation of a toilet flush will differ depending on the hemisphere you are in.",
        "Einstein failed his math class.",
        "Humans existed the same time dinosaurs did.",
        "If you touch a baby bird, its mother will reject it due to the smell of humans.",
        "Police require a 24-hour waiting period before accepting a missing persons report.",
        "Bats are blind.",
        "A goldfish has an average memory of about 3 seconds.",
        "Your hair and nails will continue to grow after you die.",
        "The national seal for the United States was originally a Turkey.",
        "Americans eat more calories on Super Bowl Sunday than the rest of the world combined.",
        "Coconuts are technically considered mammals because they have hair and produce milk.",
        "Human males can only release two sperm during their lifetime: one for each testicle.",
        "One in ten men have a third nipple.",
        "During his time in the Navy, Barack Obama proteced his ship and crew from a pirate attack. After this attack, he left the Navy to pursue a life in politics.",
        "If you microwave a peanut for the right amount of time, it can turn into popcorn.",
        "Buzz Aldrin was the first man to legally have sex in space.",
        "There is a fruit found in Hawaii that has been known to let the consumer stretch their limbs an extra three to six inches.",
        "There is a natural phenomenon where explorers who visit the North and South pole within the span of one week develop bipolar disorder.",
        "Rupert Grint, who played Ron Weasley in the Harry Potter films, got his role when JK Rowling accidentally pushed him off a cruise ship.",
        "Lobsters are immortal until a predator kills them.",
        "Male penguins search the entire beach for a pebble to propose to the penguin of their dreams.",
        "In India, building a snowman is punishable by death.",
        "One in ten women admit to eating their own children at least once.",
        "In Jamaica, squirrels were often kept to teach kids how to climb trees.",
        "In certain cultures, a middle finger means 'peace among worlds'.",
        "Nikes were originally worn by Greek Gods.",
        "Benjamin Franklin had a blueprint for the world's first car. He just never got around to publishing it, which led to a feud between him and Henry Ford. This feud lasted until Franklin died.",
        "George Clooney requested nipples on his Batman suit in order to have a unique look from the other Batsuits.",
        "Neptune was first discovered by a nine year old boy in England named Thomas Lee.",
        "Snapchat was built by a 14 year old developer.",
        "The first living thing sent into space from Earth was a squirrel, Randolph, from Russia in 1952.",
        "Bill Gates and Steve Wozniak attended the same high school.",
        "Narwhals are mythical creatures.",
        "In the 1800s many Irish-Americans were mistaken as Elves.",
        "Kanye West's favorite show is Spongebob Squarepants.",
        "Brad Pitt killed Adolf Hitler in 1945, ending World War II.",
        "Actor Shia Labeouf is the last known cannibal.",
        "Ghengis Khan developed his own fast food chain that is still operating today.",
        "American 'football' was first created when a soccer ball was flattened in 1908 right before a tournament and they played with the ball anyways. This is why it's called 'football' in the United States.",
        "If you go into space without a space suit, your body will physically implode.",
        "Pluto, being a gaseous planet, has the same properties found in an ordinary plum. In other words, Pluto likely smells like a plum.",
        "The average software developer can bench press 300 pounds.",
        "Sharks kill more humans per year than any other wild animal.",
        "Due to lack of dynamite, part of Mount Rushmore was created using cannonballs.",
        "There are more atoms in a drop of water than drops of water in the entire world.",
        "If a snake bites you, you should suck the venom out so it doesn't spread through your body.",
        "Season 1 of American Idol aired before text-message based voting became popular, so watchers had to mail in their votes.",
        "Before he was a wrestler, Dwayne 'The Rock' Johnson studied to become a geologist.",
        "Over 80% of North American death-row inmates ask for fast food as their final meal.",
        "S. Truett Cathy, the creator of Chick Fil A, became a vegetarian four years after opening the first Chick Fil A restaurant.",
        "Thomas Edison was also a boxer.",
        "The phrase \"That's all folks\" was popularized by Benjamin Franklin.",
        "The last Harry Potter book only sold 5,000 copies in Canada in its first month due to printing issues.",
        "Police are also known as 'cops' because their badges were originally made out of copper.",
        "The popular video game Super Mario Bros was based off a true story.",
        "10% of Americans admit wanting to try cannibalism if it were legal and safe.",
        "The Lord of the Rings is loosely based off of America's founding fathers.",
        "Sharks can get dandruff.",
        "After Pearl Harbor, anime was illegal in the United States for almost a decade.",
        "In Canada, you can be arrested for running over a moose.",
        "The last known reindeer was spotted in Wyoming.",
        "Rapper T-Pain invented and made auto-tune popular in modern music.",
        "Rapper Kanye West no longer eats fish.",
        "Brain freeze kills 1-3 Americans every year.",
        "In the late 1600s, hiccups were a sign of witchcraft and was often a crime punishable by death.",
        "Carly Rae Jepsen made over $1B off her hit single 'Call Me Maybe'.",
        "After Stephen King's 'It' hit the movie theaters in 1990, the clown industry declined by almost 500% over the next three years.",
        "The discoverer of milk was arrested for beastiality.",
        "Rapper 50 Cent got his name because he only had 50¢ to his name when he released his debut album.",
        "95% of all statistics are made up.",
        "Henry Ford, inventor of the first car, regretted his invention after car accidents were introduced into the world. He spent his later years trying to ban automobiles.",
        "In 2016, 'Khaleesi' was the most popular name for newborn girls in the United States.",
        "The Russian language has more curse words than any other language.",
        "The smell of freshly mowed grass is actually chemicals that grass releases to warn other grass of the oncoming danger.",
        "The state mascot of Illinois is Superman.",
        "Your tongue has sections with taste buds for each flavor.",
        "Star Wars was based on a true story.",
        "Men cannot pee with an erection.",
        "Due to religious disputes, Neil Degrasse Tyson and Bill Nye the Science Guy have an ongoing feud.",
        "Before horses were popular in the United States, nearly 70% of people rode their slaves to the store as the main source of transportation.",
        "Michael Jordan's net worth increased by nearly $75 million after Space Jam released.",
        "During a televised fight, Bruce Lee once kicked a man so hard his opponent flew out of their shoes and socks. This was the origin of the term 'knock your socks off'.",
        "Squirrels are actually super-intelligent creatures who are plotting to destroy the world.",
        "North America and South America are actually one big country.",
        "Sylvester Stallone was actually born 'Sylvester Cipriani', but changed his last name to Stallone after discovering that his father was part horse.",
        "DJ Khaled pursued a career in philosophy before starting his career in music.",
        "SPAM is short for spiced ham.",
        "Lebron James and Kobe Bryant were in a two year feud regarding who would star in Space Jam 2.",
        "Clyde Tombaugh, the man who first discovered Pluto, named Pluto after Mickey Mouse's dog of the same name.",
        "The Sun revolves around the Earth.",
        "If men deny their existence hard enough, their nipples can disappear.",
        "Facebook Addiction Disorder is an official disorder defined by the American Psychology Association.",
        "McDonald's brought back its infamous Chicken Selects after a sick Vietnamese boy tweeted them asking about it.",
        "News isn't called news because it is new information. It's because information comes from all directions: North, East, West, and South.",
        "The Atlantic Ocean has the highest salt content of all oceans in the world because of the salty attitudes of America's East coast.",
        "Nickelback makes over $2 million every year on royalties for their memes.",
        "Nicolas Cage is the only living American who has met the Greek God Zeus.",
        "A typical $10,000 Rolex watch costs only ~$55 to make.",
        "Ford was the first company to introduce a three-point seat belt required in modern cars today.",
        "Most koala bears are female.",
        "Mens' ring fingers will always be longer than their index fingers, while womens' fingers are vice versa.",
        "A U.S. cop will typically eat 36 donuts a month.",
        "The first aquarium in the Cananda featured 'mermaids'.",
        "Steve Jobs is often credited for coming up with Star Wars before George Lucas.",
        "Tangerines are classified as berries, not citrus.",
        "Philadelphia has the largest population of hobo-gangs.",
        "The average person chews gum for 18 minutes before spitting it out.",
        "Hawaii citizens have an average lifespan of over 15 years more than the rest of the world.",
        "The chances of two snowflakes being the same are actually about 1 in 8,000.",
        "The Amazon Alexa has already replaced 15% of American jobs.",
        "11% of Canadians identify as part Moose.",
        "Elon Musk publicly identifies as a Martian.",
        "Bill Gates heavily advises against space exploration. He recommends instead we focus on improving the planet we already have.",
        "Half of all Europeans are born in a fast food restaurant.",
        "Dong Nguyen made over $20 million for his hit app Flappy Bird in the span of one year."
    ]
}
