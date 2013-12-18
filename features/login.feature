Feature: API
	In order to ensure quality
	As a user
	I want to be able to see an exampe of using pickle with cucumber
	
	Scenario: Bad login
		Given admin exists with first_name: "Nic"
		And bigdog exists
		Then a admin should exist with first_name: "Nic"
