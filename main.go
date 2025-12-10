package main

import (
	"encoding/json"
	"log"
	"net/http"
)

func helloHandler(w http.ResponseWriter, r *http.Request) {
	resp := struct {
		Message string `json:"message"`
	}{
		Message: "Hello World!!",
	}

	bytes, err := json.Marshal(resp)
	if err != nil {
		panic(err)
	}
	w.WriteHeader(http.StatusOK)
	w.Write(bytes)
}

func main() {
	mux := http.NewServeMux()

	mux.HandleFunc("/hello", helloHandler)

	log.Printf("The server now start listening")
	log.Fatal(http.ListenAndServe(":8080", mux))
}
