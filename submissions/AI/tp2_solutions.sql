create table specialties (
specialty_id int primary key auto_increment,
specialty_name VARCHAR(100) NOT NULL UNIQUE,
description TEXT,
consultation_fee DECIMAL(10, 2) NOT NULL
) ;

create table doctors (
doctor_id INT PRIMARY KEY AUTO_INCREMENT,
last_name VARCHAR(50) NOT NULL,
first_name VARCHAR(50) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone VARCHAR(20),
specialty_id INT NOT NULL ,
license_number VARCHAR(20) UNIQUE NOT NULL,
hire_date DATE,
office VARCHAR(100),
active BOOLEAN DEFAULT TRUE,
foreign key (specialty_id) REFERENCES specialties(specialty_id)
) ;

create table patients (
patient_id INT PRIMARY KEY AUTO_INCREMENT,
file_number VARCHAR(20) UNIQUE NOT NULL,
last_name VARCHAR(50) NOT NULL,
first_name VARCHAR(50) NOT NULL,
date_of_birth DATE NOT NULL,
gender ENUM('M', 'F') NOT NULL,
blood_type VARCHAR(5),
email VARCHAR(100),
phone VARCHAR(20) NOT NULL,
address TEXT,
city VARCHAR(50),
province VARCHAR(50),
registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
insurance VARCHAR(100),
insurance_number VARCHAR(50),
allergies TEXT,
medical_history TEXT
);

