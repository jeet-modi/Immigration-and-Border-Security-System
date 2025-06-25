-- Public Queries (Unregistered Users)
-- 1. Find visa requirements for a country
SELECT 
    country_name, 
    visa_required, 
    visa_type, 
    requirements
FROM 
    visa_requirements
WHERE 
    destination_country = '[country_name]'
    AND nationality = '[nationality]'
    AND travel_purpose = '[purpose]';

-- 2. Check visa processing times
SELECT 
    visa_type, 
    processing_time_days
FROM 
    visa_processing_times
WHERE 
    country = '[country_name]';

-- 3. Compare visa fees
SELECT 
    country, 
    visa_type, 
    fee_amount, 
    currency
FROM 
    visa_fees
WHERE 
    visa_type = '[visa_type]'
ORDER BY 
    fee_amount;

-- 4. View latest immigration policies
SELECT 
    policy_title, 
    description, 
    effective_date
FROM 
    immigration_policies
ORDER BY 
    effective_date DESC
LIMIT 10;

-- 5. Check travel restrictions
SELECT 
    country, 
    restriction_type, 
    description, 
    start_date, 
    end_date
FROM 
    travel_restrictions
WHERE 
    country = '[country_name]'
    AND current_date BETWEEN start_date AND end_date;

-- Immigrant Queries (Applicants)
-- 1. My Visa Applications
SELECT 
    application_id, 
    visa_type, 
    status, 
    submission_date
FROM 
    visa_applications
WHERE 
    applicant_id = '[applicant_id]';

-- 2. My Asylum Applications
SELECT 
    application_id, 
    status, 
    submission_date, 
    interview_date
FROM 
    asylum_applications
WHERE 
    applicant_id = '[applicant_id]';

-- 3. Visa Expiration Alerts
SELECT 
    visa_id, 
    visa_type, 
    expiration_date
FROM 
    visas
WHERE 
    applicant_id = '[applicant_id]'
    AND expiration_date BETWEEN current_date AND current_date + 30;

-- 4. My Travel History
SELECT 
    entry_date, 
    exit_date, 
    port_of_entry, 
    purpose
FROM 
    travel_history
WHERE 
    traveler_id = '[applicant_id]'
ORDER BY 
    entry_date DESC;

-- 5. My Document Status
SELECT 
    document_type, 
    status, 
    submission_date
FROM 
    application_documents
WHERE 
    application_id = '[application_id]';

-- 6. Visa Appointment Schedule
SELECT 
    appointment_id, 
    appointment_date, 
    location, 
    status
FROM 
    visa_appointments
WHERE 
    applicant_id = '[applicant_id]'
    AND appointment_date >= current_date;

-- 7. Appeal Status
SELECT 
    appeal_id, 
    original_application_id, 
    status, 
    submission_date
FROM 
    visa_appeais
WHERE 
    applicant_id = '[applicant_id]';

-- Immigration Officer Queries
-- 1. Pending Visa Applications
SELECT 
    application_id, 
    applicant_name, 
    visa_type, 
    submission_date
FROM 
    visa_applications
WHERE 
    status = 'Pending'
ORDER BY 
    submission_date;

-- 2. Approved vs. Rejected Visas (Monthly/Yearly Report)
SELECT
    DATE_TRUNC('month', decision_date) AS month,
    COUNT(CASE WHEN status = 'Approved' THEN 1 END) AS approved,
    COUNT(CASE WHEN status = 'Rejected' THEN 1 END) AS rejected
FROM 
    visa_applications
WHERE 
    decision_date BETWEEN '[start_date]' AND '[end_date]'
GROUP BY 
    DATE_TRUNC('month', decision_date)
ORDER BY 
    month;

-- 3. High-Risk Applicants Report
SELECT 
    a.applicant_id, 
    a.applicant_name, 
    COUNT(*) AS rejections
FROM 
    visa_applications v
JOIN 
    applicants a ON v.applicant_id = a.applicant_id
WHERE 
    v.status = 'Rejected'
GROUP BY 
    a.applicant_id, a.applicant_name
HAVING 
    COUNT(*) > 1
ORDER BY 
    rejections DESC;

-- 4. Applications by Visa Type
SELECT 
    visa_type, 
    COUNT(*) AS application_count
FROM 
    visa_applications
WHERE 
    submission_date BETWEEN '[start_date]' AND '[end_date]'
GROUP BY 
    visa_type
ORDER BY 
    application_count DESC;

-- 5. Processing Time Analysis
SELECT
    visa_type,
    AVG(decision_date - submission_date) AS avg_processing_days,
    MAX(decision_date - submission_date) AS max_processing_days,
    MIN(decision_date - submission_date) AS min_processing_days
FROM 
    visa_applications
WHERE 
    status IN ('Approved', 'Rejected')
