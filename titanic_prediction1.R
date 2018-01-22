# VARIABLE DESCRIPTIONS:
# survival        Survival
# (0 = No; 1 = Yes)
# pclass          Passenger Class
# (1 = 1st; 2 = 2nd; 3 = 3rd)
# name            Name
# sex             Sex
# age             Age
# sibsp           Number of Siblings/Spouses Aboard
# parch           Number of Parents/Children Aboard
# ticket          Ticket Number
# fare            Passenger Fare
# cabin           Cabin
# embarked        Port of Embarkation
# (C = Cherbourg; Q = Queenstown; S = Southampton)

# SPECIAL NOTES:
# Pclass is a proxy for socio-economic status (SES)
# 1st ~ Upper; 2nd ~ Middle; 3rd ~ Lower

# Age is in Years; Fractional if Age less than One (1)
# If the Age is Estimated, it is in the form xx.5
# Note: there is missingness in the age indicator

# With respect to the family relation variables (i.e. sibsp and parch)
# some relations were ignored.  The following are the definitions used
# for sibsp and parch.

# Sibling:  Brother, Sister, Stepbrother, or Stepsister of Passenger Aboard Titanic
# Spouse:   Husband or Wife of Passenger Aboard Titanic (Mistresses and Fiances Ignored)
# Parent:   Mother or Father of Passenger Aboard Titanic
# Child:    Son, Daughter, Stepson, or Stepdaughter of Passenger Aboard Titanic

# Other family relatives excluded from this study include cousins,
# nephews/nieces, aunts/uncles, and in-laws.  Some children travelled
# only with a nanny, therefore parch=0 for them.  As well, some
# travelled with very close friends or neighbors in a village, however,
# the definitions do not support such relations.

# Now, let's read this data into R dataframes...

# Check working directory to make sure you are in the right directory
getwd()

# Yes, I am. This is "C:/kaggle/titanic"

# genderclassmodel dataframe
genderclassmodel <- read.csv("genderclassmodel.csv")

# gendermodel dataframe
gendermodel <- read.csv("gendermodel.csv")

# train dataframe
train <- read.csv("train.csv")

# test dataframe
test <- read.csv("test.csv")

# Some of the following is based on Trevor Stephens Tutorial (http://trevorstephens.com/)

# Let’s take a quick look at the structure of the dataframe, ie the types of 
# variables that were loaded. We will use the str command for this:

str(train)

# To access columns of a dataframe, there are several options, but if you want to 
# isolate a single column of the dataframe, use the dollar sign operator. Try this 
# is in the console: train$Survived. You should see a vector of the fates of the 
# passengers in the training set. You can feed this vector to a function too. 
# Let’s try table(train$Survived)

# Vector of survived column

train$Survived

# Here is a cross-tabulation of those who Survived vs. those who did not

table(train$Survived)

# The table command is one of the most basic summary statistics functions in R, 
# it runs through the vector you gave it and simply counts the occurrence of 
# each value in it. We see that in the training set, 342 passengers survived, 
# while 549 died. How about a proportion? Well, we can send the output of one 
# function into another. So now give prop.table() the output of the table function 
# as input:

?prop.table

# This command expresses table entries as fraction of a marginal table
# Sounds like a useful command!

prop.table(table(train$Survived))

# Okay, that’s a bit more readable. 38% of passengers survived the disaster in the 
# training set. This of course means that most people aboard perished. So are you 
# ready to make your first prediction? Since most people died in our training set, 
# perhaps it’s a good start to assume that everyone in the test set did too? A bit 
# morbid perhaps, but let’s break the ice (so to speak) and send in a prediction.

# Some more R syntax to keep moving. The assignment operator is <- and is used to 
# store the right hand side value to the left hand side. For instance, x <- 3 will 
# store the value of 3 to the variable x. In some limited cases, such as passing 
# argument values to a function signature, the equals sign is used (you’ll see 
# this in later lessons). Okay, so let’s add our ‘everyone dies’ prediction to 
# the test set dataframe. To do this we’ll need to use a new command, ‘rep’ that 
# simply repeats something by the number of times we tell it to:

# I think it is better to think of 'rep' as repeat - never thought of this.

test$Survived <- rep(0, 418)

# Since there was no ‘Survived’ column in the dataframe, it will create one for us 
# and repeat our ‘0’ prediction 418 times, the number of rows we have. If this 
# column already existed, it would overwrite it with the new values, so be 
# careful! While not entirely necessary for this simple model, putting the 
# prediction next to the existing data will help keep things in order later, so 
# it’s a good habit to get into for more complicated predictions. If you preview 
# the test set dataframe now, you will find our new column at the end.

# We need to submit a csv file with the PassengerId as well as our Survived 
# predictions to Kaggle. So let’s extract those two columns from the test 
# dataframe, store them in a new container, and then send it to an output file:

# This is useful to know, in terms of Kaggle submissions!

# We just submit PassengerId and SUrvived Score
submit <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)

# Write these results to a CSV file
write.csv(submit, file = "theyallperish.csv", row.names = FALSE)

# Here are the official Kaggle Submission Instructions
# ----------------------------------------------------
# You should submit a csv file with exactly 418 entries plus a header row. This 
# must have exactly 2 columns: PassengerId (which can be sorted in any order), 
# and Survived which contains your binary predictions: 1 for survived, 0 for did 
# not. You cannot submit superfluous columns (beyond PassengerId and Survived) 
# or else the site will show an error with your submission. For an example, see 
# the file "gendermodel.csv" on the Data page.

# Now I understand... gendermodel and genderclassmodel are CSV files representing
# what we will submit. The gender model simply predicts survival based on gender.
# genderclassmodel predicts based on gender and class. Or this is my current
# understanding for now.

# The data.frame command has created a new dataframe with the headings consistent 
# with those from the test set, go ahead and take a look by previewing it. The 
# write.csv command has sent that dataframe out to a CSV file, and importantly 
# excluded the row numbers that would cause Kaggle to reject our submission.

# Okay, the file should have written to your working directory, so first make 
# sure you can see it in your working directory and then head back to Kaggle and 
# click ‘Make a submission’. You may be asked to register a team now; it’s okay 
# if you’re planning to compete solo, every entrant needs to be part of a team, 
# even if there’s only a single member. You can add more people later if you want 
# to, though you cannot kick anyone out once you’ve sent in a submission. You 
# have 10 submissions per day in the Titanic competition; this is great news as 
# we’ll generate a couple more in part 2! Anyhow, now that you have your team set 
# up, either drag the csv file you just created to the yellow box on the submit 
# page, or click the button and browse to it. Then hit submit!

# Titanic: Getting Started With R - Part 2: The Gender-Class Model

# In the previous lesson, we covered the basics of navigating data in R, but only 
# looked at the target variable as a predictor. Now it’s time to try and use the 
# other variables in the dataset to predict the target more accurately. The 
# disaster was famous for saving “women and children first”, so let’s take a look 
# at the Sex and Age variables to see if any patterns are evident. We’ll start 
# with the gender of the passengers. After reloading the data into R, take a look 
# at the summary of this variable:

summary(train$Sex)

# So we see that the majority of passengers were male. Now let’s expand the 
# proportion table command we used last time to do a two-way comparison on the 
# number of males and females that survived:

# I typed...
table(train$Sex, train$Survived)

# Trevor typed
prop.table(table(train$Sex, train$Survived))

# Well that’s not very clean, the proportion table command by default takes each 
# entry in the table and divides by the total number of passengers. What we want 
# to see is the row-wise proportion, ie, the proportion of each sex that survived, 
# as separate groups. So we need to tell the command to give us proportions in 
# the 1st dimension which stands for the rows (using ‘2’ instead would give you 
# column proportions):

prop.table(table(train$Sex, train$Survived),1)

# This might be useful to see!

# Okay, that’s better. We now can see that the majority of females aboard 
# survived, and a very low percentage of males did. In our last prediction we 
# said they all met Davy Jones, so changing our prediction for this new insight 
# should give us a big gain on the leaderboard! Let’s update our old prediction 
# and introduce some more R syntax:

# Here, we set all Survived to 0
test$Survived <- 0

# Here, if the person was female (test$Sex=='female'), we assign Survived!
test$Survived[test$Sex == 'female'] <- 1

