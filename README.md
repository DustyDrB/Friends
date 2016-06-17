TO DO:

FRONTEND:
	-create main page that handles login/reg
	-create dashboard that:
		-displays the logged in user's name
		-has a logout link
		-displays a list of users who have poked you, ordered by # of pokes

		-has a menu of all OTHER users (not yourself), which contains:
			-alias
			-email
			-history of how many times each user has been poked
			-an option to poke each user
DATABASE:
	-should track registered users as well as logins
	-tracks pokes recieved and given
MODELS:
	-Queries to handle:
		-Registration
		-Login
		-Pokes
		-Logout
ROUTES:
	-Main page
	-Add a user (register)
	-Login a user
	-Add a poke
