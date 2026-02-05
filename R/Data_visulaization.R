#installing tidyverse
install.packages("tidyverse")
#reloading tidyverse
library(tidyverse)

#view mpg datset
view(mpg)

#Template for graphics
#ggplot(data = <DATA>) + <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))


#using mpg dataset from ggplt2 to draw a scatter plot using geom_point
ggplot(data=mpg)+geom_point(mapping= aes(x=displ,y=hwy))

ggplot(data=mpg)

#make scatter plot of hwy and cyl

ggplot(data = mpg)+ geom_point(mapping = aes(x=hwy,y=cyl))

#What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
ggplot(data=mpg)+geom_point(mapping = aes(x=class,y=drv)) # we could figure out the pattern which car use which drv.Most of the model cars uses combination of drv.


#Add aesthtic to the plots like size,color, and shape
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy, color = class)) #here class is another variable in mpg
#this add color to the plots and legend to the graph. this process is called "scaling"

#size
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy, size = class))  # warning will pop because we are mapping the ordered variable to the unordered variable

#shape
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy, shape = class)) #here SUV's will not get shapes because ggplots will give only 6 shapes at a time.


#alpha(transparency)
ggplot(data=mpg)+geom_point(mapping = aes(x=displ,y=hwy, alpha = class))


#for manual aesthetic for the plots we will write outside aes() because aes() collectes aesthetic from data variables and pass it to the layer mapping.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

#EXERCISE
#1. What’s gone wrong with this code? Why are the points not blue?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue")) #because the color is given manual value which should be outside the aes() function and inside geom_point

# 2. Which variables in mpg are categorical? Which variables are continuous? (Hint: type ?mpg to read the documentation for the dataset). How can you see this information when you run mpg?

#to find categorical and continuous variable, below code is used
str(mpg) #if chr or fct means categorical, int or num means continuous variables
#here: tibble [234 × 11] (S3: tbl_df/tbl/data.frame)
# $ manufacturer: chr [1:234] "audi" "audi" "audi" "audi" ...
# $ model       : chr [1:234] "a4" "a4" "a4" "a4" ...
# $ displ       : num [1:234] 1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
# $ year        : int [1:234] 1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
# $ cyl         : int [1:234] 4 4 4 4 6 6 6 4 4 4 ...
# $ trans       : chr [1:234] "auto(l5)" "manual(m5)" "manual(m6)" "auto(av)" ...
# $ drv         : chr [1:234] "f" "f" "f" "f" ...
# $ cty         : int [1:234] 18 21 20 21 16 18 18 18 16 20 ...
# $ hwy         : int [1:234] 29 29 31 30 26 26 27 26 25 28 ...
# $ fl          : chr [1:234] "p" "p" "p" "p" ...
# $ class       : chr [1:234] "compact" "compact" "compact" "compact" ...
> 
summarise(mpg)
#Continuous variables → min, max, quartiles

# Categorical variables → counts for each level

#str() is used to find the variable type

# 3. Map a continuous variable to color, size, and shape. How do these aesthetics behave differently for categorical vs. continuous variables?
ggplot(data = mpg)+ geom_point(aes(x=displ, y=hwy, color = year))
ggplot(data = mpg)+ geom_point(aes(x=displ, y=hwy, size = cty))
#4. What happens if you map the same variable to multiple aesthetics?
ggplot(data = mpg)+ geom_point(aes(x=displ, y=hwy, size = year, color = year))
#5 . What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point)
?geom_point
# For shapes that have a border (like 21), you can colour the inside and
# outside separately. Use the stroke aesthetic to modify the width of the
# border
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "green",shape = 14, stroke = 0.5)



#5. What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)? Note, you’ll also need to specify x and y.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))


# Facets

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
               facet_wrap(~class,nrow=2)

#facet-grid

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))+
  facet_grid(drv~cyl)

#we also use "." instead of variable name
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))+
  facet_grid(.~cyl)


#Exercise
ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))+
  facet_wrap(~cyl,nrow=2)

#2. What do the empty cells in plot with facet_grid(drv ~ cyl) mean? How do they relate to this plot? 
#the empty cell means no observation for r-4 and r-5. the below plots gives  a scatter plot with drv on the x axes and cyl in the y axes and clearly stated that drv r has no observations for cyl 4 and 5 in the data set
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

#3. What plots does the following code make? What does . do?
#The below code assign the facet row and no facet column. The "." means no variable for the column side and it splits the facet by row variable.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

