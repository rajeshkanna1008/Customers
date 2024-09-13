SELECT
    papf.employee_number                                        "Employee Number",
    pat.user_person_type                                        "Employee Type",
    decode(papf.effective_end_date, NULL, 'Active', 'Inactive') "Employment Status Name",
    papf.first_name                                             "Employee First Name",
    papf.last_name                                              "Employee Last Name",
    papf.title                                                  "Titile",
    to_char(papf.effective_start_date, 'DD-MM-YYYY')            "Hire Date",
    to_char(papf.effective_end_date, 'DD-MM-YYYY')              "End Date",
    papf.email_address                                          "Employee Email",
    ''                                                          "Email Type",
    haou.name                                                   "Department Name",
    pj.name                                                     "Job",
    hla.location_code                                           "Location Code",
    papf1.first_name                                            "Supervisor First Name",
    papf1.last_name                                             "Supervisor Last Name",
    paaf.default_code_comb_id                                   "Code Combination Id",
    gcc.concatenated_segments                                   "Expense Account",
    gl.name                                                     "Ledger",
    to_char(papf.date_of_birth, 'DD-MM-YYYY')                   "Date of Birth",
    paaf.assignment_number                                      "Assignment Number",
    past.user_status                                            "Assignment Status",
    pbg.short_name                                              "Business Unit Short Code",
    pat.system_person_type                                      "System Person Type",
    pap.replacement_required_flag                               "Position Override Flag",
    ''                                                          "Primary Assignment Flag",
    paaf.primary_flag                                           "Primary Flag",
    paaf.manager_flag                                           "Manager Flag",
    paaf.labour_union_member_flag                               "Labor Union Member Flag",
    paaf.assignment_category                                    "Assignment Category",
    pap.frequency                                               "Frequency",
    paaf.hourly_salaried_code                                   "Hourly Salaried Code",
    paaf.normal_hours                                           "Normal hours",
    paaf.notice_period                                          "Notic Period",
    ''                                                          "Reason Code",
    ''                                                          "Job Code",
    ''                                                          "Manager Type",
    paaf.assignment_type                                        "Assignment Types",
    ''                                                          "Action Code",
    ''                                                          "Job and Org Start Date"
FROM
    per_all_people_f            papf,
    per_all_people_f            papf1,
    per_person_types            pat,
    per_jobs                    pj,
    per_all_assignments_f       paaf,
    per_all_assignments_f       paaf1,
    hr_locations_all            hla,
    gl_code_combinations_kfv    gcc,
    gl_ledgers                  gl,
    per_assignment_status_types past,
    per_business_groups         pbg,
    per_all_positions           pap,
    hr_all_organization_units   haou
WHERE
        1 = 1
    AND papf.person_id = 34712
    AND papf.person_type_id = pat.person_type_id
    AND papf.person_id = paaf.person_id
    AND paaf.job_id = pj.job_id (+)
    AND paaf.location_id = hla.location_id
    AND papf1.person_id (+) = paaf.supervisor_id
    AND paaf1.person_id (+) = papf1.person_id
    AND paaf.default_code_comb_id = gcc.code_combination_id (+)
    AND gcc.chart_of_accounts_id = gl.chart_of_accounts_id (+)
    AND paaf.set_of_books_id = gl.ledger_id (+)
    AND paaf.assignment_status_type_id = past.assignment_status_type_id (+)
    AND pbg.location_id = paaf.location_id (+)
    AND pap.job_id = paaf.job_id
    AND haou.organization_id = paaf.organization_id;
	
--=========================================
-- Modifications

