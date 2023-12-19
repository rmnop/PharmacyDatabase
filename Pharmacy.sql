
--SUPERCLASS

-- Table: Person
CREATE TABLE Person (
    SSN VARCHAR(9) PRIMARY KEY NOT NULL,
    name VARCHAR(255)
);

ALTER TABLE Person
ADD CONSTRAINT unique_pk
UNIQUE (SSN, name);

INSERT INTO Person (SSN, name) VALUES
('987654321', 'Jane Smith'),
('555666777', 'Bob Johnson'),
('111222333', 'Alice Williams'),
('248953176', 'Emily Johnson'),
('142951076', 'Michael Rodriguez'),
('365128731', 'Sarah Williams'),
('964558247', 'Christopher Lee'),
('126833772', 'Jessica Taylor'),
('259944186', 'Steve Carrell'),
('146738811', 'Oliver Martinez'),
('267149933', 'Jackson Turner'),
('337841595', 'Amelia Harper'),
('651259714', 'Benjamin Mitchell'),
('631872398', 'Samuel Collins'),
('124129327', 'Daniel Cooper'),
('348346791', 'Caleb Morgan'),
('544589235', 'Owen Bennett'),
('423453491', 'Mia Hayes');

select * from person;

-- SUBCLASSES

-- Table: Patient
CREATE TABLE Patient (
    SSN VARCHAR(9) PRIMARY KEY NOT NULL,
    physician_SSN VARCHAR(15),
	full_name VARCHAR(255),
	address VARCHAR(255),
	age INT NOT NULL,
    FOREIGN KEY (SSN) REFERENCES Person(SSN),
    FOREIGN KEY (physician_SSN) REFERENCES Doctor(SSN),
	UNIQUE(SSN, full_name)
);

ALTER TABLE Patient
ADD prescription_id VARCHAR(255);

ALTER TABLE Patient
ADD FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id);

INSERT INTO Patient (SSN, physician_SSN, full_name, address, age) VALUES
('987654321', '555666777', 'Jane Smith', '123 Oak Street Springfield, IL 62701', 34),
('111222333', '142951076', 'Alice Williams', '456 Pine Avenue, Rivertown, CA 90210', 28),
('248953176', '365128731', 'Emily Johnson', '789 Maple Lane, Lakeside, TX 75001', 42),
('964558247', '267149933', 'Christopher Lee', '101 Cedar Drive, Hilltop, NY 10001', 19),
('126833772', '124589235', 'Jessica Taylor' , '234 Birch Court, Meadowville, FL 33123', 50),
('259944186', '678346791', 'Steve Carrell', '789 Pine Street, Hillside, OH 43001', 78),
('365128732', '631872398', 'Sarah Williams', '456 Elm Avenue, Lakeside, FL 33123', 65),
('126833777', '964558243', 'Jessica Taylor', '234 Oak Lane, Meadowville, CA 90210', 18),
('259944185', '146129327', 'Steve Carrell', '101 Birch Drive, Rivertown, TX 75001', 26),
('146738811', '124589235', 'Oliver Martinez', '567 Maple Court, Springfield, NY 10001', 43),
('337841595', '124589235', 'Amelia Harper', '890 Cedar Road, Lakeshore, IL 62701', 15),
('651259714', '678346791', 'Benjamin Mitchell', '123 Pine Circle, Hilltop, TX 75002', 32),
('678346791', '678346791', 'Caleb Morgan', '678 Elm Terrace, Meadowland, CA 90211', 37),
('271453491', '142951076', 'Mia Hayes', '345 Oak Boulevard, Riverside, FL 33124', 25),
('124129327', '267149933', 'Daniel Cooper', '210 Birch Place, Springdale, OH 43002', 21);

select * from patient;

UPDATE Patient
SET prescription_id = 'PG16'
WHERE SSN = '987654321';
UPDATE Patient

SET prescription_id = 'NP89'
WHERE SSN = '111222333';
UPDATE Patient

SET prescription_id = 'MS12'
WHERE SSN = '248953176';
UPDATE Patient

