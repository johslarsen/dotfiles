#!/usr/bin/env Rscript
data <- read.table(file("stdin"))
message(paste("Number of rows:", nrow(data)))
summary(data)
message("Columnwise sum:")
colSums(data)
message("Columnwise product:")
apply(data, 2, prod)
