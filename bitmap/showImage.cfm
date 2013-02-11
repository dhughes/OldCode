<cfparam name="url.image" default="test" />
<h1>Flex Screen Capture</h1>
<p>Here is your image from the Flex application</p>
<cfoutput><img src="images/#url.image#.jpg" /></cfoutput>
