SELECT *
FROM abroad.company AS C
JOIN abroad.association A ON C.asso_id = A.asso_id
WHERE A.asso_name = 'Toyoyo Kigyo Kyodo Kumiai';

SELECT *
FROM student.information
WHERE est_departure_date LIKE '__-11-2024';

SELECT
    j.job_id,
    j.job_name,
    COUNT(w.worker_id) AS num_workers
FROM
    abroad.job AS j
LEFT JOIN
    abroad.worker_information AS w ON j.job_id = w.job_id
GROUP BY
    j.job_id, j.job_name;

SELECT
    wp.worker_id,
    wi.worker_name,
    wd.dependence_name,
    wd.relationship,
    wd.dependence_phone
FROM
    abroad.worker_problem AS wp
JOIN
    abroad.worker_information AS wi ON wp.worker_id = wi.worker_id
JOIN
    abroad.worker_dependence AS wd ON wi.worker_id = wd.worker_id
ORDER BY wp.worker_id;

SELECT
    W_i.company_id,
    C.company_name,
    COUNT(W_i.worker_id) AS quantity
FROM
    abroad.company AS C
JOIN
    abroad.worker_information AS W_i ON W_i.company_id = C.company_id
JOIN
    abroad.worker_problem AS P ON P.worker_id = W_i.worker_id
GROUP BY
    W_i.company_id, C.company_name
ORDER BY
    COUNT(W_i.worker_id) DESC;

SELECT
    job.job_id,
    job.job_name,
    AVG(awi.worker_age * 1.0),
    COUNT(awi.worker_id)
FROM
    abroad.worker_information AS awi
JOIN
    abroad.job AS job ON awi.job_id = job.job_id
GROUP BY
    job.job_id, job.job_name;

SELECT
    r.recruitment_id,
    COUNT(si.student_id) AS num_students,
    r.quantity,
    (r.quantity - COUNT(si.student_id)) AS Slot_left
FROM
    abroad.recruitment AS r
LEFT JOIN
    student.information AS si ON r.recruitment_id = si.recruitment_id
GROUP BY
    r.recruitment_id, r.quantity
HAVING
    COUNT(si.student_id) < r.quantity;

SELECT
    worker_age,
    COUNT(worker_id) AS num_workers,
    ROUND((COUNT(worker_id) * 100.0 / (
        SELECT COUNT(worker_id) FROM abroad.worker_information
    )), 4) AS age_percentage
FROM
    abroad.worker_information
GROUP BY
    worker_age
ORDER BY worker_age;

SELECT
    dde.department_id,
    dde.department_name,
    COUNT(dst.staff_id) AS staff_COUNT,
    SUM(CAST(dst.staff_salary AS INT)) AS total_salary
FROM
    domestic.staff AS dst
JOIN
    domestic.department AS dde ON dst.department_id = dde.department_id
WHERE dst.office_id = 'HN'
GROUP BY ROLLUP (dde.department_id, dde.department_name);

SELECT
    r.recruitment_id,
    r.recruitment_beginTime,
    r.recruitment_endTime,
    COUNT(si.student_id) AS total_students
FROM
    abroad.recruitment AS r
JOIN
    abroad.job AS j ON r.job_id = j.job_id
JOIN
    student.information AS si ON r.recruitment_id = si.recruitment_id
GROUP BY
    r.recruitment_id, r.recruitment_beginTime, r.recruitment_endTime
HAVING
    COUNT(si.student_id) = (
        SELECT MAX(student_COUNT)
        FROM (
            SELECT COUNT(si.student_id) AS student_COUNT
            FROM abroad.recruitment r
            JOIN student.information si ON r.recruitment_id = si.recruitment_id
            GROUP BY r.recruitment_id
        ) AS max_students
    )
ORDER BY total_students DESC;

SELECT
    d.department_id,
    d.department_name,
    COUNT(s.staff_id)
FROM
    domestic.staff AS s
JOIN
    domestic.department AS d ON s.department_id = d.department_id
WHERE
    s.office_id = 'HN'
GROUP BY
    d.department_id, d.department_name
ORDER BY
    COUNT(s.staff_id) DESC;

SELECT
    cla.class_id,
    sta.staff_name,
    sta.staff_phone,
    COUNT(stu.student_id)
FROM
    student.information AS stu
JOIN
    student.class AS cla ON stu.class_id = cla.class_id
JOIN
    domestic.staff AS sta ON cla.teacher_id = sta.staff_id
GROUP BY
    cla.class_id, sta.staff_name, sta.staff_phone
ORDER BY
    COUNT(stu.student_id) ASC;

SELECT
    s.student_id,
    s.student_name,
    d.dependence_name,
    d.relationship,
    d.dependence_phone
FROM
    student.information AS s
JOIN
    student.dependence AS d ON s.student_id = d.student_id;

SELECT
    w.worker_id,
    w.worker_name,
    p.problem_description
FROM
    abroad.worker_problem AS p
JOIN
    abroad.worker_information AS w ON p.worker_id = w.worker_id;

SELECT
    w.worker_id,
    w.worker_name,
    d.dependence_name,
    d.relationship,
    d.dependence_phone
FROM
    abroad.worker_problem AS p
JOIN
    abroad.worker_information AS w ON p.worker_id = w.worker_id
JOIN
    abroad.worker_dependence AS d ON p.worker_id = d.worker_id;

SELECT
    c.company_id,
    c.company_name,
    c.company_email,
    j.job_id,
    j.job_name,
    j.est_salary,
    r.quantity
FROM
    abroad.recruitment AS r
JOIN
    abroad.company AS c ON r.company_id = c.company_id
JOIN
    abroad.job AS j ON c.company_id = r.company_id
ORDER BY
    r.quantity ASC, j.est_salary DESC;

SELECT
    c.company_id,
    c.company_name,
    a.asso_id,
    a.asso_name,
    a.asso_contact,
    a.asso_address
FROM
    abroad.company AS c
JOIN
    abroad.association AS a ON c.asso_id = a.asso_id;