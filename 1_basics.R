#===============================================================================
# R PROGRAMMING WORKSHOP - 25-Sep-2020
#===============================================================================
# THE BASICS
# * RStudio
# * Data formats: scalar, vector, matrix, data frame
# * Subsetting vectors
# * Date classes: number, string/character, boolean/logical
# * Setting the working directory + listing local files
# * Getting help
#===============================================================================

#-------------------------------------------------------------------------------
# General parameters / settings for a script should go at the top:
#-------------------------------------------------------------------------------
3 + 4

#-------------------------------------------------------------------------------
# Data formats: scalars and vectors
#-------------------------------------------------------------------------------
# Vectors are simple lists with each item being of the same type.
# Scalars are really just vectors with a single item.
# Some useful vectors are 'built' into R:
# (place the cursor any where in a line of code and press Ctrl-Enter to execute
# the code / Cmd-Enter on a Mac)
# Results / output will appear in the 'Console' window below
letters
LETTERS
month.abb
month.name

1:10

# Vectors can be generated using the c() function:
print("Hello")
cat("Hello")
help(package="base")
c(14, 6, 2016)

#-------------------------------------------------------------------------------
# Variables
#-------------------------------------------------------------------------------
# Usually data are stored in named VARIABLES
# * Variables can be long
# * Variables CANNOT contain spaces
# * Variables CANNOT start with a number (but numbers can appear elsewhere in the name)

# Two scalars:
my.first.variable <- "Hello world!"
my.second.variable <- 2019

# Use 'print()' or 'cat()' command to display the contents of a variable:
# Output from 'print()' is preceded by row numbers in square brackets:
print(my.first.variable)
print(my.second.variable)

# A vector:
v1 <- c(14, 6, 2016)

# Just the variable is equivalent to 'print()'
v1 # same as print(v1)

# Output from 'cat()' has no row numbers:
cat(v1)

# The 'View()' function opens a new tab - mostly used to inspect large tables:
View(v1)

# A vector containing text:
v2 <- c("Hello", "world", "!")
print(v2)

# Vector items can be 'glued' together using the paste() function:
paste(v1, collapse="-")
paste(v2, collapse=" ")

# It's easy to generate simply series of numbers:
v3 <- 1:12
print(v3)

# There seq command can generate more complicated number vectors:
seq(from=1, to=22, by=3)
seq(from=1, to=10, length.out=19)

# Vector items can have names:
print(v3)
month.abb
names(v3) <- month.abb
print(v3)
names(v3)

#-------------------------------------------------------------------------------
# Subsetting vectors
#-------------------------------------------------------------------------------
# You can select items from within a vector using square brackets + indices ...
# A single index number...
LETTERS
LETTERS[10]
# ... or a vector of numbers ...
c(8,5,12,12,15)
LETTERS[c(8,5,12,12,15)]

# You can also refer to vector items by name, if defined ...
v3
v3[11]
v3["Nov"]
# Using a vector of names:
c("Jan", "Mar")
v3[c(1,3)]
v3[c("Jan", "Mar")]
# ... or using boolean/logical values (TRUE/FALSE):
v4 <- 1:3
v4
(v4 <- 1:3)
c(TRUE, FALSE, TRUE)
v4[c(TRUE, FALSE, TRUE)]

#-------------------------------------------------------------------------------
# Boolean/logical data
#-------------------------------------------------------------------------------
# Boolean/logical values are often generated through 'equal' or
# 'greather/lesser than' (<==>) operations:
10 > 2
2 > 10
3 == 3.0
4 == 5
# The following generates a vector of boolean values:
1:10
1:10 >= 5
v5 <- 1:10 >= 5
v5
names(v5) <- 1:10
print(v5)

class(v5)
is.logical(v5)
is.logical(letters)
typeof(letters)
typeof(1:10)
typeof(1.2)


#-------------------------------------------------------------------------------
# Matrices are 2-dimensional arrays/tables where each item (cell) has to be of
# the same data type:
#-------------------------------------------------------------------------------
1:24
mx1 <- matrix(1:24, ncol=6)
mx1

# Fill by column:
mx2 <- matrix(LETTERS[1:24], nrow=6, byrow=FALSE)
mx2

# Fill by row:
mx3 <- matrix(LETTERS[1:24], nrow=6, byrow=TRUE)
mx3

#-------------------------------------------------------------------------------
# One of the great things about vectors and matrices in R is that they can be
# modified with simple code:
#-------------------------------------------------------------------------------
print(v3)
v3 * 100

print(mx1)
mx1
mx1 + 1000
mx1
t(mx1)

