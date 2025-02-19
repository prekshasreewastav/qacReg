solution.lreg <- function(x){
   class(x) <- c("glm", "lreg")
   sol <- as.data.frame(broom::tidy(x, conf.int=FALSE))
   rownames(sol) <- sol$term
   sol <- sol[, c(2, 3, 4, 5)]

   signif <- ifelse(round(sol[[4]], 3) == 0, "***",
                    ifelse(round(sol[[4]], 3) < 0.001, "**",
                           ifelse(round(sol[[4]], 3) < 0.01, "*",
                                  ifelse(round(sol[[4]], 3) < 0.05, ".",
                                         ifelse(round(sol[[4]], 3) < 0.1, " ", "")))))

   sol <- cbind(sol, signif)
   names(sol) <- c("B", "SE", "t", "p-value", "")

   return(sol)
}
