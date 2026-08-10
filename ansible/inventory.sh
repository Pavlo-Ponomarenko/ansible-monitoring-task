#!/bin/bash

# Ask user for IPs
read -p "Enter control_IP: " CONTROL_IP
read -p "Enter target-1_IP: " TARGET1_IP
read -p "Enter target-2_IP: " TARGET2_IP
read -p "Enter target-3_IP: " TARGET3_IP

# Export them so envsubst can substitute
export CONTROL_IP
export TARGET1_IP
export TARGET2_IP
export TARGET3_IP

# Render templates
envsubst < inventory.ini.tpl > inventory.ini