# Here we have begun with adding the ‘everyone dies’ prediction column as before, 
# except that we’ll ditch the rep command and just assign the zero to the whole 
# column, it has the same effect. We then altered that same column with 1’s for 
# the subset of passengers where the variable ‘Sex’ is equal to ‘female’.
# We just used two new pieces of R syntax, the equality operator, ==, and the 
# square bracket operator. The square brackets create a subset of the total 
# dataframe, and apply our assignment of ‘1’ to only those rows that meet the 
# criteria specified. The double equals sign no longer works as an assignment 
# here, now it is a boolean test to see if they are already equal. Now let’s 
# write a new submission and send it to Kaggle to see how it’s improved our 
# position!

# We just submit PassengerId and SUrvived Score
# Note, I reference here as submit2
submit2 <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)

# Write these results to a CSV file - menperish.csv
write.csv(submit2, file = "menperish.csv", row.names = FALSE)

# Nice! We’re getting there, but let’s start digging into the age variable now:

summary(train$Age)

# Note all of the NA's. In later work, I want to model the missingness...
# I could also do some form of imputation as well?

# It is possible for values to be missing in data analytics, and this can cause a 
# variety of problems out in the real world that can be quite difficult to deal 
# with at times. For now we could assume that the 177 missing values are the 
# average age of the rest of the passengers, ie. late twenties.

# Our last few tables were on categorical variables, ie. they only had a few 
# values. Now we have a continuous variable which makes drawing proportion tables 
# almost useless, as there may only be one or two passengers for each age! So, 
# let’s create a new variable, Child, to indicate whether the passenger is below 
# the age of 18:

train$Child <- 0
train$Child[train$Age < 18] <- 1

# As with our prediction column, we have now created a new column in the training 
# set dataframe indicating whether the passenger was a child or not. Beginning 
# with the assumption that they were an adult, and then overwriting the value for 
# passengers below the age of 18. To do this we used the less than operator, which 
# is another boolean test, similar to the equality check used in our last 
# predictions. If you click on the train object in the explorer, you will see 
# that any passengers with an age of NA have been assigned a zero, this is because 
# the NA will fail any boolean test. This is what we wanted though, since we had 
# decided to use the average age, which was an adult.

# Now we want to create a table with both gender and age to see the survival 
# proportions for different subsets. Unfortunately our proportion table isn’t 
# equipped for this, so we’re going to have to use a new R command, aggregate. 
# First let’s try to find the number of survivors for the different subsets:

?aggregate

# Compute Summary Statistics of Data Subsets

# Description: Splits the data into subsets, computes summary statistics for each, 
# and returns the result in a convenient form.

aggregate(Survived ~ Child + Sex, data=train, FUN=sum)

# The aggregate command takes a formula with the target variable on the left hand 
# side of the tilde symbol and the variables to subset over on the right. We then 
# tell it which dataframe to look at with the data argument, and finally what 
# function to apply to these subsets. The command above subsets the whole 
# dataframe over the different possible combinations of the age and gender 
# variables and applies the sum function to the Survived vector for each of these 
# subsets. As our target variable is coded as a 1 for survived, and 0 for not, 
# the result of summing is the number of survivors. But we don’t know the total 
# number of people in each subset; let’s find out:

aggregate(Survived ~ Child + Sex, data=train, FUN=length)

# This simply looked at the length of the Survived vector for each subset and 
# output the result, the fact that any of them were 0’s or 1’s was irrelevant for 
# the length function. Now we have the totals for each group of passengers, but 
# really, we would like to know the proportions again. To do this is a little more 
# complicated. We need to create a function that takes the subset vector as input 
# and applies both the sum and length commands to it, and then does the division 
# to give us a proportion. Here is the syntax:

aggregate(Survived ~ Child + Sex, data=train, FUN=function(x) {sum(x)/length(x)})

# I think this is the R facility to create functions on the fly! Look into this.

# Well, it still appears that if a passenger is female most survive, and if they 
# were male most don’t, regardless of whether they were a child or not. So we 
# haven’t got anything to change our predictions on here. Let’s take a look at a 
# couple of other potentially interesting variables to see if we can find anything 
# more: the class that they were riding in, and what they paid for their ticket.

# While the class variable is limited to a manageable 3 values, the fare is again 
# a continuous variable that needs to be reduced to something that can be easily 
# tabulated. Let’s bin the fares into less than $10, between $10 and $20, $20 to 
# $30 and more than $30 and store it to a new variable:

train$Fare2 <- '30+'
train$Fare2[train$Fare < 30 & train$Fare >= 20] <- '20-30'
train$Fare2[train$Fare < 20 & train$Fare >= 10] <- '10-20'
train$Fare2[train$Fare < 10] <- '<10'

# Now let’s run a longer aggregate function to see if there’s anything interesting 
# to work with here:

aggregate(Survived ~ Fare2 + Pclass + Sex, data=train, FUN=function(x) {sum(x)/length(x)})

# While the majority of males, regardless of class or fare still don’t do so well, we 
# notice that most of the class 3 women who paid more than $20 for their ticket actually 
# also miss out on a lifeboat, I’ve indicated these with asterisks, but R won’t know 
# what you’re looking for, so they won’t show up in the console.

# It’s a little hard to imagine why someone in third class with an expensive ticket 
# would be worse off in the accident, but perhaps those more expensive cabins were 
# located close to the iceberg impact site, or further from exit stairs? Whatever the 
# cause, let’s make a new prediction based on the new insights.

# Set all to Dead
test$Survived <- 0

# Set all females to Survived
test$Survived[test$Sex == 'female'] <- 1

# Set all females in Class 3 with fare greater than 20 to Dead
test$Survived[test$Sex == 'female' & test$Pclass == 3 & test$Fare >= 20] <- 0

# Most of the above code should be familiar to you by now. The only exception would be 
# that there are multiple boolean checks all stringed together for the last adjustment. 
# For more complicated boolean logic, you can combine the logical AND operator & with 
# the logical OR operator |.

# Okay, let’s create the output file and see if we did any better!

# We just submit PassengerId and SUrvived Score
# Note: this is submit3
submit3 <- data.frame(PassengerId = test$PassengerId, Survived = test$Survived)

# Write these results to a CSV file femaleclassmodel
write.csv(submit3, file = "femaleclassmodel.csv", row.names = FALSE)

# Titanic: Getting Started With R - Part 3: Decision Trees

# Last lesson, we sliced and diced the data to try and find subsets of the passengers 
# that were more, or less, likely to survive the disaster. We climbed up the leaderboard 
# a great deal, but it took a lot of effort to get there. To find more fine-grained 
# subsets with predictive ability would require a lot of time to adjust our bin sizes 
# and look at the interaction of many different variables. Luckily there is a simple and 
# elegant algorithm that can do this work for us. Today we’re going to use machine 
# learning to build decision trees to do the heavy lifting for us.

# Decision trees have a number of advantages. They are what’s known as a glass-box model, 
# after the model has found the patterns in the data you can see exactly what decisions 
# will be made for unseen data that you want to predict. They are also intuitive and 
# can be read by people with little experience in machine learning after a brief 
# explanation. Finally, they are the basis for some of the most powerful and popular 
# machine learning algorithms.

# I won’t get into the mathematics here, but conceptually, the algorithm starts with all 
# of the data at the root node (drawn at the top) and scans all of the variables for the 
# best one to split on. The way it measures this is to make the split on the variable 
# that results in the most pure nodes below it, ie with either the most 1’s or the most 
# 0’s in the resulting buckets. But let’s look at something more familiar to get the 
# idea. Here we draw a decision tree for only the gender variable, and some familiar 
# numbers jump out:

# Let’s decode the numbers shown on this new representation of our original manual 
# gender-based model. The root node, at the top, shows our tutorial one insights, 62% 
# of passengers die, while 38% survive. The number above these proportions indicates 
# the way that the node is voting (recall we decided at this top level that everyone 
# would die, or be coded as zero) and the number below indicates the proportion of the 
# population that resides in this node, or bucket (here at the top level it is everyone, 
# 100%).

# So far, so good. Now let’s travel down the tree branches to the next nodes down the 
# tree. If the passenger was a male, indicated by the boolean choice below the node, 
# you move left, and if female, right. The survival proportions exactly match those we 
# found in tutorial two through our proportion tables. If the passenger was male, only 
# 19% survive, so the bucket votes that everyone here (65% of passengers) perish, while 
# the female bucket votes in the opposite manner, most of them survive as we saw before. 
# In fact, the above decision tree is an exact representation of our gender model from 
# last lesson.

# The final nodes at the bottom of the decision tree are known as terminal nodes, or 
# sometimes as leaf nodes. After all the boolean choices have been made for a given 
# passenger, they will end up in one of the leaf nodes, and the majority vote of all 
# passengers in that bucket determine how we will predict for new passengers with 
# unknown fates.

