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
			card: one CreditCard,
			request: some Request
}

sig TaxiDriver extends Account{
			iD: one String,
			availability: one boolean,
			workingArea: one Area,
			requests: some Request
}
			
sig Request{
			id: one int,
			passengerPosition: one String,
			payByCreditCard: one boolean,
			passenger: one Passenger,
			taxiDrivers: some TaxiDriver,
			area: one Area
}	

sig Reserve extends Request{
			departureTime: one int,
			origin: one String,
			destination: one String
}

sig Area{
			id: one int,
			position: one String,
			requests: some Request,
			taxiDrivers: some TaxiDriver
}

// FACTS

fact UserRequestAtATime{
}




// ASSERTIONS

// PREDICATES
