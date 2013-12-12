
## ----,echo=FALSE,error=FALSE,warning=FALSE-------------------------------
library(rinat)
library(ggplot2)


## ----, eval=FALSE--------------------------------------------------------
## butterflies <- get_inat_obs(query="Monarch Butterfly")


## ------------------------------------------------------------------------
vp_obs <- get_inat_obs(query="vernal pool")
head(vp_obs$Species.guess)


## ----,eval = FALSE-------------------------------------------------------
## ## Return just observations in the family Plecoptera
## stone_flies <- get_inat_obs(taxon="Plecoptera")
## 
## ## Return just Monarch Butterfly records
## just_butterflies <- get_inat_obs(taxon="Danaus plexippus")


## ----, eval = FALSE------------------------------------------------------
## ## Search by area
## 
## bounds <- c(38.44047,-125,40.86652,-121.837)
## deer <- get_inat_obs(query="Mule Deer", bounds=bounds)


## ------------------------------------------------------------------------
## Just get info about a project
vt_crows <- get_inat_obs_project("crows-in-vermont", type="info",raw=FALSE) 
## Now get all the observations for that project
vt_crows_obs <- get_inat_obs_project(vt_crows$id,type="observations")


## ------------------------------------------------------------------------
m_obs <- get_inat_obs(query="Monarch Butterfly")
head(get_inat_obs_id(m_obs$Id[1]))


## ------------------------------------------------------------------------
m_obs <- get_inat_obs(query="Monarch Butterfly")
head(get_inat_obs_user(as.character(m_obs$User.login[1]),maxresults=20))[,1:5]


## ------------------------------------------------------------------------
## By date
counts <- get_inat_taxon_stats(date="2010-06-14")
counts

## By place_ID
vt_crows <- get_inat_obs_project("crows-in-vermont", type="info",raw=FALSE) 
place_counts <- get_inat_taxon_stats(place = vt_crows$place_id)
place_counts


## ------------------------------------------------------------------------
## By date
counts <- get_inat_user_stats(date="2010-06-14")
counts

## By place_ID
vt_crows <- get_inat_obs_project("crows-in-vermont", type="info",raw=FALSE) 
place_counts <- get_inat_user_stats(place = vt_crows$place_id)
place_counts


## ----, fig.align='center',fig.height=5,fig.width=7,fig.path='inst/'------
## Map salamanders in the genuse Ambystoma
m_obs <- get_inat_obs(taxon="Ambystoma maculatum")

salamander_map <- inat_map(m_obs,plot=FALSE)
### Now we can modify the returned map
salamander_map + borders("state") + theme_bw()



