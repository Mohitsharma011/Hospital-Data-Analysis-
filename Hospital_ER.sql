Create database Hospital;
use hospital;
select * from appointment;
select * from billing;
select * from doctor;
select * from medicalprocedure;
select * from patient;

-- 🔹 Basic Queries (Retrieval & Filtering)
-- 1.👉 Retrieve all patient details and display them in ascending order of their last name.
select * from patient
order by lastname asc;

-- 2️⃣ Fetch details of all doctors, displaying their doctor_id, name, specialization, and contact info, sorted by specialization.
select doctorid ,doctorname , Specialization ,doctorcontact from doctor 
order by Specialization asc;

-- 3.Get a list of all scheduled appointments, displaying appointment_id, 
-- patient_id, doctor_id, and appointment_date, sorted by appointment_date.
select appointmentid, patientid,doctorid, date from appointment
order by date asc;


-- 4.Retrieve billing details where the total bill amount is greater than ₹1,00,000 sorted by amount in descending order.
select *  from billing
where amount > 100000
order by amount desc;

-- 5.Retrieve medicalprocedure details  where appointmentid is null
select * from medicalprocedure
where appointmentid is null;


-- 🔹 Intermediate Queries (Joins & Aggregation)

-- 6️.Get a list of patients along with their assigned doctor names, sorted by doctor_id.
select  pt.firstname,pt.lastname ,dc.doctorname,dc.doctorid from patient pt
join doctor dc
on pt.patientid = dc.doctorid
order by dc.doctorid asc;

-- 7️.Show appointment details including patient name, doctor name, and appointment date.
select pt.firstname ,dc.doctorname, ap.date
from patient pt 
join appointment ap
on pt.patientid = ap.patientid
join doctor dc
on pt.patientid = dc.doctorid;

-- 8️.Find the total number of appointments per doctor, sorted in descending order.
SELECT DC.DOCTORNAME, COUNT(AP.APPOINTMENTID) AS APD
FROM APPOINTMENT AP
LEFT JOIN DOCTOR DC ON DC.DOCTORID = AP.DOCTORID
WHERE DC.DOCTORNAME IS NOT NULL  -- Exclude doctors with NULL names
GROUP BY DC.DOCTORNAME
ORDER BY APD DESC;

-- 9.Retrieve the most commonly performed medical procedures, sorted by frequency in descending order..

select procedurename, count(procedureid) as Frequency  from medicalprocedure
group by procedurename 
order by frequency desc;

-- 10.Display patients who have undergone more than 2 medical procedures, sorted by patient_id.
Select p.patientid,count(m.procedurename) as medical from patient p
join medicalprocedure m
on p.patientid = m.appointmentid
group by p.patientid
having medical > 2
order by p.patientid;


-- 🔹 Advanced Queries (Subqueries, Views, and Analytics)

-- 11.Identify the doctor with the highest number of appointments.
SELECT 
    d.doctorid, COUNT(*) AS appointment_count
FROM
    doctor d
        JOIN
    appointment a ON d.doctorid = a.doctorid
GROUP BY d.doctorid
ORDER BY appointment_count DESC
LIMIT 1;

-- 1️2.Retrieve details of patients who have never booked an appointment.
select p.patientid ,a.appointmentid from patient p
left join appointment a 
on p.patientid = a.appointmentid
where a.appointmentid is null;

-- 13.Find the top 3 doctors with the most performed procedures.
SELECT 
    d.doctorid, COUNT(*) AS procedure_count
FROM
    doctor d
        JOIN
    medicalprocedure m ON d.doctorid = m.appointmentid
GROUP BY d.doctorid
ORDER BY procedure_count DESC
LIMIT 3;


-- 14.Count the total number of different procedures performed per doctor.
SELECT 
    d.doctorid, COUNT(DISTINCT (m.procedurename)) AS PPD
FROM
    doctor d
        JOIN
    medicalprocedure m ON d.doctorid = m.appointmentid
GROUP BY d.doctorid
ORDER BY PPD DESC;



-- 15.Create a view that shows the patient name, doctor name, procedure type, and appointment date for every completed appointment.


CREATE VIEW hospital1 AS
    SELECT 
        p.firstname,
        p.lastname,
        d.doctorname,
        m.procedurename,
        a.date
    FROM
        appointment a
            JOIN
        patient p ON p.patientid = a.patientid
            JOIN
        doctor d ON d.doctorid = a.doctorid
            JOIN
        medicalprocedure m ON a.appointmentid = m.appointmentid;  

select * from hospital1;






