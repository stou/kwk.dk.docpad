# The DocPad Configuration File
# It is simply a CoffeeScript Object which is parsed by CSON
docpadConfig = {

	# Render Passes
    # How many times should we render documents that reference other documents?
    renderPasses: 2  # default

	# =================================
	# Template Data
	# These are variables that will be accessible via our templates
	# To access one of these within our templates, refer to the FAQ: https://github.com/bevry/docpad/wiki/FAQ

	templateData:

		# Specify some site properties
		site:
			# The production url of our website
			#url: "http://kwk.dk"
			url: 'http://stou-nodejs.herokuapp.com'

			# Here are some old site urls that you would like to redirect from
			# oldUrls: [
			# 	'www.kwk.dk',
			# 	'stou-nodejs.herokuapp.com'
			# ]
			oldUrls: [
			]

			# The default title of our website
			title: "Kolding Windsurfing Klub"

			# The author of the site
			author: "Rasmus Stougaard"

			# The website description (for SEO)
			description: """
				Kolding Windsurfing Klub blev stiftet i 1992. Det har siden klubbens start, været vort formål at udbrede sporten og fordre unge talenter. Surfskolens dygtige DS uddannede instruktører, underviser over 100 elever hver sommer, det vil sige at vi stadig er en af de førende surfskoler i landet. Vi har Klubaften med surfskole 2 gange ugentligt i sommerhalvåret, hvor elever i alle aldersklasser, begyndere som øvede, bliver undervist efter Dansk Sejlunion’ s surfskole kursussæt windsurfer 1 og windsurfer 2. Hvis du er i tvivl om windsurfing er noget for dig, så kom forbi klubben på klubaften, hvor du gratis kan prøve at windsurfe 1. gang. Hele sommeren er fyldt med aktiviteter i Kolding windsurfing klub, og medlemmerne må også bruge klubbens område på andre dage end på klubaftener.
				"""

			# The website keywords (for SEO) separated by commas
			keywords: """
				Windsurfing, surf, SUP, stand up paddle, Kolding, surfskole, instruktion, den blå lejeplads
				"""

			# The website's styles
			styles: [
				'/css/style.css'
				'/js/google-code-prettify/prettify.css'
				'/css/jquery.googleslides.css'
			]

			# The website's scripts
			scripts: [
				# '//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js'
				'/js/vendor/modernizr-2.6.2.min.js'
				'/js/plugins.js'
			]


		# -----------------------------
		# Helper Functions

		# Get the prepared site/document title
		# Often we would like to specify particular formatting to our page's title
		# we can apply that formatting here
		getPreparedTitle: ->
			# if we have a document title, then we should use that and suffix the site's title onto it
			if @document.title
				"#{@document.title} | #{@site.title}"
			# if our document does not have it's own title, then we should just use the site's title
			else
				@site.title

		# Get the prepared site/document description
		getPreparedDescription: ->
			# if we have a document description, then we should use that, otherwise use the site's description
			@document.description or @site.description

		# Get the prepared site/document keywords
		getPreparedKeywords: ->
			# Merge the document keywords with the site keywords
			@site.keywords.concat(@document.keywords or []).join(', ')

		getPreparedSiteAuthor: -> 
			@site.author

	# =================================
	# DocPad Events

	# Here we can define handlers for events that DocPad fires
	# You can find a full listing of events on the DocPad Wiki
	events:

		# Server Extend
		# Used to add our own custom routes to the server before the docpad routes are added
		serverExtend: (opts) ->
			# Extract the server from the options
			{server} = opts
			docpad = @docpad

			# As we are now running in an event,
			# ensure we are using the latest copy of the docpad configuraiton
			# and fetch our urls from it
			latestConfig = docpad.getConfig()
			oldUrls = latestConfig.templateData.site.oldUrls or []
			newUrl = latestConfig.templateData.site.url

			# Redirect any requests accessing one of our sites oldUrls to the new site url
			server.use (req,res,next) ->
				if req.headers.host in oldUrls
					res.redirect(newUrl+req.url, 301)
				else
					next()
}

# Export our DocPad Configuration
module.exports = docpadConfig