# But you can keep going, and this is what I alluded to at the end of the last lesson. 
# We can grow this tree until every passenger is classified and all the nodes are marked 
# with either 0% or 100% chance of survival… All that chopping and comparing of subsets 
# is taken care of for us in the blink of an eye!

# Decision trees do have some drawbacks though, they are greedy. They make the decision 
# on the current node which appear to be the best at the time, but are unable to change 
# their minds as they grow new nodes. Perhaps a better, more pure, tree would have been 
# grown if the gender split occurred later? It is really hard to tell, there are a huge 
# number of decisions that could be made, and exploring every possible version of a tree 
# is extremely computationally expensive. This is why the greedy algorithm is used.

# As an example, imagine a cashier in a make-believe world with a currency including 
# 25c, 15c and 1c coins. The cashier must make change for 30c using the smallest number 
# of coins possible. A greedy algorithm would start with the coin that leaves the 
# smallest amount of change left to pay:

# Greedy: 25 + 1 + 1 + 1 + 1 + 1 = 30c, with 6 coins
# Optimal: 15 + 15 = 30c, with 2 coins

# Clearly the greedy cashier algorithm failed to find the best solution here, and the 
# same is true with decision trees. Though they usually do a great job given their speed 
# and the other advantages we already mentioned, the optimal solution is not guaranteed. 
# Decision trees are also prone to overfitting which requires us to use caution with how 
# deep we grow them as we’ll see later.

# So, let’s get started with our first real algo! Now we start to open up the power of 
# R: its packages. R is extremely extensible, you’d be hard pressed to find a package 
# that doesn’t automatically do what you need. There’s thousands of options out there 
# written by people who needed the functionality and published their work. You can 
# easily add these packages within R with just a couple of commands.

# The one we’ll need for this lesson comes with R. It’s called rpart for 
# ‘Recursive Partitioning and Regression Trees’ and uses the CART decision tree 
# algorithm. While rpart comes with base R, you still need to import the functionality 
# each time you want to use it. Go ahead:

library(rpart)

# Now let’s build our first model. Let’s take a quick review of the possible variables 
# we could look at. Last time we used aggregate and proportion tables to compare gender, 
# age, class and fare. But we never did investigate SibSp, Parch or Embarked. The 
# remaining variables of passenger name, ticket number and cabin number are all unique 
# identifiers for now; they don’t give any new subsets that would be interesting for a 
# decision tree. So let’s build a tree off everything else.

# The format of the rpart command works similarly to the aggregate function we used in 
# tutorial 2. You feed it the equation, headed up by the variable of interest and 
# followed by the variables used for prediction. You then point it at the data, and for 
# now, follow with the type of prediction you want to run (see ?rpart for more info). 
# If you wanted to predict a continuous variable, such as age, you may use 
# method=”anova”. This would run generate decimal quantities for you. But here, we just 
# want a one or a zero, so method=”class” is appropriate:

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, method="class")

# Let’s examine the tree. There are a lot of ways to do this, and the built-in version 
# requires running 

plot(fit)
text(fit)

# Hmm, not very pretty or insightful. To get some more informative graphics, you will 
# need to install some external packages. As I mentioned, tons of world-class developers 
# donate their time and energy to the R project by contributing powerful packages to 
# CRAN, free of charge. You can install them from within R using install.packages(), 
# and load them as before with library(). Here are the ones we need for some better 
# graphics for rpart:

# Learn more about Rattle later on!

install.packages('rattle')
install.packages('rpart.plot')
install.packages('RColorBrewer')
library(rattle)
library(rpart.plot)
library(RColorBrewer)

# Let’s try rendering this tree a bit nicer with fancyRpartPlot (of course).

fancyRpartPlot(fit)

# Okay, now we’ve got somewhere readable. The decisions that have been found go a lot 
# deeper than what we saw last time when we looked for them manually. Decisions have 
# been found for the SipSp variable, as well as the port of embarkation one that we 
# didn’t even look at. And on the male side, the kids younger than 6 years old have a 
# better chance of survival, even if there weren’t too many aboard. That resonates with 
# the famous naval law we mentioned earlier. It all looks very promising, so let’s send 
# another submission into Kaggle!

# To make a prediction from this tree doesn’t require all the subsetting and overwriting 
# we did last lesson, it’s actually a lot easier.

# Generate the prediction
Prediction <- predict(fit, test, type = "class")

# Put in a new dataframe submit4
submit4 <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)

write.csv(submit4, file = "myfirstdtree.csv", row.names = FALSE)

# Here we have called rpart’s predict function. Here we point the function to the model’s 
# fit object, which contains all of the decisions we see above, and tell it to work its 
# magic on the test dataframe. No need to tell it which variables we originally used in 
# the model-building phase, it automatically looks for them and will certainly let you 
# know if something is wrong. Finally we tell it to again use the class method (for ones 
# and zeros output) and as before write the output to a dataframe and submission file.
# Let’s send it in and see how our algorithm performed!

# Nice! We just jumped hundreds of spots with only an extra 0.5% increase in accuracy! 
# Are you getting the picture here? The higher you climb in a Kaggle leaderboard, the 
# more important these fractional percentage bumps become.

# The rpart package automatically caps the depth that the tree grows by using a metric 
# called complexity which stops the resulting model from getting too out of hand. But 
# we already saw that a more complex model than what we made ourselves did a bit better, 
# so why not go all out and override the defaults? Let’s do it.

# You can find the default limits by typing ?rpart.control. The first one we want to 
# unleash is the cp parameter, this is the metric that stops splits that aren’t deemed 
# important enough. The other one we want to open up is minsplit which governs how many 
# passengers must sit in a bucket before even looking for a split. Let’s max both out 
# and reduce cp to zero and minsplit to 2 (no split would obviously be possible for a 
# single passenger in a bucket):

?rpart.control

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train,
             method="class", control=rpart.control(minsplit=2, cp=0))
fancyRpartPlot(fit)

# Okay, I can’t even see what’s going on here, but with that much subsetting and mining 
# for tiny nuggets of truth, how could we go wrong? Let’s make a sub from this model and 
# get to the top of the leaderboard!

# Generate the prediction
Prediction <- predict(fit, test, type = "class")

# Put in a new dataframe submit5
submit5 <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)

write.csv(submit5, file = "myfirstdtree2.csv", row.names = FALSE)

# Note, that when I submitted, it only kept my best model. This is good news!

# Even our simple gender model did better! What went wrong? Welcome to overfitting.

# Overfitting is technically defined as a model that performs better on a training set 
# than another simpler model, but does worse on unseen data, as we saw here. We went too 
# far and grew our decision tree out to encompass massively complex rules that may not 
# generalize to unknown passengers. Perhaps that 34 year old female in third class who 
# paid $20.17 for a ticket from Southampton with a sister and mother aboard may have been 
# a bit of a rare case after all.

# The point of this exercise was that you must use caution with decision trees. While 
# this particular tree may have been 100% accurate on the data that you trained it on, 
# even a trivial tree with only one rule could beat it on unseen data. You just overfit 
# big time!

# Use caution with decision trees, and any other algorithm actually, or you can find 
# yourself making rules from the noise you’ve mistaken for signal!

# Before moving on, I encourage you to have a play with the various control parameters we 
# saw in the rpart.control help file. Perhaps you can find a tree that does a little 
# better by either growing it out further, or reigning it in. You can also manually trim 
# trees in R with these commands:

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train,
             method="class", control=rpart.control(minsplit=20, cp=0.05, maxcompete=4, maxsurrogate = 5, usesurrogate = 2, xval=10, surrogatestyle = 0, maxdepth = 30))
new.fit <- prp(fit,snip=TRUE)$obj
fancyRpartPlot(new.fit)

# An interactive version of the decision tree will appear in the 
# plot tab where you simply click on the nodes that you want to 
# kill. Once you’re satisfied with the tree, hit ‘quit’ and it 
# will be stored to the new.fit object. Try to look for overly 
# complex decisions being made, and kill the nodes that appear 
# to go to far.

# Titanic: Getting Started With R - Part 4: Feature Engineering

# Feature engineering is so important to how your model performs, 
# that even a simple model with great features can outperform a 
# complicated algorithm with poor ones. In fact, feature 
# engineering has been described as “easily the most important 
# factor” in determining the success or failure of your 
# predictive model. Feature engineering really boils down to the 
# human element in machine learning. How much you understand the 
# data, with your human intuition and creativity, can make the 
# difference.

