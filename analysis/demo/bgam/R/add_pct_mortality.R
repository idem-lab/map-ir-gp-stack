#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param data_all
#' @return
#' @author njtierney
#' @export
add_pct_mortality <- function(data_all) {

  # ==== Create pcent_mortality transformed variable ====
  # Empirical logit and IHS transform on labels
  data_all[, "pcent_mortality"] <- emplogit2(
    data_all["no_dead"],
    data_all["no_tested"]
  )

  theta2 <- optimise(
    f = IHS.loglik,
    lower = 0.001,
    upper = 50,
    x = data_all[, "pcent_mortality"],
    maximum = TRUE
  )

  data_all[, "pcent_mortality"] <- IHS(
    data_all[, "pcent_mortality"],
    theta2$maximum
  )

  # add an intercept
  data_all$int <- 1

  data_all

}
