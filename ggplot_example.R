## Example: ggplot2 ##

library(ggplot2)
str(mpg)

### qplot ###
qplot(displ,hwy,data = mpg)

with(mpg,plot(displ,hwy))
# color
qplot(displ,hwy,data = mpg,color=drv)
