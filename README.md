# Hospital-Data-Analysis-

**📌 Project Overview** 
**This project focuses on analyzing hospital data using MySQL. It includes multiple SQL queries to extract insights from appointments, billing, doctors, medical procedures, and patients tables. The goal is to demonstrate real-world database management and data analysis skills.** 

**🏥 Dataset Details**
**The database contains 5 main tables:**

**Appointment** – Stores appointment details between patients and doctors.

**Billing** – Contains patient billing information.

**Doctor** – Includes doctor details and their specialization.

**Medicalprocedure** – Stores records of medical procedures performed.

**Patient** – Contains patient details.

💡 **Key Features & Queries**

**Below are some key SQL queries performed in this project:**

**Basic Queries (Retrieval & Filtering)**


**1.Retrieve all patient details and display them in ascending order of their last name.**
select * from patient
  order by lastname asc;

**2️⃣ Fetch details of all doctors, displaying their doctor_id, name, specialization, and contact info, sorted by specialization.**
select doctorid ,doctorname , Specialization ,doctorcontact from doctor order by Specialization asc;

**-- 3.Get a list of all scheduled appointments, displaying appointment_id, 
-- patient_id, doctor_id, and appointment_date, sorted by appointment_date.**
select appointmentid, patientid,doctorid, date from appointment
order by date asc;


**-- 4.Retrieve billing details where the total bill amount is greater than ₹1,00,000 sorted by amount in descending order.**
select *  from billing where amount > 100000 order by amount desc;

**-- 5.Retrieve medicalprocedure details  where appointmentid is null** 
select * from medicalprocedure
where appointmentid is null;


**-- 🔹 Intermediate Queries (Joins & Aggregation)**

**-- 6️.Get a list of patients along with their assigned doctor names, sorted by doctor_id.**
select  pt.firstname,pt.lastname ,dc.doctorname,dc.doctorid from patient pt
join doctor dc
on pt.patientid = dc.doctorid
order by dc.doctorid asc;

**-- 7️.Show appointment details including patient name, doctor name, and appointment date.**
select pt.firstname ,dc.doctorname, ap.date
from patient pt 
join appointment ap
on pt.patientid = ap.patientid
join doctor dc
on pt.patientid = dc.doctorid;

**-- 8️.Find the total number of appointments per doctor, sorted in descending order.**
SELECT DC.DOCTORNAME, COUNT(AP.APPOINTMENTID) AS APD
FROM APPOINTMENT AP
LEFT JOIN DOCTOR DC ON DC.DOCTORID = AP.DOCTORID
WHERE DC.DOCTORNAME IS NOT NULL  -- Exclude doctors with NULL names
GROUP BY DC.DOCTORNAME
ORDER BY APD DESC;

**-- 9.Retrieve the most commonly performed medical procedures, sorted by frequency in descending order..**

select procedurename, count(procedureid) as Frequency  from medicalprocedure
group by procedurename 
order by frequency desc;

**-- 10.Display patients who have undergone more than 2 medical procedures, sorted by patient_id.**
Select p.patientid,count(m.procedurename) as medical from patient p
join medicalprocedure m
on p.patientid = m.appointmentid
group by p.patientid
having medical > 2
order by p.patientid;


**-- 🔹 Advanced Queries (Subqueries, Views, and Analytics)**


**-- 11.Identify the doctor with the highest number of appointments.**
SELECT 
    d.doctorid, COUNT(*) AS appointment_count
FROM
    doctor d
        JOIN
    appointment a ON d.doctorid = a.doctorid
GROUP BY d.doctorid
ORDER BY appointment_count DESC
LIMIT 1;

**-- 1️2.Retrieve details of patients who have never booked an appointment.**

select p.patientid ,a.appointmentid from patient p
left join appointment a 
on p.patientid = a.appointmentid
where a.appointmentid is null;

**-- 13.Find the top 3 doctors with the most performed procedures.**
SELECT 
    d.doctorid, COUNT(*) AS procedure_count
FROM
    doctor d
        JOIN
    medicalprocedure m ON d.doctorid = m.appointmentid
GROUP BY d.doctorid
ORDER BY procedure_count DESC
LIMIT 3;


**-- 14.Count the total number of different procedures performed per doctor.**
SELECT 
    d.doctorid, COUNT(DISTINCT (m.procedurename)) AS PPD
FROM
    doctor d
        JOIN
    medicalprocedure m ON d.doctorid = m.appointmentid
GROUP BY d.doctorid
ORDER BY PPD DESC;



**-- 15.Create a view that shows the patient name, doctor name, procedure type, and appointment date for every completed appointment.**


CREATE VIEW hospital1 AS
SELECT p.firstname, p.lastname, d.doctorname, m.procedurename, a.date
FROM appointment a
JOIN patient p ON p.patientid = a.patientid
JOIN doctor d ON d.doctorid = a.doctorid
JOIN medicalprocedure m ON a.appointmentid = m.appointmentid;  -- Assuming procedure is linked to appointment

select * from hospital1;

**-- 16.Retrieve the total number of medical procedures performed per department.**
SELECT 
    d.specialization AS department,
    COUNT(mp.procedureid) AS total_procedures
FROM
    doctor d
        JOIN
    appointment a ON d.doctorid = a.doctorid
        JOIN
    medicalprocedure mp ON a.appointmentid = mp.appointmentid
GROUP BY d.specialization
ORDER BY total_procedures DESC;

**-- 17.Identify the most common medical procedure performed in the hospital.**
SELECT 
    procedurename, 
    COUNT(*) AS total_performed
FROM medicalprocedure
GROUP BY procedurename
ORDER BY total_performed DESC
LIMIT 1;


**-- 18.Find patients who visited more than 3 different doctors**
SELECT 
    p.patientid,
    p.firstname,
    COUNT(DISTINCT a.doctorid) AS unique_doctors_visited
FROM
    patient p
        JOIN
    appointment a ON p.patientid = a.patientid
GROUP BY p.patientid , p.firstname
HAVING unique_doctors_visited > 3;

**📂 Project Structure**
https://github.com/Mohitsharma011/Hospital-Data-Analysis-



**🛠 Tools Used**

**MySQL** – Database Management
**MySQL Workbench** – Query Execution

**📢 Contributions** 
Pull requests are welcome! If you find a bug or want to add more queries, feel free to contribute. 

🌟 Connect with Me

LinkedIn: Your Profile
GitHub: Your GitHub








  