# the below code has no facet row variable and "." indicates to split the facet by column variable.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)

# 4. Take the first faceted plot in this section:
# are the advantages to using faceting instead of the colour aesthetic? What are the disadvantages? How might the balance change if you had a larger dataset?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# Advantage;
#Using facet we can view the datasets into separate panels and view clearly with facet variable without clutters.
#We can able to discover patterns within the group.

#Disadvantage:
#facets occupies more space and we cant create pattern out of the group. whereas colors helps to create a pattern for overall dataset by keeping the group together.
#Also colors are confusing as dataset growth because of overlapping of data

#How might the balance change if you had a larger dataset?
#for larger datasets, facets are helpful for group wise comparison though too many facets still reduce the readbility.


# 5. Read ?facet_wrap. What does nrow do? What does ncol do? What other options control the layout of the individual panels? Why doesn’t facet_grid() have nrow and ncol arguments?
#nrow and ncol represent the number of rows and number of columns
#scales => default values =>fixed but we can change to free or free in dimension xor y as free_x or free_y
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2,scales = "free")

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2,scales = "free_x")

#Strip.position # keep the facet variable label top/bottom/left/right

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2,scales = "free", strip.position = "bottom")

#axes

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2, axes="all")

#dir =>final layout h for horizontal(default) , v for vertical, or top as t, left as l, bottom as b, right as r. for eg tr represent top right the first panel of table starts from top right and fills from right to left

ggplot(data = mpg)+
  geom_point(mapping= aes(x=displ, y= hwy))+
  facet_wrap(~class, nrow = 2, dir = "tr")
#Why doesn’t facet_grid() have nrow and ncol arguments?
# because the no.of rows and columns are determined by the number level of the variable assigned to row and column in facet_grid

#When using facet_grid() you should usually put the variable with more unique levels in the columns. Why?
#the more unique level in the column makes it wider and readable whereas if the row has more level , it makes the plot taller , which reduces the readability o fthe plots.

#1. What geom would you use to draw a line chart? A boxplot? A histogram? An area chart

ggplot(data=mpg, mapping= aes(x=displ, y= hwy))+
  geom_line()

#for box plot , one categorical and one continuous variable gives a clear view of graph. if you compare 2 continuous variable, boxplot ingore one and gives a single box in the graph with warning in the console.

ggplot(data = mpg)+
  geom_boxplot(aes(x=class, y= hwy)) 

# A histogram takes only x axis and gies the frequency / count in the y axis. this is automatically assigned by ggplot. the x axis cannot be categorical.
# histogram is a summary of the variable in the x axis.
ggplot(data = mpg)+
  geom_histogram(aes(x=displ))
# below code throws error
ggplot(data = mpg)+
  geom_histogram(aes(x=class))


# 2. Run this code in your head and predict what the output will look like. Then, run the code in R and check your predictions.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE) # standard error= false which will remove the shaded line around the smooth line.Run the below code, to see the shaded line.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"))


#3. What does show.legend = FALSE do? What happens if you remove it?
#Why do you think I used it earlier in the chapter?

ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

# ggplot automatically assign legend for color aesthetic, so show.legend= false will disable the legend.
#applying the legand code for another scenario.
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class), show.legend = FALSE) + 
  geom_smooth(data = filter(mpg, class == "subcompact"))
#Will these two graphs look different? Why/why not?

#both syntax gives same result 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# 6. Recreate the R code necessary to generate the following graphs.

#graph 1
ggplot(data= mpg,mapping= aes(x=displ, y= hwy))+
  geom_point()+
  geom_smooth(se=FALSE)

#graph 2
ggplot(data= mpg,mapping= aes(x=displ, y= hwy))+
  geom_point()+
  geom_smooth(mapping=aes(shape=drv),se=FALSE)

#graph 3
ggplot(data= mpg,mapping= aes(x=displ, y= hwy))+
  geom_point(mapping=aes(color=drv))+
  geom_smooth(mapping=aes(color=drv),se=FALSE)

#graph 4
ggplot(data= mpg,mapping= aes(x=displ, y= hwy))+
  geom_point(mapping=aes(color=drv))+
  geom_smooth(se=FALSE)

#graph 5
ggplot(data= mpg,mapping= aes(x=displ, y= hwy))+
  geom_point(mapping=aes(color=drv))+
  geom_smooth(mapping=aes(linetype = drv,),se=FALSE)

#graph 6
ggplot(data= mpg,mapping= aes(x=displ, y= hwy))+
  geom_point(mapping=aes(color=drv))