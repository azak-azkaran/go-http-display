package main

import (
	"fmt"
	"log"
	"net/http"
)

func handleHttp(w http.ResponseWriter, r *http.Request) {
	log.Println("http Header:", r.Header)
	fmt.Fprintln(w, "Hello World")
	fmt.Fprintln(w, r.Header)
}

func main() {
	log.Println("Hello World")

	http.HandleFunc("/", handleHttp)

	log.Println("Starting Server")
	log.Println(http.ListenAndServe(":9100", nil))
}
