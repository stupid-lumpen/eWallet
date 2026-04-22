package com.github.stupid_lumpen.network;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ResourceBundle;

public class Server {
    private final int port;
    private boolean isRunning;

    public Server() {
        ResourceBundle bundle = ResourceBundle.getBundle("server");
        this.port = Integer.parseInt(bundle.getString("SERVER_PORT"));
        this.isRunning = false;
    }

    public void start() {
        if (isRunning)
            return;
        isRunning = true;

        System.out.println("Server initialization");

        try (ServerSocket serverSocket = new ServerSocket(port)) {
            System.out.println("Server runs on port: " + port);

            while (isRunning) {
                try {
                    System.out.println("Waiting new connections");
                    Socket clientSocket = serverSocket.accept();
                    System.out.println("New connection. Client with address: " + clientSocket.getInetAddress() + ":"
                            + clientSocket.getPort());

                    ClientHandler handler = new ClientHandler(clientSocket);
                    Thread.ofVirtual().start(handler);

                } catch (IOException e) {
                    if (isRunning) {
                        System.err.println("Handling receiving connections error: " + e.getMessage());
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Critical sever error: " + e.getMessage());
        }
    }

    public void stop() {
        this.isRunning = false;
        System.out.println("Server stopped");
    }
}
