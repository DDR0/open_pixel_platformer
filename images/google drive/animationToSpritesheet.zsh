gifs=`find . -iname '*.gif'`
echo "Queuing $(echo "$gifs" | wc -l) gif animations to be converted to png spritesheets. Queued images may take a while to process in the background."
echo "$gifs" | while read gif; do
	png=${gif/.gif/.png} #convert *.gif filename to *.png filename.
	#echo queued "$gif"
	
	# Explanation of montage command:
	# "$gif" \
	# -tile x1 -geometry +0+0 \ #Set up the tiles.
	# -border 1 -bordercolor \#F9303D -compose src -define 'compose:outside-overlay=false' \ #Draw a 1-px red border around the image, so it's easier to find frames. -compose is needed to make the border not fill in the transparent pixels in the image, and -define is needed to make the -compose not erease the previous gif frames we're compositing as we draw each subsequent one.
	# -background "rgba(0, 0, 0, 0.0)" \ #Set the background to stay transparent, as opposed to white. (-alpha On seems to have no effect)
	# -quality 100 \ #The default quality is 92, but since we're dealing with pixel art we want the fidelity.
	# "$png" & #Run all the conversions in parallel, let the OS figure out scheduling. Replace with something smarter if things start lagging too much.
	
	montage \
		"$gif" \
		-tile x1 -geometry +0+0 \
		-border 1 -bordercolor \#F9303D -compose src -define 'compose:outside-overlay=false' \
		-background "rgba(0, 0, 0, 0.0)" \
		-quality 100 \
		"$png" &
done