CREATE TABLE consultations (
consultation_id INT PRIMARY KEY AUTO_INCREMENT,
patient_id INT NOT NULL,
doctor_id INT NOT NULL,
consultation_date DATETIME NOT NULL,
reason TEXT NOT NULL,
diagnosis TEXT,
observations TEXT,
blood_pressure VARCHAR(20),
temperature DECIMAL(4, 2),
weight DECIMAL(5, 2),
height DECIMAL(5, 2),
status ENUM('Scheduled', 'In Progress', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
amount DECIMAL(10, 2),
paid BOOLEAN DEFAULT FALSE,
FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

CREATE TABLE medications (
medication_id INT PRIMARY KEY AUTO_INCREMENT,
medication_code VARCHAR(20) UNIQUE NOT NULL,
commercial_name VARCHAR(150) NOT NULL,
generic_name VARCHAR(150),
form VARCHAR(50),
dosage VARCHAR(50),
manufacturer VARCHAR(100),
unit_price DECIMAL(10, 2) NOT NULL,
available_stock INT DEFAULT 0,
minimum_stock INT DEFAULT 10,
expiration_date DATE,
prescription_required BOOLEAN DEFAULT TRUE,
reimbursable BOOLEAN DEFAULT FALSE,
INDEX idx_expiration (expiration_date),
INDEX idx_stock (available_stock)
);

create table prescriptions(
prescription_id int primary key auto_increment,
consultation_id int not null ,
prescription_date DATETIME DEFAULT CURRENT_TIMESTAMP,
treatment_duration INT ,
general_instructions TEXT,
foreign key (consultation_id) references consultations(consultation_id)

);

create table prescription_details(
detail_id INT PRIMARY KEY AUTO_INCREMENT,
prescription_id INT NOT NULL ,
medication_id INT NOT NULL  ,
quantity INT NOT NULL ,
dosage_instructions VARCHAR(200) NOT NULL,
duration INT NOT NULL,
total_price DECIMAL(10, 2),
foreign key (prescription_id) references prescriptions(prescription_id),
foreign key (medication_id) references medications(medication_id),
constraint quantity_positive check (quantity > 0 )
);

CREATE INDEX idx_patients_name ON patients(last_name, first_name);
CREATE INDEX idx_consultations_date ON consultations(consultation_date);
CREATE INDEX idx_consultations_patient ON consultations(patient_id);
CREATE INDEX idx_consultations_doctor ON consultations(doctor_id);
CREATE INDEX idx_medications_commercial_name ON medications(commercial_name);
CREATE INDEX idx_prescriptions_consultation ON prescriptions(consultation_id);

insert into specialties(specialty_name ,description ,consultation_fee) values
("General Medicine","Diagnosis and treatment of common illnesses",1500.00),
("Cardiology","Specialty dealing with heart diseases",3000.00),
("Pediatrics","Medical care for children and infants",2000.00),
("Dermatology","Treatment of skin diseases",2500.00),
("Orthopedics","Treatment of bones and joints problems",1000.00),
("Gynecology","Medical care for women reproductive health",4000.00);

insert into doctors(last_name,first_name,email,phone,specialty_id,license_number,hire_date,office) values
("BRAHIMI","LAZHER","lz.brahimi@hospital.dz","0788563309",1,"DZ-MED-1001","2011-04-11","room 8"),
('Mansouri', 'Yasmine', 'yasmine.mansouri@hospital.dz', '0550234567', 2, 'DZ-CAR-2001', '2019-03-10', 'room 7'),
('Bouzidi', 'Karim', 'karim.bouzidi@hospital.dz', '0550345678', 3, 'DZ-PED-3001', '2020-09-20', 'room 4'),
('Ferhat', 'Lina', 'lina.ferhat@hospital.dz', '0550456789', 4, 'DZ-DER-4001', '2017-11-05', 'room 14'),
('Saadi', 'Nadir', 'nadir.saadi@hospital.dz', '0550567890', 5, 'DZ-ORT-5001', '2016-02-18', 'room 12'),
('Khelladi', 'Samira', 'samira.khelladi@hospital.dz', '0550678901', 6, 'DZ-GYN-6001', '2022-12-18', 'room 10');

INSERT INTO patients 
(file_number, last_name, first_name, date_of_birth, gender, blood_type, email, phone, address, city, province, insurance, insurance_number, allergies, medical_history)VALUES
('PAT1001', 'BENABED', 'FAROUK', '2005-06-30', 'M', 'O+', 'farouk13cheb@email.com', '0556465638', 'CITE 140 LOGTS BT 8 NO 4 WIAM MADANI ', 'OUED RHIOU', 'Relizane',"CNAS", "051177002759", NULL, 'No major medical history'),
('PAT1002', 'Mansouri', 'Yasmine', '2002-09-21', 'F', 'A+', 'yasmine.m@email.com', '0550234567', 'Cite 120 Logements', 'Oran', 'Oran', 'CNAS', '041177002754', NULL, 'Asthma'),
('PAT1003', 'Bouzidi', 'Amine', '1995-01-10', 'M', 'B+', 'amine.b@email.com', '0550345678', 'Quartier El Badr', 'Constantine', 'Constantine', 'CASNOS', '042556778912', 'Penicillin allergy', NULL),
('PAT1004', 'Ferhat', 'Lina', '1988-07-30', 'F', 'AB+', 'lina.f@email.com', '0550456789', 'Rue Didouche Mourad', 'CASBAH', 'Algiers', NULL, NULL, NULL, 'Diabetes'),
('PAT1005', 'Saadi', 'Nadir', '1975-12-05', 'M', 'O-', 'nadir.s@email.com', '0550567890', 'Hai El Yasmine', 'Setif', 'Setif', 'CNAS', '091224556781', NULL, 'High blood pressure'),
('PAT1006', 'Khelladi', 'Samira', '1962-03-18', 'F', 'A-', 'samira.k@email.com', '0550678901', 'Cite El Amal', 'Annaba', 'Annaba', 'CNAS', '021337884512', 'Dust allergy', 'Arthritis'),
('PAT1007', 'Rahmani', 'Omar', '1948-11-11', 'M', 'B-', 'omar.r@email.com', '0550789012', 'Rue Ben Mhidi', 'Tlemcen', 'Tlemcen', NULL, NULL, NULL, 'Heart disease'),
('PAT1008', 'MOUNA', 'NADA', '2005-10-17', 'F', 'O+', 'nada.mouna@email.com', '0550890123', "CITE 120 WIAM MADANI", 'OUED RHIOU', 'Relizane', 'CNAS', '072334889541', 'Milk allergy', NULL);

INSERT INTO consultations
(patient_id, doctor_id, consultation_date, reason, diagnosis, observations, blood_pressure, temperature, weight, height, status, amount, paid)VALUES
(1, 1, '2026-03-01 09:30:00', 'Fever and cough', 'Common cold', 'Patient seems fine', '120/80', 37.5, 20.5, 1.10, 'Completed', 1500.00, TRUE),
(2, 2, '2026-03-02 11:00:00', 'Chest pain', 'Mild angina', 'Advised ECG', '130/85', 36.8, 60.0, 1.65, 'Completed', 3000.00, TRUE),
(3, 3, '2026-03-03 10:00:00', 'Routine check-up', 'Healthy', 'No issues', '110/70', 36.5, 70.0, 1.72, 'Completed', 2000.00, TRUE),
(4, 4, '2026-03-04 14:30:00', 'Skin rash', 'Eczema', 'Prescribed cream', '115/75', 36.7, 55.0, 1.60, 'Completed', 2500.00, TRUE),
(5, 5, '2026-03-05 09:00:00', 'Knee pain', 'Arthritis', 'Needs physiotherapy', '125/80', 36.6, 80.0, 1.78, 'Completed', 2800.00, TRUE),
(6, 6, '2026-03-06 13:00:00', 'Routine gynecology check', 'Healthy', 'No issues', '118/78', 36.9, 65.0, 1.62, 'Completed', 2600.00, TRUE),
(7, 2, '2026-03-07 15:00:00', 'Follow-up heart check', 'Stable', 'Continue meds', '135/88', 36.8, 75.0, 1.70, 'Scheduled', 3000.00, FALSE),
(8, 3, '2026-03-08 10:30:00', 'Flu symptoms', 'Influenza', 'Advised rest', '118/76', 38.0, 35.0, 1.20, 'Scheduled', 2000.00, FALSE);

INSERT INTO medications
(medication_code, commercial_name, generic_name, form, dosage, manufacturer, unit_price, available_stock, minimum_stock, expiration_date, prescription_required, reimbursable)VALUES
('MED001', 'Paracetamol 500mg', 'Paracetamol', 'Tablet', '1 tablet every 6h', 'PharmaAlgeria', 200.00, 100, 10, '2026-12-31', TRUE, TRUE),
('MED002', 'Amoxicillin 250mg', 'Amoxicillin', 'Capsule', '1 capsule every 8h', 'Saidal', 350.00, 50, 10, '2026-09-30', TRUE, TRUE),
('MED003', 'Ibuprofen 400mg', 'Ibuprofen', 'Tablet', '1 tablet every 8h', 'PharmaAlgeria', 250.00, 80, 10, '2027-01-15', TRUE, FALSE),
('MED004', 'Cough Syrup', 'Dextromethorphan', 'Syrup', '10ml every 8h', 'Saidal', 400.00, 40, 5, '2026-08-20', FALSE, FALSE),
('MED005', 'Insulin', 'Insulin Glargine', 'Injection', '10 units subcutaneously', 'Novo Nordisk', 1500.00, 20, 5, '2026-11-30', TRUE, TRUE),
('MED006', 'Vitamin D3', 'Cholecalciferol', 'Tablet', '1 tablet daily', 'PharmaAlgeria', 300.00, 70, 10, '2027-05-31', FALSE, FALSE),
('MED007', 'Antihistamine', 'Loratadine', 'Tablet', '1 tablet daily', 'Saidal', 250.00, 90, 10, '2026-12-31', FALSE, TRUE),
('MED008', 'Omeprazole', 'Omeprazole', 'Capsule', '1 capsule daily', 'PharmaAlgeria', 400.00, 60, 10, '2026-10-31', TRUE, TRUE),
('MED009', 'Paracetamol Syrup', 'Paracetamol', 'Syrup', '5ml every 6h', 'Saidal', 250.00, 30, 5, '2027-02-28', TRUE, FALSE),
('MED010', 'Calcium Tablets', 'Calcium Carbonate', 'Tablet', '1 tablet daily', 'PharmaAlgeria', 200.00, 100, 10, '2027-06-30', FALSE, FALSE);

INSERT INTO prescriptions
(consultation_id, prescription_date, treatment_duration, general_instructions)VALUES
(1, '2026-03-01 10:00:00', 5, 'Take medications after meals. Drink plenty of water.'),
(2, '2026-03-02 11:30:00', 10, 'Take heart medications twice daily. Avoid heavy exercise.'),
(3, '2026-03-03 10:30:00', 7, 'Maintain a balanced diet. Take vitamins daily.'),
(4, '2026-03-04 15:00:00', 14, 'Apply cream to affected area twice daily. Avoid scratching.'),
(5, '2026-03-05 09:30:00', 21, 'Perform physiotherapy exercises daily. Take painkillers as needed.'),
(6, '2026-03-06 13:30:00', 30, 'Take tablets daily. Schedule follow-up after one month.'),
(8, '2026-03-08 11:00:00', 7, 'Take medications every 6 hours. Rest and hydrate well.');

INSERT INTO prescription_details
(prescription_id, medication_id, quantity, dosage_instructions, duration, total_price)VALUES
(1, 1, 10, '1 tablet every 6 hours after meals', 5, 2000.00),  
(1, 9, 25, '5ml syrup every 6 hours', 5, 6250.00),             
(2, 2, 30, '1 capsule every 8 hours', 10, 10500.00),           
(2, 8, 10, '1 capsule daily', 10, 4000.00),                    
(3, 6, 7, '1 tablet daily', 7, 2100.00),                        
(4, 4, 14, '10ml syrup twice daily', 14, 5600.00),             
(4, 3, 14, '1 tablet every 8 hours', 14, 3500.00),              
(5, 3, 21, '1 tablet every 8 hours', 21, 5250.00),             
(5, 7, 21, '1 tablet daily', 21, 5250.00),                      
(6, 10, 30, '1 tablet daily', 30, 6000.00),                     
(7, 1, 14, '1 tablet every 6 hours', 7, 2800.00),               
(7, 9, 21, '5ml syrup every 6 hours', 7, 5250.00);          

-- Q1. List all patients with their main information
select file_number, last_name,first_name, date_of_birth, phone, city from patients;   

-- Q2. Display all doctors with their specialty
select last_name,first_name,office,specialty_id from doctors;

-- Q3. Find all medications with price less than 500 DA
select * from medications where unit_price < 500;

 -- Q4. List consultations from January 2025
SELECT 
    c.consultation_date,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    c.status
FROM consultations c
JOIN patients p ON c.patient_id = p.patient_id
JOIN doctors d ON c.doctor_id = d.doctor_id
WHERE c.consultation_date >= '2025-01-01'
  AND c.consultation_date < '2025-02-01'
ORDER BY c.consultation_date;

-- Q6. All consultations with patient and doctor names 
SELECT c.consultation_date,
       CONCAT(p.first_name,' ',p.last_name) AS patient_name,
       CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
       c.diagnosis, c.amount
FROM consultations c
JOIN patients p ON c.patient_id = p.patient_id
JOIN doctors d ON c.doctor_id = d.doctor_id;

-- Q7. All prescriptions with medication details
SELECT pr.prescription_date,
       CONCAT(p.first_name,' ',p.last_name) AS patient_name,
       m.commercial_name AS medication_name,
       pd.quantity, pd.dosage_instructions
FROM prescriptions pr
JOIN consultations c ON pr.consultation_id = c.consultation_id
JOIN patients p ON c.patient_id = p.patient_id
JOIN prescription_details pd ON pr.prescription_id = pd.prescription_id
JOIN medications m ON pd.medication_id = m.medication_id;

-- Q8. Patients with their last consultation date 
SELECT CONCAT(p.first_name,' ',p.last_name) AS patient_name,
       MAX(c.consultation_date) AS last_consultation_date,
       CONCAT(d.first_name,' ',d.last_name) AS doctor_name
FROM consultations c
JOIN patients p ON c.patient_id = p.patient_id
JOIN doctors d ON c.doctor_id = d.doctor_id
GROUP BY p.patient_id, d.doctor_id;

-- Q9. Doctors and number of consultations
SELECT CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
       COUNT(c.consultation_id) AS consultation_count
FROM doctors d
LEFT JOIN consultations c ON d.doctor_id = c.doctor_id
GROUP BY d.doctor_id;

-- Q10. Revenue by medical specialty 
SELECT s.specialty_name,
       SUM(c.amount) AS total_revenue,
       COUNT(c.consultation_id) AS consultation_count
FROM consultations c
JOIN doctors d ON c.doctor_id = d.doctor_id
JOIN specialties s ON d.specialty_id = s.specialty_id
GROUP BY s.specialty_id;

-- Q11. Total prescription amount per patient
SELECT CONCAT(p.first_name,' ',p.last_name) AS patient_name,
       SUM(pd.total_price) AS total_prescription_cost
FROM patients p
JOIN consultations c ON p.patient_id = c.patient_id
JOIN prescriptions pr ON c.consultation_id = pr.consultation_id
JOIN prescription_details pd ON pr.prescription_id = pd.prescription_id
GROUP BY p.patient_id;

-- Q12. Number of consultations per doctor
SELECT CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
       COUNT(c.consultation_id) AS consultation_count
FROM doctors d
LEFT JOIN consultations c ON d.doctor_id = c.doctor_id
GROUP BY d.doctor_id;

-- Q13. Total stock value of pharmacy 
SELECT COUNT(medication_id) AS total_medications,
       SUM(unit_price * available_stock) AS total_stock_value
FROM medications;

-- Q14. Average consultation price per specialty 
SELECT s.specialty_name,
       AVG(c.amount) AS average_price
FROM consultations c
JOIN doctors d ON c.doctor_id = d.doctor_id
JOIN specialties s ON d.specialty_id = s.specialty_id
GROUP BY s.specialty_id;

-- Q15. Number of patients by blood type
SELECT blood_type, COUNT(*) AS patient_count
FROM patients
GROUP BY blood_type;

-- Q16. Top 5 most prescribed medications 
SELECT m.commercial_name AS medication_name,
       COUNT(pd.medication_id) AS times_prescribed,
       SUM(pd.quantity) AS total_quantity
FROM prescription_details pd
JOIN medications m ON pd.medication_id = m.medication_id
GROUP BY pd.medication_id
ORDER BY times_prescribed DESC
LIMIT 5;

-- Q17. Patients who never had a consultation
SELECT CONCAT(p.first_name,' ',p.last_name) AS patient_name, p.registration_date
FROM patients p
LEFT JOIN consultations c ON p.patient_id = c.patient_id
WHERE c.consultation_id IS NULL;

-- Q18. Doctors with more than 2 consultations
SELECT CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
       s.specialty_name AS specialty,
       COUNT(c.consultation_id) AS consultation_count
FROM doctors d
JOIN specialties s ON d.specialty_id = s.specialty_id
JOIN consultations c ON d.doctor_id = c.doctor_id
GROUP BY d.doctor_id
HAVING COUNT(c.consultation_id) > 2;

-- Q19. Unpaid consultations with total amount 
SELECT CONCAT(p.first_name,' ',p.last_name) AS patient_name,
       c.consultation_date, c.amount,
       CONCAT(d.first_name,' ',d.last_name) AS doctor_name
FROM consultations c
JOIN patients p ON c.patient_id = p.patient_id
JOIN doctors d ON c.doctor_id = d.doctor_id
WHERE c.paid = FALSE;

-- Q20. Medications expiring in <6 months from today
SELECT commercial_name AS medication_name,
       expiration_date,
       DATEDIFF(expiration_date, CURDATE()) AS days_until_expiration
FROM medications
WHERE expiration_date <= DATE_ADD(CURDATE(), INTERVAL 6 MONTH);

-- Q21. Patients who consulted more than average
SELECT CONCAT(p.first_name,' ',p.last_name) AS patient_name,
       COUNT(c.consultation_id) AS consultation_count,
       (SELECT AVG(consult_count) FROM 
            (SELECT COUNT(*) AS consult_count FROM consultations GROUP BY patient_id) AS avg_table
       ) AS average_count
FROM patients p
JOIN consultations c ON p.patient_id = c.patient_id
GROUP BY p.patient_id
HAVING COUNT(c.consultation_id) > 
       (SELECT AVG(consult_count) FROM 
            (SELECT COUNT(*) AS consult_count FROM consultations GROUP BY patient_id) AS avg_table
       );

-- Q22. Medications more expensive than average price
SELECT commercial_name AS medication_name, unit_price,
       (SELECT AVG(unit_price) FROM medications) AS average_price
FROM medications
WHERE unit_price > (SELECT AVG(unit_price) FROM medications);

-- Q23. Doctors from the most requested specialty
SELECT CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
       s.specialty_name,
       COUNT(c.consultation_id) AS specialty_consultation_count
FROM doctors d
JOIN specialties s ON d.specialty_id = s.specialty_id
JOIN consultations c ON d.doctor_id = c.doctor_id
WHERE d.specialty_id = (
    SELECT specialty_id 
    FROM consultations c2
    JOIN doctors d2 ON c2.doctor_id = d2.doctor_id
    GROUP BY d2.specialty_id
    ORDER BY COUNT(c2.consultation_id) DESC
    LIMIT 1
)
GROUP BY d.doctor_id;

-- Q24. Consultations with amount higher than average
SELECT consultation_date,
       CONCAT(p.first_name,' ',p.last_name) AS patient_name,
       amount,
       (SELECT AVG(amount) FROM consultations) AS average_amount
FROM consultations
WHERE amount > (SELECT AVG(amount) FROM consultations);

-- Q25. Allergic patients who received a prescription 
SELECT CONCAT(p.first_name,' ',p.last_name) AS patient_name,
       p.allergies,
       COUNT(pr.prescription_id) AS prescription_count
FROM patients p
JOIN consultations c ON p.patient_id = c.patient_id
JOIN prescriptions pr ON c.consultation_id = pr.consultation_id
WHERE p.allergies IS NOT NULL AND p.allergies != ''
GROUP BY p.patient_id;

-- Q26. Total revenue per doctor (paid consultations only) 
SELECT CONCAT(d.first_name,' ',d.last_name) AS doctor_name,
       COUNT(c.consultation_id) AS total_consultations,
       SUM(c.amount) AS total_revenue
FROM doctors d
JOIN consultations c ON d.doctor_id = c.doctor_id
WHERE c.paid = TRUE
GROUP BY d.doctor_id;

-- Q27. Top 3 most profitable specialties 
SELECT s.specialty_name,
       SUM(c.amount) AS total_revenue
FROM specialties s
JOIN doctors d ON s.specialty_id = d.specialty_id
JOIN consultations c ON d.doctor_id = c.doctor_id
GROUP BY s.specialty_id
ORDER BY total_revenue DESC
LIMIT 3;

-- Q28. Medications to restock (stock < minimum)
SELECT commercial_name AS medication_name,
       available_stock AS current_stock,
       minimum_stock,
       (minimum_stock - available_stock) AS quantity_needed
FROM medications
WHERE available_stock < minimum_stock;

-- Q29. Average number of medications per prescription
SELECT AVG(med_count) AS average_medications_per_prescription
FROM (
    SELECT COUNT(*) AS med_count
    FROM prescription_details
    GROUP BY prescription_id
) AS temp;

-- Q30. Patient demographics report by age group 
SELECT
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 0 AND 18 THEN '0-18'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 19 AND 40 THEN '19-40'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS patient_count,
    ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM patients),2) AS percentage
FROM patients
GROUP BY age_group;