# So what is feature engineering? It can mean many things to 
# different problems, but in the Titanic competition it could 
# mean chopping, and combining different attributes that we were 
# given by the good folks at Kaggle to squeeze a little bit more 
# value from them. In general, an engineered feature may be 
# easier for a machine learning algorithm to digest and make 
# rules from than the variables it was derived from.

# The initial suspects for gaining more machine learning mojo 
# from are the three text fields that we never sent into our 
# decision trees last time. While the ticket number, cabin, and 
# name were all unique to each passenger; perhaps parts of those 
# text strings could be extracted to build a new predictive 
# attribute. Let’s start with the name field. If we take a 
# glance at the first passenger’s name we see the following:

train$Name[1]

# Previously we have only accessed passenger groups by subsetting, 
# now we access an individual by using the row number, 1, as an 
# index instead. Okay, no one else on the boat had that name, 
# that’s pretty much certain, but what else might they have 
# shared? Well, I’m sure there were plenty of Mr’s aboard. 
# Perhaps the persons title might give us a little more insight.

# If we scroll through the dataset we see many more titles 
# including Miss, Mrs, Master, and even the Countess! The title 
# ‘Master’ is a bit outdated now, but back in these days, it was 
# reserved for unmarried boys. Additionally, the nobility such as
# our Countess would probably act differently to the lowly 
# proletariat too. There seems to be a fair few possibilities of 
# patterns in this that may dig deeper than the combinations of 
# age, gender, etc that we looked at before.

# In order to extract these titles to make new variables, we’ll 
# need to perform the same actions on both the training and 
# testing set, so that the features are available for growing 
# our decision trees, and making predictions on the unseen 
# testing data. An easy way to perform the same processes on 
# both datasets at the same time is to merge them. In R we can 
# use rbind, which stands for row bind, so long as both 
# dataframes have the same columns as each other. Since we 
# obviously lack the Survived column in our test set, let’s 
# create one full of missing values (NAs) and then row bind the 
# two datasets together:

# Note: this only works if I reload original train and test df's

test$Survived <- NA
combi <- rbind(train, test)

# Now we have a new dataframe called combi with all the same rows 
# as the original two datasets, stacked in the order in which we 
# specified: train first, and test second.

# If you look back at the output of our inquiry on Owen, his name 
# is still encoded as a factor. As we mentioned earlier in the 
# tutorial series, strings are automatically imported as factors 
# in R, even if it doesn’t make sense. So we need to cast this 
# column back into a text string. To do this we use as.character. 
# Let’s do this and then take another look at Owen:

combi$Name <- as.character(combi$Name)
combi$Name[1]

# Excellent, no more levels, now it’s just pure text. In order to 
# break apart a string, we need some hooks to tell the program to 
# look for. Nicely, we see that there is a comma right after the 
# person’s last name, and a full stop after their title. We can 
# easily use the function strsplit, which stands for string split, 
# to break apart our original name over these two symbols. Let’s 
# try it out on Mr. Braund:

strsplit(combi$Name[1], split='[,.]')

# Okay, good. Here we have sent strsplit the cell of interest, 
# and given it some symbols to chose from when splitting the string 
# up, either a comma or period. Those symbols in the square 
# brackets are called regular expressions, though this is a very 
# simple one, and if you plan on working with a lot of text I 
# would certainly recommend getting used to using them!

# We see that the title has been broken out on its own, though 
# there’s a strange space before it begins because the comma 
# occurred at the end of the surname. But how do we get to that 
# title piece and clear out the rest of the stuff we don’t want? 
# An index [[1]] is printed before the text portions. Let’s try to 
# dig into this new type of container by appending all those 
# square brackets to the original command:

strsplit(combi$Name[1], split='[,.]')[[1]]

# Getting there! String split uses a doubly stacked matrix because 
# it can never be sure that a given regex will have the same number
# of pieces. If there were more commas or periods in the name, it 
# would create more segments, so it hides them a level deeper to 
# maintain the rectangular types of containers that we are used to 
# in things like spreadsheets, or now dataframes! Let’s go a level 
# deeper into the indexing mess and extract the title. It’s the 
# second item in this nested list, so let’s dig in to index number 
# 2 of this new container:

strsplit(combi$Name[1], split='[,.]')[[1]][2]

# Great. We have isolated the title we wanted at last. But how to 
# apply this transformation to every row of the combined train/test 
# dataframe? Luckily, R has some extremely useful functions that 
# apply more complication functions one row at a time. As we had 
# to dig into this container to get the title, simply trying to run 
# combi$Title <- strsplit(combi$Name, split='[,.]')[[1]][2] over 
# the whole name vector would result in all of our rows having the 
# same value of Mr., so we need to work a bit harder. 
# Unsurprisingly applying a function to a lot of cells in a 
# dataframe or vector uses the apply suite of functions of R:

# Note to self: really understand apply functions in R

combi$Title <- sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][2]})

# R’s apply functions all work in slightly different ways, but 
# sapply will work great here. We feed sapply our vector of names 
# and our function that we just came up with. It runs through the 
# rows of the vector of names, and sends each name to the function. 
# The results of all these string splits are all combined up into a 
# vector as output from the sapply function, which we then store to
# a new column in our original dataframe, called Title.

# Finally, we may wish to strip off those spaces from the beginning 
# of the titles. Here we can just substitute the first occurrence 
# of a space with nothing. We can use sub for this (gsub would 
# replace all spaces, poor ‘the Countess’ would look strange then 
# though):

combi$Title <- sub(' ', '', combi$Title)

# Alright, we now have a nice new column of titles, let’s have a 
# look at it:

table(combi$Title)

# Hmm, there are a few very rare titles in here that won’t give our 
# model much to work with, so let’s combine a few of the most 
# unusual ones. We’ll begin with the French. Mademoiselle and 
# Madame are pretty similar (so long as you don’t mind offending) 
# so let’s combine them into a single category:

combi$Title[combi$Title %in% c('Mme', 'Mlle')] <- 'Mlle'

# What have we done here? The %in% operator checks to see if a 
# value is part of the vector we’re comparing it to. So here we 
# are combining two titles, ‘Mme’ and ‘Mlle’, into a new temporary 
# vector using the c() operator and seeing if any of the existing 
# titles in the entire Title column match either of them. We then 
# replace any match with ‘Mlle’.

# Let’s keep looking for redundancy. It seems the very rich are a 
# bit of a problem for our set here too. For the men, we have a 
# handful of titles that only one or two have been blessed with: 
# Captain, Don, Major and Sir. All of these are either military 
# titles, or rich fellas who were born with vast tracts of land. 
# For the ladies, we have Dona, Lady, Jonkheer (*see comments 
# below), and of course our Countess. All of these are again the 
# rich folks, and may have acted somewhat similarly due to their 
# noble birth. Let’s combine these two groups and reduce the number 
# of factor levels to something that a decision tree might make 
# sense of:

combi$Title[combi$Title %in% c('Capt', 'Don', 'Major', 'Sir')] <- 'Sir'
combi$Title[combi$Title %in% c('Dona', 'Lady', 'the Countess', 'Jonkheer')] <- 'Lady'

# Our final step is to change the variable type back to a factor, 
# as these are essentially categories that we have created:

combi$Title <- factor(combi$Title)

# Alright. We’re done with the passenger’s title now. What else 
# can we think up? Well, there’s those two variables SibSb and 
# Parch that indicate the number of family members the passenger 
# is travelling with. Seems reasonable to assume that a large 
# family might have trouble tracking down little Johnny as they 
# all scramble to get off the sinking ship, so let’s combine the 
# two variables into a new one, FamilySize:

combi$FamilySize <- combi$SibSp + combi$Parch + 1

# Pretty simple! We just add the number of siblings, spouses, 
# parents and children the passenger had with them, and plus one 
# for their own existence of course, and have a new variable 
# indicating the size of the family they travelled with.
# Anything more? Well we just thought about a large family having 
# issues getting to lifeboats together, but maybe specific families
# had more trouble than others? We could try to extract the Surname
# of the passengers and group them to find families, but a common 
# last name such as Johnson might have a few extra non-related 
# people aboard. In fact there are three Johnsons in a family with
# size 3, and another three probably unrelated Johnsons all 
# travelling solo. Combining the Surname with the family size
# though should remedy this concern. No two family-Johnson’s 
# should have the same FamilySize variable on such a small ship. 
# So let’s first extract the passengers’ last names. This should 
# be a pretty simple change from the title extraction code we ran 
# earlier, now we just want the first part of the strsplit output:

combi$Surname <- sapply(combi$Name, FUN=function(x) {strsplit(x, split='[,.]')[[1]][1]})

