## DATA 3230 - How Much?? ##

library(tidyverse)
library(readxl)

## "How does the amount of garbage/refuse (in tons) that 
## the NYC Department of Sanitation reportedly collected 
## from each borough compare during September 2011?" ##

## To answer this question, let's first read in the data ##

nyc <- read_xlsx("Communicating How Much/NYC Trash Data.xlsx")

## Subset to September 2011 ##

nyc_sept11 <- nyc |>
  filter(MONTH == 9 & YEAR == 2011)

## Sum up REFUSETONSCOLLECTED variable by Borough ##

trash_tot <- nyc_sept11 |>
  group_by(BOROUGH) |>
  summarize(Sum_Trash = sum(REFUSETONSCOLLECTED))

## Take a glimpse of the result ##

print(trash_tot)

## Let's start by building a vertical bar chart! ##

## To do so, we will use the geom_bar function ##

trash_tot |>
  ggplot(aes(x=BOROUGH,y=Sum_Trash)) +
  geom_bar(stat='identity')

## Okay great! What are some problems?? ##

## First, the labels are poor. We can change those
## using the "labs" function: ##

trash_tot |>
  ggplot(aes(x=BOROUGH,y=Sum_Trash)) +
  geom_bar(stat='identity') +
  labs(x = "NYC Borough",
       y = "Total Refuse Collected (in tons)",
       title = "Trash Collectd in NYC by Borough",
       subtitle = "September 2011")

## Better! The grey color is a bit unappealing. We 
## can change the outline of the bars using the color
## argument and the fill of the bars using the fill
## argument: ##

trash_tot |>
  ggplot(aes(x=BOROUGH,y=Sum_Trash)) +
  geom_bar(stat='identity',color='black',fill='white') +
  labs(x = "NYC Borough",
       y = "Total Refuse Collected (in tons)",
       title = "Trash Collectd in NYC by Borough",
       subtitle = "September 2011")

## The grey gridded background is also problematic...
## we can make this change using a different theme! ##

trash_tot |>
  ggplot(aes(x=BOROUGH,y=Sum_Trash)) +
  geom_bar(stat='identity',color='black',fill='white') +
  labs(x = "NYC Borough",
       y = "Total Refuse Collected (in tons)",
       title = "Trash Collectd in NYC by Borough",
       subtitle = "September 2011") +
  theme_classic()

## This is better! ##

## What if we wanted to reorder the bars by value rather than
## by name? We can use the reorder function to sort in descending
## order by value ##

trash_tot |>
  ggplot(aes(x=reorder(BOROUGH,-Sum_Trash),y=Sum_Trash)) +
  geom_bar(stat='identity',color='black',fill='white') +
  labs(x = "NYC Borough",
       y = "Total Refuse Collected (in tons)",
       title = "Trash Collectd in NYC by Borough",
       subtitle = "September 2011") +
  theme_classic()

## This may be better displayed as a horizontal bar chart 
## rather than a vertical bar chart! ##

trash_tot |>
  ggplot(aes(x=Sum_Trash,y=reorder(BOROUGH,Sum_Trash))) +
  geom_bar(stat='identity',color='black',fill='white') +
  labs(y = "NYC Borough",
       x = "Total Refuse Collected (in tons)",
       title = "Trash Collectd in NYC by Borough",
       subtitle = "September 2011") +
  theme_classic()

## A dot chart is a similar alternative to a bar chart! ##

trash_tot |>
  ggplot(aes(x=reorder(BOROUGH,-Sum_Trash),y=Sum_Trash)) +
  geom_point(color='blue',fill='blue') +
  labs(x = "NYC Borough",
       y = "Total Refuse Collected (in tons)",
       title = "Trash Collectd in NYC by Borough",
       subtitle = "September 2011") +
  theme_classic()

## We can control the size of the dots by using the size argument
## within the geom_point function...the default value is 1.5
## Let's increase it to 3 and see if that helps ##

trash_tot |>
  ggplot(aes(x=reorder(BOROUGH,-Sum_Trash),y=Sum_Trash)) +
  geom_point(color='blue',fill='blue',size=3) +
  labs(x="NYC Borough",
       y="Total Refuse Collected (in tons)",
       title="Trash Collected in NYC by Borough",
       subtitle="September 2011") +
  theme_classic()

## What about a horizontal dot chart? 
## Notice, I have once again removed the - symbol from
## the reorder function to have the dots render in descending
## rather than ascending order ##

trash_tot |>
  ggplot(aes(x=Sum_Trash,y=reorder(BOROUGH,Sum_Trash))) +
  geom_point(color='blue',fill='blue',size=3) +
  labs(y="NYC Borough",
       x="Total Refuse Collected (in tons)",
       title="Trash Collected in NYC by Borough",
       subtitle="September 2011") +
  theme_classic()

## Let's try adding a dashed horizontal line going from the name
## of the borough to the point itself by making use of
## geom_segment ##

trash_tot |>
  ggplot(aes(x=Sum_Trash,y=reorder(BOROUGH,Sum_Trash))) +
  geom_point(color='blue',fill='blue',size=3) +
  geom_segment(aes(yend=BOROUGH),xend=0,color='gray',
               linetype='dashed') +
  labs(x="NYC Borough",
       y="Total Refuse Collected (in tons)",
       title="Trash Collected in NYC by Borough",
       subtitle="September 2011") +
  theme_classic() 
 