GROUP BY 
    visa_type;

-- 6. Country-Wise Visa Reports
SELECT
    nationality,
    COUNT(CASE WHEN status = 'Approved' THEN 1 END) AS approved,
    COUNT(CASE WHEN status = 'Rejected' THEN 1 END) AS rejected,
    COUNT(*) AS total,
    ROUND(COUNT(CASE WHEN status = 'Approved' THEN 1 END) * 100.0 / COUNT(*), 2) AS approval_rate
FROM 
    visa_applications
GROUP BY 
    nationality
ORDER BY 
    approval_rate DESC;

-- 7. Document Verification Summary
SELECT
    status,
    COUNT(*) AS document_count
FROM 
    application_documents
WHERE 
    application_id IN (
        SELECT application_id FROM visa_applications WHERE status = 'Pending'
    )
GROUP BY 
    status;

-- 8. Fraud Detection Alerts
SELECT 
    a.applicant_id, 
    a.applicant_name, 
    f.reason, 
    f.flagged_date
FROM 
    fraud_flags f
JOIN 
    applicants a ON f.applicant_id = a.applicant_id
WHERE 
    f.resolved = false
ORDER BY 
    f.flagged_date DESC;

-- Border Officer Queries
-- 1. Entry & Exit Log (Daily/Weekly/Monthly)
SELECT
    DATE_TRUNC('[period]', entry_date) AS period,
    COUNT(*) AS entries,
    COUNT(DISTINCT traveler_id) AS unique_travelers
FROM 
    entry_logs
WHERE 
    entry_date BETWEEN '[start_date]' AND '[end_date]'
GROUP BY 
    DATE_TRUNC('[period]', entry_date)
ORDER BY 
    period;

-- 2. Overstayed Visas Report
SELECT 
    t.traveler_id, 
    t.traveler_name, 
    v.visa_id, 
    v.expiration_date, 
    e.entry_date
FROM 
    visas v
JOIN 
    travelers t ON v.traveler_id = t.traveler_id
JOIN 
    entry_logs e ON v.traveler_id = e.traveler_id
WHERE 
    v.expiration_date < current_date
    AND e.exit_date IS NULL;

-- 3. Flagged Travelers Report
SELECT 
    t.traveler_id, 
    t.traveler_name, 
    f.reason, 
    f.flagged_date
FROM 
    traveler_flags f
JOIN 
    travelers t ON f.traveler_id = t.traveler_id
WHERE 
    f.active = true
ORDER BY 
    f.flagged_date DESC;

-- 4. Frequent Traveler Report
SELECT 
    t.traveler_id, 
    t.traveler_name, 
    COUNT(*) AS entry_count
FROM 
    entry_logs e
JOIN 
    travelers t ON e.traveler_id = t.traveler_id
WHERE 
    e.entry_date BETWEEN current_date - 365 AND current_date
GROUP BY 
    t.traveler_id, t.traveler_name
HAVING 
    COUNT(*) > 3
ORDER BY 
    entry_count DESC;

-- 5. Entry Denials Report
SELECT
    DATE_TRUNC('[period]', attempt_date) AS period,
    reason,
    COUNT(*) AS denial_count
FROM 
    entry_denials
WHERE 
    attempt_date BETWEEN '[start_date]' AND '[end_date]'
GROUP BY 
    DATE_TRUNC('[period]', attempt_date), reason
ORDER BY 
    period, denial_count DESC;

-- 6. Border Checkpoint Traffic
SELECT
    checkpoint_id,
    checkpoint_name,
    COUNT(*) AS total_entries,
    COUNT(DISTINCT traveler_id) AS unique_travelers
FROM 
    entry_logs
WHERE 
    entry_date BETWEEN '[start_date]' AND '[end_date]'
GROUP BY 
    checkpoint_id, checkpoint_name
ORDER BY 
    total_entries DESC;

-- 7. Suspected Human Trafficking Cases
SELECT
    t.traveler_id,
    t.traveler_name,
    e.entry_date,
    e.flight_number,
    e.travel_companions,
    f.reason
FROM 
    entry_logs e
JOIN 
    travelers t ON e.traveler_id = t.traveler_id
JOIN 
    trafficking_flags f ON e.entry_id = f.entry_id
WHERE 
    f.verified = false
ORDER BY 
    e.entry_date DESC;

-- Asylum Officer Queries
-- 1. Pending Asylum Applications
SELECT 
    application_id, 
    applicant_name, 
    submission_date, 
    interview_date
FROM 
    asylum_applications
WHERE 
    status = 'Pending'
ORDER BY 
    submission_date;

-- 2. Approved vs. Rejected Asylum Cases
SELECT
    DATE_TRUNC('[period]', decision_date) AS period,
    COUNT(CASE WHEN status = 'Approved' THEN 1 END) AS approved,
    COUNT(CASE WHEN status = 'Rejected' THEN 1 END) AS rejected,
    COUNT(*) AS total
