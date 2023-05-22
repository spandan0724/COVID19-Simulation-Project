#COVID-19 Simulation
library(ggplot2)


#initializing the parameters for the simulation
N_total_population=10000
recovery_time=10
simulation_time=150#days 
initially_infect=2 
mortality_rate=0.002
infection_rate=0.3  
immune_coeff=0.1  


#initialise citizen
#0--->healthy citizen
#1--->initial infected citizen
#2--->dead citizen


citizens=rep(0, N_total_population)  
citizens[sample(1:N_total_population, initially_infect)]=1


#data frame for simulation
df_simulate=data.frame(day=0, sick=sum(citizens==1), deaths=0, new_infections=0)


#loop for simulation
for(day in 1:simulation_time)
  {
  
  #we start by assuming all citizens are alive and healthy
  new_infections=0
  deaths=0
  sick_citizens=which(citizens==1)
  
  
  #no. of deaths based on a mortality rate.  
  deaths=sum(rnorm(length(sick_citizens))<mortality_rate)
  
  
  #every citizen is meeting a randomly selected person from the population b/w 0 to 20 who is sick.
  contacts=sample(N_total_population, size=sum(sample(0:20,length(sick_citizens),replace=TRUE)))
  
  
  #total no. of new infections based on contacts and infection rate
  new_infections=sum(citizens[contacts]==0 & runif(length(contacts))<infection_rate)
  
  
  #After 10 days a sick citizen becomes healthy and stops spreading virus.
  #Hence checking if the person is recovered and marking them healthy(3)
  recovery_citizens=sick_citizens[runif(length(sick_citizens))<inverse_recovery_time]
  citizens[recovery_citizens]=3   
  
  
  #citizens who are recovered(partial immunity) after surviving the infection and getting healthy. 
  #which reduces the chances of getting sick in future if they meet a sick person.
  immune_citizens=which(citizens == 3)
  contacts=sample(N_total_population, size=sum(sample(0:20,length(immune_citizens), replace=TRUE)))
  new_infections_immunity=sum(citizens[contacts] == 0 & runif(length(contacts))<infection_rate*immune_coeff)
  
  
  #updating the status of the citizens to know if the citizens are immune or still sick.
  citizens[sick_citizens]=ifelse(runif(length(sick_citizens)) < inverse_recovery_time, 3, 1)
  citizens[immune_citizens]=ifelse(runif(length(immune_citizens)) < infection_rate*immune_coeff, 1, 3)
  
  
  #updating the simulation data by adding a row which contains current day, 
  #the no. of sick individuals, the number of deaths, and the number of new infections.
  df_simulate=rbind(df_simulate, data.frame(day=day, sick=sum(citizens == 1), 
                                                  deaths=deaths, new_infections=new_infections+new_infections_immunity))
}


#printing the data
print("Simulation Data")
print(df_simulate)




#plotting the simulation data as line plot graph.
ggplot(df_simulate, aes(x = day)) +
  geom_line(aes(y = sick, color = "Sick"), size = 1) +
  geom_line(aes(y = deaths, color = "Deaths"), size = 1) +
  geom_line(aes(y = new_infections, color = "New Infections"), size = 1) +
  labs(x = "Day", y = "Number of Citizens", color = "Status") +
  scale_color_manual(values = c("Sick" = "orange", "Deaths" = "red", "New Infections" = "cornflowerblue")) +
  ggtitle("COVID-19 Simulation") +
  theme_dark()



#plotting the simulation data as pie chart.
status_sum <- data.frame(
  Status = c("Sick", "Death", "New Infection"),
  Count = c(
    sum(df_simulate$sick),
    sum(df_simulate$deaths),
    sum(df_simulate$new_infections)
  )
)
status_sum$Percentage=status_sum$Count/sum(status_sum$Count)*100
ggplot(status_sum, aes(x = "", y = Count, fill = Status)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(x = NULL, y = NULL, fill = "Status") +
  ggtitle("COVID-19 Simulation") +
  geom_text(aes(label = paste0(round(Percentage, 1), "%")), 
            position = position_stack(vjust = 0.5)) +
  theme_dark()

library(csv)
# Assuming you have a data frame called "df_simulate"
# Specify the file path and name
file_path <- "C:/Users/spand/OneDrive/Desktop/New folder/COVID STIMULATION.csv"
# Export the data frame to Excel
write.csv(df_simulate, file_path, row.names = FALSE)
# Confirm the export
print("Data exported to Excel successfully.")


