library(tidyverse)

# For more information on data import with
# the tidyverse way take a look at R for Data Science
# the book is great, make sure to come back here, too ;)
# https://r4ds.had.co.nz/data-import.html
f <- read_csv("FILE.csv")
# pipes %>% take the result of one line as input for the next line
sel <- f %>%
  filter(FREQUENCY == "A",
         TIME >= 2010,
         SUBJECT == "TOT") %>%
# let's focus on cols location, time value, because none
# of the other cols contain information, i.e., all their values
# are the same
  select(TIME, LOCATION, Value)

# the object sel is a three column long format classic now...
wide_out <- sel %>%
  pivot_wider(names_from = LOCATION,
              values_from = Value)


write_csv(wide_out,file = "wide_out.csv")
