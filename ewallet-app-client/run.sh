#!/bin/bash

set -e

echo "Running E-Wallet App..."
mvn exec:java -Dexec.mainClass="com.github.stupid_lumpen.App"
