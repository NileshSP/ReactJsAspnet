﻿-- Add new sql(.mdf) database file named as SampleDatabase.mdf inside App_Data folder and then run the following script

/* if db with specified name as below doesn't exist then execute the create database command as below inside SampleDatabase.mdf file */
CREATE DATABASE SampleDatabase;
GO

USE SampleDatabase;
GO

CREATE TABLE [Website] (
    [WebsiteId] int NOT NULL IDENTITY,
    [Url] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Website] PRIMARY KEY ([WebsiteId])
);
GO

CREATE TABLE [WebsiteVisitDetails] (
    [WebsiteVisitDetailsId] int NOT NULL IDENTITY,
    [WebsiteId] int NOT NULL,
    [TotalVisits] int,
    [VisitDate] date,
    CONSTRAINT [PK_WebsiteVisitDetails] PRIMARY KEY ([WebsiteVisitDetailsId]),
    CONSTRAINT [FK_WebsiteVisitDetails_Website_WebsiteId] FOREIGN KEY ([WebsiteId]) REFERENCES [Website] ([WebsiteId]) ON DELETE CASCADE
);
GO

INSERT INTO [Website] (Url) VALUES
('http://blogs.msdn.com/dotnet'),
('http://blogs.msdn.com/webdev'),
('http://blogs.msdn.com/visualstudio'),
('http://blogs.msdn.com/signalr'),
('http://blogs.msdn.com/mobiles'),
('http://blogs.msdn.com/visualstudiocode'),
('http://blogs.msdn.com/csharp'),
('http://blogs.msdn.com/webdev'),
('http://blogs.msdn.com/visualbasic'),
('http://blogs.msdn.com/mssql'),
('http://blogs.msdn.com/azure'),
('http://blogs.msdn.com/xbox'),
('http://blogs.msdn.com/surfaceproducts'),
('http://blogs.msdn.com/fsharp'),
('http://blogs.msdn.com/office')
GO

