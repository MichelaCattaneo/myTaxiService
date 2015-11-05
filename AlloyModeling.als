// SIGNATURES
open util/boolean
sig Strings{}
sig Date{}
sig Integer{}

sig Visitor{
			email: one Strings,
		//	phoneNumber: one Strings
}

sig Account extends Visitor{
			name: one Strings,
			surname: one Strings,
		/*	dateOfBirth: one Date,
			gender: one Strings,
			password: one Strings,
			profilePicture: one Strings*/
}

sig Passenger extends Account{
			creditCard: one CreditCard
}

sig TaxiDriver extends Account{
			iD: one Strings,
			idArea: one Integer,
			availability: one Bool
}

sig Request{
		/*	id: one Integer,
			userPosition: one Strings,*/
			currentTime: one Integer,
			area: one Area,
			taxiDriver: one TaxiDriver,
			rideTerminated: one Bool
}

sig RequestPassenger extends Request{
		//	payByCreditCard: one Bool,
			passenger: one Passenger,
}	

sig RequestVisitor extends Request{
			visitor: one Visitor
}

sig Reservation extends RequestPassenger{
			departureTime: one Integer,
			/*origin: one Strings,
			destination: one Strings*/
}

sig Area{
			id: one Integer,
		//	position: one Strings,
			taxiDrivers: some TaxiDriver
}

sig CreditCard{
		/*	cardType: one Strings,
			firstName: one Strings,
			lastName: one Strings,
			cardNumber: one Integer,
			expirationDate: one Date,
			ccv: one Integer*/
}

// FACTS

/*fact emailUnicity{
			no disj v1, v2 :Visitor | v1.email = v2.email
}

fact oneCreditCardPerPassenger{
			all p : Passenger | (lone c : CreditCard | p.creditCard=c)
}

fact idUnicity{
			no disj t1, t2 : TaxiDriver | t1.iD = t2.iD
}

fact onePassengerPerPassengerRequest{
			all rp : RequestPassenger | (one p : Passenger | rp.passenger=p)
}

fact oneAreaPerRequest{
			all r : Request | (one a : Area | r.area=a)
}

fact oneVisitorPerVisitorRequest{
			all rv : RequestVisitor | (one v : Visitor | rv.visitor=v)
}*/
// ASSERTIONS
assert validReservation{
			all r : Reservation | #r.departureTime-#r.currentTime>=2
}

check validReservation

assert enqueueTaxiInDesignatedArea{
			all a : Area |(no td : TaxiDriver | (td in a.taxiDrivers and td.idArea!=a.id))
}

check enqueueTaxiInDesignatedArea

assert oneAvailableTaxiInAreas{
			all a : Area | (some td : TaxiDriver | (td in a.taxiDrivers and td.availability=True))
}

check oneAvailableTaxiInAreas

assert correctAreaTaxiRequest{
			all r : Request | (r.taxiDriver.idArea=r.area.id)
}

check correctAreaTaxiRequest
// PREDICATES
pred show{
}
run show

pred makeRequest(p : Passenger, r : RequestPassenger){
			r.passenger=p
}
run makeRequest
