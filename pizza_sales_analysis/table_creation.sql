-- Create tables

-- Create pizza table
CREATE TABLE pizzas (
    pizza_id INT PRIMARY KEY,
    category_id INT,
    pizza_name VARCHAR(100),
    pizza_name_id VARCHAR(50),
    pizza_size VARCHAR(50),
    pizza_ingredients TEXT,
    FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

-- Create categories table
CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);


-- Create order table 
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    order_time TIME
);

-- Create order details table
CREATE TABLE order_details (
    order_id INT,
    quantity INT,
    unit_price FLOAT,
    total_price FLOAT,
    pizza_id INT,
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas (pizza_id)
)