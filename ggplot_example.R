## Example: ggplot2 ##

library(ggplot2)
str(mpg)

### qplot ###
qplot(displ,hwy,data = mpg)

with(mpg,plot(displ,hwy))
# color
qplot(displ,hwy,data = mpg,color=drv)

# add geometry

qplot(displ,hwy,data = mpg,geom=c("point","smooth"))

# histogram
qplot(hwy,data=mpg,fill=drv)

# panels
qplot(displ,hwy,data = mpg, facets = .~ drv)

qplot(displ,hwy,data = mpg, facets = drv ~.)
## histogram in panels
qplot(hwy,data=mpg,facets = drv ~.,binwidth=2)


str(maacs)