SET prescription_id = 'PG09'
WHERE SSN = '964558247';
UPDATE Patient

SET prescription_id = 'BI02'
WHERE SSN = '126833772';
UPDATE Patient

SET prescription_id = 'MS11'
WHERE SSN = '259944186';
UPDATE Patient

SET prescription_id = 'BI98'
WHERE SSN = '365128732';
UPDATE Patient

SET prescription_id = 'NP27'
WHERE SSN = '126833777';
UPDATE Patient

SET prescription_id = 'VB47'
WHERE SSN = '259944185';
UPDATE Patient

SET prescription_id = 'NP26'
WHERE SSN = '146738811';
UPDATE Patient

SET prescription_id = 'VB35'
WHERE SSN = '337841595';
UPDATE Patient

SET prescription_id = 'MS13'
WHERE SSN = '651259714';
UPDATE Patient

SET prescription_id = 'NP90'
WHERE SSN = '678346791';

UPDATE Patient
SET prescription_id = 'NP91'
WHERE SSN = '271453491';

UPDATE Patient
SET prescription_id = 'PG18'
WHERE SSN = '124129327';


-- Table: Doctor
CREATE TABLE Doctor (
   	SSN VARCHAR(9) PRIMARY KEY NOT NULL,
	full_name VARCHAR(255) NOT NULL,
    specialty VARCHAR(255),
    years_of_experience INT DEFAULT 0,
	FOREIGN KEY(SSN) REFERENCES Person(SSN),
	UNIQUE(SSN),
	UNIQUE(full_name)
);

INSERT INTO Doctor (SSN, full_name, specialty, years_of_experience) VALUES
('555666777', 'Bob Johnson', 'Pediatric', 5),
('142951076', 'Michael Rodriguez', 'Internal Medicine', 12),
('365128731', 'Sarah Williams', 'Dermatology', 8);
('267149933', 'Jackson Turner', 'Cardiology', default),
('124589235', 'Owen Bennett','Internal Medicine', 25),
('678346791', 'Caleb Morgan', 'Internal Medicine', 18),
('631872398', 'Samuel Collins', 'Surgery', 29),
('964558243', 'Christopher Lee', 'Pediatric', 12),
('146129327', 'Daniel Cooper', 'Otolaryngology', 17);

select * from doctor;


--REFERENTIAL TABLES

-- Table: Prescription
CREATE TABLE Prescription (
    prescription_id VARCHAR(255) PRIMARY KEY,
    doctor_SSN VARCHAR(15),
    patient_SSN VARCHAR(15),
    drug_trade_name VARCHAR(255),
    prescription_date DATE,
	quantity INT DEFAULT 1,
    FOREIGN KEY (doctor_SSN) REFERENCES Doctor(SSN),
    FOREIGN KEY (patient_SSN) REFERENCES Patient(SSN),
    FOREIGN KEY (drug_trade_name) REFERENCES Drug(trade_name)
);


INSERT INTO Prescription(prescription_id, doctor_ssn, patient_ssn, drug_trade_name, prescription_date, quantity) VALUES
('PG16', '142951076', '987654321', 'Lipitor', '2023-12-11', 23), -- Internal Medicine
('NP89', '142951076', '111222333', 'Duramorph', '2023-08-27', 12), -- Internal Medicine
('MS12', '555666777', '248953176', 'Moxatag', '2023-04-03', 8), -- Pediatric Medicine
('PG09', '365128731', '964558247', 'Aldactone', '2023-01-15', 9), -- Dermatologist Medicine
('BI02', '267149933', '126833772', 'Lotensin', '2023-10-31', 27), -- Cardiologist Medicine
('MS11', '678346791', '259944186', 'Ventolin HFA', '2023-11-11', 5), -- Pediatric Medicine
('BI98', '631872398', '365128732', 'Betnesol', '2023-08-01', 1), -- Otolaryngology Medicine
('NP27', '124589235', '126833777', 'Dolophine', '2023-03-22', 30), -- Internal Medicine
('VB47', '267149933', '259944185', 'Capoten', '2023-02-28', 26), -- Cardiologist Medicine
('NP26', '631872398', '146738811', 'Dolophine', '2023-12-23', 12), -- Surgeon Medicine
('VB35', '267149933', '337841595', 'Isordil', '2023-05-19', 17), -- Cardiologist Medicine
('MS13', '964558243', '651259714', 'Ventolin HFA', '2023-06-24', 4), -- Pediatrician Medicine
('NP90', '631872398', '678346791', 'Duramorph', '2023-08-25', 18), -- Surgeon Medicine
('NP91', '631872398', '271453491', 'Duramorph', '2023-09-12', 15), -- Surgeon Medicine
('PG18', '678346791', '124129327', 'Lipitor', '2023-09-14', 21); -- Internal Medicine

