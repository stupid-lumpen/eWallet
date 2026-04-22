package com.github.stupid_lumpen;

import com.github.stupid_lumpen.network.Server;

public class App {
    public static void main(String[] args) {
        Server myServer = new Server();
        myServer.start();
    }
}
