USER MANUAL
< Lease Analytics >
< Open Source UIF Generation >
Document Revision #: 1.0
Date of Issue: 3/31/2020
Project Manager: Aleck Blohowiak
Project Members: Jeremiah Spears, Benjamin Geiger, Ryan Haupers

General Information
Automation of language to display widgets such as forms and grids.
System has many connecting parts that share information and streamline user experience.
Frontend utilizes DevExtreme, Vue, Javascript, and Apollo. 
Backend has support from a Hasura PostgreSQL database, Rails, and GraphQL.
Open-source, any coder or widget creator will have access to this via github.

Automation
Our application allows you to create a customized widget with data that you set. To specify which data to use you will need to edit the template json file in the /templates directory. 
Here is an example of the json format:
{
	Title: Chickfila Employees
	Table-name: 
	Data: 
{
	Name:
	Date:
	Balance:
	etc:
	}
} 
Each entry in the data element will be generated as a column in the grid/form template. It should correspond to the elements in the Postgres database.

Using GUI
Backend: The backend system itself runs from the Linux command line. As such, be sure to familiarize yourself with Linux command syntax: https://www.sdstate.edu/information-technology/linux-command-line-documentation
Form: The form widget pulls data from either a set source or from a database. The form will display the object you’ve selected in the grid.
Form update: Each field can be edited within the form and the update button will write to whatever data source you pulled from.
Grid: The grid widget pulls data from either a set source or from a database. It can be sorted by clicking on the individual fields on top of the table.
Grid search: There is a search bar in the top right that can be used to query for certain values.
Running Hasura
To start up Hasura GraphQL server and browser console use command ./docker-run.sh
Console can be connected to via port 8080.
Running Rails Server/Node
To start up Rails Server and Node/Webpacker use command foreman start
App can be reached in the browser via port 3000.
Error Handling
To help find errors you can look in the Browser console for the frontend, and for the backend look at the Rails and/or Vue logs.
If you do not get any output from GraphQL in the browser console you may have a connection issue with your endpoint and should refer to the Hasura documentation (found in our maintenance manual.)