select * from Prescription;


-- Table: Pharmacuetical Company
CREATE TABLE PharmacueticalCompany (
    name VARCHAR(255) PRIMARY KEY,
    phone_number VARCHAR(15)
);

INSERT INTO PharmacueticalCompany(name, phone_number) VALUES
('MedicoGen Solutions','213-288-0973'),
('PharmSynth Global', '214-123-3465'),
('NexusCure Pharmaceuticals', '816-321-7854'),
('BioCare Innovations', '903-755-9331'),
('VitalBio Pharma','816-881-1122');

select * from PharmacueticalCompany;

-- Table: Drug
-- If pharmacuetical company deleted, delete row
CREATE TABLE Drug (
    trade_name VARCHAR(255) PRIMARY KEY,
    formula VARCHAR(255),
    company_name VARCHAR(255),
    FOREIGN KEY (company_name) REFERENCES PharmacueticalCompany(name)
	ON DELETE CASCADE
);

INSERT INTO Drug(trade_name, formula, company_name) VALUES
('Moxatag', 'Amoxicillin', 'MedicoGen Solutions'), -- Pediatrician prescription
('Ventolin HFA', 'Albuterol', 'MedicoGen Solutions'), -- Pediatrician prescription
('Lipitor', 'Atorvastatin', 'PharmSynth Global'), -- Internal Medicine prescription
('Aldactone', 'Spironolactone', 'PharmSynth Global'), -- Dermatologists prescription
('Dolophine', 'Methadone', 'NexusCure Pharmaceuticals'), -- Surgeon Prescriptions, Internal
('Duramorph', 'Morphine', 'NexusCure Pharmaceuticals'), -- Surgeon Prescription, Internal
('Betnesol', 'Betamethasone', 'BioCare Innovations'), -- Otolaryngology Prescriptions
('Lotensin', 'Benazepril', 'BioCare Innovations'), -- Cardiologist Prescriptions
('Capoten', 'Capoten', 'VitalBio Pharma'), -- Cardiologist Prescriptions
('Isordil', 'Isosorbide dinitrate', 'VitalBio Pharma');  -- Cardiologist Prescriptions

select * from drug;

-- Table: Pharmacy
CREATE TABLE Pharmacy (
    name VARCHAR(255) PRIMARY KEY,
    address VARCHAR(255),
    phone_number VARCHAR(15) NOT NULL
);

INSERT INTO Pharmacy(name, address, phone_number) VALUES
('Sams Club', '123 Main Street, Chicago, IL 62701', '312-234-9433'),
('Costco', '456 Oak Avenue, Rivertown, CA 90210', '415-536-8364'),
('CVS Pharmacy', '101 Maple Drive, Hilltop, NY 10001', '213-473-7766'),
('Walgreens', '234 Birch Court, Meadowville, FL 33123', '610-877-0988'),
('Health Mart', '210 Willow Boulevard, Meadowland, CA 90211', '415-237-1432');


