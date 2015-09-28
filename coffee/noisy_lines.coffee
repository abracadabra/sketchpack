$ = require "jquery"

# Our main sketch object:
coffee_draw = (p5) ->

	p5.setup = () ->

		frameWidth = $(window).width()
		frameHeight = $(window).height()
		bg = [38, 38, 38]

		p5.size frameWidth, frameHeight
		p5.background(bg[0], bg[1], bg[2])

		# create an array to store our "beans"
		# (to be created below)
		@beans = []
		@maxBeans = 5000
		@rectWidth = 20
		@rectHeight = 20
		@rectX = frameWidth/2 - @rectWidth/2
		@rectY = 150
		@boundX = @rectX + @rectWidth
		@boundY = @rectY + @rectHeight

	p5.draw = () ->
		# p5.println p5.frameCount
		# p5.println @beans.length
		p5.noFill()
		p5.stroke(255)
		p5.rect(@rectX, @rectY, @rectWidth, @rectHeight)

		x_off = p5.frameCount * 0.0005 + @rectX
		y_off = x_off + p5.frameCount * 0.0005 + @rectY

		# x = p5.noise(x_off) * p5.width
		x = p5.noise(x_off) * @rectWidth + @rectX
		# y = p5.noise(y_off) * p5.height
		y = p5.noise(y_off) * @rectHeight + @rectY

		# if x > @boundX
		# 	x = x*-1
		# else if x < @rectX


		# if y > @boundY

		# else if y < @rectY

		vel = 10
		accel = -0.0003
		x_inc = 0.0005
		y_inc = 0.0005

		# every 20 frames, we'll create a "bean"
		if p5.frameCount % 10 == 0 && @beans.length < @maxBeans
			#create new bean
			bean = new Bean(p5, {
				x: x
				y: y
				x_off: x_off
				y_off: y_off
				vel : vel
				accel : accel
				x_inc : x_inc
				y_inc : y_inc
			})
			#add to bean array
			@beans.push(bean)

		# go through the list of "@beans" and draw them
		bean.draw() for bean in @beans


# a helper class that will come into play soon

class Bean
	# when creating a new bean instance
	# we'll pass in a reference to processing

	# and an options object
	constructor: (@p5, opts) ->
		# set the initial values for bean's attributes
		@x = opts.x
		@y = opts.y
		@x_off = opts.x_off
		@y_off = opts.y_off
		@vel = opts.vel
		@accel = opts.accel
		@x_inc = opts.x_inc
		@y_inc = opts.y_inc

	# we'll call this once per frame, just like our main
	# object's draw() method
	draw: () ->

		# only do the following if we have positive velocity
		return unless @vel > 0

		# increment our noise offsets
		@x_off += @x_inc
		@y_off += @y_inc

		# adjust our velocity 
		# by our acceleration
		@vel += @accel

		# use noise, offsets and velocity 
		# to get a new position
		@x += @p5.noise(@x_off) * @vel - @vel/2
		@y += @p5.noise(@y_off) * @vel - @vel/2

		@set_color()

		# draw a point
		@p5.point(@x, @y)

	set_color: () ->

		# we're primarily interested in changing the hue
		# of the draw color, therefore we make our lives
		# easier by setting the color mode to HSB
		@p5.colorMode(@p5.HSB, 360, 100, 100)

		# the hue will now be a function of our good friend
		# noise, and the average of the x and y offsets
		h = @p5.noise((@x_off+@y_off)/2)*360
		s = 100
		b = @p5.noise((@x_off+@y_off)/2)*100
		a = @p5.noise((@x_off+@y_off)/2)*100

		# and set the stroke
		@p5.stroke(h, s, b, a)

# wait for the DOM to be ready, 
# create a processing instance...
$(document).ready ->
	canvas = document.getElementById "processing"

	processing = new Processing(canvas, coffee_draw)