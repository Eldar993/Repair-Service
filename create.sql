CREATE TABLE Clients
(
    id          INT PRIMARY KEY DEFAULT(NEXT VALUE FOR clients_seq),
    client_name NVARCHAR(30) NOT NULL,
    telephone   VARCHAR(15) NOT NULL,
    email       VARCHAR(30),
    order_id    INT         NOT NULL,
    CONSTRAINT fk_clients_oreders FOREIGN KEY (order_id)
        REFERENCES Orders (id)
);

CREATE SEQUENCE clients_seq AS INT
START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE TABLE Orders
(
    id             INT PRIMARY KEY DEFAULT(NEXT VALUE FOR orders_seq),
    device         VARCHAR(50) NOT NULL,
    description_id INT,
    createdAt      DATETIME2   NOT NULL,
    worker_id      INT         NOT NULL
        CONSTRAINT fk_workers FOREIGN KEY (worker_id)
        REFERENCES Workers(id),
    CONSTRAINT fk_workers FOREIGN KEY (description_id)
        REFERENCES Descriptions (id)
);

CREATE SEQUENCE orders_seq AS INT
START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE TABLE Workers
(
    id          INT PRIMARY KEY DEFAULT(NEXT VALUE FOR workers_seq),
    worker_name VARCHAR(50) NOT NULL,
    order_id    INT         NOT NULL,
    CONSTRAINT fk_workers_orders FOREIGN KEY (order_id)
        REFERENCES Orders (id)
);

CREATE SEQUENCE workers_seq AS INT
START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

CREATE TABLE Descriptions
(
    id      INT PRIMARY KEY DEFAULT(NEXT VALUE FOR descriptions_seq),
    type    VARCHAR,
    problem VARCHAR NOT NULL
);

CREATE SEQUENCE descriptions_seq AS INT
START WITH 1
    INCREMENT BY 1
    MINVALUE 1;