SELECT  
    papf.employee_number                                        "Employee Number",
    pat.user_person_type                                        "Employee Type",
    decode(papf.effective_end_date, NULL, 'Active', 'Inactive') "Employment Status Name",
    papf.first_name                                             "Employee First Name",
    papf.last_name                                              "Employee Last Name",
    papf.title                                                  "Titile",
    to_char(papf.effective_start_date, 'DD-MM-YYYY')            "Hire Date",
    to_char(papf.effective_end_date, 'DD-MM-YYYY')              "End Date",
    papf.email_address                                          "Employee Email",
    'W1'                                                        "Email Type",
    haou.name                                                   "Department Name",
    pj.name                                                     "Job",
    hla.location_code                                           "Location Code",
    papf1.first_name                                            "Supervisor First Name",
    papf1.last_name                                             "Supervisor Last Name",
    paaf.default_code_comb_id                                   "Code Combination Id",
    gcc.concatenated_segments                                   "Expense Account",
    gl.name                                                     "Ledger",
    to_char(papf.date_of_birth, 'DD-MM-YYYY')                   "Date of Birth",
    paaf.assignment_number                                      "Assignment Number",
    past.user_status                                            "Assignment Status",
    pbg.short_name                                              "Business Unit Short Code",
    pat.system_person_type                                      "System Person Type",
    pap.replacement_required_flag                               "Position Override Flag",
    'Y'                                                         "Primary Assignment Flag",
    paaf.primary_flag                                           "Primary Flag",
    paaf.manager_flag                                           "Manager Flag",
    paaf.labour_union_member_flag                               "Labor Union Member Flag",
    paaf.assignment_category                                    "Assignment Category",
    pap.frequency                                               "Frequency",
    paaf.hourly_salaried_code                                   "Hourly Salaried Code",
    paaf.normal_hours                                           "Normal hours",
    paaf.notice_period                                          "Notic Period",
    ''                                                          "Reason Code",
    ''                                                          "Job Code",
    ''                                                          "Manager Type",
    paaf.assignment_type                                        "Assignment Types",
    ''                                                          "Action Code",
    ''                                                          "Job and Org Start Date"
FROM
    per_all_people_f            papf,
    per_all_people_f            papf1,
    per_person_types            pat,
    per_jobs                    pj,
    per_all_assignments_f       paaf,
    per_all_assignments_f       paaf1,
    hr_locations_all            hla,
    gl_code_combinations_kfv    gcc,
    gl_ledgers                  gl,
    per_assignment_status_types past,
    per_business_groups         pbg,
    per_all_positions           pap,
    hr_all_organization_units   haou
WHERE
       1 = 1
    AND papf.person_id = 34712 --34712 --31539
    AND papf.person_type_id = pat.person_type_id
    AND paaf1.assignment_status_type_id = past.assignment_status_type_id
    AND papf.person_id = paaf.person_id
    AND paaf.job_id = pj.job_id (+)
    AND paaf.location_id = hla.location_id
    AND papf1.person_id  = paaf.supervisor_id
    AND paaf1.person_id  = papf1.person_id
    AND paaf.default_code_comb_id = gcc.code_combination_id (+)
    AND gcc.chart_of_accounts_id = gl.chart_of_accounts_id (+)
    AND paaf.set_of_books_id = gl.ledger_id (+)
    AND pbg.location_id = paaf.location_id(+)
    and paaf.POSITION_ID = pap.POSITION_ID
    AND haou.organization_id = paaf1.organization_id
    and trunc(sysdate) between  trunc(papf.EFFECTIVE_START_DATE) and trunc(papf.EFFECTIVE_END_DATE)
    and trunc(sysdate) between  trunc(papf1.EFFECTIVE_START_DATE) and trunc(papf1.EFFECTIVE_END_DATE)
    and trunc(sysdate) between  trunc(paaf1.EFFECTIVE_START_DATE) and trunc(paaf1.EFFECTIVE_END_DATE)
    and trunc(sysdate) between  trunc(paaf.EFFECTIVE_START_DATE) and trunc(paaf.EFFECTIVE_END_DATE);
--===================================================================================================

