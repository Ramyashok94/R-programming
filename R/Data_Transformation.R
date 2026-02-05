install.packages("tidyverse", dependencies = TRUE)

library(dplyr)

install.packages("nycflights13")

library(nycflights13)


?flights
View(flights)
nrow(flights)


# fliter operation using filter()
#syntax: filter(dataframe, filter based on variable)

#eg filter the flight on jan 1st of 2013. the flights dataframe for the year 2013

#to save the result in variable
jan1 <- filter(flights, month == 1, day == 1) # assigning to new variable because i want to store it.

#to print the result enclose in parenthesis
(jan1 <- filter(flights, month == 1, day == 1))

#for some arithmetic operation we cannot use the "==" operator because system cant display infinite no of digits.
#so use near() func in just cases
sqrt(2)^2 == 2

 #using near()
near(sqrt(2)^2 , 2)

(decornov<- filter(flights, month == 11 | month ==12))

#short hand to check that x in y x%in% y

dec_nov <- filter(flights, month %in% c(11, 12))


# sometime we require demorgans law !(x&y) = !x & !y
#eg: if you wanted to find flights that weren’t delayed (on arrival or departure) by more than two hours

(two_hour_delay <- filter(flights,!(dep_delay>120 & arr_delay >120)))

(two_hour_delay1 <- filter(flights,dep_delay<=120, arr_delay <=120))

#Missing values

NA > 5
10 == NA
NA + 10
NA / 2
NA == NA


# Let x be Mary's age. We don't know how old she is.
x <- NA
# Let y be John's age. We don't know how old he is.
y <- NA
# Are John and Mary the same age?
x == y

#If you want to determine if a value is missing, use is.na():
is.na(x)

#constructing dataframe with tibble

df <- tibble(x = c(1,NA,3))
(a<-filter(df,x>1))

(b<-filter(df,is.na(x)| x>1))


#exercise
#Had an arrival delay of two or more hours

(two_hrs_arr_delay = filter(flights,arr_delay >=120))

#Flew to Houston (IAH or HOU)
(flew_HOU = filter(two_hrs_arr_delay, dest %in% c("IAH","HOU")))

#Were operated by United, American, or Delta
(op_by = filter(flew_HOU, carrier %in% c('DL','AA','UA')))


#Departed in summer (July, August, and September)
(dep_summer = filter(op_by, month %in% c(7,8,9)))
View(dep_summer)

#Arrived more than two hours late, but didn’t leave late
(arr_dep = filter(dep_summer, (arr_delay>=120 & dep_delay>0)))

#Were delayed by at least an hour, but made up over 30 minutes in flight

(del_hr = filter(arr_dep,(dep_delay>=60 & arr_delay<(dep_delay-30))))

#Departed between midnight and 6am (inclusive)

(dep_midnight = filter(flights,(dep_time >= 0 & dep_time<=600))) #no result so used flight data set

#between(x, left, right, ..., ptype = NULL)
(dep_midnight = filter(flights,(dep_time >= 0 & dep_time<=600)))
#rewriting the code
(dep_midnight = filter(flights,
                       between(dep_time,0,600)))

#missing dep_time flights

(missing_dept = filter(flights,is.na(dep_time))) 

#dep_time ,dep_delay ,arr_time ,arr_delay  are NA ==> flights may be cancelled



#ARRANGE using arrange()
#This function takes dataframe, column to arrange . It takes multiple column too and arrange table and ties the order based on the preceding column

(arrge = arrange(flights, year,month,day))


#desc() is used to arrange in reverse because arrange by default uses asc order
(arrge = arrange(flights,desc(dep_delay)))


#arrange() takes the missng value and order it at the end of the result

(df1<- tibble(x=c(2,3,NA)))
(arrge1 = arrange(df1,x))

(arrge1 = arrange(df1,desc(x)))


#EXERCISE
# 1. How could you use arrange() to sort all missing values to the start? (Hint: use is.na()).

(arrge2 <- arrange(flights,desc(is.na(flights))))

View(arrge2)
(arrange(flights,arr_delay,dep_delay<0))

View(high_speed <- arrange(flights, desc((distance/air_time)*60)))

View(farest_flight<- arrange(flights, desc(distance)))


View(shortest<- arrange(flights,distance))


#SELECT

#select() is used to manipulate the column names and operations on column.

#1. Select dat by column 

(name_flights = select(flights,
                      year,
                      month,
                      day))

## Select all columns between year and day (inclusive)

(yearToDay = select(flights,
                  year:day ))

#Select all columns except those from year to day (inclusive)
(yearToDay = select(flights,
                    -(year:day )))

#matches names that begin 

(matchNames =  select(flights, starts_with("arr")))

#matches names that end

(matchNames =  select(flights, ends_with("delay")))

#matches names that contain

(matchNames =  select(flights, contains("time")))

#contains matching expression

(matchNames =  select(flights, matches("(.)\\1"))) # gives columns with more than one repeated characters

#selecting the range of values from the column
df2<- tibble(x1=1,x2=5,x3=8,x4=0) # column names are x1,x2,x3,x4

(filterusingselct = select(df2, num_range("x" , 0:5) )) # this will check column name with range like x0,x1,x2


#remane of column

(renameflight = rename(flights, tail_num=tailnum ))








  