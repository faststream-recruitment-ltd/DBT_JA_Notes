{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('notes_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        array_to_string('attachments'),
        'attachmentId',
        'attachment_createdAt',
        'attachment_fileType',
        'attachment_fileName',
        'subject',
        array_to_string('jobs'),
        'jobs',
        'jobId',
        'jobs_company_name',
        'jobs_companyId',
        'jobtitle',
        'noteid',
        array_to_string('placements'),
        'placementId',
        adapter.quote('source'),
        adapter.quote('type'),
        'reference',
        'createdat',
        array_to_string('candidates'),
        'candidateId',
        'candidate_email',
        'candidate_firstName',
        'candidate_lastName',  
        array_to_string('companies'),
        'companyId',
        'company_name',
        object_to_string('createdby'),
        'createdBy_userId',
        'createdBy_email',
        'createdBy_firstName',
        'createdBy_lastName',
        'createdBy_deleted',
        adapter.quote('text'),
        array_to_string('contacts'),
        'contactId',
        'contact_firstName',
        'contact_lastName',
        'contact_email', 
        array_to_string('applications'),
        'applicationId',
    ]) }} as _airbyte_notes_hashid,
    tmp.*
from {{ ref('notes_ab2') }} tmp
-- notes
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

