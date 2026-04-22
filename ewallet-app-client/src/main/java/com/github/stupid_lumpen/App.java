package com.github.stupid_lumpen;

import com.github.stupid_lumpen.network.Client;

public class App {
    public static void main(String[] args) {

        Client client = new Client();
        client.start();
    }
}