FROM 
    asylum_applications
WHERE 
    decision_date BETWEEN '[start_date]' AND '[end_date]'
GROUP BY 
    DATE_TRUNC('[period]', decision_date)
ORDER BY 
    period;

-- 3. Shelter Occupancy Report
SELECT
    s.shelter_id,
    s.shelter_name,
    s.capacity,
    COUNT(r.resident_id) AS current_residents,
    s.capacity - COUNT(r.resident_id) AS available_space
FROM 
    shelters s
LEFT JOIN 
    shelter_residents r ON s.shelter_id = r.shelter_id AND r.exit_date IS NULL
GROUP BY 
    s.shelter_id, s.shelter_name, s.capacity
ORDER BY 
    available_space;

-- 4. Country of Origin Trends
SELECT
    nationality,
    COUNT(*) AS applicant_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM asylum_applications WHERE submission_date BETWEEN '[start_date]' AND '[end_date]'), 2) AS percentage
FROM 
    asylum_applications
WHERE 
    submission_date BETWEEN '[start_date]' AND '[end_date]'
GROUP BY 
    nationality
ORDER BY 
    applicant_count DESC;

-- 5. Appealed Cases Report
SELECT
    a.appeal_id,
    o.application_id,
    a.appeal_date,
    a.status,
    o.applicant_name
FROM 
    asylum_appeals a
JOIN 
    asylum_applications o ON a.application_id = o.application_id
WHERE 
    a.status = 'Pending'
ORDER BY 
    a.appeal_date;

-- 6. Processing Time Analysis for Asylum Cases
SELECT
    AVG(decision_date - submission_date) AS avg_processing_days,
    MAX(decision_date - submission_date) AS max_processing_days,
    MIN(decision_date - submission_date) AS min_processing_days
FROM 
    asylum_applications
WHERE 
    status IN ('Approved', 'Rejected')
    AND decision_date BETWEEN '[start_date]' AND '[end_date]';

-- 7. Fraudulent Asylum Claims
SELECT
    a.application_id,
    a.applicant_name,
    f.reason,
    f.flagged_date
FROM 
    asylum_applications a
JOIN 
    asylum_fraud_flags f ON a.application_id = f.application_id
WHERE 
    f.resolved = false
ORDER BY 
    f.flagged_date DESC;

-- Employer/HR Queries
-- 1. Work Visa Applications by Status
SELECT
    status,
    COUNT(*) AS application_count
FROM 
    work_visa_applications
WHERE 
    employer_id = '[employer_id]'
GROUP BY 
    status;

-- 2. Employee Work Visa Expiration Report
SELECT
    e.employee_id,
    e.employee_name,
    v.visa_id,
    v.expiration_date
FROM 
    employees e
JOIN 
    work_visas v ON e.employee_id = v.employee_id
WHERE 
    v.expiration_date BETWEEN current_date AND current_date + 90
    AND e.employer_id = '[employer_id]'
ORDER BY 
    v.expiration_date;

-- 3. Total Work Visas Issued to Company
SELECT
    COUNT(*) AS total_visas,
    COUNT(DISTINCT employee_id) AS unique_employees
FROM 
    work_visas
WHERE 
    employer_id = '[employer_id]'
    AND status = 'Active';

-- 4. Visa Quota Utilization Report
SELECT
    visa_type,
    quota_limit,
    COUNT(*) AS issued_count,
    quota_limit - COUNT(*) AS remaining
FROM 
    work_visa_quotas q
LEFT JOIN 
    work_visas v ON q.visa_type = v.visa_type AND v.status = 'Active' AND v.employer_id = '[employer_id]'
WHERE 
    q.employer_id = '[employer_id]'
GROUP BY 
    visa_type, quota_limit;

-- 5. Rejected Work Visa Applications Report
SELECT
    application_id,
    employee_name,
    visa_type,
    rejection_reason,
    application_date
FROM 
    work_visa_applications
WHERE 
    employer_id = '[employer_id]'
    AND status = 'Rejected'
ORDER BY 
    application_date DESC;

-- 6. Nationality Breakdown of Employees
SELECT
    nationality,
    COUNT(*) AS employee_count
FROM 
    employees
WHERE 
    employer_id = '[employer_id]'
GROUP BY 
    nationality
ORDER BY 
    employee_count DESC;

-- 7. Employer Compliance Report
SELECT
    requirement,
    status,
    compliance_date,
    next_review_date
FROM 
    employer_compliance
WHERE 
    employer_id = '[employer_id]'
ORDER BY 
    next_review_date;

-- Traveler Queries
-- 1. My Visa Application Status
SELECT 
    application_id, 
    visa_type, 
    status, 
    submission_date