-- TABLE: Pharmacy prescription price
CREATE TABLE PharmacySells (
	pharmacy_name VARCHAR(255),
	prescription_id VARCHAR(255),
	drug_trade_name VARCHAR(255),
	price VARCHAR(255) NOT NULL,
	FOREIGN KEY (pharmacy_name) REFERENCES Pharmacy(name),
	FOREIGN KEY (prescription_id) REFERENCES Prescription(prescription_id),
	FOREIGN KEY (drug_trade_name) REFERENCES Drug(trade_name)
);

INSERT INTO PharmacySells(pharmacy_name, prescription_id, drug_trade_name, price) VALUES
('Sams Club','PG16', 'Lipitor', '$49.99'),
('Walgreens','NP89', 'Duramorph', '$24.99'),
('Sams Club','MS12', 'Moxatag', '$14.99'),
('Walgreens','PG09', 'Aldactone', '$18.99'),
('CVS Pharmacy','BI02', 'Lotensin', '$22,99'),
('Walgreens','MS11', 'Ventolin HFA', '$69.99'),
('CVS Pharmacy','BI98', 'Betnesol', '$9.99'),
('Sams Club','NP27', 'Dolophine', '$29.99'),
('Costco','VB47', 'Capoten', '$39.99'),
('CVS Pharmacy','NP26', 'Dolophine', '$69.99'),
('Costco','VB35', 'Isordil', '$32.99'),
('Health Mart','MS13', 'Ventolin HFA', '$29.75'),
('CVS Pharmacy','NP90', 'Duramorph', '$40.00'),
('Health Mart','NP91', 'Duramorph', '$59.60'),
('CVS Pharmacy','PG18', 'Lipitor', '$62.99');


-- Table: Contract
CREATE TABLE Contract (
    contract_id INT PRIMARY KEY,
    pharmacy_name VARCHAR(255),
    company_name VARCHAR(255),
    start_date DATE,
    end_date DATE,
	text varchar(255),
    supervisor_id VARCHAR(15),
    FOREIGN KEY (pharmacy_name) REFERENCES Pharmacy(name),
    FOREIGN KEY (company_name) REFERENCES PharmacueticalCompany(name),
    FOREIGN KEY (supervisor_id) REFERENCES Supervisor(supervisor_id)
);

INSERT INTO Contract(contract_id, pharmacy_name, company_name, start_date, end_date, text, supervisor_id) VALUES
(01,  'Sams Club', 'MedicoGen Solutions', '2023-03-15', '2023-06-23', 'This Agreement shall (i) govern in all respects the provision of pharmaceutical products and related services to Sams Club or any Facility by any of the MedicoGen Solutions', 'S01'),
(02,'Costco', 'PharmSynth Global', '2023-09-05', '2023-12-08', 'This Agreement shall (i) govern in all respects the provision of pharmaceutical products and related services to Costco or any Facility by any of the PharmSynth Global', 'S02'),
(03, 'CVS Pharmacy', 'NexusCure Pharmaceuticals', '2023-01-08', '2023-04-17', 'This Agreement shall (i) govern in all respects the provision of pharmaceutical products and related services to CVS Pharmacy or any Facility by any of the NexusCure Pharmaceuticals', 'S03'),
(04, 'Walgreens', 'BioCare Innovations', '2023-05-20' , '2023-08-25', 'This Agreement shall (i) govern in all respects the provision of pharmaceutical products and related services to Walgreens or any Facility by any of the BioCare Innovations', 'S04'),
(05, 'Health Mart', 'VitalBio Pharma', '2023-11-12', '2024-02-24', 'This Agreement shall (i) govern in all respects the provision of pharmaceutical products and related services to Health Mart Company or any Facility by any of the VitalBio Pharma', 'S05'),
(06, 'Sams Club', 'MedicoGen Solutions', '2023-04-03', '2024-01-05', 'This Agreement shall (i) govern in all respects the provision of pharmaceutical products and related services to Sams Club Company or any Facility by any of the MedicoGen Solutions', 'S06'),
(07, 'Costco', 'PharmSynth Global', '2023-02-15', '2023-08-29', 'This Agreement shall (i) govern in all respects the provision of pharmaceutical products and related services to Costco or any Facility by any of the PharmSynth Global', 'S07'),
(08, 'CVS Pharmacy', 'NexusCure Pharmaceuticals', '2023-03-21', '2023-11-21', 'This Agreement shall (i) govern in all respects the provision of pharmaceutical products and related services to CVS Pharmacy or any Facility by any of the NexusCure Pharmaceuticals', 'S08'),
(09, 'Walgreens', 'BioCare Innovations', '2023-02-10', '2025-04-10', 'This Agreement shall (i) govern in all respects the provision of pharmaceutical products and related services to Walgreens Company or any Facility by any of the BioCare Innovations', 'S09'),
(10, 'Health Mart', 'VitalBio Pharma', '2023-07-06', '2024-12-30', 'This Agreement shall (i) govern in all respects the provision of pharmaceutical products and related services to Health Mart or any Facility by any of the VitalBio Pharma', 'S10');