# We then want to append the FamilySize variable to the front of it, but as we saw with 
# factors, string operations need strings. So let’s convert the FamilySize variable 
# temporarily to a string and combine it with the Surname to get our new FamilyID variable:

combi$FamilyID <- paste(as.character(combi$FamilySize), combi$Surname, sep="")

# We used the function paste to bring two strings together, and 
# told it to separate them with nothing through the sep argument. 
# This was stored to a new column called FamilyID. But those three 
# single Johnsons would all have the same Family ID. Given we were 
# originally hypothesising that large families might have trouble 
# sticking together in the panic, let’s knock out any family size 
# of two or less and call it a “small” family. This would fix the 
# Johnson problem too.

combi$FamilyID[combi$FamilySize <= 2] <- 'Small'

# Let’s see how we did for identifying these family groups:

table(combi$FamilyID)

# Hmm, a few seemed to have slipped through the cracks here. 
# There’s plenty of FamilyIDs with only one or two members, 
# even though we wanted only family sizes of 3 or more. Perhaps 
# some families had different last names, but whatever the case, 
# all these one or two people groups is what we sought to avoid 
# with the three person cut-off. Let’s begin to clean this up:

famIDs <- data.frame(table(combi$FamilyID))

# Now we have stored the table above to a dataframe. Yep, you can 
# store most tables to a dataframe if you want to, so let’s take a 
# look at it by clicking on it in the explorer:

# Here we see again all those naughty families that didn’t work 
# well with our assumptions, so let’s subset this dataframe to 
# show only those unexpectedly small FamilyID groups.

famIDs <- famIDs[famIDs$Freq <= 2,]

# We then need to overwrite any family IDs in our dataset for 
# groups that were not correctly identified and finally convert 
# it to a factor:

combi$FamilyID[combi$FamilyID %in% famIDs$Var1] <- 'Small'

combi$FamilyID <- factor(combi$FamilyID)

# We are now ready to split the test and training sets back into 
# their original states, carrying our fancy new engineered 
# variables with them. The nicest part of what we just did is how 
# the factors are treated in R. Behind the scenes, factors are 
# basically stored as integers, but masked with their text names 
# for us to look at. If you create the above factors on the 
# isolated test and train sets separately, there is no guarantee 
# that both groups exist in both sets.

# For instance, the family ‘3Johnson’ previously discussed does 
# not exist in the test set. We know that all three of them survive 
# from the training set data. If we had built our factors in 
# isolation, there would be no factor ‘3Johnson’ for the test set. 
# This would upset any machine learning model because the factors 
# between the training set used to build the model and the test 
# set it is asked to predict for are not consistent. ie. R will 
# throw errors at you if you try. Because we built the factors on 
# a single dataframe, and then split it apart after we built them, 
# R will give all factor levels to both new dataframes, even if 
# the factor doesn’t exist in one. It will still have the factor 
# level, but no actual observations of it in the set. Neat trick 
# right? Let me assure you that manually updating factor levels is 
# a pain. So let’s break them apart and do some predictions on our 
# new fancy engineered variables:

train <- combi[1:891,]
test <- combi[892:1309,]

# Here we introduce yet another subsetting method in R; there are 
# many depending on how you want to chop up your data. We have 
# isolated certain ranges of rows of the combi dataset based on 
# the sizes of the original train and test sets. The comma after 
# that with no numbers following it indicates that we want to take 
# ALL columns with this subset and store it to the assigned 
# dataframe. This gives us back our original number of rows, as 
# well as all our new variables including the consistent factor 
# levels.

# Time to do our predictions! We have a bunch of new variables, 
# so let’s send them to a new decision tree. Last time the default 
# complexity worked out pretty well, so let’s just grow a tree 
# with the vanilla controls and see what it can do:

fit <- rpart(Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID,
             data=train, method="class")

# Interestingly our new variables are basically governing our 
# tree. Here’s another drawback with decision trees that I didn’t 
# mention last time: they are biased to favour factors with many 
# levels. Look at how our 61-level FamilyID factor is so prominent 
# here, and the tree picked out all the families that are biased 
# one way more than the others. This way the decision node can 
# chop and change the data into the best way possible combination 
# for purity of the following nodes. But all that aside, you know 
# should know how to create a submission from a decision tree, so 
# let’s see how it performed!

# Generate the prediction
Prediction <- predict(fit, test, type = "class")

# Put in a new dataframe submit6
submit6 <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)

write.csv(submit6, file = "myfirstdtree3.csv", row.names = FALSE)

# In most cases though, the title or gender variables will govern 
# the first decision due to the greedy nature of decision trees. 
# The bias towards many-levelled factors won’t go away either, and 
# the overfitting problem can be difficult to gauge without 
# actually sending in submissions, but good judgement can help. 
# Next lesson, we will overcome these limitations by building an 
# ensemble of decision trees with the powerful Random Forest 
# algorithm. 

# Titanic: Getting Started With R - Part 5: Random Forests

# Seems fitting to start with a definition, en·sem·ble 
# A unit or group of complementary parts that contribute to a 
# single effect, especially:
# A coordinated outfit or costume.
# A coordinated set of furniture.
# A group of musicians, singers, dancers, or actors who perform 
# together 

# While I won’t be teaching about how to best coordinate 
# your work attire or living room, I think the musician metaphor 
# works here. In an ensemble of talented instrumentalists, the 
# issues one might have with an off-note are overpowered by the 
# others in the group. The same goes for machine learning. Take a 
# large collection of individually imperfect models, and their 
# one-off mistakes are probably not going to be made by the rest 
# of them. If we average the results of all these models, we can 
# sometimes find a superior model from their combination than any 
# of the individual parts. That’s how ensemble models work, they 
# grow a lot of different models, and let their outcomes be 
# averaged or voted across the group. We are now well aware of the 
# overfitting problems with decision trees. But if we grow a whole 
# lot of them and have them vote on the outcome, we can get passed 
# this limitation. Let’s build a very small ensemble of three 
# simple decision trees to illustrate:

# Each of these trees make their classification decisions based on 
# different variables. So let’s imagine a female passenger from 
# Southampton who rode in first class. Tree one and two would vote 
# that she survived, but tree three votes that she perishes. If we 
# take a vote, it’s 2 to 1 in favour of her survival, so we would 
# classify this passenger as a survivor. Random Forest models grow 
# trees much deeper than the decision stumps above, in fact the 
# default behaviour is to grow each tree out as far as possible, 
# like the overfitting tree we made in lesson three. But since the 
# formulas for building a single decision tree are the same every 
# time, some source of randomness is required to make these trees 
# different from one another. Random Forests do this in two ways. 
# The first trick is to use bagging, for bootstrap aggregating. 
# Bagging takes a randomized sample of the rows in your training 
# set, with replacement. This is easy to simulate in R using the 
# sample function. Let’s say we wanted to perform bagging on a 
# training set with 10 rows.

sample(1:10, replace = TRUE)

# In this simulation, we would still have 10 rows to work with, 
# but rows 1, 2, 9 and 10 are each repeated twice, while rows 4, 5, 
# 6 and 8 are excluded. If you run this command again, you will 
# get a different sample of rows each time. On average, around 
# 37% of the rows will be left out of the bootstrapped sample. 
# With these repeated and omitted rows, each decision tree grown 
# with bagging would evolve slightly differently. If you have very 
# strong features such as gender in our example though, that 
# variable will probably still dominate the first decision in most 
# of your trees.

# The second source of randomness gets past this limitation though.
# Instead of looking at the entire pool of available variables, 
# Random Forests take only a subset of them, typically the square 
# root of the number available. In our case we have 10 variables, 
# so using a subset of three variables would be reasonable. The 
# selection of available variables is changed for each and every 
# node in the decision trees. This way, many of the trees won’t 
# even have the gender variable available at the first split, and 
# might not even see it until several nodes deep.

# Through these two sources of randomness, the ensemble contains a 
# collection of totally unique trees which all make their 
# classifications differently. As with our simple example, each 
# tree is called to make a classification for a given passenger, 
# the votes are tallied (with perhaps many hundreds, or thousands 
# of trees) and the majority decision is chosen. Since each tree 
# is grown out fully, they each overfit, but in different ways. 
# Thus the mistakes one makes will be averaged out over them all.

# R’s Random Forest algorithm has a few restrictions that we did 
# not have with our decision trees. The big one has been the 
# elephant in the room until now, we have to clean up the missing 
# values in our dataset. rpart has a great advantage in that it can 
# use surrogate variables when it encounters an NA value. In our 
# dataset there are a lot of age values missing. If any of our 
# decision trees split on age, the tree would search for another 
# variable that split in a similar way to age, and use them 
# instead. Random Forests cannot do this, so we need to find a 
# way to manually replace these values.