#-------------------------------------------------------------------------------
# Data frames are the most common container used to store data in R.
# Each column can be a different data type:
#-------------------------------------------------------------------------------
df1 <- data.frame(Name=c("Jane", "Jack", "Jaim"),
                  Age=c(5, 12, 30),
                  Female=c(TRUE, FALSE, FALSE))
df1
View(df1)

#-------------------------------------------------------------------------------
# Subsetting data frames
#-------------------------------------------------------------------------------
# Similar to vectors, extract data from data frames using square brackets;
# rows and columns are separated by a comma:
print(df1)
df1[1,1]
df1[3,2]

# Leaving the space before the comma blank will return entire columns (all rows):
df1[,1]

# Accordingly, leaving the space AFTER the comma blank will return entire rows:
df1[1,]

# Here again, extract several rows/columns using number vectors:
df1[c(2,3), c(1,3)]

# ... or boolean values:
df1[c(FALSE, TRUE, TRUE), c(TRUE, FALSE, TRUE)]

# For data frames the 'names()' command refers to column headers:
names(df1)
names(df1) <- c("Nom", "Age", "Femelle")
df1

# We often use the dollar sign to refer to entire column of a data frame
# (returns a vector):
df1$Nom
class(df1$Nom)

# Data frames can have row names as well:
row.names(df1) <- paste0("Row", seq_len(nrow(df1)))
df1

# And similar to vectors, we can use row names and column names to subset
# data frames:
# (NOTE that text always to be defined with quotation marks)
df1[,c("Nom", "Femelle")]
df1[c("Row1", "Row3"),c("Nom", "Femelle")]

df1[c("Row1", "Row3"),c("Femelle", "Nom")]

# Sometimes code becomes easier to read if indices vectors are first stored
# in a variable; then use the variable to subset the data frame:
a <- c(2,3)
b <- c(TRUE, FALSE, TRUE)
c <- c("Nom", "Age")

df1[a, b]
df1[b, c]

#-------------------------------------------------------------------------------
# Packages
#-------------------------------------------------------------------------------
# Packages extend the basic repertoire of R with new functions.
# There are three main depositories for R packages: CRAN, Bioconductor and github
# Packages from CRAN are installed as follows, e.g.:
# install.packages("magrittr")

# To install a package from Bioconductor, find the package's page through a
# Google search or at http://bioconductor.org;
# then copy the installation code and paste into your script

# Packages are then _loaded_ using the library() or require() functions:
# library(magrittr)
# library(Biostrings)

# FOR GEEKS:
# To avoid downoading an already installed package, use this code in your scripts:
# (If the package is already installed, it will only be loaded; otherwise it will
# be installed)
# if (!require(wordcloud2)) install.packages("wordcloud2"); library(wordcloud2)

#-------------------------------------------------------------------------------
# Getting help
#-------------------------------------------------------------------------------
median(c(1:3, 100, 1000))

# (1) To get help on a specific function the first option usually is to use the
#     'Help' tab in RStudio

# (2) Help is also available through code:
help(sd)
?median

sd(1:2)

??variance

# (3) Sometimes the same function name is used by different packages. To get help
#     on a function from a specific package, use:
help(sd, package="stats")

# (4) For most functions, there are code examples:
example(persp)

# (5) To see a list of help files for _all_ functions from a specific package, use:
help(package="stats")

# (6) For some (not all) packages, so-called 'vignettes' are available - articles that explain
#     packages with code examples that show how to work through a typical problem. If no
#     vignette is available from within R, go to the package's page on CRAN or Bioconductor
#     respectively.
vignette("magrittr")

# (7) Programmers spend a lot of time searching for help on Google, mostly looking
#     for search hits on the stackoverflow web site:
#     https://stackoverflow.com/documentation/r
#     https://stackoverflow.com/documentation/r/topics

# (8) To stay up-to-date on R consider subscribing to r-bloggers:
#     * https://www.r-bloggers.com/
#     * https://feeds.feedburner.com/RBloggers

#-------------------------------------------------------------------------------
# ********************************  EXERCISE!!  ********************************
#-------------------------------------------------------------------------------
# For the vector v6 below calculate:
# mean/average
# median
# variance
# standard deviation
# standard error of the mean

v6 <- c(-0.18, 0.61, -0.12, 1.02, 1.69, 0.41, 0.3, -0.07, -0.51, 0.84,
        0.69, -0.24, -1.17, 0.02, -0.81, 0.83, -0.62, -1.46, 0.44, -0.65,
        -0.37, 1.56, -0.33, -0.4, -1.22, -1.29, -2.34, -0.61, -0.26,
        -0.2, -1.48, 1.01, 0.27, 0.06, 0.79, 1.35, -2.01, -0.16, -1.45,
        -0.49, -0.35, 1.39, -0.65, -0.2, -0.31, -0.66, -0.31, -1.2, -0.28,
        -0.58)
