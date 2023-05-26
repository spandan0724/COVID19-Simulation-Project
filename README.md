

# COVID-19 Simulation

This is a simulation of the spread of COVID-19 within a population. The simulation models the infection dynamics based on specified parameters such as infection probability, death probability, recovery time, and immunity reduction.

## Prerequisites

To run the simulation, you need to have R and the ggplot2 library installed on your machine.

## Getting Started

1. Clone or download the repository containing the simulation code.

2. Open the R script file (`COVID_19_simulation.R`) in an R development environment or text editor.

3. Set the desired simulation parameters in the script:
   - `population_size`: Total size of the population
   - `initial_infection_count`: Number of initial infections at the start of the simulation
   - `infection_chance`: Probability of infection upon contact
   - `death_chance`: Probability of death for infected individuals
   - `recovery_time`: Number of days required for an individual to recover
   - `immunity_reduction`: Reduction factor for infection probability in recovered individuals
   - `simulation_days`: Number of days to simulate

4. Run the script to execute the simulation. The script will simulate the spread of COVID-19 over the specified number of days and generate visualizations of the results.

5. The simulation results will be displayed in the R console, and line plot and scatter plot visualizations will be saved as images.

## Results

The simulation generates the following results:

- Number of sick individuals (infected but not recovered or deceased) at each simulation day.
- Number of deaths due to COVID-19 at each simulation day.
- Number of new infections at each simulation day.

## Visualizations

The simulation provides two types of visualizations:

- Line Plot: Displays the number of sick individuals, deaths, and new infections over the simulation days.
- Scatter Plot: Shows the daily count of sick individuals, deaths, and new infections as individual data points.

## Contributing

Contributions to the COVID-19 simulation project are welcome. If you have any ideas, suggestions, or improvements, please open an issue or submit a pull request.





Feel free to modify and adapt the code according to your needs. If you have any questions or need further assistance, please let me know.