SELECT  
    papf.employee_number                                        "Employee Number",
    pat.user_person_type                                        "Employee Type",
    decode(papf.effective_end_date, NULL, 'Active', 'Inactive') "Employment Status Name",
    papf.first_name                                             "Employee First Name",
    papf.last_name                                              "Employee Last Name",
    papf.title                                                  "Titile",
    to_char(papf.effective_start_date, 'DD-MM-YYYY')            "Hire Date",
    to_char(papf.effective_end_date, 'DD-MM-YYYY')              "End Date",
    papf.email_address                                          "Employee Email",
    'W1'                                                        "Email Type",
    haou.name                                                   "Department Name",
    pj.name                                                     "Job",
    hla.location_code                                           "Location Code",
    papf1.first_name                                            "Supervisor First Name",
    papf1.last_name                                             "Supervisor Last Name",
    paaf.default_code_comb_id                                   "Code Combination Id",
    gcc.concatenated_segments                                   "Expense Account",
    gl.name                                                     "Ledger",
    to_char(papf.date_of_birth, 'DD-MM-YYYY')                   "Date of Birth",
    paaf.assignment_number                                      "Assignment Number",
    past.user_status                                            "Assignment Status",
    pbg.short_name                                              "Business Unit Short Code",
    pat.system_person_type                                      "System Person Type",
    pap.replacement_required_flag                               "Position Override Flag",
    'Y'                                                         "Primary Assignment Flag",
    paaf.primary_flag                                           "Primary Flag",
    paaf.manager_flag                                           "Manager Flag",
    paaf.labour_union_member_flag                               "Labor Union Member Flag",
    paaf.assignment_category                                    "Assignment Category",
    pap.frequency                                               "Frequency",
    paaf.hourly_salaried_code                                   "Hourly Salaried Code",
    paaf.normal_hours                                           "Normal hours",
    paaf.notice_period                                          "Notic Period",
    ''                                                          "Reason Code",
    ''                                                          "Job Code",
    ''                                                          "Manager Type",
    paaf.assignment_type                                        "Assignment Types",
    ''                                                          "Action Code",
    ''                                                          "Job and Org Start Date"
FROM
    per_all_people_f            papf,
    per_all_people_f            papf1,
    per_person_types            pat,
    per_jobs                    pj,
    per_all_assignments_f       paaf,
    per_all_assignments_f       paaf1,
    hr_locations_all            hla,
    gl_code_combinations_kfv    gcc,
    gl_ledgers                  gl,
    per_assignment_status_types past,
    per_business_groups         pbg,
    per_all_positions           pap,
    hr_all_organization_units   haou
WHERE
       1 = 1
    AND papf.person_id = 34712 --34712 --31539
    AND papf.person_type_id = pat.person_type_id
    AND paaf1.assignment_status_type_id = past.assignment_status_type_id
    AND papf.person_id = paaf.person_id
    AND paaf.job_id = pj.job_id (+)
    AND paaf.location_id = hla.location_id
    AND papf1.person_id  = paaf.supervisor_id
    AND paaf1.person_id  = papf1.person_id
    AND paaf.default_code_comb_id = gcc.code_combination_id (+)
    AND gcc.chart_of_accounts_id = gl.chart_of_accounts_id (+)
    AND paaf.set_of_books_id = gl.ledger_id (+)
    AND pbg.location_id = paaf.location_id(+)
    and paaf.POSITION_ID = pap.POSITION_ID
    AND haou.organization_id = paaf1.organization_id
    and trunc(sysdate) between  trunc(papf.EFFECTIVE_START_DATE) and trunc(papf.EFFECTIVE_END_DATE)
    and trunc(sysdate) between  trunc(papf1.EFFECTIVE_START_DATE) and trunc(papf1.EFFECTIVE_END_DATE)
    and trunc(sysdate) between  trunc(paaf1.EFFECTIVE_START_DATE) and trunc(paaf1.EFFECTIVE_END_DATE)
    and trunc(sysdate) between  trunc(paaf.EFFECTIVE_START_DATE) and trunc(paaf.EFFECTIVE_END_DATE);