# A method we implicitly used in part 2 when we defined the 
# adult/child age buckets was to assume that all missing values 
# were the mean or median of the remaining data. Since then we’ve 
# learned a lot of new skills though, so let’s use a decision 
# tree to fill in those values instead. Let’s pick up where we 
# left off last lesson, and take a look at the combined 
# dataframe’s age variable to see what we’re up against:

summary(combi$Age)

# 263 values out of 1309 were missing this whole time, that’s a 
# whopping 20%! A few new pieces of syntax to use. Instead of 
# subsetting by boolean logic, we can use the R function is.na(), 
# and it’s reciprocal !is.na() (the bang symbol represents ‘not’). 
# This subsets on whether a value is missing or not. We now also 
# want to use the method=”anova” version of our decision tree, as 
# we are not trying to predict a category any more, but a 
# continuous variable. So let’s grow a tree on the subset of the 
# data with the age values available, and then replace those that 
# are missing:

# I think the goal is to impute the missing value with dtrees.

Agefit <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked + Title + FamilySize,
                data=combi[!is.na(combi$Age),], method="anova")
combi$Age[is.na(combi$Age)] <- predict(Agefit, combi[is.na(combi$Age),])

# I left off the family size and family IDs here as I didn’t 
# think they’d have much impact on predicting age. You can go 
# ahead and inspect the summary again, all those NA values are 
# gone.
# Let’s take a look at the summary of the entire dataset now to 
# see if there are any other problem variables that we hadn’t 
# noticed before:

summary(combi)

# Two jump out as a problem, though no where near as bad as Age, 
# Embarked and Fare both are lacking values in two different ways.

summary(combi$Embarked)

# Embarked has a blank for two passengers. While a blank wouldn’t 
# be a problem for our model like an NA would be, since we’re 
# cleaning anyhow, let’s get rid of it. Because it’s so few 
# observations and such a large majority boarded in Southampton, 
# let’s just replace those two with ‘S’. First we need to find 
# out who they are though! We can use which for this:

which(combi$Embarked == '')

# This gives us the indexes of the blank fields. Then we simply 
# replace those two, and encode it as a factor:

combi$Embarked[c(62,830)] = "S"
combi$Embarked <- factor(combi$Embarked)

# The other naughty variable was Fare, let’s take a look:

summary(combi$Fare)

# It’s only one passenger with a NA, so let’s find out which one 
# it is and replace it with the median fare:

which(is.na(combi$Fare))

combi$Fare[1044] <- median(combi$Fare, na.rm=TRUE)

# Okay. Our dataframe is now cleared of NAs. Now on to restriction
# number two: Random Forests in R can only digest factors with up 
# to 32 levels. Our FamilyID variable had almost double that. We 
# could take two paths forward here, either change these levels 
# to their underlying integers (using the unclass() function) and 
# having the tree treat them as continuous variables, or manually 
# reduce the number of levels to keep it under the threshold.

# Let’s take the second approach. To do this we’ll copy the 
# FamilyID column to a new variable, FamilyID2, and then convert 
# it from a factor back into a character string with 
# as.character(). We can then increase our cut-off to be a 
# “Small” family from 2 to 3 people. Then we just convert it back 
# to a factor and we’re done:

combi$FamilyID2 <- combi$FamilyID
combi$FamilyID2 <- as.character(combi$FamilyID2)
combi$FamilyID2[combi$FamilySize <= 3] <- 'Small'
combi$FamilyID2 <- factor(combi$FamilyID2)

# Okay, we’re down to 22 levels so we’re good to split the test 
# and train sets back up as we did last lesson and grow a Random 
# Forest. Install and load the package randomForest:

library(randomForest)

# Because the process has the two sources of randomness that we 
# discussed earlier, it is a good idea to set the random seed in R 
# before you begin. This makes your results reproducible next time
# you load the code up, otherwise you can get different 
# classifications for each run.

set.seed(415)

# The number inside isn’t important, you just need to ensure you 
# use the same seed number each time so that the same random 
# numbers are generated inside the Random Forest function.
# Now we’re ready to run our model. The syntax is similar to 
# decision trees, but there’s a few extra options.

# note, this only works if you split up train/test from combi again...
train <- combi[1:891,]
test <- combi[892:1309,]

fit <- randomForest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID2, data=train, importance=TRUE, ntree=2000)

# Instead of specifying method=”class” as with rpart, we force 
# the model to predict our classification by temporarily changing 
# our target variable to a factor with only two levels using as.
# factor(). The importance=TRUE argument allows us to inspect 
# variable importance as we’ll see, and the ntree argument 
# specifies how many trees we want to grow.

# If you were working with a larger dataset you may want to reduce 
# the number of trees, at least for initial exploration, or 
# restrict the complexity of each tree using nodesize as well as 
# reduce the number of rows sampled with sampsize. You can also 
# override the default number of variables to choose from with 
# mtry, but the default is the square root of the total number 
# available and that should work just fine. Since we only have a 
# small dataset to play with, we can grow a large number of trees 
# and not worry too much about their complexity, it will still 
# run pretty fast.

# So let’s look at what variables were important:

varImpPlot(fit)

# Remember with bagging how roughly 37% of our rows would be left 
# out? Well Random Forests doesn’t just waste those “out-of-bag” 
# (OOB) observations, it uses them to see how well each tree 
# performs on unseen data. It’s almost like a bonus test set to 
# determine your model’s performance on the fly.

# There’s two types of importance measures shown above. The 
# accuracy one tests to see how worse the model performs without 
# each variable, so a high decrease in accuracy would be expected 
# for very predictive variables. The Gini one digs into the 
# mathematics behind decision trees, but essentially measures how 
# pure the nodes are at the end of the tree. Again it tests to 
# see the result if each variable is taken out and a high score 
# means the variable was important.

# Unsurprisingly, our Title variable was at the top for both 
# measures. We should be pretty happy to see that the remaining 
# engineered variables are doing quite nicely too. Anyhow, enough 
# delay, let’s see how it did!

# The prediction function works similarly to decision trees, and 
# we can build our submission file in exactly the same way. It 
# will take a bit longer though, as all 2000 trees need to make 
# their classifications and then discuss who’s right:

Prediction <- predict(fit, test)
submit7 <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit7, file = "firstforest.csv", row.names = FALSE)

# no improvement here in my score...

# Hrmm, well this actually worked out exactly the same as Kaggle’s
# Python random forest tutorial. I wouldn’t take that as the 
# expected result from any forest though, this may just be pure 
# coincidence. It’s relatively poor performance does go to show 
# that on smaller datasets, sometimes a fancier model won’t beat 
# a simple one. Besides that, there’s also the private leaderboard 
# as only 50% of the test data is evaluated for our public scores. 
# But let’s not give up yet. There’s more than one ensemble model. 
# Let’s try a forest of conditional inference trees. They make 
# their decisions in slightly different ways, using a statistical 
# test rather than a purity measure, but the basic construction of 
# each tree is fairly similar.

# So go ahead and install and load the party package.

library (party)

# We again set the seed for consistent results and build a model 
# in a similar way to our Random Forest:

set.seed(415)
fit <- cforest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + FamilyID,
               data = train, controls=cforest_unbiased(ntree=2000, mtry=3))

# Conditional inference trees are able to handle factors with more
# levels than Random Forests can, so let’s go back to out original 
# version of FamilyID. You may have also noticed a few new 
# arguments. Now we have to specify the number of trees inside a 
# more complicated command, as arguments are passed to cforest 
# differently. We also have to manually set the number of 
# variables to sample at each node as the default of 5 is pretty 
# high for our dataset. Okay, let’s make another prediction:

Prediction <- predict(fit, test, OOB=TRUE, type = "response")

# The prediction function requires a few extra nudges for 
# conditional inference forests as you see. Let’s write a 
# submission and submit it!

# There may be a few more insights to wring from this dataset 
# yet though. We never did look at the ticket or cabin numbers, 
# so take a crack at extracting some insights from them to see if 
# any more gains are possible. Maybe extracting the cabin letter 
# (deck) or number (location) and extrapolating to the rest of 
# the passengers’ family if they’re missing might be worth a try?

submit8 <- data.frame(PassengerId = test$PassengerId, Survived = Prediction)
write.csv(submit8, file = "firstforest.csv", row.names = FALSE)

