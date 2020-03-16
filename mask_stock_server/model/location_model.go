package model

type Location struct {
	Lng float64
	Lat float64
}

type Geo struct {
	Latitude   float64 `json:"lat"`
	Longitude  float64 `json:"lng"`
	RangeMeter int     `json:"range"`
}
