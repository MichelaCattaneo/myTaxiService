// SIGNATURES

abstract sig Account{
			name: one String,
			surname: one String,
			dateOfBirth: one Date,
			gender: one char,
			email: one String,
			password: one String,
			phoneNumber: one String,
			profilePicture: one String
}

sig Passenger extends Account{
			card: one CreditCard
}

sig TaxiDriver extends Account{
			iD: one String,
			availability: one boolean,
			forwardedRequest: some Request
}
			
sig Request{
			id: one int,
			passengerPosition: one String,
			payByCreditCard: one boolean,
			passenger: one Passenger,
			area: one Area
}	

sig Reservation extends Request{
			departureTime: one int,
			origin: one String,
			destination: one String
}

sig Area{
			id: one int,
			position: one String,
			taxiDrivers: some TaxiDriver
}

sig CreditCard{
			cardType: one String,
			firstName: one String,
			lastName: one String,
			cardNumber: one int,
			expirationDate: one Date,
			ccv: one int
}

// FACTS

fact UserRequestAtATime{
}




// ASSERTIONS

// PREDICATES
