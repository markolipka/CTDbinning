library("tidyverse")

binCTD.mean <- function(.data, # data.frame to be binned
                        .binvar, # variable name to bin over (usually depth or pressure)
                        .breaks, # breaks as in cut() (either single value giving the number of equally distributed bins or a vector of cut points)
                        .binwidth = NA # alternatively to .breaks the binwidth can be set (overwrites .breaks)
) {
    # calculate .breaks from .binwidth if provided:
    if (!is.na(.binwidth)) { 
        .breaks <- seq(0, ## starting from the water surface makes sense?!
                       ceiling(max(.data[, .binvar])), # to highest depth (rounded up)
                       by = .binwidth) # in intervals of given binwidth
    }
    
    # new parameter "bins", cut according to given breaks (or binwidth)
    .data$bins <- cut(x = .data[, .binvar], breaks = .breaks)
    
    # return new data frame with averaged parameters, grouped by bins
    .data %>% # I LOVE the pipe operator %>% !! 
        group_by(bins) %>% # dplyr function to group data
        summarise_all(mean, na.rm = TRUE) # dplyr function to apply functions on all parameters in the data frame (actually a tibble, which is kind of the better data.frame)
}


