## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning = FALSE)

## -----------------------------------------------------------------------------
library(rinat)
butterflies <- get_inat_obs(query = "Monarch Butterfly")

## -----------------------------------------------------------------------------
vp_obs <- get_inat_obs(query = "vernal pool")
head(vp_obs$species_guess)

## -----------------------------------------------------------------------------
## Return observations in the family Nymphalidae, for 2015 only
nymphalidae <- get_inat_obs(taxon_name  = "Nymphalidae", year = 2015)

## Return just Monarch Butterfly records, all years
monarchs <- get_inat_obs(taxon_name = "Danaus plexippus")

## ----fig.width=7, fig.height=4, fig.retina=3----------------------------------
## Search by area
bounds <- c(38.44047, -125, 40.86652, -121.837)
deer <- get_inat_obs(query = "Mule Deer", bounds = bounds)
plot(deer$longitude, deer$latitude)

## -----------------------------------------------------------------------------
## Just get info about a project
vt_crows <- get_inat_obs_project("crows-in-vermont", type = "info", raw = FALSE)

## -----------------------------------------------------------------------------
## Now get all the observations for that project
vt_crows_obs <- get_inat_obs_project(vt_crows$id, type = "observations")

## -----------------------------------------------------------------------------
m_obs <- get_inat_obs(query = "Monarch Butterfly")
head(get_inat_obs_id(m_obs$id[1]))

## -----------------------------------------------------------------------------
user_obs <- get_inat_obs_user(m_obs$user_login[1], maxresults = 20)
head(user_obs)[,1:5]

## -----------------------------------------------------------------------------
## By date
counts <- get_inat_taxon_stats(date = "2020-06-14")
counts$total
### Top 5 species
counts$species_counts
### Most common taxon ranks
counts$rank_counts

## -----------------------------------------------------------------------------
## By date
counts <- get_inat_user_stats(date = "2010-06-14")
counts$total
counts$most_observations[1:10,]
counts$most_species[1:10,]

## -----------------------------------------------------------------------------
## By place_ID
vt_crows <- get_inat_obs_project("crows-in-vermont", type = "info", raw = FALSE)
place_counts <- get_inat_user_stats(place = vt_crows$place_id)
place_counts$total
place_counts$most_observations[1:10,]
place_counts$most_species[1:10,]

## ----fig.width=7, fig.height=4, fig.retina=3----------------------------------
library(ggplot2)

## Map 100 spotted salamanders
a_mac <- get_inat_obs(taxon_name = "Ambystoma maculatum")
salamander_map <- inat_map(a_mac, plot = FALSE)

### Now we can modify the returned map
salamander_map + borders("state") + theme_bw()

## ----fig.width=7, fig.height=7, fig.retina=3----------------------------------
## A more elaborate map of Colibri sp.
colibri <- get_inat_obs(taxon_name = "Colibri",
                        quality = "research",
                        maxresults = 500)
ggplot(data = colibri, aes(x = longitude,
                         y = latitude,
                         colour = scientific_name)) +
  geom_polygon(data = map_data("world"),
                   aes(x = long, y = lat, group = group),
                   fill = "grey95",
                   color = "gray40",
                   size = 0.1) +
  geom_point(size = 0.7, alpha = 0.5) +
  coord_fixed(xlim = range(colibri$longitude, na.rm = TRUE),
              ylim = range(colibri$latitude, na.rm = TRUE)) +
  theme_bw()

