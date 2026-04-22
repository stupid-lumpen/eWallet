package com.github.stupid_lumpen.network;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.ResourceBundle;

public class Client {
    private final String host;
    private final int port;

    public Client() {
        ResourceBundle bundle = ResourceBundle.getBundle("client");
        this.host = bundle.getString("SERVER_HOST");
        this.port = Integer.parseInt(bundle.getString("SERVER_PORT"));
    }

    public void start() {
        try (Socket socket = new Socket(host, port);
                PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
                BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                BufferedReader stdIn = new BufferedReader(new InputStreamReader(System.in))) {

            System.out.println("Connected to the server " + host + ":" + port);
            System.out.println("Print your message or/and hit enter:");

            String userInput;
            while ((userInput = stdIn.readLine()) != null) {
                if ("exit".equalsIgnoreCase(userInput)) {
                    break;
                }

                out.println(userInput);

                String response = in.readLine();
                System.out.println("Server response: " + response);
            }

        } catch (IOException e) {
            System.err.println("Connection error: " + e.getMessage());
        }
    }
}
