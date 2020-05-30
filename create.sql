
CREATE SEQUENCE clients_seq 
AS INT
START WITH 1
    INCREMENT BY 1
    MINVALUE 1;
    
CREATE TABLE Clients
(
    id          INT PRIMARY KEY DEFAULT(NEXT VALUE FOR clients_seq),
    client_name NVARCHAR(30) NOT NULL,
    telephone   VARCHAR(15) NOT NULL,
    email       VARCHAR(30)
);


CREATE SEQUENCE descriptions_seq AS INT
START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE TABLE Descriptions
(
    id      INT PRIMARY KEY DEFAULT(NEXT VALUE FOR descriptions_seq),
    problem_type    VARCHAR(50),
    problem_description VARCHAR(100) NOT NULL
);

CREATE SEQUENCE orders_seq AS INT
START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE TABLE Orders
(
    id             INT PRIMARY KEY DEFAULT(NEXT VALUE FOR orders_seq),
    device         VARCHAR(50) NOT NULL,
    description_id INT,
    price          DECIMAL (5, 2)  NOT NULL,
    created_at      DATETIME2   NOT NULL,
	client_id      INT         NOT NULL,
        CONSTRAINT fk_clients FOREIGN KEY (client_id)
        REFERENCES Clients(id) ON DELETE CASCADE,
		CONSTRAINT fk_descriptions FOREIGN KEY(description_id)
		REFERENCES Descriptions(id) ON DELETE CASCADE
);

CREATE SEQUENCE workers_seq AS INT
START WITH 1
    INCREMENT BY 1
    MINVALUE 1;
    
CREATE TABLE Workers
(
    id          INT PRIMARY KEY DEFAULT(NEXT VALUE FOR workers_seq),
    worker_name VARCHAR(50) NOT NULL
);

CREATE TABLE workers_orders(
  order_id INT NOT NULL,
  worker_id INT NOT NULL,
  PRIMARY KEY(order_id,worker_id),
 FOREIGN KEY(order_id)  REFERENCES Orders(id) ON DELETE CASCADE,
 FOREIGN KEY(worker_id) REFERENCES Workers(id) ON DELETE CASCADE

);






INSERT INTO Clients(client_name,telephone,email)
VALUES ('John','123456789','john@gmail.com'),
        ('Tom','123','tom@yandex.com'),
        ('Jerry','987654321','jerry@rambler.com'),
         ('Banny','12121212','banny@rambler.com');
       
       INSERT INTO Descriptions( problem_type,problem_description)
       VALUES('glass','front broken glass'),
	         ('PCcomponent','Fix processsor cooling'),
			 ('Antivirus','Clean computer from viruses');

INSERT INTO Orders(device,description_id,price,created_at,client_id)
VALUES ('iphone',1,50.00,'2018-06-23 07:30:20',1),
       ('laptop',3,15.50,'2020-03-22 05:20:30',3),
       ('PC',2,5.30,'2019-07-15 07:30:20',2),
       ('Keyboar',1,5.30,'2019-07-15 07:30:20',2);

INSERT INTO Workers(worker_name)
 VALUES('Hank'),
	   ('Bill'),
	   ('James');

			 

 INSERT INTO workers_orders(order_id,worker_id)
			 VALUES (1,2);

			 
			  SELECT * 
			 FROM Clients;
			  SELECT * 
			 FROM Workers;
			  SELECT * 
			 FROM Descriptions;
             SELECT * 
			 FROM Orders;
             
             SELECT *
             FROM Orders,Descriptions,Clients
             WHERE Orders.description_id=descriptions.id AND Orders.client_id = Clients.id
             ORDER BY created_At;
             
             --2.1--
             SELECT client_name,device,COUNT(CLIENT_ID) AS order_count
             FROM Clients FULL OUTER JOIN Orders
             ON Clients.id = orders.client_id
             WHERE client_name LIKE 'J%' 
             GROUP BY client_name,device
             ORDER BY device desc, client_name;
             
             
             --2.2--
             SELECT *
             FROM workers
             WHERE NOT EXISTS(SELECT worker_name
                                    FROM workers
                                    WHERE worker_name = 'Bob');
             --2.3--                       
             SELECT MAX(price) AS Expensive_order 
             FROM Orders
             WHERE created_at >= '2010-04-01';
             
             --2.4--
             SELECT client_name,COUNT(CLIENT_ID) AS order_count
             FROM Clients FULL OUTER JOIN Orders
             ON Clients.id = orders.client_id
             GROUP BY client_name
             HAVING COUNT(CLIENT_ID) = 0 OR COUNT(CLIENT_ID) >= 2;
             
             
             --3.2--
             GO
               CREATE FUNCTION order_date( @from DATETIME2, @to DATETIME2)
             RETURNS TABLE
             AS
              RETURN 
              SELECT *
              FROM Orders
              WHERE created_at BETWEEN @from AND @to;
              
              GO
              SELECT *
              FROM order_date('2015-02-10 07:30:20','2020-02-10 07:30:20');
         
          
            --3.1--
              GO 
             CREATE PROCEDURE new_order
                    @Device            VARCHAR(50),
                    @Description_id    INT        ,
                    @Price             DECIMAL(5,2),
                    @Created_at        DATETIME2   ,
                    @Client_id         INT        
             AS 
             BEGIN
                  SET NOCOUNT ON
                  
                  INSERT INTO Orders
                              (
                                 device ,
                                 description_id ,
                                 price ,
                                 created_at  ,
                                 client_id     
                               )
                  VALUES
                        (
                            @Device ,
                            @Description_id,
                            @Price ,
                            @Created_at,
                            @Client_id 
                            
                           )
                END
                GO
                
                exec new_order
                            @Device = 'Tablet' ,
                            @Description_id = 1,
                            @Price = 20.00,
                            @Created_at = '2015-02-10 07:30:20',
                            @Client_id = 4
                            
                            SELECT *
                            FROM ORDERS;
             
             
             
           
      