select * from contract;

-- Table: Supervisor
CREATE TABLE Supervisor (
	supervisor_id VARCHAR(15) PRIMARY KEY NOT NULL,
	supervisor_name VARCHAR(255),
	pharmacy_name VARCHAR(255),
	company_name VARCHAR(255),
	start_date DATE,
	end_date DATE
);

INSERT INTO Supervisor(supervisor_id, supervisor_name, pharmacy_name, company_name, start_date, end_date) VALUES
('S01', 'Xavier Carter', 'Sams Club', 'MedicoGen Solutions','2023-03-15', '2023-06-23'),
('S02', 'Scarlett Miller', 'Costco', 'PharmSynth Global', '2023-09-05', '2023-12-08'),
('S03', 'Sebastian Harris', 'CVS Pharma', 'NexusCure Pharmaceuticals', '2023-01-08', '2023-04-17'),
('S04', 'Zoe Mitchell', 'Walgreens', 'BioCare Innovations', '2023-05-20', '2023-08-25'),
('S05', 'Gabriel Turner', 'Health Mart', 'VitalBio Pharma', '2023-11-12', '2024-02-24'),
('S06', 'Lily Anderson', 'Sams Club', 'MedicoGen Solutions', '2023-04-03', '2024-01-05'),
('S08', 'Aurora Davis', 'CVS Pharma', 'NexusCure Pharmaceuticals', '2023-03-21', '2023-11-21'),
('S09', 'Caleb Foster', 'Walgreens', 'BioCare Innovations', '2023-02-10', '2025-04-10'),
('S10', 'Grace Thompson', 'Health Mart', 'VitalBio Pharma','2023-07-06', '2024-12-30');

INSERT INTO Supervisor(supervisor_id, supervisor_name, pharmacy_name, company_name, start_date, end_date) VALUES
('S07', 'Samuel Jeff', 'Costco', 'PharmSynth Global','2023-02-15', '2023-08-29');


-- 1.
SELECT
	p.prescription_id,
    p.prescription_date,
    p.quantity,
    p.drug_trade_name,
    pc.name,
    d.SSN AS SSN,
    d.full_name AS name,
    d.specialty,
    d.years_of_experience
FROM
    Prescription p
JOIN
    Doctor d ON p.doctor_ssn = d.SSN
JOIN
    pharmacueticalcompany pc ON pc.name = pc.name
JOIN prescription pr ON p.patient_ssn = pr.patient_ssn
WHERE EXTRACT(MONTH FROM pr.prescription_date) = 9
  AND EXTRACT(YEAR FROM pr.prescription_date) = 2023;
  
 -- 2.
SELECT
    d.trade_name,
    d.formula,
    pi.pharmacy_name, 
	pi.prescription_id,
	pi.price
FROM
    drug d
JOIN
    pharmacysells pi ON d.trade_name = pi.drug_trade_name;
	
-- 3.
 SELECT
    d.trade_name,
    d.formula,
	d.company_name,
    pi.pharmacy_name, 
	pi.prescription_id,
	pi.drug_trade_name,
	pi.price
FROM
    drug d
