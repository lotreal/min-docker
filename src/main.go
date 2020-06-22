package main

import (
	"fmt"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
)

func main() {
	fmt.Println("Server Ready")
	router := gin.Default()
	router.GET("/", func(c *gin.Context) {
		c.String(200, "hello world, this time is: "+time.Now().Format(time.RFC1123Z))
	})
	router.GET("/github", func(c *gin.Context) {
		_, err := http.Get("https://api.github.com/")
		if err != nil {
			c.String(500, err.Error())
			return
		}
		c.String(200, "access github api ok")
	})

	if err := router.Run(":8000"); err != nil {
		panic(err)
	}
}