INSERT INTO [WebsiteVisitDetails] (WebsiteId, TotalVisits, VisitDate) VALUES
(1, 100, '11/01/2018'), (1, 200, '11/02/2018'), (1, 300, '11/03/2018'), (1, 400, '11/04/2018'), (1, 500, '11/05/2018'), (1, 600, '11/06/2018'), (1, 700, '11/07/2018'), (1, 800, '11/08/2018'), (1, 900, '11/09/2018'), (1, 1000, '01/10/2018'),
(2, 200, '11/01/2018'), (2, 300, '11/02/2018'), (2, 400, '11/03/2018'), (2, 500, '11/04/2018'), (2, 600, '11/05/2018'), (2, 700, '11/06/2018'), (2, 800, '11/07/2018'), (2, 900, '11/08/2018'), (2, 1000, '11/09/2018'), (2, 1100, '01/10/2018'),
(3, 300, '11/01/2018'), (3, 400, '11/02/2018'), (3, 500, '11/03/2018'), (3, 600, '11/04/2018'), (3, 700, '11/05/2018'), (3, 800, '11/06/2018'), (3, 900, '11/07/2018'), (3, 1000, '11/08/2018'), (3, 1100, '11/09/2018'), (3, 1200, '01/10/2018'),
(4, 400, '11/01/2018'), (4, 500, '11/02/2018'), (4, 600, '11/03/2018'), (4, 700, '11/04/2018'), (4, 800, '11/05/2018'), (4, 900, '11/06/2018'), (4, 1000, '11/07/2018'), (4, 1100, '11/08/2018'), (4, 1200, '11/09/2018'), (4, 1300, '01/10/2018'),
(5, 500, '11/01/2018'), (5, 600, '11/02/2018'), (5, 700, '11/03/2018'), (5, 800, '11/04/2018'), (5, 900, '11/05/2018'), (5, 1000, '11/06/2018'), (5, 1100, '11/07/2018'), (5, 1200, '11/08/2018'), (5, 1300, '11/09/2018'), (5, 1400, '01/10/2018'),
(6, 600, '11/01/2018'), (6, 700, '11/02/2018'), (6, 800, '11/03/2018'), (6, 900, '11/04/2018'), (6, 1000, '11/05/2018'), (6, 1100, '11/06/2018'), (6, 1200, '11/07/2018'), (6, 1300, '11/08/2018'), (6, 1400, '11/09/2018'), (6, 1500, '01/10/2018'),
(7, 700, '11/01/2018'), (7, 800, '11/02/2018'), (7, 900, '11/03/2018'), (7, 1000, '11/04/2018'), (7, 1100, '11/05/2018'), (7, 1200, '11/06/2018'), (7, 1300, '11/07/2018'), (7, 1400, '11/08/2018'), (7, 1500, '11/09/2018'), (7, 1600, '01/10/2018'),
(8, 800, '11/01/2018'), (8, 900, '11/02/2018'), (8, 1000, '11/03/2018'), (8, 1100, '11/04/2018'), (8, 1200, '11/05/2018'), (8, 1300, '11/06/2018'), (8, 1400, '11/07/2018'), (8, 1500, '11/08/2018'), (8, 1600, '11/09/2018'), (8, 1700, '01/10/2018'),
(9, 900, '11/01/2018'), (9, 1000, '11/02/2018'), (9, 1100, '11/03/2018'), (9, 1200, '11/04/2018'), (9, 1300, '11/05/2018'), (9, 1400, '11/06/2018'), (9, 1500, '11/07/2018'), (9, 1600, '11/08/2018'), (9, 1700, '11/09/2018'), (9, 1800, '01/10/2018'),
(10, 1000, '11/01/2018'), (10, 1100, '11/02/2018'), (10, 1200, '11/03/2018'), (10, 1300, '11/04/2018'), (10, 1400, '11/05/2018'), (10, 1500, '11/06/2018'), (10, 1600, '11/07/2018'), (10, 1700, '11/08/2018'), (10, 1800, '11/09/2018'), (10, 1900, '01/10/2018'),
(11, 1100, '11/01/2018'), (11, 1200, '11/02/2018'), (11, 1300, '11/03/2018'), (11, 1400, '11/04/2018'), (11, 1500, '11/05/2018'), (11, 1600, '11/06/2018'), (11, 1700, '11/07/2018'), (11, 1800, '11/08/2018'), (11, 1900, '11/09/2018'), (11, 2000, '01/10/2018'),
(12, 1200, '11/01/2018'), (12, 1300, '11/02/2018'), (12, 1400, '11/03/2018'), (12, 1500, '11/04/2018'), (12, 1600, '11/05/2018'), (12, 1700, '11/06/2018'), (12, 1800, '11/07/2018'), (12, 1900, '11/08/2018'), (12, 2000, '11/09/2018'), (12, 2100, '01/10/2018'),
(13, 1300, '11/01/2018'), (13, 1400, '11/02/2018'), (13, 1500, '11/03/2018'), (13, 1600, '11/04/2018'), (13, 1700, '11/05/2018'), (13, 1800, '11/06/2018'), (13, 1900, '11/07/2018'), (13, 2000, '11/08/2018'), (13, 2100, '11/09/2018'), (13, 2200, '01/10/2018'),
(14, 1400, '11/01/2018'), (14, 1500, '11/02/2018'), (14, 1600, '11/03/2018'), (14, 1700, '11/04/2018'), (14, 1800, '11/05/2018'), (14, 1900, '11/06/2018'), (14, 2000, '11/07/2018'), (14, 2100, '11/08/2018'), (14, 2200, '11/09/2018'), (14, 2300, '01/10/2018'),
(15, 1500, '11/01/2018'), (15, 1600, '11/02/2018'), (15, 1700, '11/03/2018'), (15, 1800, '11/04/2018'), (15, 1900, '11/05/2018'), (15, 2000, '11/06/2018'), (15, 2100, '11/07/2018'), (15, 2200, '11/08/2018'), (15, 2300, '11/09/2018'), (15, 2400, '01/10/2018')
GO


/* desired query 
SELECT TOP 5 a.WebsiteId, a.Url, b.WebsiteVisitDetailsId, b.TotalVisits, b.VisitDate
FROM Website a
INNER JOIN WebsiteVisitDetails b ON a.WebsiteId = b.WebsiteId
WHERE b.VisitDate = '11/01/2018'
ORDER BY b.TotalVisits DESC

with output as 
WebsiteId	Url										WebsiteVisitDetailsId	TotalVisits	VisitDate	
15			http://blogs.msdn.com/office			141						1500		2018-11-01	
14			http://blogs.msdn.com/fsharp			131						1400		2018-11-01	
13			http://blogs.msdn.com/surfaceproducts	121						1300		2018-11-01	
12			http://blogs.msdn.com/xbox				111						1200		2018-11-01	
11			http://blogs.msdn.com/azure				101						1100		2018-11-01	


*/