FROM 
    visa_applications
WHERE 
    applicant_id = '[traveler_id]';

-- 2. My Travel History
SELECT 
    entry_date, 
    exit_date, 
    port_of_entry, 
    purpose
FROM 
    travel_history
WHERE 
    traveler_id = '[traveler_id]'
ORDER BY 
    entry_date DESC;

-- 3. Visa Expiration & Renewal Reminder
SELECT 
    visa_id, 
    visa_type, 
    expiration_date
FROM 
    visas
WHERE 
    traveler_id = '[traveler_id]'
    AND expiration_date BETWEEN current_date AND current_date + 60;

-- 4. Upcoming Visa Appointments
SELECT 
    appointment_id, 
    appointment_date, 
    location, 
    purpose
FROM 
    visa_appointments
WHERE 
    traveler_id = '[traveler_id]'
    AND appointment_date >= current_date
ORDER BY 
    appointment_date;

-- 5. Visa-Free Travel Report
SELECT 
    destination_country, 
    allowed_stay_days, 
    notes
FROM 
    visa_free_travel
WHERE 
    nationality = '[nationality]'
ORDER BY 
    destination_country;

-- 6. Total Number of Visas Issued to Me
SELECT 
    COUNT(*) AS total_visas
FROM 
    visas
WHERE 
    traveler_id = '[traveler_id]';

-- 7. Blacklist Status Check
SELECT 
    EXISTS (
        SELECT 1 FROM traveler_blacklist
        WHERE traveler_id = '[traveler_id]'
    ) AS is_blacklisted;

-- Problem: Find all immigrants whose visas are currently valid.
SELECT 
    i.Passport_No, 
    i.Name, 
    v.Visa_ID, 
    v.Issue_Date, 
    v.Expiry_Date
FROM 
    Immigrants i
JOIN 
    Visa v ON i.Passport_No = v.Passport_No
WHERE 
    v.Expiry_Date >= CURDATE();

-- Problem: List the total number of immigrants by country.
SELECT 
    Country, 
    COUNT(*) AS Total_Immigrants
FROM 
    Immigrants
GROUP BY 
    Country
ORDER BY 
    Total_Immigrants DESC;

-- Problem: Find immigrants whose age is above 60.
SELECT 
    Passport_No, 
    Name, 
    DOB,
    TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age
FROM 
    Immigrants
WHERE 
    TIMESTAMPDIFF(YEAR, DOB, CURDATE()) > 60;

-- Problem: Get all sponsorship relationships where the sponsorship lasted more than 365 days.
SELECT 
    Employee_Passport_No, 
    Employee_Start_Date, 
    Employee_End_Date,
    DATEDIFF(Employee_End_Date, Employee_Start_Date) AS Duration_Days
FROM 
    Sponsors_Employee
WHERE 
    DATEDIFF(Employee_End_Date, Employee_Start_Date) > 365;

-- Problem: Retrieve asylum seekers whose hearings are due in the next 7 days.
SELECT 
    Passport_Number, 
    Application_ID, 
    Hearing_Date
FROM 
    Asylum_Seeker
WHERE 
    Hearing_Date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY);

-- Problem: Show email addresses of government employees from a specific city
SELECT 
    ge.E_ID, 
    gec.EmailID
FROM 
    Govt_Employee ge
JOIN 
    Govt_Emp_Email_Info gec ON ge.E_ID = gec.E_ID
WHERE 
    ge.City = 'Delhi';

-- Problem: List the name and visa status of all immigrants with expired visas.
SELECT 
    i.Name, 
    v.Passport_No, 
    v.Visa_ID, 
    v.Expiry_Date, 
    v.Visa_Status
FROM 
    Immigrants i
JOIN 
    Visa v ON i.Passport_No = v.Passport_No
WHERE 
    v.Expiry_Date < CURDATE();

-- Problem: Get the number of dependents supported by each family sponsor.
SELECT 
    Sponsorers_Member_Passport_No, 
    COUNT(*) AS Number_of_Dependents
FROM 
    Family_Sponsor_Sponoree
GROUP BY 
    Sponsorers_Member_Passport_No;

-- Problem: Count asylum seekers per category.
SELECT 
    CID, 
    COUNT(*) AS Number_of_Seekers
FROM 
    Asylum_Seeker
GROUP BY 
    CID;

-- Problem: List all visa officers along with the department name they work in.
SELECT 
    go.E_FirstName, 
    go.E_LastName, 
    d.Name AS Department_Name
FROM 
    Visa_Officer vo
JOIN 
    Govt_Employee go ON vo.E_ID = go.E_ID
JOIN 
    Visa_Department vd ON vd.DID = vo.DID
JOIN 
    Department d ON d.DID = vd.DID;
