**NJPW Events \& Match Ratings (2015–2025)**



Structured Entertainment Analytics Dataset





**Dataset Summary**



njpw\_events.csv → 2,164 rows



njpw\_match\_rating.csv → 7,426 rows



**Date range:** 2015-01-01 to 2025-12-31



Dates stored as true date type



**Designed for SQL modeling and BI analysis**



**Table:** njpw\_events.csv



**Purpose**: Event-level table containing NJPW shows from 2015–2025, including televised programming, premium live events (PLE/PPV), and non-televised live events.



**Columns**



| Column Name | Data Type | Description |

|-------------|-----------|-------------|

| Date	| Date | Event date (YYYY-MM-DD) |

| Promotion | Text | Promotion name (NJPW) |

| Event | Text | General show or brand (e.g., Wrestle Kingdom, Strong) |

| EventName | Text | Specific event instance or episode title (e.g., “NJPW World Tag League 2025”) |

| EventType | Text | Event classification: Televised, Non-Televised, or PLE/PPV |

| Location | Text | Full formatted location string (City, State/Province, Country) |

| CityTown | Text | City or town where the event occurred |

| StateProvince | Text | State, province, or region |

| Country | Text | Country of event |

---



**Table:** njpw\_match\_rating.csv



**Purpose:** Match-level fact table containing NJPW matches with available Cagematch and/or WON ratings.



**Columns**



| Column Name | Date Type | Description |

|-------------|-----------|-------------|

| Index | Integer | Row index used as a temporary match identifier. (Can be replaced with a surrogate MatchID in SQL.) |

| Date | Date | Match date (true date type). Used to link to event table. |

| Promotion | Text | Promotion name (NJPW). |

| Match | Text | Full match description string as captured from source. |

| CageMatchRating | Decimal | Cagematch user rating score. Nullable. |

| CageMatchRatingVotes | Integer | Total votes contributing to Cagematch rating. Nullable. |

| WONStarRating | Decimal | Wrestling Observer Newsletter star rating. Nullable. |

| Opponent1 | Text | Competitor or team on one side of the match. |

| Opponent2 | Text | Competitor or team on the opposing side.|

---



**Nullable Columns**



The following columns may contain null values due to missing ratings in source data:



CageMatchRating



CageMatchRatingVotes



WONStarRating



Null values indicate the match was not rated by that source.





**Relationship Notes**



Each match in njpw\_match\_rating.csv corresponds to an event date in njpw\_events.csv.





**Current join logic:**



Date



Promotion



Future modeling enhancement:



Introduce EventID in njpw\_events.csv



Add EventID foreign key to njpw\_match\_rating.csv







**Suggested Analytical Use Cases**



**This dataset supports:**



Superstar rating trajectory analysis



Televised vs PLE quality comparison



Touring heatmaps (city/state/country)



Vote-weighted rating analysis



Match rating inflation trends



Cross-rating system comparison (Fan vs WON)



SQL practice

