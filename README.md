Add freehand circles to ggplot2 graphs
======================================

The ggfreehand package allows one to add freehand red circles to a plot. This can improve many plots, but most importantly those that are to be posted on the Stack Exchange network, since everyone knows [graphs with freehand red circles are the only kind worth posting](http://meta.stackexchange.com/a/19775/176330).

### Example: a mediocre plot without freehand circles

Suppose we set up a plot of a user's (mine) number of Stack Overflow answers per month (similar to [this analysis](http://meta.stackoverflow.com/questions/252756/are-high-reputation-users-answering-fewer-questions/252757#252757)), using the [stackr](https://github.com/dgrtwo/stackr) package to query the API:

    library(ggplot2)
    library(dplyr)
    library(lubridate)
    library(stackr)

    answers <- stack_users(712603, "answers", num_pages = 10, pagesize = 100)
    answers_per_month <- answers %>%
        mutate(month = round_date(creation_date, "month")) %>%
        count(month)

    ggplot(answers_per_month, aes(month, n)) + geom_line()

![without freehand](http://i.imgur.com/C7v9D9R.png)

This plot is... OK. But as pointed out [here](http://meta.stackoverflow.com/questions/252756/are-high-reputation-users-answering-fewer-questions/252757#comment9735_252757), it's missing something.

### Example: a terrific plot with freehand circles

We now add freehand red circles to the plot, marking the top two most active months.

    top_2_months <- answers_per_month %>% top_n(2)

    library(ggfreehand)
    ggplot(answers_per_month, aes(month, n)) + geom_line() +
        geom_freehand(data = top_2_months)

![with freehand](http://i.imgur.com/jnWlTwM.png)

That looks *so much* better! It is now worthy of being posted on a Stack Exchange network site.

### Installation and documentation

This package can be installed with the [devtools](https://github.com/hadley/devtools) package:

    devtools::install_github("dgrtwo/ggfreehand", build_vignettes = TRUE)

At which point you can read the vignette for more examples:

    browseVignettes("ggfreehand")
