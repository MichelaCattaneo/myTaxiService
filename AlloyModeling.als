
	--------------------------------	SIGNATURES   --------------------------------
open util/boolean
sig Strings{}
sig Date{}
sig Integer{}

sig User{
			email: one Strings
}

sig Visitor extends User{}

sig Passenger extends User{
			creditCard: lone CreditCard
}

sig TaxiDriver extends User{
			iD: one Strings,
			idArea: one Integer,
			availability: one Bool
}

abstract sig Request{
			area: one Area,
			taxiDriver: one TaxiDriver,
			rideTerminated: one Bool
}

sig PassengerRequest extends Request{
			passenger: one Passenger
}	

sig VisitorRequest extends Request{
			visitor: one Visitor
}

sig Reservation extends PassengerRequest{}

sig Area{
			id: one Integer,
			taxiDrivers: some TaxiDriver
}

sig CreditCard{}

 	--------------------------------	FACTS		--------------------------------

//there is always an available taxi in each area
fact oneAvailableTaxiInArea{
			all a : Area | (some td : TaxiDriver | (td in a.taxiDrivers and td.availability=True))
}

//enqueue taxi in his designated area
fact  enqueueTaxiInDesignatedArea{
			all a : Area |(no td : TaxiDriver | (td in a.taxiDrivers and td.idArea!=a.id))
}

// no different account with the same e-mail
fact emailUnicity{
			no disj v1, v2 :Visitor | v1.email = v2.email
}

//every request is forwarded to the taxi driver of the same area
fact taxiDriverInAreaOfRequest{
			all r : Request | r.taxiDriver.idArea=r.area.id
}

//it can not exist a taxi driver with the wrong area id
fact idAreaInTaxiDriver{
			all t : TaxiDriver | (one a : Area | t.idArea=a.id)
}

//no different areas with the same ID
fact idAreaUnicity{
			no disj a1,a2 : Area | a1.id=a2.id
}

//no different taxi driver with the same ID and email
fact emailIdUnicity{
			all t1,t2 :TaxiDriver | ((t1.email=t2.email and t1.iD=t2.iD) implies t1=t2)
}

// no different taxi driver with the same ID
fact idTaxiDriverUnicity{
			no disj t1, t2 : TaxiDriver | t1.iD = t2.iD
}

// a passenger request can be made only by one passenger
fact onePassengerPerPassengerRequest{
			all rp : PassengerRequest | (one p : Passenger | rp.passenger=p)
}

// a request can be made only in one area
fact oneAreaPerRequest{
			all r : Request | (one a : Area | r.area=a)
}

// a visitor request can be made only by one visitor
fact oneVisitorPerVisitorRequest{
			all rv : VisitorRequest | (one v : Visitor | rv.visitor=v)
}

//every taxi driver is associated to an area
fact allTaxiDriverInAQueue{
			all t : TaxiDriver | (one a : Area | #a.taxiDrivers>=1 and (one td : a.taxiDrivers | td=t))
}

//a taxi driver can not be available if the ride is not terminated 
fact taxiDriverUnavailable{
			all r : Request | (r.rideTerminated=False implies r.taxiDriver.availability=False)
}

	--------------------------------	ASSERTIONS		--------------------------------

// checks that the taxi drivers are properly enqueued in the correct area
assert enqueueTaxiInDesignatedArea{
			all a : Area |(no td : TaxiDriver | (td in a.taxiDrivers and td.idArea!=a.id))
}

check enqueueTaxiInDesignatedArea

// checks that there is always at least one available taxi driver in the areas
assert oneAvailableTaxiInAreas{
			all a : Area | (some td : TaxiDriver | (td in a.taxiDrivers and td.availability=True))
}

check oneAvailableTaxiInAreas

// checks that the request is forwarded to the taxi of the correct area
assert correctAreaTaxiRequest{
			all r : Request | (r.taxiDriver.idArea=r.area.id)
}

check correctAreaTaxiRequest

	--------------------------------	PREDICATES		--------------------------------
pred show{
#TaxiDriver=2
}
run show

//shows the request of a passenger
pred makeRequest(p : Passenger, r : PassengerRequest){
			r.passenger=p and #TaxiDriver=2
}
run makeRequest
