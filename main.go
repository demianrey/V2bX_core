package main

import (
	"log"
	"net/http"
	"os"

	"github.com/InazumaV/V2bX/cmd"
)

func main() {
	// Obtener el puerto de la variable de entorno PORT, o usar 8080 por defecto
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	// Ejecutar la función principal de tu aplicación
	go cmd.Run()

	// Configurar un servidor HTTP que escuche en el puerto necesario
	log.Printf("Escuchando en el puerto %s...", port)
	if err := http.ListenAndServe(":"+port, nil); err != nil {
		log.Fatal(err)
	}
}
