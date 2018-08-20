library("tidyverse")

binCTD.mean <- function(.data, # data.frame to be binned
                        .binvar, # variable name to bin over
                        .breaks, # breaks as used by cut() (either single value giving the number of equally distributed bins or a vector of cut points)
                        .binwidth = NA # alternatively to .breaks the binwidth can be set (overwrites .breaks)
                        ) {
    
    if (!is.na(.binwidth)) {
        .breaks <- seq(0, ceiling(max(.data[, .binvar])), by = .binwidth)
    }
    
    .data$bins <- cut(x = .data[, .binvar], breaks = .breaks)
    
    .data %>%
        group_by(bins) %>%
        summarise_all(mean, na.rm = TRUE)
}