# My next goal is to adapt decision trees, random forests, and
# decision trees to Migraine Dataset. In particular, I could 
# work with the variable importance measure. And also use it to
# predict headache level (0-10).

#-------------------------------------------------------------------------------
# Now let's apply SuperLearner to this dataset...
# Our last call was the following:
# fit <- cforest(as.factor(Survived) ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked + Title + FamilySize + 
# FamilyID, data = train, controls=cforest_unbiased(ntree=2000, mtry=3))
# Also... Prediction <- predict(fit, test, OOB=TRUE, type = "response")
# I need to do the following:
# (1) Load SuperLearner and associated packages
# (2) Identify all Classification Packages
# (3) Run SuperLearner - and apply parallelism - with training set - this should take a while (but the dataset is relatively small)
# (4) Predict on test set
# (5) Submit

# From SL Analysis (in Dec 2014), here are the binary prediction packages I can use: knn, glmnet, randomForest, 
# bagging, bart, mean, glm, bayesglm, gam, nnet, polyclass, DSA, polymars, gbm, earth, ipredbagg, rpart, stepAIC,
# glm.interaction, elastic net, lda (needs wrapper?), boosted cart (wrapper for twang package?), step

# Install, just in case it is not on this computer

# Install SuperLearner package
install.packages("SuperLearner")

# Install additional packages
install.packages("arm")
install.packages("caret")
install.packages("class")
install.packages("cvAUC")
install.packages("e1071")
install.packages("earth")
install.packages("gam")
install.packages("gbm")
install.packages("genefilter") # not available for R 3.1.2
install.packages("ggplot2")
install.packages("glmnet")
install.packages("Hmisc")
install.packages("ipred")
install.packages("lattice")
install.packages("LogicReg")
install.packages("MASS")
install.packages("mda")
install.packages("mlbench")
install.packages("nloptr")
install.packages("nnet")
install.packages("parallel")
install.packages("party")
install.packages("polspline")
install.packages("quadprog")
install.packages("randomForest")
install.packages("ROCR")
install.packages("rpart")
install.packages("SIS")
install.packages("spls")
install.packages("stepPlr")
install.packages("sva") # not available for R 3.1.2

#Load these packages
library("arm")
library("caret")
library("class")
library("cvAUC")
library("e1071")
library("earth")
library("gam")
library("gbm")
library("genefilter")
library("ggplot2")
library("glmnet")
library("Hmisc")
library("ipred")
library("lattice")
library("LogicReg")
library("MASS")
library("mda")
library("mlbench")
library("nloptr")
library("nnet")
library("parallel")
library("party")
library("polspline")
library("quadprog")
library("randomForest")
library("ROCR")
library("rpart")
library("SIS")
library("spls")
library("stepPlr")
library("sva")

# Load the SuperLearner package with the library function.
library('SuperLearner')

#Use the listWrappers() function to see built-in candidate algorithms
listWrappers()

# Create candidate library of algorithms for SuperLearner
# This is based on going through SuperLearner github code - these are all packages with binary outcomes
SL.library <- c('SL.rpartPrune', 'SL.rpart', 'SL.logreg', 'SL.earth', 'SL.caret', 'SL.glm', 'SL.glm.interaction', 'SL.randomForest', 'SL.ipredbagg', 'SL.gam', 'SL.gbm', 'SL.nnet', 'SL.polymars', 'SL.bayesglm', 'SL.step', 'SL.step.interaction', 'SL.stepAIC','SL.leekasso', 'SL.svm', 'SL.glmnet', 'SL.knn', 'SL.mean')

X <- subset(train, select= c(Pclass, Sex, Age, SibSp, Parch, Fare, Embarked, Title, FamilySize, FamilyID))

# Let's parallelize with Snow SuperLearner

# first, let's initialize parallel package
library('parallel')

# Now, let's setup PSOCK multi-core cluster.
cl <- makeCluster(detectCores(), type = "PSOCK") # can use different types here
clusterSetRNGStream(cl, iseed = 2343)

# Let's do the analysis with snow SuperLearner. This should take advantage of multicore

# Note: the outcome Y must be a numeric vector
binary_outcome <- train$Survived

# Y = survived
# X = all predictors
# family = binomial (binary outcomes)
# verbose = TRUE.  TRUE for printing progress during the computation (helpful for debugging).
# SL.library = machine learning libraries we use
# Default is NNLS for error estimation.
# We also calculate the System time as well.
system.time(testSNOW <- snowSuperLearner(cluster = cl, Y = binary_outcome, X = X, SL.library = SL.library, family='binomial', verbose = TRUE, method = "method.NNLS"))

# Stop cluster once SuperLearner finishes running.
stopCluster(cl)

# Got the following errors:
# Failed with error:  ‘package ‘Rcpp’ required by ‘lme4’ could not be found’
# In addition: Warning messages:
#  1: package ‘arm’ was built under R version 3.0.3 
# 2: package ‘lme4’ was built under R version 3.0.3 
# Error: You have selected bayesglm as a library algorithm but either do not have the arm package installed or it can not be loaded

# Let's install Rcpp and arm
install.packages(c('Rcpp', 'arm'))

# Load these packages
library('Rcpp')
library('arm')

# Now, let's try SuperLearner again.
# has a problem with gbm...
install.packages('gbm')
library('gbm')

# caret needs to be installed...
install.packages('caret')
library('caret')

#   there is no package called ‘quantreg’ - needed for caret package
install.packages('quantreg')
library('quantreg')

# Now let's do prediction...

## S3 method for class 'SuperLearner'

newdata <- subset(test, select= c(Pclass, Sex, Age, SibSp, Parch, Fare, Embarked, Title, FamilySize, FamilyID))

SL_survived <- predict(object=testSNOW, newdata=newdata, onlySL = TRUE)
# This only worked when I set onlySL = TRUE.
# if onlySL = TRUE, only compute predictions for algorithms with non-zero coefficients 
# in the super learner object.
# I did this because I received the following warning message after SL ran:
# Warning message:
# In snowSuperLearner(cluster = cl, Y = binary_outcome, X = X, SL.library = SL.library,  :
#                      coefficients already 0 for all failed algorithm(s)

# OKay... my predictions are in SL_survived$pred
# This gives me probabilities. I need to convert this to survived = 0/1.

# If probability > 0.5, then set to TRUE, else FALSE 
SL_survived_binary <- SL_survived$pred>0.5

# Convert boolean values to integers
SL_survived_binary <- as.integer(SL_survived_binary) 

# Now let's submit this...
submit_sl1 <- data.frame(PassengerId = test$PassengerId, Survived = SL_survived_binary)
write.csv(submit_sl1 , file = "submit_sl1.csv", row.names = FALSE)

# Nice... I finished... It did not improve my score though.
# what I can do - is to add more to SL... And see if that changes my odds?

################################################################################
# SuperLearner part 2!

# Let's add more algorithms to SL, including screening algorithms...

# Create candidate library of algorithms for SuperLearner
# This is based on going through SuperLearner github code - these are all packages with binary outcomes
# We also add screening algorithms to each learner - with the exception of RandomForest
# Note: this is a list and not a character vector
# SL.library <- list( c('SL.rpartPrune', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest") , c('SL.rpart', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest"), c('SL.rpart', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest"), c('SL.rpart', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest"), c('SL.logreg', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest") , c('SL.earth', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest") , c('SL.caret', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest") , c('SL.glm', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest"), c('SL.glm.interaction', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest"), 'SL.randomForest', c('SL.ipredbagg', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest"), c('SL.gam', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest") , c('SL.gbm', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest") , c('SL.nnet', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest"), c('SL.polymars', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest") , c('SL.bayesglm', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest") , c('SL.step', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest")  , c('SL.step.interaction', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest") , c('SL.stepAIC', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest") , c('SL.leekasso', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest"), c('SL.svm', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest")  , c('SL.glmnet', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest")  , c('SL.knn', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest") , c('SL.mean', "All", "screen.SIS", "screen.corP", "screen.corRank", "screen.glmnet", "screen.ttest")   )

# SL.library <- list( c('SL.glm', "All", "screen.glmnet", "screen.ttest") )

# SL.library <- list( c('SL.glm', "All"), c("SL.glm", "screen.glmnet"), c("SL.glm", "screen.ttest") )

