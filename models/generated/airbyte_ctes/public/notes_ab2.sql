{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('notes_ab1') }}
select
    attachments,
    cast(attachmentId as {{ dbt_utils.type_string() }}) as attachmentId,
    cast(attachment_createdAt as {{ dbt_utils.type_string() }}) as attachment_createdAt,
    cast(attachment_fileType as {{ dbt_utils.type_string() }}) as attachment_fileType,
    cast(attachment_fileName as {{ dbt_utils.type_string() }}) as attachment_fileName,
    cast(subject as {{ dbt_utils.type_string() }}) as subject,
    jobs,
    cast(jobId as {{ dbt_utils.type_string() }}) as jobId,
    cast(jobs_company_name as {{ dbt_utils.type_string() }}) as jobs_company_name,
    cast(jobs_companyId as {{ dbt_utils.type_string() }}) as jobs_companyId,
    cast(jobtitle as {{ dbt_utils.type_string() }}) as jobtitle,
    cast(noteid as {{ dbt_utils.type_string() }}) as noteid,
    placements,
    cast(placementId as {{ dbt_utils.type_string() }}) as placementId,
    cast({{ adapter.quote('source') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('source') }},
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast(reference as {{ dbt_utils.type_string() }}) as reference,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    candidates,
    cast(candidateId as {{ dbt_utils.type_string() }}) as candidateId,
    cast(candidate_email as {{ dbt_utils.type_string() }}) as candidate_email,
    cast(candidate_firstName as {{ dbt_utils.type_string() }}) as candidate_firstName,
    cast(candidate_lastName as {{ dbt_utils.type_string() }}) as candidate_lastName,    
    companies,
    cast(companyId as {{ dbt_utils.type_string() }}) as companyId,
    cast(company_name as {{ dbt_utils.type_string() }}) as company_name,
    cast(createdby as {{ type_json() }}) as createdby,
    cast(createdBy_userId as {{ dbt_utils.type_string() }}) as createdBy_userId,
    cast(createdBy_email as {{ dbt_utils.type_string() }}) as createdBy_email,
    cast(createdBy_firstName as {{ dbt_utils.type_string() }}) as createdBy_firstName,
    cast(createdBy_lastName as {{ dbt_utils.type_string() }}) as createdBy_lastName,
    cast(createdBy_deleted as {{ dbt_utils.type_string() }}) as createdBy_deleted,
    cast({{ adapter.quote('text') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('text') }},
    contacts,
    cast(contactId as {{ dbt_utils.type_string() }}) as contactId,
    cast(contact_firstName as {{ dbt_utils.type_string() }}) as contact_firstName,
    cast(contact_lastName as {{ dbt_utils.type_string() }}) as contact_lastName,
    cast(contact_email as {{ dbt_utils.type_string() }}) as contact_email, 
    applications,
    cast(applicationId as {{ dbt_utils.type_string() }}) as applicationId,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('notes_ab1') }}
-- notes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

