library(blogdown)

serve_site()
build_site()
new_post('Reaching for the stars',  ext = '.Rmd')
new_post('useR2019!',  ext = '.Rmd')
new_post('Function of the week: uncount',  ext = '.Rmd', tags = c('tidyr', 'uncount'))


install_theme('tranquilpeak', hostname = "kakawait/hugo-tranquilpeak-theme", theme_example = FALSE, 
              update_config = TRUE, force = TRUE, update_hugo = FALSE)
