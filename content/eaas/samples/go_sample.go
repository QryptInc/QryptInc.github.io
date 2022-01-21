package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

type Response struct {
	RandomSize string   `json:"size"`
	Random     []string `json:"random"`
}

func main() {
	client := &http.Client{}
	// can replace size with a kib between 1 and 512
	req, err := http.NewRequest("GET", "https://https://api-eus.qrypt.com/api/v1/quantum-entropy?size=1", nil)
	if err != nil {
		fmt.Print(err.Error())
	}

	req.Header.Add("Authorization", "Bearer PLACE_JWT_HERE")
	response, err := client.Do(req)
	if err != nil {
		log.Fatal(err)
	}

	defer response.Body.Close()
	responseData, err := ioutil.ReadAll(response.Body)
	if err != nil {
		log.Fatal(err)
	}
	// for raw response
	fmt.Println(string(responseData))
	var responseObject Response
	json.Unmarshal(responseData, &responseObject)

	fmt.Println(responseObject.RandomSize)
	fmt.Println(len(responseObject.Random))

	for i := 0; i < len(responseObject.Random); i++ {
		// base 64 encoded random
		fmt.Println(responseObject.Random[i])
	}

}
