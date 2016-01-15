#!/usr/bin/ruby


#You have a directory where backups are created. It is organized
#as
#/dir1/YYYY­MM­DD­hh­mm­ss/*
#Assume that multiple entries appear each day.
#Create a pruning script to keep a subset of these directories, with the rules:
#­ keep all for last 24 hour period
#­ for the last 7 days, keep 1/calendar day ­ for the last 365 days, keep 1/week
#Use the time implied by the directory name, not file modification time, as the backup process itself may take time.
require 'time'

i = Time.new
a = Time.strptime("2015-12-11", "%Y-%m-%d")

puts a