# Note: this is a list and not a character vector
# SL.library <- list( c('SL.rpartPrune', "All", "screen.glmnet", "screen.ttest") , c('SL.rpart', "All", "screen.glmnet", "screen.ttest"), c('SL.rpart', "All", "screen.glmnet", "screen.ttest"), c('SL.rpart', "All", "screen.glmnet", "screen.ttest"), c('SL.logreg', "All", "screen.glmnet", "screen.ttest") , c('SL.earth', "All", "screen.glmnet", "screen.ttest") , c('SL.caret', "All", "screen.glmnet", "screen.ttest") , c('SL.glm', "All", "screen.glmnet", "screen.ttest"), c('SL.glm.interaction', "All", "screen.glmnet", "screen.ttest"), c('SL.randomForest', "All"), c('SL.ipredbagg', "All", 'screen.glmnet", "screen.ttest"), c('SL.gam', "All", "screen.glmnet", "screen.ttest") , c('SL.gbm', "All", "screen.glmnet", "screen.ttest") , c('SL.nnet', "All", "screen.glmnet", "screen.ttest"), c('SL.polymars', "All",  "screen.glmnet", "screen.ttest") , c('SL.bayesglm', "All",  "screen.glmnet", "screen.ttest") , c('SL.step', "All",  "screen.glmnet", "screen.ttest")  , c('SL.step.interaction', "All",  "screen.glmnet", "screen.ttest") , c('SL.stepAIC', "All",  "screen.glmnet", "screen.ttest") , c('SL.leekasso', "All", "screen.glmnet", "screen.ttest"), c('SL.svm', "All", "screen.glmnet", "screen.ttest")  , c('SL.glmnet', "All",  "screen.glmnet", "screen.ttest")  , c('SL.knn', "All",  "screen.glmnet", "screen.ttest") , c('SL.mean', "All",  "screen.glmnet", "screen.ttest")   )

# SuperLearner CRAN example (http://cran.r-project.org/web/packages/SuperLearner/SuperLearner.pdf)
# library with screening
SL.library <- list(c("SL.glmnet", "All"), c("SL.glm", "screen.randomForest", "All", "screen.SIS"), "SL.randomForest", c("SL.polymars", "All"), "SL.mean")


# X is the same - no need to rerun this code
# X <- subset(train, select= c(Pclass, Sex, Age, SibSp, Parch, Fare, Embarked, Title, FamilySize, FamilyID))

# Let's parallelize with Snow SuperLearner

# first, let's initialize parallel package
library('parallel')

# Now, let's setup PSOCK multi-core cluster.
cl <- makeCluster(detectCores(), type = "PSOCK") # can use different types here
clusterSetRNGStream(cl, iseed = 2343)

# Let's do the analysis with snow SuperLearner. This should take advantage of multicore

# No need to rerun this code
# Note: the outcome Y must be a numeric vector
# binary_outcome <- train$Survived

# Y = survived
# X = all predictors
# family = binomial (binary outcomes)
# verbose = TRUE.  TRUE for printing progress during the computation (helpful for debugging).
# SL.library = machine learning libraries we use
# Default is NNLS for error estimation.
# We also calculate the System time as well.
system.time(SL_wrappers <- snowSuperLearner(cluster = cl, Y = binary_outcome, X = X, SL.library = SL.library, family='binomial', verbose = TRUE, method = "method.NNLS"))

# Stop cluster once SuperLearner finishes running.
stopCluster(cl)

# I received the following error
# Error in checkForRemoteErrors(val) : 
# 4 nodes produced errors; first error: $ operator is invalid for atomic vectors

# CV SL.rpartPrune_All
# Error in testAlg$pred : $ operator is invalid for atomic vectors
# Let's try parallel again without rpartprune...

# 3/15/2015 @ 10:11pm:
# I used the following SL library: SL.library <- list( c('SL.glm', "All", "screen.glmnet", "screen.ttest") )
# I received the following error:
# Error in checkForRemoteErrors(val) : 
#   4 nodes produced errors; first error: number of items to replace is not a multiple of replacement length

# According to Subsemble News (http://cran.r-project.org/web/packages/subsemble/NEWS)
# * Cannot use `parallel="multicore"` when `"SL.gbm"` is part of the library.  This is because the `"SL.gbm"` function uses multicore parallelization by default and R gets upset when you have two levels of multicore parallelism.  This may be fixed in a future release.  This is the error: `Error in checkForRemoteErrors(val) :
# 7 nodes produced errors; first error: cannot open the connection`

SL_survived2 <- predict(object=SL_wrappers, newdata=newdata, onlySL = TRUE)

# If probability > 0.5, then set to TRUE, else FALSE 
SL_survived2_binary <- SL_survived2$pred>0.5

# Convert boolean values to integers
SL_survived2_binary <- as.integer(SL_survived2_binary) 

# Now let's submit this...
submit_sl2 <- data.frame(PassengerId = test$PassengerId, Survived = SL_survived2_binary)
write.csv(submit_sl2 , file = "submit_sl2.csv", row.names = FALSE)

################################################################################################
# SuperLearner Part 3

# Let's add my existing SL algorithms to this library with screening algorithms (from SuperLearner Example)
# I removed SL.gbm just in case it gave me problems...
# Later, we can add screening algorithms to the additional algorithms...

SL.library <- list(c("SL.glmnet", "All"), c("SL.glm", "screen.randomForest", "All", "screen.SIS"), "SL.randomForest", c("SL.polymars", "All"), "SL.mean", 'SL.rpartPrune', 'SL.rpart', 'SL.logreg', 'SL.earth', 'SL.caret', 'SL.glm.interaction', 'SL.ipredbagg', 'SL.gam', 'SL.nnet',  'SL.bayesglm', 'SL.step', 'SL.step.interaction', 'SL.stepAIC','SL.leekasso', 'SL.svm', 'SL.knn')

# Now, let's setup PSOCK multi-core cluster.
cl <- makeCluster(detectCores(), type = "PSOCK") # can use different types here
clusterSetRNGStream(cl, iseed = 2343)
system.time(SL_wrappers2 <- snowSuperLearner(cluster = cl, Y = binary_outcome, X = X, SL.library = SL.library, family='binomial', verbose = TRUE, method = "method.NNLS"))

# Stop cluster once SuperLearner finishes running.
stopCluster(cl)

SL_survived3 <- predict(object=SL_wrappers2, newdata=newdata, onlySL = TRUE)

# If probability > 0.5, then set to TRUE, else FALSE 
SL_survived3_binary <- SL_survived3$pred>0.5

# Convert boolean values to integers
SL_survived3_binary <- as.integer(SL_survived3_binary) 

# Now let's submit this...
submit_sl3 <- data.frame(PassengerId = test$PassengerId, Survived = SL_survived3_binary)
write.csv(submit_sl3 , file = "submit_sl3.csv", row.names = FALSE)


################################################################################################
# SuperLearner Part 4

SL.library <- list(c("SL.glmnet", "All"), c("SL.glm", "screen.randomForest", "All", "screen.SIS"), "SL.randomForest", c("SL.polymars", "All"), "SL.mean", 'SL.rpartPrune', 'SL.rpart', c('SL.logreg',  "screen.randomForest", "All", "screen.SIS"), 'SL.earth', 'SL.caret', c('SL.glm.interaction',  "screen.randomForest", "All", "screen.SIS"), c('SL.ipredbagg',  "screen.randomForest", "All", "screen.SIS"), c('SL.gam',  "screen.randomForest", "All", "screen.SIS"), c('SL.nnet',  "screen.randomForest", "All", "screen.SIS"),  c('SL.bayesglm',  "screen.randomForest", "All", "screen.SIS"), 'SL.step', 'SL.step.interaction', 'SL.stepAIC', 'SL.leekasso', c('SL.svm',  "screen.randomForest", "All", "screen.SIS") , c('SL.knn',  "screen.randomForest", "All", "screen.SIS") )

# Now, let's setup PSOCK multi-core cluster.
cl <- makeCluster(detectCores(), type = "PSOCK") # can use different types here
clusterSetRNGStream(cl, iseed = 2343)
system.time(SL_wrappers4 <- snowSuperLearner(cluster = cl, Y = binary_outcome, X = X, SL.library = SL.library, family='binomial', verbose = TRUE, method = "method.NNLS"))

# Stop cluster once SuperLearner finishes running.
stopCluster(cl)

SL_survived4 <- predict(object=SL_wrappers4, newdata=newdata, onlySL = TRUE)

# If probability > 0.5, then set to TRUE, else FALSE 
SL_survived4_binary <- SL_survived4$pred>0.5

# Convert boolean values to integers
SL_survived4_binary <- as.integer(SL_survived4_binary) 

# Now let's submit this...
submit_sl4 <- data.frame(PassengerId = test$PassengerId, Survived = SL_survived4_binary)
write.csv(submit_sl4 , file = "submit_sl4.csv", row.names = FALSE)


