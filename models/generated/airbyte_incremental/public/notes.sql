{{ config(
    indexes = [{'columns':['_airbyte_unique_key'],'unique':True}],
    unique_key = "_airbyte_unique_key",
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('notes_scd') }}
select
    _airbyte_unique_key,
    _airbyte_notes_hashid,    
    noteid,    
    {{ adapter.quote('type') }},
    reference,
    {{ adapter.quote('source') }},
    createdat,
    createdBy_userId,
    createdBy_email,
    createdBy_firstName,
    createdBy_lastName,
    createdBy_deleted,
    candidateId,
    candidate_email,
    candidate_firstName,
    candidate_lastName,
    applicationId,
    jobId,
    jobs_company_name,
    jobs_companyId,
    jobtitle,
    contactId,
    contact_firstName,
    contact_lastName,
    contact_email, 
    companyId,
    company_name,
    placementId,    
    attachments,
    attachmentId,
    attachment_createdAt,
    attachment_fileType,
    attachment_fileName,
    subject,
    {{ adapter.quote('text') }},   
    jobs,
    placements,
    candidates,
    companies,
    contacts,
    applications,
    createdby,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notes_scd') }}
-- notes from {{ source('public', '_airbyte_raw_notes') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