JOIN
    pharmacysells pi ON d.trade_name = pi.drug_trade_name;
	
--4.
	SELECT
    d.trade_name,
    d.formula,
    d.company_name
FROM 
	drug d;
	
	SELECT * FROM Pharmacy 
	ORDER BY name ASC;
	
--5.
SELECT
    d.SSN AS ssn,
    d.full_name AS name,
	d.specialty AS specialty,
    COUNT(p.ssn) AS ssn
FROM
    doctor d
JOIN
    patient p ON d.SSN = p.physician_ssn
GROUP BY
    d.SSN, d.full_name
HAVING
    COUNT(p.ssn) >= 2
ORDER BY
    d.SSN;
	
--6. 
	SELECT
    pc.name AS pharmaceutical_name,
    pc.phone_number AS pharmaceutical_company_phone,
	ph.name AS pharmacy,
    c.start_date AS contract_start_date,
    c.end_date AS contract_end_date,
    s.supervisor_id,
    s.supervisor_name,
	s.start_date AS supervisor_start_date,
	s.end_date AS supervisor_end_date
FROM
    contract c
JOIN
    pharmacy ph ON c.pharmacy_name = ph.name
JOIN
    pharmacueticalcompany pc ON c.company_name = pc.name
JOIN
    supervisor s ON c.supervisor_id = s.supervisor_id;
	
--7.
SELECT
    pc.name AS pharmacuetical_company,
    COUNT(c.contract_id) AS total_contracts
FROM
    pharmacueticalcompany pc
LEFT JOIN
    contract c ON pc.name = c.company_name
GROUP BY
    pc.name
ORDER BY
    pc.name;
	
-- 8.
INSERT INTO drug(trade_name, formula, company_name)
VALUES ('Abilify', 'Aripiprazole', 'BioCare Innovations');

select * from drug;
--9. 

SELECT
    constraint_name,
    table_name
FROM
    information_schema.table_constraints
WHERE
    table_name = 'drug';

BEGIN TRANSACTION;
ALTER TABLE drug
    DROP CONSTRAINT drug_company_name_fkey;

ALTER TABLE drug
    ADD CONSTRAINT company_name_fk FOREIGN KEY (company_name)
        REFERENCES pharmacueticalcompany(name)
        ON DELETE CASCADE;
END;

BEGIN TRANSACTION;
ALTER TABLE contract
    DROP CONSTRAINT contract_company_name_fkey;

ALTER TABLE contract
    ADD CONSTRAINT company_name_fk FOREIGN KEY (company_name)
        REFERENCES pharmacueticalcompany(name)
        ON DELETE CASCADE;
END;

BEGIN TRANSACTION;
ALTER TABLE prescription
    DROP CONSTRAINT prescription_drug_trade_name_fkey;

ALTER TABLE prescription
    ADD CONSTRAINT drug_trade_name_fkey FOREIGN KEY (drug_trade_name)
        REFERENCES drug(trade_name)
        ON DELETE CASCADE;
END;

BEGIN TRANSACTION;
ALTER TABLE pharmacysells
    DROP CONSTRAINT pharmacysells_drug_trade_name_fkey;

ALTER TABLE pharmacysells
    ADD CONSTRAINT drug_trade_name_fkey FOREIGN KEY (drug_trade_name)
        REFERENCES drug(trade_name)
        ON DELETE CASCADE;
END;

BEGIN TRANSACTION;
ALTER TABLE patient
    DROP CONSTRAINT patient_prescription_id_fkey;

ALTER TABLE patient
    ADD CONSTRAINT prescription_id_fkey FOREIGN KEY (prescription_id)
        REFERENCES prescription(prescription_id)
        ON DELETE CASCADE;
END;

DELETE FROM pharmacueticalcompany
WHERE name = 'NexusCure Pharmaceuticals';

select * from pharmacueticalcompany;

-- 10.
UPDATE pharmacy
SET address = '6701 Boardwalk Street Chicago IL, 62701'
WHERE name = 'Sams Club';
