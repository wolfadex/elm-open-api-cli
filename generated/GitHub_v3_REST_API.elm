module GitHub_v3_REST_API exposing (..)

{-| 
-}


import Debug
import Http
import Json.Decode
import Json.Encode
import Result


metaRoot toMsg =
    Http.get { url = "/", expect = Http.expectJson toMsg 55 }


appsGetAuthenticated toMsg =
    Http.get { url = "/app", expect = Http.expectJson toMsg 55 }


appsGetWebhookConfigForApp toMsg =
    Http.get { url = "/app/hook/config", expect = Http.expectJson toMsg 55 }


appsListWebhookDeliveries toMsg =
    Http.get { url = "/app/hook/deliveries", expect = Http.expectJson toMsg 55 }


appsGetWebhookDelivery toMsg =
    Http.get
        { url = "/app/hook/deliveries/{delivery_id}"
        , expect = Http.expectJson toMsg 55
        }


appsListInstallations toMsg =
    Http.get { url = "/app/installations", expect = Http.expectJson toMsg 55 }


appsGetInstallation toMsg =
    Http.get
        { url = "/app/installations/{installation_id}"
        , expect = Http.expectJson toMsg 55
        }


appsGetBySlug toMsg =
    Http.get { url = "/apps/{app_slug}", expect = Http.expectJson toMsg 55 }


codesOfConductGetAllCodesOfConduct toMsg =
    Http.get { url = "/codes_of_conduct", expect = Http.expectJson toMsg 55 }


codesOfConductGetConductCode toMsg =
    Http.get
        { url = "/codes_of_conduct/{key}", expect = Http.expectJson toMsg 55 }


emojisGet toMsg =
    Http.get { url = "/emojis", expect = Http.expectJson toMsg 55 }


enterpriseAdminGetServerStatistics toMsg =
    Http.get
        { url = "/enterprise-installation/{enterprise_or_org}/server-statistics"
        , expect = Http.expectJson toMsg 55
        }


actionsGetActionsCacheUsageForEnterprise toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/cache/usage"
        , expect = Http.expectJson toMsg 55
        }


enterpriseAdminGetGithubActionsPermissionsEnterprise toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/permissions"
        , expect = Http.expectJson toMsg 55
        }


enterpriseAdminListSelectedOrganizationsEnabledGithubActionsEnterprise toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/permissions/organizations"
        , expect = Http.expectJson toMsg 55
        }


enterpriseAdminGetAllowedActionsEnterprise toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/permissions/selected-actions"
        , expect = Http.expectJson toMsg 55
        }


actionsGetGithubActionsDefaultWorkflowPermissionsEnterprise toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/permissions/workflow"
        , expect = Http.expectJson toMsg 55
        }


enterpriseAdminListSelfHostedRunnerGroupsForEnterprise toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/runner-groups"
        , expect = Http.expectJson toMsg 55
        }


enterpriseAdminGetSelfHostedRunnerGroupForEnterprise toMsg =
    Http.get
        { url =
            "/enterprises/{enterprise}/actions/runner-groups/{runner_group_id}"
        , expect = Http.expectJson toMsg 55
        }


enterpriseAdminListOrgAccessToSelfHostedRunnerGroupInEnterprise toMsg =
    Http.get
        { url =
            "/enterprises/{enterprise}/actions/runner-groups/{runner_group_id}/organizations"
        , expect = Http.expectJson toMsg 55
        }


enterpriseAdminListSelfHostedRunnersInGroupForEnterprise toMsg =
    Http.get
        { url =
            "/enterprises/{enterprise}/actions/runner-groups/{runner_group_id}/runners"
        , expect = Http.expectJson toMsg 55
        }


enterpriseAdminListSelfHostedRunnersForEnterprise toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/runners"
        , expect = Http.expectJson toMsg 55
        }


enterpriseAdminListRunnerApplicationsForEnterprise toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/runners/downloads"
        , expect = Http.expectJson toMsg 55
        }


enterpriseAdminGetSelfHostedRunnerForEnterprise toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/runners/{runner_id}"
        , expect = Http.expectJson toMsg 55
        }


enterpriseAdminListLabelsForSelfHostedRunnerForEnterprise toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/runners/{runner_id}/labels"
        , expect = Http.expectJson toMsg 55
        }


codeScanningListAlertsForEnterprise toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/code-scanning/alerts"
        , expect = Http.expectJson toMsg 55
        }


secretScanningListAlertsForEnterprise toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/secret-scanning/alerts"
        , expect = Http.expectJson toMsg 55
        }


billingGetGithubAdvancedSecurityBillingGhe toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/settings/billing/advanced-security"
        , expect = Http.expectJson toMsg 55
        }


activityListPublicEvents toMsg =
    Http.get { url = "/events", expect = Http.expectJson toMsg 55 }


activityGetFeeds toMsg =
    Http.get { url = "/feeds", expect = Http.expectJson toMsg 55 }


gistsList toMsg =
    Http.get { url = "/gists", expect = Http.expectJson toMsg 55 }


gistsListPublic toMsg =
    Http.get { url = "/gists/public", expect = Http.expectJson toMsg 55 }


gistsListStarred toMsg =
    Http.get { url = "/gists/starred", expect = Http.expectJson toMsg 55 }


gistsGet toMsg =
    Http.get { url = "/gists/{gist_id}", expect = Http.expectJson toMsg 55 }


gistsListComments toMsg =
    Http.get
        { url = "/gists/{gist_id}/comments", expect = Http.expectJson toMsg 55 }


gistsGetComment toMsg =
    Http.get
        { url = "/gists/{gist_id}/comments/{comment_id}"
        , expect = Http.expectJson toMsg 55
        }


gistsListCommits toMsg =
    Http.get
        { url = "/gists/{gist_id}/commits", expect = Http.expectJson toMsg 55 }


gistsListForks toMsg =
    Http.get
        { url = "/gists/{gist_id}/forks", expect = Http.expectJson toMsg 55 }


gistsCheckIsStarred toMsg =
    Http.get
        { url = "/gists/{gist_id}/star", expect = Http.expectJson toMsg 55 }


gistsGetRevision toMsg =
    Http.get
        { url = "/gists/{gist_id}/{sha}", expect = Http.expectJson toMsg 55 }


gitignoreGetAllTemplates toMsg =
    Http.get { url = "/gitignore/templates", expect = Http.expectJson toMsg 55 }


gitignoreGetTemplate toMsg =
    Http.get
        { url = "/gitignore/templates/{name}"
        , expect = Http.expectJson toMsg 55
        }


appsListReposAccessibleToInstallation toMsg =
    Http.get
        { url = "/installation/repositories"
        , expect = Http.expectJson toMsg 55
        }


issuesList toMsg =
    Http.get { url = "/issues", expect = Http.expectJson toMsg 55 }


licensesGetAllCommonlyUsed toMsg =
    Http.get { url = "/licenses", expect = Http.expectJson toMsg 55 }


licensesGet toMsg =
    Http.get { url = "/licenses/{license}", expect = Http.expectJson toMsg 55 }


appsGetSubscriptionPlanForAccount toMsg =
    Http.get
        { url = "/marketplace_listing/accounts/{account_id}"
        , expect = Http.expectJson toMsg 55
        }


appsListPlans toMsg =
    Http.get
        { url = "/marketplace_listing/plans"
        , expect = Http.expectJson toMsg 55
        }


appsListAccountsForPlan toMsg =
    Http.get
        { url = "/marketplace_listing/plans/{plan_id}/accounts"
        , expect = Http.expectJson toMsg 55
        }


appsGetSubscriptionPlanForAccountStubbed toMsg =
    Http.get
        { url = "/marketplace_listing/stubbed/accounts/{account_id}"
        , expect = Http.expectJson toMsg 55
        }


appsListPlansStubbed toMsg =
    Http.get
        { url = "/marketplace_listing/stubbed/plans"
        , expect = Http.expectJson toMsg 55
        }


appsListAccountsForPlanStubbed toMsg =
    Http.get
        { url = "/marketplace_listing/stubbed/plans/{plan_id}/accounts"
        , expect = Http.expectJson toMsg 55
        }


metaGet toMsg =
    Http.get { url = "/meta", expect = Http.expectJson toMsg 55 }


activityListPublicEventsForRepoNetwork toMsg =
    Http.get
        { url = "/networks/{owner}/{repo}/events"
        , expect = Http.expectJson toMsg 55
        }


activityListNotificationsForAuthenticatedUser toMsg =
    Http.get { url = "/notifications", expect = Http.expectJson toMsg 55 }


activityGetThread toMsg =
    Http.get
        { url = "/notifications/threads/{thread_id}"
        , expect = Http.expectJson toMsg 55
        }


activityGetThreadSubscriptionForAuthenticatedUser toMsg =
    Http.get
        { url = "/notifications/threads/{thread_id}/subscription"
        , expect = Http.expectJson toMsg 55
        }


metaGetOctocat toMsg =
    Http.get { url = "/octocat", expect = Http.expectJson toMsg 55 }


orgsList toMsg =
    Http.get { url = "/organizations", expect = Http.expectJson toMsg 55 }


orgsListCustomRoles toMsg =
    Http.get
        { url = "/organizations/{organization_id}/custom_roles"
        , expect = Http.expectJson toMsg 55
        }


orgsGet toMsg =
    Http.get { url = "/orgs/{org}", expect = Http.expectJson toMsg 55 }


actionsGetActionsCacheUsageForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/actions/cache/usage"
        , expect = Http.expectJson toMsg 55
        }


actionsGetActionsCacheUsageByRepoForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/actions/cache/usage-by-repository"
        , expect = Http.expectJson toMsg 55
        }


actionsGetGithubActionsPermissionsOrganization toMsg =
    Http.get
        { url = "/orgs/{org}/actions/permissions"
        , expect = Http.expectJson toMsg 55
        }


actionsListSelectedRepositoriesEnabledGithubActionsOrganization toMsg =
    Http.get
        { url = "/orgs/{org}/actions/permissions/repositories"
        , expect = Http.expectJson toMsg 55
        }


actionsGetAllowedActionsOrganization toMsg =
    Http.get
        { url = "/orgs/{org}/actions/permissions/selected-actions"
        , expect = Http.expectJson toMsg 55
        }


actionsGetGithubActionsDefaultWorkflowPermissionsOrganization toMsg =
    Http.get
        { url = "/orgs/{org}/actions/permissions/workflow"
        , expect = Http.expectJson toMsg 55
        }


actionsListSelfHostedRunnerGroupsForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runner-groups"
        , expect = Http.expectJson toMsg 55
        }


actionsGetSelfHostedRunnerGroupForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runner-groups/{runner_group_id}"
        , expect = Http.expectJson toMsg 55
        }


actionsListRepoAccessToSelfHostedRunnerGroupInOrg toMsg =
    Http.get
        { url =
            "/orgs/{org}/actions/runner-groups/{runner_group_id}/repositories"
        , expect = Http.expectJson toMsg 55
        }


actionsListSelfHostedRunnersInGroupForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runner-groups/{runner_group_id}/runners"
        , expect = Http.expectJson toMsg 55
        }


actionsListSelfHostedRunnersForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runners"
        , expect = Http.expectJson toMsg 55
        }


actionsListRunnerApplicationsForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runners/downloads"
        , expect = Http.expectJson toMsg 55
        }


actionsGetSelfHostedRunnerForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runners/{runner_id}"
        , expect = Http.expectJson toMsg 55
        }


actionsListLabelsForSelfHostedRunnerForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runners/{runner_id}/labels"
        , expect = Http.expectJson toMsg 55
        }


actionsListOrgSecrets toMsg =
    Http.get
        { url = "/orgs/{org}/actions/secrets"
        , expect = Http.expectJson toMsg 55
        }


actionsGetOrgPublicKey toMsg =
    Http.get
        { url = "/orgs/{org}/actions/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


actionsGetOrgSecret toMsg =
    Http.get
        { url = "/orgs/{org}/actions/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


actionsListSelectedReposForOrgSecret toMsg =
    Http.get
        { url = "/orgs/{org}/actions/secrets/{secret_name}/repositories"
        , expect = Http.expectJson toMsg 55
        }


orgsListBlockedUsers toMsg =
    Http.get { url = "/orgs/{org}/blocks", expect = Http.expectJson toMsg 55 }


orgsCheckBlockedUser toMsg =
    Http.get
        { url = "/orgs/{org}/blocks/{username}"
        , expect = Http.expectJson toMsg 55
        }


codeScanningListAlertsForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/code-scanning/alerts"
        , expect = Http.expectJson toMsg 55
        }


codespacesListInOrganization toMsg =
    Http.get
        { url = "/orgs/{org}/codespaces", expect = Http.expectJson toMsg 55 }


codespacesListOrgSecrets toMsg =
    Http.get
        { url = "/orgs/{org}/codespaces/secrets"
        , expect = Http.expectJson toMsg 55
        }


codespacesGetOrgPublicKey toMsg =
    Http.get
        { url = "/orgs/{org}/codespaces/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


codespacesGetOrgSecret toMsg =
    Http.get
        { url = "/orgs/{org}/codespaces/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


codespacesListSelectedReposForOrgSecret toMsg =
    Http.get
        { url = "/orgs/{org}/codespaces/secrets/{secret_name}/repositories"
        , expect = Http.expectJson toMsg 55
        }


dependabotListOrgSecrets toMsg =
    Http.get
        { url = "/orgs/{org}/dependabot/secrets"
        , expect = Http.expectJson toMsg 55
        }


dependabotGetOrgPublicKey toMsg =
    Http.get
        { url = "/orgs/{org}/dependabot/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


dependabotGetOrgSecret toMsg =
    Http.get
        { url = "/orgs/{org}/dependabot/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


dependabotListSelectedReposForOrgSecret toMsg =
    Http.get
        { url = "/orgs/{org}/dependabot/secrets/{secret_name}/repositories"
        , expect = Http.expectJson toMsg 55
        }


activityListPublicOrgEvents toMsg =
    Http.get { url = "/orgs/{org}/events", expect = Http.expectJson toMsg 55 }


orgsListFailedInvitations toMsg =
    Http.get
        { url = "/orgs/{org}/failed_invitations"
        , expect = Http.expectJson toMsg 55
        }


orgsListFineGrainedPermissions toMsg =
    Http.get
        { url = "/orgs/{org}/fine_grained_permissions"
        , expect = Http.expectJson toMsg 55
        }


orgsListWebhooks toMsg =
    Http.get { url = "/orgs/{org}/hooks", expect = Http.expectJson toMsg 55 }


orgsGetWebhook toMsg =
    Http.get
        { url = "/orgs/{org}/hooks/{hook_id}"
        , expect = Http.expectJson toMsg 55
        }


orgsGetWebhookConfigForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/hooks/{hook_id}/config"
        , expect = Http.expectJson toMsg 55
        }


orgsListWebhookDeliveries toMsg =
    Http.get
        { url = "/orgs/{org}/hooks/{hook_id}/deliveries"
        , expect = Http.expectJson toMsg 55
        }


orgsGetWebhookDelivery toMsg =
    Http.get
        { url = "/orgs/{org}/hooks/{hook_id}/deliveries/{delivery_id}"
        , expect = Http.expectJson toMsg 55
        }


appsGetOrgInstallation toMsg =
    Http.get
        { url = "/orgs/{org}/installation", expect = Http.expectJson toMsg 55 }


orgsListAppInstallations toMsg =
    Http.get
        { url = "/orgs/{org}/installations", expect = Http.expectJson toMsg 55 }


interactionsGetRestrictionsForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/interaction-limits"
        , expect = Http.expectJson toMsg 55
        }


orgsListPendingInvitations toMsg =
    Http.get
        { url = "/orgs/{org}/invitations", expect = Http.expectJson toMsg 55 }


orgsListInvitationTeams toMsg =
    Http.get
        { url = "/orgs/{org}/invitations/{invitation_id}/teams"
        , expect = Http.expectJson toMsg 55
        }


issuesListForOrg toMsg =
    Http.get { url = "/orgs/{org}/issues", expect = Http.expectJson toMsg 55 }


orgsListMembers toMsg =
    Http.get { url = "/orgs/{org}/members", expect = Http.expectJson toMsg 55 }


orgsCheckMembershipForUser toMsg =
    Http.get
        { url = "/orgs/{org}/members/{username}"
        , expect = Http.expectJson toMsg 55
        }


codespacesGetCodespacesForUserInOrg toMsg =
    Http.get
        { url = "/orgs/{org}/members/{username}/codespaces"
        , expect = Http.expectJson toMsg 55
        }


orgsGetMembershipForUser toMsg =
    Http.get
        { url = "/orgs/{org}/memberships/{username}"
        , expect = Http.expectJson toMsg 55
        }


migrationsListForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/migrations", expect = Http.expectJson toMsg 55 }


migrationsGetStatusForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/migrations/{migration_id}"
        , expect = Http.expectJson toMsg 55
        }


migrationsDownloadArchiveForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/migrations/{migration_id}/archive"
        , expect = Http.expectJson toMsg 55
        }


migrationsListReposForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/migrations/{migration_id}/repositories"
        , expect = Http.expectJson toMsg 55
        }


orgsListOutsideCollaborators toMsg =
    Http.get
        { url = "/orgs/{org}/outside_collaborators"
        , expect = Http.expectJson toMsg 55
        }


packagesListPackagesForOrganization toMsg =
    Http.get { url = "/orgs/{org}/packages", expect = Http.expectJson toMsg 55 }


packagesGetPackageForOrganization toMsg =
    Http.get
        { url = "/orgs/{org}/packages/{package_type}/{package_name}"
        , expect = Http.expectJson toMsg 55
        }


packagesGetAllPackageVersionsForPackageOwnedByOrg toMsg =
    Http.get
        { url = "/orgs/{org}/packages/{package_type}/{package_name}/versions"
        , expect = Http.expectJson toMsg 55
        }


packagesGetPackageVersionForOrganization toMsg =
    Http.get
        { url =
            "/orgs/{org}/packages/{package_type}/{package_name}/versions/{package_version_id}"
        , expect = Http.expectJson toMsg 55
        }


projectsListForOrg toMsg =
    Http.get { url = "/orgs/{org}/projects", expect = Http.expectJson toMsg 55 }


orgsListPublicMembers toMsg =
    Http.get
        { url = "/orgs/{org}/public_members"
        , expect = Http.expectJson toMsg 55
        }


orgsCheckPublicMembershipForUser toMsg =
    Http.get
        { url = "/orgs/{org}/public_members/{username}"
        , expect = Http.expectJson toMsg 55
        }


reposListForOrg toMsg =
    Http.get { url = "/orgs/{org}/repos", expect = Http.expectJson toMsg 55 }


secretScanningListAlertsForOrg toMsg =
    Http.get
        { url = "/orgs/{org}/secret-scanning/alerts"
        , expect = Http.expectJson toMsg 55
        }


orgsListSecurityManagerTeams toMsg =
    Http.get
        { url = "/orgs/{org}/security-managers"
        , expect = Http.expectJson toMsg 55
        }


billingGetGithubActionsBillingOrg toMsg =
    Http.get
        { url = "/orgs/{org}/settings/billing/actions"
        , expect = Http.expectJson toMsg 55
        }


billingGetGithubAdvancedSecurityBillingOrg toMsg =
    Http.get
        { url = "/orgs/{org}/settings/billing/advanced-security"
        , expect = Http.expectJson toMsg 55
        }


billingGetGithubPackagesBillingOrg toMsg =
    Http.get
        { url = "/orgs/{org}/settings/billing/packages"
        , expect = Http.expectJson toMsg 55
        }


billingGetSharedStorageBillingOrg toMsg =
    Http.get
        { url = "/orgs/{org}/settings/billing/shared-storage"
        , expect = Http.expectJson toMsg 55
        }


teamsList toMsg =
    Http.get { url = "/orgs/{org}/teams", expect = Http.expectJson toMsg 55 }


teamsGetByName toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}"
        , expect = Http.expectJson toMsg 55
        }


teamsListDiscussionsInOrg toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/discussions"
        , expect = Http.expectJson toMsg 55
        }


teamsGetDiscussionInOrg toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}"
        , expect = Http.expectJson toMsg 55
        }


teamsListDiscussionCommentsInOrg toMsg =
    Http.get
        { url =
            "/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments"
        , expect = Http.expectJson toMsg 55
        }


teamsGetDiscussionCommentInOrg toMsg =
    Http.get
        { url =
            "/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments/{comment_number}"
        , expect = Http.expectJson toMsg 55
        }


reactionsListForTeamDiscussionCommentInOrg toMsg =
    Http.get
        { url =
            "/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments/{comment_number}/reactions"
        , expect = Http.expectJson toMsg 55
        }


reactionsListForTeamDiscussionInOrg toMsg =
    Http.get
        { url =
            "/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/reactions"
        , expect = Http.expectJson toMsg 55
        }


teamsListPendingInvitationsInOrg toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/invitations"
        , expect = Http.expectJson toMsg 55
        }


teamsListMembersInOrg toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/members"
        , expect = Http.expectJson toMsg 55
        }


teamsGetMembershipForUserInOrg toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/memberships/{username}"
        , expect = Http.expectJson toMsg 55
        }


teamsListProjectsInOrg toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/projects"
        , expect = Http.expectJson toMsg 55
        }


teamsCheckPermissionsForProjectInOrg toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/projects/{project_id}"
        , expect = Http.expectJson toMsg 55
        }


teamsListReposInOrg toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/repos"
        , expect = Http.expectJson toMsg 55
        }


teamsCheckPermissionsForRepoInOrg toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/repos/{owner}/{repo}"
        , expect = Http.expectJson toMsg 55
        }


teamsListChildInOrg toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/teams"
        , expect = Http.expectJson toMsg 55
        }


projectsGetCard toMsg =
    Http.get
        { url = "/projects/columns/cards/{card_id}"
        , expect = Http.expectJson toMsg 55
        }


projectsGetColumn toMsg =
    Http.get
        { url = "/projects/columns/{column_id}"
        , expect = Http.expectJson toMsg 55
        }


projectsListCards toMsg =
    Http.get
        { url = "/projects/columns/{column_id}/cards"
        , expect = Http.expectJson toMsg 55
        }


projectsGet toMsg =
    Http.get
        { url = "/projects/{project_id}", expect = Http.expectJson toMsg 55 }


projectsListCollaborators toMsg =
    Http.get
        { url = "/projects/{project_id}/collaborators"
        , expect = Http.expectJson toMsg 55
        }


projectsGetPermissionForUser toMsg =
    Http.get
        { url = "/projects/{project_id}/collaborators/{username}/permission"
        , expect = Http.expectJson toMsg 55
        }


projectsListColumns toMsg =
    Http.get
        { url = "/projects/{project_id}/columns"
        , expect = Http.expectJson toMsg 55
        }


rateLimitGet toMsg =
    Http.get { url = "/rate_limit", expect = Http.expectJson toMsg 55 }


reposGet toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}", expect = Http.expectJson toMsg 55 }


actionsListArtifactsForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/artifacts"
        , expect = Http.expectJson toMsg 55
        }


actionsGetArtifact toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/artifacts/{artifact_id}"
        , expect = Http.expectJson toMsg 55
        }


actionsDownloadArtifact toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/actions/artifacts/{artifact_id}/{archive_format}"
        , expect = Http.expectJson toMsg 55
        }


actionsGetActionsCacheUsage toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/cache/usage"
        , expect = Http.expectJson toMsg 55
        }


actionsGetActionsCacheList toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/caches"
        , expect = Http.expectJson toMsg 55
        }


actionsGetJobForWorkflowRun toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/jobs/{job_id}"
        , expect = Http.expectJson toMsg 55
        }


actionsDownloadJobLogsForWorkflowRun toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/jobs/{job_id}/logs"
        , expect = Http.expectJson toMsg 55
        }


actionsGetGithubActionsPermissionsRepository toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/permissions"
        , expect = Http.expectJson toMsg 55
        }


actionsGetWorkflowAccessToRepository toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/permissions/access"
        , expect = Http.expectJson toMsg 55
        }


actionsGetAllowedActionsRepository toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/permissions/selected-actions"
        , expect = Http.expectJson toMsg 55
        }


actionsGetGithubActionsDefaultWorkflowPermissionsRepository toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/permissions/workflow"
        , expect = Http.expectJson toMsg 55
        }


actionsListSelfHostedRunnersForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runners"
        , expect = Http.expectJson toMsg 55
        }


actionsListRunnerApplicationsForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runners/downloads"
        , expect = Http.expectJson toMsg 55
        }


actionsGetSelfHostedRunnerForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runners/{runner_id}"
        , expect = Http.expectJson toMsg 55
        }


actionsListLabelsForSelfHostedRunnerForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runners/{runner_id}/labels"
        , expect = Http.expectJson toMsg 55
        }


actionsListWorkflowRunsForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs"
        , expect = Http.expectJson toMsg 55
        }


actionsGetWorkflowRun toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs/{run_id}"
        , expect = Http.expectJson toMsg 55
        }


actionsGetReviewsForRun toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs/{run_id}/approvals"
        , expect = Http.expectJson toMsg 55
        }


actionsListWorkflowRunArtifacts toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs/{run_id}/artifacts"
        , expect = Http.expectJson toMsg 55
        }


actionsGetWorkflowRunAttempt toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/actions/runs/{run_id}/attempts/{attempt_number}"
        , expect = Http.expectJson toMsg 55
        }


actionsListJobsForWorkflowRunAttempt toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/actions/runs/{run_id}/attempts/{attempt_number}/jobs"
        , expect = Http.expectJson toMsg 55
        }


actionsDownloadWorkflowRunAttemptLogs toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/actions/runs/{run_id}/attempts/{attempt_number}/logs"
        , expect = Http.expectJson toMsg 55
        }


actionsListJobsForWorkflowRun toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs/{run_id}/jobs"
        , expect = Http.expectJson toMsg 55
        }


actionsDownloadWorkflowRunLogs toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs/{run_id}/logs"
        , expect = Http.expectJson toMsg 55
        }


actionsGetPendingDeploymentsForRun toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/actions/runs/{run_id}/pending_deployments"
        , expect = Http.expectJson toMsg 55
        }


actionsGetWorkflowRunUsage toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs/{run_id}/timing"
        , expect = Http.expectJson toMsg 55
        }


actionsListRepoSecrets toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/secrets"
        , expect = Http.expectJson toMsg 55
        }


actionsGetRepoPublicKey toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


actionsGetRepoSecret toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


actionsListRepoWorkflows toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/workflows"
        , expect = Http.expectJson toMsg 55
        }


actionsGetWorkflow toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/workflows/{workflow_id}"
        , expect = Http.expectJson toMsg 55
        }


actionsListWorkflowRuns toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/workflows/{workflow_id}/runs"
        , expect = Http.expectJson toMsg 55
        }


actionsGetWorkflowUsage toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/workflows/{workflow_id}/timing"
        , expect = Http.expectJson toMsg 55
        }


issuesListAssignees toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/assignees"
        , expect = Http.expectJson toMsg 55
        }


issuesCheckUserCanBeAssigned toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/assignees/{assignee}"
        , expect = Http.expectJson toMsg 55
        }


reposListAutolinks toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/autolinks"
        , expect = Http.expectJson toMsg 55
        }


reposGetAutolink toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/autolinks/{autolink_id}"
        , expect = Http.expectJson toMsg 55
        }


reposListBranches toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/branches"
        , expect = Http.expectJson toMsg 55
        }


reposGetBranch toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/branches/{branch}"
        , expect = Http.expectJson toMsg 55
        }


reposGetBranchProtection toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/branches/{branch}/protection"
        , expect = Http.expectJson toMsg 55
        }


reposGetAdminBranchProtection toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/enforce_admins"
        , expect = Http.expectJson toMsg 55
        }


reposGetPullRequestReviewProtection toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/required_pull_request_reviews"
        , expect = Http.expectJson toMsg 55
        }


reposGetCommitSignatureProtection toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/required_signatures"
        , expect = Http.expectJson toMsg 55
        }


reposGetStatusChecksProtection toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/required_status_checks"
        , expect = Http.expectJson toMsg 55
        }


reposGetAllStatusCheckContexts toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/required_status_checks/contexts"
        , expect = Http.expectJson toMsg 55
        }


reposGetAccessRestrictions toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/restrictions"
        , expect = Http.expectJson toMsg 55
        }


reposGetAppsWithAccessToProtectedBranch toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/restrictions/apps"
        , expect = Http.expectJson toMsg 55
        }


reposGetTeamsWithAccessToProtectedBranch toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/restrictions/teams"
        , expect = Http.expectJson toMsg 55
        }


reposGetUsersWithAccessToProtectedBranch toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/restrictions/users"
        , expect = Http.expectJson toMsg 55
        }


checksGet toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/check-runs/{check_run_id}"
        , expect = Http.expectJson toMsg 55
        }


checksListAnnotations toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/check-runs/{check_run_id}/annotations"
        , expect = Http.expectJson toMsg 55
        }


checksGetSuite toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/check-suites/{check_suite_id}"
        , expect = Http.expectJson toMsg 55
        }


checksListForSuite toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/check-suites/{check_suite_id}/check-runs"
        , expect = Http.expectJson toMsg 55
        }


codeScanningListAlertsForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/code-scanning/alerts"
        , expect = Http.expectJson toMsg 55
        }


codeScanningGetAlert toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/code-scanning/alerts/{alert_number}"
        , expect = Http.expectJson toMsg 55
        }


codeScanningListAlertInstances toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/code-scanning/alerts/{alert_number}/instances"
        , expect = Http.expectJson toMsg 55
        }


codeScanningListRecentAnalyses toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/code-scanning/analyses"
        , expect = Http.expectJson toMsg 55
        }


codeScanningGetAnalysis toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/code-scanning/analyses/{analysis_id}"
        , expect = Http.expectJson toMsg 55
        }


codeScanningListCodeqlDatabases toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/code-scanning/codeql/databases"
        , expect = Http.expectJson toMsg 55
        }


codeScanningGetCodeqlDatabase toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/code-scanning/codeql/databases/{language}"
        , expect = Http.expectJson toMsg 55
        }


codeScanningGetSarif toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/code-scanning/sarifs/{sarif_id}"
        , expect = Http.expectJson toMsg 55
        }


reposCodeownersErrors toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codeowners/errors"
        , expect = Http.expectJson toMsg 55
        }


codespacesListInRepositoryForAuthenticatedUser toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces"
        , expect = Http.expectJson toMsg 55
        }


codespacesListDevcontainersInRepositoryForAuthenticatedUser toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces/devcontainers"
        , expect = Http.expectJson toMsg 55
        }


codespacesRepoMachinesForAuthenticatedUser toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces/machines"
        , expect = Http.expectJson toMsg 55
        }


codespacesPreFlightWithRepoForAuthenticatedUser toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces/new"
        , expect = Http.expectJson toMsg 55
        }


codespacesListRepoSecrets toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces/secrets"
        , expect = Http.expectJson toMsg 55
        }


codespacesGetRepoPublicKey toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


codespacesGetRepoSecret toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


reposListCollaborators toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/collaborators"
        , expect = Http.expectJson toMsg 55
        }


reposCheckCollaborator toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/collaborators/{username}"
        , expect = Http.expectJson toMsg 55
        }


reposGetCollaboratorPermissionLevel toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/collaborators/{username}/permission"
        , expect = Http.expectJson toMsg 55
        }


reposListCommitCommentsForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/comments"
        , expect = Http.expectJson toMsg 55
        }


reposGetCommitComment toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/comments/{comment_id}"
        , expect = Http.expectJson toMsg 55
        }


reactionsListForCommitComment toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/comments/{comment_id}/reactions"
        , expect = Http.expectJson toMsg 55
        }


reposListCommits toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits"
        , expect = Http.expectJson toMsg 55
        }


reposListBranchesForHeadCommit toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{commit_sha}/branches-where-head"
        , expect = Http.expectJson toMsg 55
        }


reposListCommentsForCommit toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{commit_sha}/comments"
        , expect = Http.expectJson toMsg 55
        }


reposListPullRequestsAssociatedWithCommit toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{commit_sha}/pulls"
        , expect = Http.expectJson toMsg 55
        }


reposGetCommit toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{ref}"
        , expect = Http.expectJson toMsg 55
        }


checksListForRef toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{ref}/check-runs"
        , expect = Http.expectJson toMsg 55
        }


checksListSuitesForRef toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{ref}/check-suites"
        , expect = Http.expectJson toMsg 55
        }


reposGetCombinedStatusForRef toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{ref}/status"
        , expect = Http.expectJson toMsg 55
        }


reposListCommitStatusesForRef toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{ref}/statuses"
        , expect = Http.expectJson toMsg 55
        }


reposGetCommunityProfileMetrics toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/community/profile"
        , expect = Http.expectJson toMsg 55
        }


reposCompareCommits toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/compare/{basehead}"
        , expect = Http.expectJson toMsg 55
        }


reposGetContent toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/contents/{path}"
        , expect = Http.expectJson toMsg 55
        }


reposListContributors toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/contributors"
        , expect = Http.expectJson toMsg 55
        }


dependabotListAlertsForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/dependabot/alerts"
        , expect = Http.expectJson toMsg 55
        }


dependabotGetAlert toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/dependabot/alerts/{alert_number}"
        , expect = Http.expectJson toMsg 55
        }


dependabotListRepoSecrets toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/dependabot/secrets"
        , expect = Http.expectJson toMsg 55
        }


dependabotGetRepoPublicKey toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/dependabot/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


dependabotGetRepoSecret toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/dependabot/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


dependencyGraphDiffRange toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/dependency-graph/compare/{basehead}"
        , expect = Http.expectJson toMsg 55
        }


reposListDeployments toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/deployments"
        , expect = Http.expectJson toMsg 55
        }


reposGetDeployment toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/deployments/{deployment_id}"
        , expect = Http.expectJson toMsg 55
        }


reposListDeploymentStatuses toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/deployments/{deployment_id}/statuses"
        , expect = Http.expectJson toMsg 55
        }


reposGetDeploymentStatus toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/deployments/{deployment_id}/statuses/{status_id}"
        , expect = Http.expectJson toMsg 55
        }


reposGetAllEnvironments toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/environments"
        , expect = Http.expectJson toMsg 55
        }


reposGetEnvironment toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/environments/{environment_name}"
        , expect = Http.expectJson toMsg 55
        }


reposListDeploymentBranchPolicies toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/environments/{environment_name}/deployment-branch-policies"
        , expect = Http.expectJson toMsg 55
        }


reposGetDeploymentBranchPolicy toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/environments/{environment_name}/deployment-branch-policies/{branch_policy_id}"
        , expect = Http.expectJson toMsg 55
        }


activityListRepoEvents toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/events"
        , expect = Http.expectJson toMsg 55
        }


reposListForks toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/forks"
        , expect = Http.expectJson toMsg 55
        }


gitGetBlob toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/git/blobs/{file_sha}"
        , expect = Http.expectJson toMsg 55
        }


gitGetCommit toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/git/commits/{commit_sha}"
        , expect = Http.expectJson toMsg 55
        }


gitListMatchingRefs toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/git/matching-refs/{ref}"
        , expect = Http.expectJson toMsg 55
        }


gitGetRef toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/git/ref/{ref}"
        , expect = Http.expectJson toMsg 55
        }


gitGetTag toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/git/tags/{tag_sha}"
        , expect = Http.expectJson toMsg 55
        }


gitGetTree toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/git/trees/{tree_sha}"
        , expect = Http.expectJson toMsg 55
        }


reposListWebhooks toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/hooks"
        , expect = Http.expectJson toMsg 55
        }


reposGetWebhook toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/hooks/{hook_id}"
        , expect = Http.expectJson toMsg 55
        }


reposGetWebhookConfigForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/hooks/{hook_id}/config"
        , expect = Http.expectJson toMsg 55
        }


reposListWebhookDeliveries toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/hooks/{hook_id}/deliveries"
        , expect = Http.expectJson toMsg 55
        }


reposGetWebhookDelivery toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/hooks/{hook_id}/deliveries/{delivery_id}"
        , expect = Http.expectJson toMsg 55
        }


migrationsGetImportStatus toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/import"
        , expect = Http.expectJson toMsg 55
        }


migrationsGetCommitAuthors toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/import/authors"
        , expect = Http.expectJson toMsg 55
        }


migrationsGetLargeFiles toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/import/large_files"
        , expect = Http.expectJson toMsg 55
        }


appsGetRepoInstallation toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/installation"
        , expect = Http.expectJson toMsg 55
        }


interactionsGetRestrictionsForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/interaction-limits"
        , expect = Http.expectJson toMsg 55
        }


reposListInvitations toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/invitations"
        , expect = Http.expectJson toMsg 55
        }


issuesListForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues"
        , expect = Http.expectJson toMsg 55
        }


issuesListCommentsForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/comments"
        , expect = Http.expectJson toMsg 55
        }


issuesGetComment toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/comments/{comment_id}"
        , expect = Http.expectJson toMsg 55
        }


reactionsListForIssueComment toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/comments/{comment_id}/reactions"
        , expect = Http.expectJson toMsg 55
        }


issuesListEventsForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/events"
        , expect = Http.expectJson toMsg 55
        }


issuesGetEvent toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/events/{event_id}"
        , expect = Http.expectJson toMsg 55
        }


issuesGet toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/{issue_number}"
        , expect = Http.expectJson toMsg 55
        }


issuesListComments toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/{issue_number}/comments"
        , expect = Http.expectJson toMsg 55
        }


issuesListEvents toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/{issue_number}/events"
        , expect = Http.expectJson toMsg 55
        }


issuesListLabelsOnIssue toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/{issue_number}/labels"
        , expect = Http.expectJson toMsg 55
        }


reactionsListForIssue toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/{issue_number}/reactions"
        , expect = Http.expectJson toMsg 55
        }


issuesListEventsForTimeline toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/{issue_number}/timeline"
        , expect = Http.expectJson toMsg 55
        }


reposListDeployKeys toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/keys"
        , expect = Http.expectJson toMsg 55
        }


reposGetDeployKey toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/keys/{key_id}"
        , expect = Http.expectJson toMsg 55
        }


issuesListLabelsForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/labels"
        , expect = Http.expectJson toMsg 55
        }


issuesGetLabel toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/labels/{name}"
        , expect = Http.expectJson toMsg 55
        }


reposListLanguages toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/languages"
        , expect = Http.expectJson toMsg 55
        }


licensesGetForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/license"
        , expect = Http.expectJson toMsg 55
        }


issuesListMilestones toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/milestones"
        , expect = Http.expectJson toMsg 55
        }


issuesGetMilestone toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/milestones/{milestone_number}"
        , expect = Http.expectJson toMsg 55
        }


issuesListLabelsForMilestone toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/milestones/{milestone_number}/labels"
        , expect = Http.expectJson toMsg 55
        }


activityListRepoNotificationsForAuthenticatedUser toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/notifications"
        , expect = Http.expectJson toMsg 55
        }


reposGetPages toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pages"
        , expect = Http.expectJson toMsg 55
        }


reposListPagesBuilds toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pages/builds"
        , expect = Http.expectJson toMsg 55
        }


reposGetLatestPagesBuild toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pages/builds/latest"
        , expect = Http.expectJson toMsg 55
        }


reposGetPagesBuild toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pages/builds/{build_id}"
        , expect = Http.expectJson toMsg 55
        }


reposGetPagesHealthCheck toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pages/health"
        , expect = Http.expectJson toMsg 55
        }


projectsListForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/projects"
        , expect = Http.expectJson toMsg 55
        }


pullsList toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls"
        , expect = Http.expectJson toMsg 55
        }


pullsListReviewCommentsForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/comments"
        , expect = Http.expectJson toMsg 55
        }


pullsGetReviewComment toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/comments/{comment_id}"
        , expect = Http.expectJson toMsg 55
        }


reactionsListForPullRequestReviewComment toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/comments/{comment_id}/reactions"
        , expect = Http.expectJson toMsg 55
        }


pullsGet toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}"
        , expect = Http.expectJson toMsg 55
        }


pullsListReviewComments toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/comments"
        , expect = Http.expectJson toMsg 55
        }


pullsListCommits toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/commits"
        , expect = Http.expectJson toMsg 55
        }


pullsListFiles toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/files"
        , expect = Http.expectJson toMsg 55
        }


pullsCheckIfMerged toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/merge"
        , expect = Http.expectJson toMsg 55
        }


pullsListRequestedReviewers toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/requested_reviewers"
        , expect = Http.expectJson toMsg 55
        }


pullsListReviews toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/reviews"
        , expect = Http.expectJson toMsg 55
        }


pullsGetReview toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/reviews/{review_id}"
        , expect = Http.expectJson toMsg 55
        }


pullsListCommentsForReview toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/pulls/{pull_number}/reviews/{review_id}/comments"
        , expect = Http.expectJson toMsg 55
        }


reposGetReadme toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/readme"
        , expect = Http.expectJson toMsg 55
        }


reposGetReadmeInDirectory toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/readme/{dir}"
        , expect = Http.expectJson toMsg 55
        }


reposListReleases toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases"
        , expect = Http.expectJson toMsg 55
        }


reposGetReleaseAsset toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases/assets/{asset_id}"
        , expect = Http.expectJson toMsg 55
        }


reposGetLatestRelease toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases/latest"
        , expect = Http.expectJson toMsg 55
        }


reposGetReleaseByTag toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases/tags/{tag}"
        , expect = Http.expectJson toMsg 55
        }


reposGetRelease toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases/{release_id}"
        , expect = Http.expectJson toMsg 55
        }


reposListReleaseAssets toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases/{release_id}/assets"
        , expect = Http.expectJson toMsg 55
        }


reactionsListForRelease toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases/{release_id}/reactions"
        , expect = Http.expectJson toMsg 55
        }


secretScanningListAlertsForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/secret-scanning/alerts"
        , expect = Http.expectJson toMsg 55
        }


secretScanningGetAlert toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/secret-scanning/alerts/{alert_number}"
        , expect = Http.expectJson toMsg 55
        }


secretScanningListLocationsForAlert toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/secret-scanning/alerts/{alert_number}/locations"
        , expect = Http.expectJson toMsg 55
        }


activityListStargazersForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/stargazers"
        , expect = Http.expectJson toMsg 55
        }


reposGetCodeFrequencyStats toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/stats/code_frequency"
        , expect = Http.expectJson toMsg 55
        }


reposGetCommitActivityStats toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/stats/commit_activity"
        , expect = Http.expectJson toMsg 55
        }


reposGetContributorsStats toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/stats/contributors"
        , expect = Http.expectJson toMsg 55
        }


reposGetParticipationStats toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/stats/participation"
        , expect = Http.expectJson toMsg 55
        }


reposGetPunchCardStats toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/stats/punch_card"
        , expect = Http.expectJson toMsg 55
        }


activityListWatchersForRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/subscribers"
        , expect = Http.expectJson toMsg 55
        }


activityGetRepoSubscription toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/subscription"
        , expect = Http.expectJson toMsg 55
        }


reposListTags toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/tags"
        , expect = Http.expectJson toMsg 55
        }


reposListTagProtection toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/tags/protection"
        , expect = Http.expectJson toMsg 55
        }


reposDownloadTarballArchive toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/tarball/{ref}"
        , expect = Http.expectJson toMsg 55
        }


reposListTeams toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/teams"
        , expect = Http.expectJson toMsg 55
        }


reposGetAllTopics toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/topics"
        , expect = Http.expectJson toMsg 55
        }


reposGetClones toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/traffic/clones"
        , expect = Http.expectJson toMsg 55
        }


reposGetTopPaths toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/traffic/popular/paths"
        , expect = Http.expectJson toMsg 55
        }


reposGetTopReferrers toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/traffic/popular/referrers"
        , expect = Http.expectJson toMsg 55
        }


reposGetViews toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/traffic/views"
        , expect = Http.expectJson toMsg 55
        }


reposCheckVulnerabilityAlerts toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/vulnerability-alerts"
        , expect = Http.expectJson toMsg 55
        }


reposDownloadZipballArchive toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/zipball/{ref}"
        , expect = Http.expectJson toMsg 55
        }


reposListPublic toMsg =
    Http.get { url = "/repositories", expect = Http.expectJson toMsg 55 }


actionsListEnvironmentSecrets toMsg =
    Http.get
        { url =
            "/repositories/{repository_id}/environments/{environment_name}/secrets"
        , expect = Http.expectJson toMsg 55
        }


actionsGetEnvironmentPublicKey toMsg =
    Http.get
        { url =
            "/repositories/{repository_id}/environments/{environment_name}/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


actionsGetEnvironmentSecret toMsg =
    Http.get
        { url =
            "/repositories/{repository_id}/environments/{environment_name}/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


searchCode toMsg =
    Http.get { url = "/search/code", expect = Http.expectJson toMsg 55 }


searchCommits toMsg =
    Http.get { url = "/search/commits", expect = Http.expectJson toMsg 55 }


searchIssuesAndPullRequests toMsg =
    Http.get { url = "/search/issues", expect = Http.expectJson toMsg 55 }


searchLabels toMsg =
    Http.get { url = "/search/labels", expect = Http.expectJson toMsg 55 }


searchRepos toMsg =
    Http.get { url = "/search/repositories", expect = Http.expectJson toMsg 55 }


searchTopics toMsg =
    Http.get { url = "/search/topics", expect = Http.expectJson toMsg 55 }


searchUsers toMsg =
    Http.get { url = "/search/users", expect = Http.expectJson toMsg 55 }


teamsGetLegacy toMsg =
    Http.get { url = "/teams/{team_id}", expect = Http.expectJson toMsg 55 }


teamsListDiscussionsLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/discussions"
        , expect = Http.expectJson toMsg 55
        }


teamsGetDiscussionLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/discussions/{discussion_number}"
        , expect = Http.expectJson toMsg 55
        }


teamsListDiscussionCommentsLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/discussions/{discussion_number}/comments"
        , expect = Http.expectJson toMsg 55
        }


teamsGetDiscussionCommentLegacy toMsg =
    Http.get
        { url =
            "/teams/{team_id}/discussions/{discussion_number}/comments/{comment_number}"
        , expect = Http.expectJson toMsg 55
        }


reactionsListForTeamDiscussionCommentLegacy toMsg =
    Http.get
        { url =
            "/teams/{team_id}/discussions/{discussion_number}/comments/{comment_number}/reactions"
        , expect = Http.expectJson toMsg 55
        }


reactionsListForTeamDiscussionLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/discussions/{discussion_number}/reactions"
        , expect = Http.expectJson toMsg 55
        }


teamsListPendingInvitationsLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/invitations"
        , expect = Http.expectJson toMsg 55
        }


teamsListMembersLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/members", expect = Http.expectJson toMsg 55 }


teamsGetMemberLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/members/{username}"
        , expect = Http.expectJson toMsg 55
        }


teamsGetMembershipForUserLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/memberships/{username}"
        , expect = Http.expectJson toMsg 55
        }


teamsListProjectsLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/projects", expect = Http.expectJson toMsg 55 }


teamsCheckPermissionsForProjectLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/projects/{project_id}"
        , expect = Http.expectJson toMsg 55
        }


teamsListReposLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/repos", expect = Http.expectJson toMsg 55 }


teamsCheckPermissionsForRepoLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/repos/{owner}/{repo}"
        , expect = Http.expectJson toMsg 55
        }


teamsListChildLegacy toMsg =
    Http.get
        { url = "/teams/{team_id}/teams", expect = Http.expectJson toMsg 55 }


usersGetAuthenticated toMsg =
    Http.get { url = "/user", expect = Http.expectJson toMsg 55 }


usersListBlockedByAuthenticatedUser toMsg =
    Http.get { url = "/user/blocks", expect = Http.expectJson toMsg 55 }


usersCheckBlocked toMsg =
    Http.get
        { url = "/user/blocks/{username}", expect = Http.expectJson toMsg 55 }


codespacesListForAuthenticatedUser toMsg =
    Http.get { url = "/user/codespaces", expect = Http.expectJson toMsg 55 }


codespacesListSecretsForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/codespaces/secrets", expect = Http.expectJson toMsg 55 }


codespacesGetPublicKeyForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/codespaces/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


codespacesGetSecretForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/codespaces/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


codespacesListRepositoriesForSecretForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/codespaces/secrets/{secret_name}/repositories"
        , expect = Http.expectJson toMsg 55
        }


codespacesGetForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/codespaces/{codespace_name}"
        , expect = Http.expectJson toMsg 55
        }


codespacesGetExportDetailsForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/codespaces/{codespace_name}/exports/{export_id}"
        , expect = Http.expectJson toMsg 55
        }


codespacesCodespaceMachinesForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/codespaces/{codespace_name}/machines"
        , expect = Http.expectJson toMsg 55
        }


usersListEmailsForAuthenticatedUser toMsg =
    Http.get { url = "/user/emails", expect = Http.expectJson toMsg 55 }


usersListFollowersForAuthenticatedUser toMsg =
    Http.get { url = "/user/followers", expect = Http.expectJson toMsg 55 }


usersListFollowedByAuthenticatedUser toMsg =
    Http.get { url = "/user/following", expect = Http.expectJson toMsg 55 }


usersCheckPersonIsFollowedByAuthenticated toMsg =
    Http.get
        { url = "/user/following/{username}"
        , expect = Http.expectJson toMsg 55
        }


usersListGpgKeysForAuthenticatedUser toMsg =
    Http.get { url = "/user/gpg_keys", expect = Http.expectJson toMsg 55 }


usersGetGpgKeyForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/gpg_keys/{gpg_key_id}"
        , expect = Http.expectJson toMsg 55
        }


appsListInstallationsForAuthenticatedUser toMsg =
    Http.get { url = "/user/installations", expect = Http.expectJson toMsg 55 }


appsListInstallationReposForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/installations/{installation_id}/repositories"
        , expect = Http.expectJson toMsg 55
        }


interactionsGetRestrictionsForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/interaction-limits", expect = Http.expectJson toMsg 55 }


issuesListForAuthenticatedUser toMsg =
    Http.get { url = "/user/issues", expect = Http.expectJson toMsg 55 }


usersListPublicSshKeysForAuthenticatedUser toMsg =
    Http.get { url = "/user/keys", expect = Http.expectJson toMsg 55 }


usersGetPublicSshKeyForAuthenticatedUser toMsg =
    Http.get { url = "/user/keys/{key_id}", expect = Http.expectJson toMsg 55 }


appsListSubscriptionsForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/marketplace_purchases"
        , expect = Http.expectJson toMsg 55
        }


appsListSubscriptionsForAuthenticatedUserStubbed toMsg =
    Http.get
        { url = "/user/marketplace_purchases/stubbed"
        , expect = Http.expectJson toMsg 55
        }


orgsListMembershipsForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/memberships/orgs", expect = Http.expectJson toMsg 55 }


orgsGetMembershipForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/memberships/orgs/{org}"
        , expect = Http.expectJson toMsg 55
        }


migrationsListForAuthenticatedUser toMsg =
    Http.get { url = "/user/migrations", expect = Http.expectJson toMsg 55 }


migrationsGetStatusForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/migrations/{migration_id}"
        , expect = Http.expectJson toMsg 55
        }


migrationsGetArchiveForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/migrations/{migration_id}/archive"
        , expect = Http.expectJson toMsg 55
        }


migrationsListReposForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/migrations/{migration_id}/repositories"
        , expect = Http.expectJson toMsg 55
        }


orgsListForAuthenticatedUser toMsg =
    Http.get { url = "/user/orgs", expect = Http.expectJson toMsg 55 }


packagesListPackagesForAuthenticatedUser toMsg =
    Http.get { url = "/user/packages", expect = Http.expectJson toMsg 55 }


packagesGetPackageForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/packages/{package_type}/{package_name}"
        , expect = Http.expectJson toMsg 55
        }


packagesGetAllPackageVersionsForPackageOwnedByAuthenticatedUser toMsg =
    Http.get
        { url = "/user/packages/{package_type}/{package_name}/versions"
        , expect = Http.expectJson toMsg 55
        }


packagesGetPackageVersionForAuthenticatedUser toMsg =
    Http.get
        { url =
            "/user/packages/{package_type}/{package_name}/versions/{package_version_id}"
        , expect = Http.expectJson toMsg 55
        }


usersListPublicEmailsForAuthenticatedUser toMsg =
    Http.get { url = "/user/public_emails", expect = Http.expectJson toMsg 55 }


reposListForAuthenticatedUser toMsg =
    Http.get { url = "/user/repos", expect = Http.expectJson toMsg 55 }


reposListInvitationsForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/repository_invitations"
        , expect = Http.expectJson toMsg 55
        }


usersListSshSigningKeysForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/ssh_signing_keys", expect = Http.expectJson toMsg 55 }


usersGetSshSigningKeyForAuthenticatedUser toMsg =
    Http.get
        { url = "/user/ssh_signing_keys/{ssh_signing_key_id}"
        , expect = Http.expectJson toMsg 55
        }


activityListReposStarredByAuthenticatedUser toMsg =
    Http.get { url = "/user/starred", expect = Http.expectJson toMsg 55 }


activityCheckRepoIsStarredByAuthenticatedUser toMsg =
    Http.get
        { url = "/user/starred/{owner}/{repo}"
        , expect = Http.expectJson toMsg 55
        }


activityListWatchedReposForAuthenticatedUser toMsg =
    Http.get { url = "/user/subscriptions", expect = Http.expectJson toMsg 55 }


teamsListForAuthenticatedUser toMsg =
    Http.get { url = "/user/teams", expect = Http.expectJson toMsg 55 }


usersList toMsg =
    Http.get { url = "/users", expect = Http.expectJson toMsg 55 }


usersGetByUsername toMsg =
    Http.get { url = "/users/{username}", expect = Http.expectJson toMsg 55 }


activityListEventsForAuthenticatedUser toMsg =
    Http.get
        { url = "/users/{username}/events", expect = Http.expectJson toMsg 55 }


activityListOrgEventsForAuthenticatedUser toMsg =
    Http.get
        { url = "/users/{username}/events/orgs/{org}"
        , expect = Http.expectJson toMsg 55
        }


activityListPublicEventsForUser toMsg =
    Http.get
        { url = "/users/{username}/events/public"
        , expect = Http.expectJson toMsg 55
        }


usersListFollowersForUser toMsg =
    Http.get
        { url = "/users/{username}/followers"
        , expect = Http.expectJson toMsg 55
        }


usersListFollowingForUser toMsg =
    Http.get
        { url = "/users/{username}/following"
        , expect = Http.expectJson toMsg 55
        }


usersCheckFollowingForUser toMsg =
    Http.get
        { url = "/users/{username}/following/{target_user}"
        , expect = Http.expectJson toMsg 55
        }


gistsListForUser toMsg =
    Http.get
        { url = "/users/{username}/gists", expect = Http.expectJson toMsg 55 }


usersListGpgKeysForUser toMsg =
    Http.get
        { url = "/users/{username}/gpg_keys"
        , expect = Http.expectJson toMsg 55
        }


usersGetContextForUser toMsg =
    Http.get
        { url = "/users/{username}/hovercard"
        , expect = Http.expectJson toMsg 55
        }


appsGetUserInstallation toMsg =
    Http.get
        { url = "/users/{username}/installation"
        , expect = Http.expectJson toMsg 55
        }


usersListPublicKeysForUser toMsg =
    Http.get
        { url = "/users/{username}/keys", expect = Http.expectJson toMsg 55 }


orgsListForUser toMsg =
    Http.get
        { url = "/users/{username}/orgs", expect = Http.expectJson toMsg 55 }


packagesListPackagesForUser toMsg =
    Http.get
        { url = "/users/{username}/packages"
        , expect = Http.expectJson toMsg 55
        }


packagesGetPackageForUser toMsg =
    Http.get
        { url = "/users/{username}/packages/{package_type}/{package_name}"
        , expect = Http.expectJson toMsg 55
        }


packagesGetAllPackageVersionsForPackageOwnedByUser toMsg =
    Http.get
        { url =
            "/users/{username}/packages/{package_type}/{package_name}/versions"
        , expect = Http.expectJson toMsg 55
        }


packagesGetPackageVersionForUser toMsg =
    Http.get
        { url =
            "/users/{username}/packages/{package_type}/{package_name}/versions/{package_version_id}"
        , expect = Http.expectJson toMsg 55
        }


projectsListForUser toMsg =
    Http.get
        { url = "/users/{username}/projects"
        , expect = Http.expectJson toMsg 55
        }


activityListReceivedEventsForUser toMsg =
    Http.get
        { url = "/users/{username}/received_events"
        , expect = Http.expectJson toMsg 55
        }


activityListReceivedPublicEventsForUser toMsg =
    Http.get
        { url = "/users/{username}/received_events/public"
        , expect = Http.expectJson toMsg 55
        }


reposListForUser toMsg =
    Http.get
        { url = "/users/{username}/repos", expect = Http.expectJson toMsg 55 }


billingGetGithubActionsBillingUser toMsg =
    Http.get
        { url = "/users/{username}/settings/billing/actions"
        , expect = Http.expectJson toMsg 55
        }


billingGetGithubPackagesBillingUser toMsg =
    Http.get
        { url = "/users/{username}/settings/billing/packages"
        , expect = Http.expectJson toMsg 55
        }


billingGetSharedStorageBillingUser toMsg =
    Http.get
        { url = "/users/{username}/settings/billing/shared-storage"
        , expect = Http.expectJson toMsg 55
        }


usersListSshSigningKeysForUser toMsg =
    Http.get
        { url = "/users/{username}/ssh_signing_keys"
        , expect = Http.expectJson toMsg 55
        }


activityListReposStarredByUser toMsg =
    Http.get
        { url = "/users/{username}/starred", expect = Http.expectJson toMsg 55 }


activityListReposWatchedByUser toMsg =
    Http.get
        { url = "/users/{username}/subscriptions"
        , expect = Http.expectJson toMsg 55
        }


metaGetZen toMsg =
    Http.get { url = "/zen", expect = Http.expectJson toMsg 55 }


type alias WorkflowUsage =
    { billable :
        { uBUNTU : { total_ms : Int }
        , mACOS : { total_ms : Int }
        , wINDOWS : { total_ms : Int }
        }
    }


type alias WorkflowRunUsage =
    { billable :
        { uBUNTU :
            { total_ms : Int
            , jobs : Int
            , job_runs : List { job_id : Int, duration_ms : Int }
            }
        , mACOS :
            { total_ms : Int
            , jobs : Int
            , job_runs : List { job_id : Int, duration_ms : Int }
            }
        , wINDOWS :
            { total_ms : Int
            , jobs : Int
            , job_runs : List { job_id : Int, duration_ms : Int }
            }
        }
    , run_duration_ms : Int
    }


type alias WorkflowRun =
    { id : Int
    , name : Maybe String
    , node_id : String
    , check_suite_id : Int
    , check_suite_node_id : String
    , head_branch : Maybe String
    , head_sha : String
    , path : String
    , run_number : Int
    , run_attempt : Int
    , referenced_workflows : Maybe (List ReferencedWorkflow)
    , event : String
    , status : Maybe String
    , conclusion : Maybe String
    , workflow_id : Int
    , url : String
    , html_url : String
    , pull_requests : Maybe (List PullRequestMinimal)
    , created_at : String
    , updated_at : String
    , actor : SimpleUser
    , triggering_actor : SimpleUser
    , run_started_at : String
    , jobs_url : String
    , logs_url : String
    , check_suite_url : String
    , artifacts_url : String
    , cancel_url : String
    , rerun_url : String
    , previous_attempt_url : Maybe String
    , workflow_url : String
    , head_commit : Debug.Todo
    , repository : MinimalRepository
    , head_repository : MinimalRepository
    , head_repository_id : Int
    , display_title : String
    }


type alias Workflow =
    { id : Int
    , node_id : String
    , name : String
    , path : String
    , state : String
    , created_at : String
    , updated_at : String
    , url : String
    , html_url : String
    , badge_url : String
    , deleted_at : String
    }


type alias WebhookMergeGroupChecksRequested =
    { action : String
    , installation : SimpleInstallation
    , merge_group : { base_ref : String, head_ref : String, head_sha : String }
    , organization : OrganizationSimple
    , repository : Repository
    , sender : SimpleUser
    }


type alias WebhookDependabotAlertReopened =
    { action : String
    , alert : DependabotAlert
    , installation : SimpleInstallation
    , organization : OrganizationSimple
    , enterprise : Enterprise
    , repository : Repository
    , sender : SimpleUser
    }


type alias WebhookDependabotAlertReintroduced =
    { action : String
    , alert : DependabotAlert
    , installation : SimpleInstallation
    , organization : OrganizationSimple
    , enterprise : Enterprise
    , repository : Repository
    , sender : SimpleUser
    }


type alias WebhookDependabotAlertFixed =
    { action : String
    , alert : DependabotAlert
    , installation : SimpleInstallation
    , organization : OrganizationSimple
    , enterprise : Enterprise
    , repository : Repository
    , sender : SimpleUser
    }


type alias WebhookDependabotAlertDismissed =
    { action : String
    , alert : DependabotAlert
    , installation : SimpleInstallation
    , organization : OrganizationSimple
    , enterprise : Enterprise
    , repository : Repository
    , sender : SimpleUser
    }


type alias WebhookDependabotAlertCreated =
    { action : String
    , alert : DependabotAlert
    , installation : SimpleInstallation
    , organization : OrganizationSimple
    , enterprise : Enterprise
    , repository : Repository
    , sender : SimpleUser
    }


type alias WebhookConfigUrl =
    String


type alias WebhookConfigSecret =
    String


type alias WebhookConfigInsecureSsl =
    Json.Encode.Value


type alias WebhookConfigContentType =
    String


type alias WebhookConfig =
    { url : WebhookConfigUrl
    , content_type : WebhookConfigContentType
    , secret : WebhookConfigSecret
    , insecure_ssl : WebhookConfigInsecureSsl
    }


type alias WaitTimer =
    Int


type alias ViewTraffic =
    { count : Int, uniques : Int, views : List Traffic }


type alias Verification =
    { verified : Bool
    , reason : String
    , payload : Maybe String
    , signature : Maybe String
    }


type alias ValidationErrorSimple =
    { message : String, documentation_url : String, errors : List String }


type alias ValidationError =
    { message : String
    , documentation_url : String
    , errors :
        List { resource : String
        , field : String
        , message : String
        , code : String
        , index : Int
        , value : Json.Encode.Value
        }
    }


type alias UserSearchResultItem =
    { login : String
    , id : Int
    , node_id : String
    , avatar_url : String
    , gravatar_id : Maybe String
    , url : String
    , html_url : String
    , followers_url : String
    , subscriptions_url : String
    , organizations_url : String
    , repos_url : String
    , received_events_url : String
    , type_ : String
    , score : Float
    , following_url : String
    , gists_url : String
    , starred_url : String
    , events_url : String
    , public_repos : Int
    , public_gists : Int
    , followers : Int
    , following : Int
    , created_at : String
    , updated_at : String
    , name : Maybe String
    , bio : Maybe String
    , email : Maybe String
    , location : Maybe String
    , site_admin : Bool
    , hireable : Maybe Bool
    , text_matches : SearchResultTextMatches
    , blog : Maybe String
    , company : Maybe String
    , suspended_at : Maybe String
    }


type alias UserMarketplacePurchase =
    { billing_cycle : String
    , next_billing_date : Maybe String
    , unit_count : Maybe Int
    , on_free_trial : Bool
    , free_trial_ends_on : Maybe String
    , updated_at : Maybe String
    , account : MarketplaceAccount
    , plan : MarketplaceListingPlan
    }


type alias UnlabeledIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , label : { name : String, color : String }
    }


type alias UnassignedIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , assignee : SimpleUser
    , assigner : SimpleUser
    }


type alias Traffic =
    { timestamp : String, uniques : Int, count : Int }


type alias TopicSearchResultItem =
    { name : String
    , display_name : Maybe String
    , short_description : Maybe String
    , description : Maybe String
    , created_by : Maybe String
    , released : Maybe String
    , created_at : String
    , updated_at : String
    , featured : Bool
    , curated : Bool
    , score : Float
    , repository_count : Maybe Int
    , logo_url : Maybe String
    , text_matches : SearchResultTextMatches
    , related :
        Maybe (List { topic_relation :
            { id : Int, name : String, topic_id : Int, relation_type : String }
        })
    , aliases :
        Maybe (List { topic_relation :
            { id : Int, name : String, topic_id : Int, relation_type : String }
        })
    }


type alias Topic =
    { names : List String }


type alias TimelineUnassignedIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , assignee : SimpleUser
    }


type alias TimelineReviewedEvent =
    { event : String
    , id : Int
    , node_id : String
    , user : SimpleUser
    , body : Maybe String
    , state : String
    , html_url : String
    , pull_request_url : String
    , _links : { html : { href : String }, pull_request : { href : String } }
    , submitted_at : String
    , commit_id : String
    , body_html : String
    , body_text : String
    , author_association : AuthorAssociation
    }


type alias TimelineLineCommentedEvent =
    { event : String
    , node_id : String
    , comments : List PullRequestReviewComment
    }


type alias TimelineIssueEvents =
    {}


type alias TimelineCrossReferencedEvent =
    { event : String
    , actor : SimpleUser
    , created_at : String
    , updated_at : String
    , source : { type_ : String, issue : Issue }
    }


type alias TimelineCommittedEvent =
    { event : String
    , sha : String
    , node_id : String
    , url : String
    , author : { date : String, email : String, name : String }
    , committer : { date : String, email : String, name : String }
    , message : String
    , tree : { sha : String, url : String }
    , parents : List { sha : String, url : String, html_url : String }
    , verification :
        { verified : Bool
        , reason : String
        , signature : Maybe String
        , payload : Maybe String
        }
    , html_url : String
    }


type alias TimelineCommitCommentedEvent =
    { event : String
    , node_id : String
    , commit_id : String
    , comments : List CommitComment
    }


type alias TimelineCommentEvent =
    { event : String
    , actor : SimpleUser
    , id : Int
    , node_id : String
    , url : String
    , body : String
    , body_text : String
    , body_html : String
    , html_url : String
    , user : SimpleUser
    , created_at : String
    , updated_at : String
    , issue_url : String
    , author_association : AuthorAssociation
    , performed_via_github_app : Debug.Todo
    , reactions : ReactionRollup
    }


type alias TimelineAssignedIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , assignee : SimpleUser
    }


type alias ThreadSubscription =
    { subscribed : Bool
    , ignored : Bool
    , reason : Maybe String
    , created_at : Maybe String
    , url : String
    , thread_url : String
    , repository_url : String
    }


type alias Thread =
    { id : String
    , repository : MinimalRepository
    , subject :
        { title : String
        , url : String
        , latest_comment_url : String
        , type_ : String
        }
    , reason : String
    , unread : Bool
    , updated_at : String
    , last_read_at : Maybe String
    , url : String
    , subscription_url : String
    }


type alias TeamSimple =
    { id : Int
    , node_id : String
    , url : String
    , members_url : String
    , name : String
    , description : Maybe String
    , permission : String
    , privacy : String
    , html_url : String
    , repositories_url : String
    , slug : String
    , ldap_dn : String
    }


type alias TeamRepository =
    { id : Int
    , node_id : String
    , name : String
    , full_name : String
    , license : Debug.Todo
    , forks : Int
    , permissions :
        { admin : Bool
        , pull : Bool
        , triage : Bool
        , push : Bool
        , maintain : Bool
        }
    , role_name : String
    , owner : Debug.Todo
    , private : Bool
    , html_url : String
    , description : Maybe String
    , fork : Bool
    , url : String
    , archive_url : String
    , assignees_url : String
    , blobs_url : String
    , branches_url : String
    , collaborators_url : String
    , comments_url : String
    , commits_url : String
    , compare_url : String
    , contents_url : String
    , contributors_url : String
    , deployments_url : String
    , downloads_url : String
    , events_url : String
    , forks_url : String
    , git_commits_url : String
    , git_refs_url : String
    , git_tags_url : String
    , git_url : String
    , issue_comment_url : String
    , issue_events_url : String
    , issues_url : String
    , keys_url : String
    , labels_url : String
    , languages_url : String
    , merges_url : String
    , milestones_url : String
    , notifications_url : String
    , pulls_url : String
    , releases_url : String
    , ssh_url : String
    , stargazers_url : String
    , statuses_url : String
    , subscribers_url : String
    , subscription_url : String
    , tags_url : String
    , teams_url : String
    , trees_url : String
    , clone_url : String
    , mirror_url : Maybe String
    , hooks_url : String
    , svn_url : String
    , homepage : Maybe String
    , language : Maybe String
    , forks_count : Int
    , stargazers_count : Int
    , watchers_count : Int
    , size : Int
    , default_branch : String
    , open_issues_count : Int
    , is_template : Bool
    , topics : List String
    , has_issues : Bool
    , has_projects : Bool
    , has_wiki : Bool
    , has_pages : Bool
    , has_downloads : Bool
    , archived : Bool
    , disabled : Bool
    , visibility : String
    , pushed_at : Maybe String
    , created_at : Maybe String
    , updated_at : Maybe String
    , allow_rebase_merge : Bool
    , template_repository : Debug.Todo
    , temp_clone_token : String
    , allow_squash_merge : Bool
    , allow_auto_merge : Bool
    , delete_branch_on_merge : Bool
    , allow_merge_commit : Bool
    , allow_forking : Bool
    , web_commit_signoff_required : Bool
    , subscribers_count : Int
    , network_count : Int
    , open_issues : Int
    , watchers : Int
    , master_branch : String
    }


type alias TeamProject =
    { owner_url : String
    , url : String
    , html_url : String
    , columns_url : String
    , id : Int
    , node_id : String
    , name : String
    , body : Maybe String
    , number : Int
    , state : String
    , creator : SimpleUser
    , created_at : String
    , updated_at : String
    , organization_permission : String
    , private : Bool
    , permissions : { read : Bool, write : Bool, admin : Bool }
    }


type alias TeamOrganization =
    { login : String
    , id : Int
    , node_id : String
    , url : String
    , repos_url : String
    , events_url : String
    , hooks_url : String
    , issues_url : String
    , members_url : String
    , public_members_url : String
    , avatar_url : String
    , description : Maybe String
    , name : String
    , company : String
    , blog : String
    , location : String
    , email : String
    , twitter_username : Maybe String
    , is_verified : Bool
    , has_organization_projects : Bool
    , has_repository_projects : Bool
    , public_repos : Int
    , public_gists : Int
    , followers : Int
    , following : Int
    , html_url : String
    , created_at : String
    , type_ : String
    , total_private_repos : Int
    , owned_private_repos : Int
    , private_gists : Maybe Int
    , disk_usage : Maybe Int
    , collaborators : Maybe Int
    , billing_email : Maybe String
    , plan :
        { name : String
        , space : Int
        , private_repos : Int
        , filled_seats : Int
        , seats : Int
        }
    , default_repository_permission : Maybe String
    , members_can_create_repositories : Maybe Bool
    , two_factor_requirement_enabled : Maybe Bool
    , members_allowed_repository_creation_type : String
    , members_can_create_public_repositories : Bool
    , members_can_create_private_repositories : Bool
    , members_can_create_internal_repositories : Bool
    , members_can_create_pages : Bool
    , members_can_create_public_pages : Bool
    , members_can_create_private_pages : Bool
    , members_can_fork_private_repositories : Maybe Bool
    , web_commit_signoff_required : Bool
    , updated_at : String
    }


type alias TeamMembership =
    { url : String, role : String, state : String }


type alias TeamFull =
    { id : Int
    , node_id : String
    , url : String
    , html_url : String
    , name : String
    , slug : String
    , description : Maybe String
    , privacy : String
    , permission : String
    , members_url : String
    , repositories_url : String
    , parent : Debug.Todo
    , members_count : Int
    , repos_count : Int
    , created_at : String
    , updated_at : String
    , organization : TeamOrganization
    , ldap_dn : String
    }


type alias TeamDiscussionComment =
    { author : Debug.Todo
    , body : String
    , body_html : String
    , body_version : String
    , created_at : String
    , last_edited_at : Maybe String
    , discussion_url : String
    , html_url : String
    , node_id : String
    , number : Int
    , updated_at : String
    , url : String
    , reactions : ReactionRollup
    }


type alias TeamDiscussion =
    { author : Debug.Todo
    , body : String
    , body_html : String
    , body_version : String
    , comments_count : Int
    , comments_url : String
    , created_at : String
    , last_edited_at : Maybe String
    , html_url : String
    , node_id : String
    , number : Int
    , pinned : Bool
    , private : Bool
    , team_url : String
    , title : String
    , updated_at : String
    , url : String
    , reactions : ReactionRollup
    }


type alias Team =
    { id : Int
    , node_id : String
    , name : String
    , slug : String
    , description : Maybe String
    , privacy : String
    , permission : String
    , permissions :
        { pull : Bool
        , triage : Bool
        , push : Bool
        , maintain : Bool
        , admin : Bool
        }
    , url : String
    , html_url : String
    , members_url : String
    , repositories_url : String
    , parent : Debug.Todo
    }


type alias TagProtection =
    { id : Int
    , created_at : String
    , updated_at : String
    , enabled : Bool
    , pattern : String
    }


type alias Tag =
    { name : String
    , commit : { sha : String, url : String }
    , zipball_url : String
    , tarball_url : String
    , node_id : String
    }


type alias StatusCheckPolicy =
    { url : String
    , strict : Bool
    , contexts : List String
    , checks : List { context : String, app_id : Maybe Int }
    , contexts_url : String
    }


type alias Status =
    { url : String
    , avatar_url : Maybe String
    , id : Int
    , node_id : String
    , state : String
    , description : Maybe String
    , target_url : Maybe String
    , context : String
    , created_at : String
    , updated_at : String
    , creator : Debug.Todo
    }


type alias StateChangeIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , state_reason : Maybe String
    }


type alias StarredRepository =
    { starred_at : String, repo : Repository }


type alias Stargazer =
    { starred_at : String, user : Debug.Todo }


type alias SshSigningKey =
    { key : String, id : Int, title : String, created_at : String }


type alias Snapshot =
    { version : Int
    , job : { id : String, correlator : String, html_url : String }
    , sha : String
    , ref : String
    , detector : { name : String, version : String, url : String }
    , metadata : Metadata
    , manifests : {}
    , scanned : String
    }


type alias SimpleUser =
    { name : Maybe String
    , email : Maybe String
    , login : String
    , id : Int
    , node_id : String
    , avatar_url : String
    , gravatar_id : Maybe String
    , url : String
    , html_url : String
    , followers_url : String
    , following_url : String
    , gists_url : String
    , starred_url : String
    , subscriptions_url : String
    , organizations_url : String
    , repos_url : String
    , events_url : String
    , received_events_url : String
    , type_ : String
    , site_admin : Bool
    , starred_at : String
    }


type alias SimpleRepository =
    { id : Int
    , node_id : String
    , name : String
    , full_name : String
    , owner : SimpleUser
    , private : Bool
    , html_url : String
    , description : Maybe String
    , fork : Bool
    , url : String
    , archive_url : String
    , assignees_url : String
    , blobs_url : String
    , branches_url : String
    , collaborators_url : String
    , comments_url : String
    , commits_url : String
    , compare_url : String
    , contents_url : String
    , contributors_url : String
    , deployments_url : String
    , downloads_url : String
    , events_url : String
    , forks_url : String
    , git_commits_url : String
    , git_refs_url : String
    , git_tags_url : String
    , issue_comment_url : String
    , issue_events_url : String
    , issues_url : String
    , keys_url : String
    , labels_url : String
    , languages_url : String
    , merges_url : String
    , milestones_url : String
    , notifications_url : String
    , pulls_url : String
    , releases_url : String
    , stargazers_url : String
    , statuses_url : String
    , subscribers_url : String
    , subscription_url : String
    , tags_url : String
    , teams_url : String
    , trees_url : String
    , hooks_url : String
    }


type alias SimpleInstallation =
    { id : Int, node_id : String }


type alias SimpleCommitStatus =
    { description : Maybe String
    , id : Int
    , node_id : String
    , state : String
    , context : String
    , target_url : Maybe String
    , required : Maybe Bool
    , avatar_url : Maybe String
    , url : String
    , created_at : String
    , updated_at : String
    }


type alias SimpleCommit =
    { id : String
    , tree_id : String
    , message : String
    , timestamp : String
    , author : Maybe { name : String, email : String }
    , committer : Maybe { name : String, email : String }
    }


type alias ShortBranch =
    { name : String
    , commit : { sha : String, url : String }
    , protected : Bool
    , protection : BranchProtection
    , protection_url : String
    }


type alias ShortBlob =
    { url : String, sha : String }


type alias ServerStatistics =
    List { server_id : String
    , collection_date : String
    , schema_version : String
    , ghes_version : String
    , host_name : String
    , github_connect : { features_enabled : List String }
    , ghe_stats :
        { comments :
            { total_commit_comments : Int
            , total_gist_comments : Int
            , total_issue_comments : Int
            , total_pull_request_comments : Int
            }
        , gists : { total_gists : Int, private_gists : Int, public_gists : Int }
        , hooks :
            { total_hooks : Int, active_hooks : Int, inactive_hooks : Int }
        , issues :
            { total_issues : Int, open_issues : Int, closed_issues : Int }
        , milestones :
            { total_milestones : Int
            , open_milestones : Int
            , closed_milestones : Int
            }
        , orgs :
            { total_orgs : Int
            , disabled_orgs : Int
            , total_teams : Int
            , total_team_members : Int
            }
        , pages : { total_pages : Int }
        , pulls :
            { total_pulls : Int
            , merged_pulls : Int
            , mergeable_pulls : Int
            , unmergeable_pulls : Int
            }
        , repos :
            { total_repos : Int
            , root_repos : Int
            , fork_repos : Int
            , org_repos : Int
            , total_pushes : Int
            , total_wikis : Int
            }
        , users :
            { total_users : Int, admin_users : Int, suspended_users : Int }
        }
    , dormant_users : { total_dormant_users : Int, dormancy_threshold : String }
    }


type alias SelectedActionsUrl =
    String


type alias SelectedActions =
    { github_owned_allowed : Bool
    , verified_allowed : Bool
    , patterns_allowed : List String
    }


type alias SecurityAndAnalysis =
    Maybe { advanced_security : { status : String }
    , secret_scanning : { status : String }
    , secret_scanning_push_protection : { status : String }
    }


type alias SecretScanningLocationCommit =
    { path : String
    , start_line : Float
    , end_line : Float
    , start_column : Float
    , end_column : Float
    , blob_sha : String
    , blob_url : String
    , commit_sha : String
    , commit_url : String
    }


type alias SecretScanningLocation =
    { type_ : String, details : Json.Encode.Value }


type alias SecretScanningAlertState =
    String


type alias SecretScanningAlertResolutionComment =
    Maybe String


type alias SecretScanningAlertResolution =
    Maybe String


type alias SecretScanningAlert =
    { number : AlertNumber
    , created_at : AlertCreatedAt
    , updated_at : AlertUpdatedAt
    , url : AlertUrl
    , html_url : AlertHtmlUrl
    , locations_url : String
    , state : SecretScanningAlertState
    , resolution : SecretScanningAlertResolution
    , resolved_at : Maybe String
    , resolved_by : Debug.Todo
    , secret_type : String
    , secret_type_display_name : String
    , secret : String
    , push_protection_bypassed : Maybe Bool
    , push_protection_bypassed_by : Debug.Todo
    , push_protection_bypassed_at : Maybe String
    , resolution_comment : Maybe String
    }


type alias SearchResultTextMatches =
    List { object_url : String
    , object_type : Maybe String
    , property : String
    , fragment : String
    , matches : List { text : String, indices : List Int }
    }


type alias ScopedInstallation =
    { permissions : AppPermissions
    , repository_selection : String
    , single_file_name : Maybe String
    , has_multiple_single_files : Bool
    , single_file_paths : List String
    , repositories_url : String
    , account : SimpleUser
    }


type alias ScimError =
    { message : Maybe String
    , documentation_url : Maybe String
    , detail : Maybe String
    , status : Int
    , scimType : Maybe String
    , schemas : List String
    }


type alias RunnerLabel =
    { id : Int, name : String, type_ : String }


type alias RunnerGroupsOrg =
    { id : Float
    , name : String
    , visibility : String
    , default : Bool
    , selected_repositories_url : String
    , runners_url : String
    , inherited : Bool
    , inherited_allows_public_repositories : Bool
    , allows_public_repositories : Bool
    , workflow_restrictions_read_only : Bool
    , restricted_to_workflows : Bool
    , selected_workflows : List String
    }


type alias RunnerGroupsEnterprise =
    { id : Float
    , name : String
    , visibility : String
    , default : Bool
    , selected_organizations_url : String
    , runners_url : String
    , allows_public_repositories : Bool
    , workflow_restrictions_read_only : Bool
    , restricted_to_workflows : Bool
    , selected_workflows : List String
    }


type alias RunnerApplication =
    { os : String
    , architecture : String
    , download_url : String
    , filename : String
    , temp_download_token : String
    , sha256_checksum : String
    }


type alias Runner =
    { id : Int
    , name : String
    , os : String
    , status : String
    , busy : Bool
    , labels : List RunnerLabel
    }


type alias Root =
    { current_user_url : String
    , current_user_authorizations_html_url : String
    , authorizations_url : String
    , code_search_url : String
    , commit_search_url : String
    , emails_url : String
    , emojis_url : String
    , events_url : String
    , feeds_url : String
    , followers_url : String
    , following_url : String
    , gists_url : String
    , hub_url : String
    , issue_search_url : String
    , issues_url : String
    , keys_url : String
    , label_search_url : String
    , notifications_url : String
    , organization_url : String
    , organization_repositories_url : String
    , organization_teams_url : String
    , public_gists_url : String
    , rate_limit_url : String
    , repository_url : String
    , repository_search_url : String
    , current_user_repositories_url : String
    , starred_url : String
    , starred_gists_url : String
    , topic_search_url : String
    , user_url : String
    , user_organizations_url : String
    , user_repositories_url : String
    , user_search_url : String
    }


type alias ReviewRequestedIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , review_requester : SimpleUser
    , requested_team : Team
    , requested_reviewer : SimpleUser
    }


type alias ReviewRequestRemovedIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , review_requester : SimpleUser
    , requested_team : Team
    , requested_reviewer : SimpleUser
    }


type alias ReviewDismissedIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , dismissed_review :
        { state : String
        , review_id : Int
        , dismissal_message : Maybe String
        , dismissal_commit_id : String
        }
    }


type alias ReviewComment =
    { url : String
    , pull_request_review_id : Maybe Int
    , id : Int
    , node_id : String
    , diff_hunk : String
    , path : String
    , position : Maybe Int
    , original_position : Int
    , commit_id : String
    , original_commit_id : String
    , in_reply_to_id : Int
    , user : Debug.Todo
    , body : String
    , created_at : String
    , updated_at : String
    , html_url : String
    , pull_request_url : String
    , author_association : AuthorAssociation
    , _links : { self : Link, html : Link, pull_request : Link }
    , body_text : String
    , body_html : String
    , reactions : ReactionRollup
    , side : String
    , start_side : Maybe String
    , line : Int
    , original_line : Int
    , start_line : Maybe Int
    , original_start_line : Maybe Int
    }


type alias RepositorySubscription =
    { subscribed : Bool
    , ignored : Bool
    , reason : Maybe String
    , created_at : String
    , url : String
    , repository_url : String
    }


type alias RepositoryInvitation =
    { id : Int
    , repository : MinimalRepository
    , invitee : Debug.Todo
    , inviter : Debug.Todo
    , permissions : String
    , created_at : String
    , expired : Bool
    , url : String
    , html_url : String
    , node_id : String
    }


type alias RepositoryCollaboratorPermission =
    { permission : String, role_name : String, user : Debug.Todo }


type alias Repository =
    { id : Int
    , node_id : String
    , name : String
    , full_name : String
    , license : Debug.Todo
    , organization : Debug.Todo
    , forks : Int
    , permissions :
        { admin : Bool
        , pull : Bool
        , triage : Bool
        , push : Bool
        , maintain : Bool
        }
    , owner : SimpleUser
    , private : Bool
    , html_url : String
    , description : Maybe String
    , fork : Bool
    , url : String
    , archive_url : String
    , assignees_url : String
    , blobs_url : String
    , branches_url : String
    , collaborators_url : String
    , comments_url : String
    , commits_url : String
    , compare_url : String
    , contents_url : String
    , contributors_url : String
    , deployments_url : String
    , downloads_url : String
    , events_url : String
    , forks_url : String
    , git_commits_url : String
    , git_refs_url : String
    , git_tags_url : String
    , git_url : String
    , issue_comment_url : String
    , issue_events_url : String
    , issues_url : String
    , keys_url : String
    , labels_url : String
    , languages_url : String
    , merges_url : String
    , milestones_url : String
    , notifications_url : String
    , pulls_url : String
    , releases_url : String
    , ssh_url : String
    , stargazers_url : String
    , statuses_url : String
    , subscribers_url : String
    , subscription_url : String
    , tags_url : String
    , teams_url : String
    , trees_url : String
    , clone_url : String
    , mirror_url : Maybe String
    , hooks_url : String
    , svn_url : String
    , homepage : Maybe String
    , language : Maybe String
    , forks_count : Int
    , stargazers_count : Int
    , watchers_count : Int
    , size : Int
    , default_branch : String
    , open_issues_count : Int
    , is_template : Bool
    , topics : List String
    , has_issues : Bool
    , has_projects : Bool
    , has_wiki : Bool
    , has_pages : Bool
    , has_downloads : Bool
    , archived : Bool
    , disabled : Bool
    , visibility : String
    , pushed_at : Maybe String
    , created_at : Maybe String
    , updated_at : Maybe String
    , allow_rebase_merge : Bool
    , template_repository :
        Maybe { id : Int
        , node_id : String
        , name : String
        , full_name : String
        , owner :
            { login : String
            , id : Int
            , node_id : String
            , avatar_url : String
            , gravatar_id : String
            , url : String
            , html_url : String
            , followers_url : String
            , following_url : String
            , gists_url : String
            , starred_url : String
            , subscriptions_url : String
            , organizations_url : String
            , repos_url : String
            , events_url : String
            , received_events_url : String
            , type_ : String
            , site_admin : Bool
            }
        , private : Bool
        , html_url : String
        , description : String
        , fork : Bool
        , url : String
        , archive_url : String
        , assignees_url : String
        , blobs_url : String
        , branches_url : String
        , collaborators_url : String
        , comments_url : String
        , commits_url : String
        , compare_url : String
        , contents_url : String
        , contributors_url : String
        , deployments_url : String
        , downloads_url : String
        , events_url : String
        , forks_url : String
        , git_commits_url : String
        , git_refs_url : String
        , git_tags_url : String
        , git_url : String
        , issue_comment_url : String
        , issue_events_url : String
        , issues_url : String
        , keys_url : String
        , labels_url : String
        , languages_url : String
        , merges_url : String
        , milestones_url : String
        , notifications_url : String
        , pulls_url : String
        , releases_url : String
        , ssh_url : String
        , stargazers_url : String
        , statuses_url : String
        , subscribers_url : String
        , subscription_url : String
        , tags_url : String
        , teams_url : String
        , trees_url : String
        , clone_url : String
        , mirror_url : String
        , hooks_url : String
        , svn_url : String
        , homepage : String
        , language : String
        , forks_count : Int
        , stargazers_count : Int
        , watchers_count : Int
        , size : Int
        , default_branch : String
        , open_issues_count : Int
        , is_template : Bool
        , topics : List String
        , has_issues : Bool
        , has_projects : Bool
        , has_wiki : Bool
        , has_pages : Bool
        , has_downloads : Bool
        , archived : Bool
        , disabled : Bool
        , visibility : String
        , pushed_at : String
        , created_at : String
        , updated_at : String
        , permissions :
            { admin : Bool
            , maintain : Bool
            , push : Bool
            , triage : Bool
            , pull : Bool
            }
        , allow_rebase_merge : Bool
        , temp_clone_token : String
        , allow_squash_merge : Bool
        , allow_auto_merge : Bool
        , delete_branch_on_merge : Bool
        , allow_update_branch : Bool
        , use_squash_pr_title_as_default : Bool
        , squash_merge_commit_title : String
        , squash_merge_commit_message : String
        , merge_commit_title : String
        , merge_commit_message : String
        , allow_merge_commit : Bool
        , subscribers_count : Int
        , network_count : Int
        }
    , temp_clone_token : String
    , allow_squash_merge : Bool
    , allow_auto_merge : Bool
    , delete_branch_on_merge : Bool
    , allow_update_branch : Bool
    , use_squash_pr_title_as_default : Bool
    , squash_merge_commit_title : String
    , squash_merge_commit_message : String
    , merge_commit_title : String
    , merge_commit_message : String
    , allow_merge_commit : Bool
    , allow_forking : Bool
    , web_commit_signoff_required : Bool
    , subscribers_count : Int
    , network_count : Int
    , open_issues : Int
    , watchers : Int
    , master_branch : String
    , starred_at : String
    , anonymous_access_enabled : Bool
    }


type alias RepoSearchResultItem =
    { id : Int
    , node_id : String
    , name : String
    , full_name : String
    , owner : Debug.Todo
    , private : Bool
    , html_url : String
    , description : Maybe String
    , fork : Bool
    , url : String
    , created_at : String
    , updated_at : String
    , pushed_at : String
    , homepage : Maybe String
    , size : Int
    , stargazers_count : Int
    , watchers_count : Int
    , language : Maybe String
    , forks_count : Int
    , open_issues_count : Int
    , master_branch : String
    , default_branch : String
    , score : Float
    , forks_url : String
    , keys_url : String
    , collaborators_url : String
    , teams_url : String
    , hooks_url : String
    , issue_events_url : String
    , events_url : String
    , assignees_url : String
    , branches_url : String
    , tags_url : String
    , blobs_url : String
    , git_tags_url : String
    , git_refs_url : String
    , trees_url : String
    , statuses_url : String
    , languages_url : String
    , stargazers_url : String
    , contributors_url : String
    , subscribers_url : String
    , subscription_url : String
    , commits_url : String
    , git_commits_url : String
    , comments_url : String
    , issue_comment_url : String
    , contents_url : String
    , compare_url : String
    , merges_url : String
    , archive_url : String
    , downloads_url : String
    , issues_url : String
    , pulls_url : String
    , milestones_url : String
    , notifications_url : String
    , labels_url : String
    , releases_url : String
    , deployments_url : String
    , git_url : String
    , ssh_url : String
    , clone_url : String
    , svn_url : String
    , forks : Int
    , open_issues : Int
    , watchers : Int
    , topics : List String
    , mirror_url : Maybe String
    , has_issues : Bool
    , has_projects : Bool
    , has_pages : Bool
    , has_wiki : Bool
    , has_downloads : Bool
    , archived : Bool
    , disabled : Bool
    , visibility : String
    , license : Debug.Todo
    , permissions :
        { admin : Bool
        , maintain : Bool
        , push : Bool
        , triage : Bool
        , pull : Bool
        }
    , text_matches : SearchResultTextMatches
    , temp_clone_token : String
    , allow_merge_commit : Bool
    , allow_squash_merge : Bool
    , allow_rebase_merge : Bool
    , allow_auto_merge : Bool
    , delete_branch_on_merge : Bool
    , allow_forking : Bool
    , is_template : Bool
    , web_commit_signoff_required : Bool
    }


type alias RepoCodespacesSecret =
    { name : String, created_at : String, updated_at : String }


type alias RenamedIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , rename : { from : String, to : String }
    }


type alias RemovedFromProjectIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , project_card :
        { id : Int
        , url : String
        , project_id : Int
        , project_url : String
        , column_name : String
        , previous_column_name : String
        }
    }


type alias ReleaseNotesContent =
    { name : String, body : String }


type alias ReleaseAsset =
    { url : String
    , browser_download_url : String
    , id : Int
    , node_id : String
    , name : String
    , label : Maybe String
    , state : String
    , content_type : String
    , size : Int
    , download_count : Int
    , created_at : String
    , updated_at : String
    , uploader : Debug.Todo
    }


type alias Release =
    { url : String
    , html_url : String
    , assets_url : String
    , upload_url : String
    , tarball_url : Maybe String
    , zipball_url : Maybe String
    , id : Int
    , node_id : String
    , tag_name : String
    , target_commitish : String
    , name : Maybe String
    , body : Maybe String
    , draft : Bool
    , prerelease : Bool
    , created_at : String
    , published_at : Maybe String
    , author : SimpleUser
    , assets : List ReleaseAsset
    , body_html : String
    , body_text : String
    , mentions_count : Int
    , discussion_url : String
    , reactions : ReactionRollup
    }


type alias ReferrerTraffic =
    { referrer : String, count : Int, uniques : Int }


type alias ReferencedWorkflow =
    { path : String, sha : String, ref : String }


type alias ReactionRollup =
    { url : String
    , total_count : Int
    , +1 : Int
    , -1 : Int
    , laugh : Int
    , confused : Int
    , heart : Int
    , hooray : Int
    , eyes : Int
    , rocket : Int
    }


type alias Reaction =
    { id : Int
    , node_id : String
    , user : Debug.Todo
    , content : String
    , created_at : String
    }


type alias RateLimitOverview =
    { resources :
        { core : RateLimit
        , graphql : RateLimit
        , search : RateLimit
        , source_import : RateLimit
        , integration_manifest : RateLimit
        , code_scanning_upload : RateLimit
        , actions_runner_registration : RateLimit
        , scim : RateLimit
        , dependency_snapshots : RateLimit
        }
    , rate : RateLimit
    }


type alias RateLimit =
    { limit : Int, remaining : Int, reset : Int, used : Int }


type alias PullRequestSimple =
    { url : String
    , id : Int
    , node_id : String
    , html_url : String
    , diff_url : String
    , patch_url : String
    , issue_url : String
    , commits_url : String
    , review_comments_url : String
    , review_comment_url : String
    , comments_url : String
    , statuses_url : String
    , number : Int
    , state : String
    , locked : Bool
    , title : String
    , user : Debug.Todo
    , body : Maybe String
    , labels :
        List { id : Int
        , node_id : String
        , url : String
        , name : String
        , description : String
        , color : String
        , default : Bool
        }
    , milestone : Debug.Todo
    , active_lock_reason : Maybe String
    , created_at : String
    , updated_at : String
    , closed_at : Maybe String
    , merged_at : Maybe String
    , merge_commit_sha : Maybe String
    , assignee : Debug.Todo
    , assignees : Maybe (List SimpleUser)
    , requested_reviewers : Maybe (List SimpleUser)
    , requested_teams : Maybe (List Team)
    , head :
        { label : String
        , ref : String
        , repo : Repository
        , sha : String
        , user : Debug.Todo
        }
    , base :
        { label : String
        , ref : String
        , repo : Repository
        , sha : String
        , user : Debug.Todo
        }
    , _links :
        { comments : Link
        , commits : Link
        , statuses : Link
        , html : Link
        , issue : Link
        , review_comments : Link
        , review_comment : Link
        , self : Link
        }
    , author_association : AuthorAssociation
    , auto_merge : AutoMerge
    , draft : Bool
    }


type alias PullRequestReviewRequest =
    { users : List SimpleUser, teams : List Team }


type alias PullRequestReviewComment =
    { url : String
    , pull_request_review_id : Maybe Int
    , id : Int
    , node_id : String
    , diff_hunk : String
    , path : String
    , position : Int
    , original_position : Int
    , commit_id : String
    , original_commit_id : String
    , in_reply_to_id : Int
    , user : SimpleUser
    , body : String
    , created_at : String
    , updated_at : String
    , html_url : String
    , pull_request_url : String
    , author_association : AuthorAssociation
    , _links :
        { self : { href : String }
        , html : { href : String }
        , pull_request : { href : String }
        }
    , start_line : Maybe Int
    , original_start_line : Maybe Int
    , start_side : Maybe String
    , line : Int
    , original_line : Int
    , side : String
    , reactions : ReactionRollup
    , body_html : String
    , body_text : String
    }


type alias PullRequestReview =
    { id : Int
    , node_id : String
    , user : Debug.Todo
    , body : String
    , state : String
    , html_url : String
    , pull_request_url : String
    , _links : { html : { href : String }, pull_request : { href : String } }
    , submitted_at : String
    , commit_id : String
    , body_html : String
    , body_text : String
    , author_association : AuthorAssociation
    }


type alias PullRequestMinimal =
    { id : Int
    , number : Int
    , url : String
    , head :
        { ref : String
        , sha : String
        , repo : { id : Int, url : String, name : String }
        }
    , base :
        { ref : String
        , sha : String
        , repo : { id : Int, url : String, name : String }
        }
    }


type alias PullRequestMergeResult =
    { sha : String, merged : Bool, message : String }


type alias PullRequest =
    { url : String
    , id : Int
    , node_id : String
    , html_url : String
    , diff_url : String
    , patch_url : String
    , issue_url : String
    , commits_url : String
    , review_comments_url : String
    , review_comment_url : String
    , comments_url : String
    , statuses_url : String
    , number : Int
    , state : String
    , locked : Bool
    , title : String
    , user : Debug.Todo
    , body : Maybe String
    , labels :
        List { id : Int
        , node_id : String
        , url : String
        , name : String
        , description : Maybe String
        , color : String
        , default : Bool
        }
    , milestone : Debug.Todo
    , active_lock_reason : Maybe String
    , created_at : String
    , updated_at : String
    , closed_at : Maybe String
    , merged_at : Maybe String
    , merge_commit_sha : Maybe String
    , assignee : Debug.Todo
    , assignees : Maybe (List SimpleUser)
    , requested_reviewers : Maybe (List SimpleUser)
    , requested_teams : Maybe (List TeamSimple)
    , head :
        { label : String
        , ref : String
        , repo :
            Maybe { archive_url : String
            , assignees_url : String
            , blobs_url : String
            , branches_url : String
            , collaborators_url : String
            , comments_url : String
            , commits_url : String
            , compare_url : String
            , contents_url : String
            , contributors_url : String
            , deployments_url : String
            , description : Maybe String
            , downloads_url : String
            , events_url : String
            , fork : Bool
            , forks_url : String
            , full_name : String
            , git_commits_url : String
            , git_refs_url : String
            , git_tags_url : String
            , hooks_url : String
            , html_url : String
            , id : Int
            , node_id : String
            , issue_comment_url : String
            , issue_events_url : String
            , issues_url : String
            , keys_url : String
            , labels_url : String
            , languages_url : String
            , merges_url : String
            , milestones_url : String
            , name : String
            , notifications_url : String
            , owner :
                { avatar_url : String
                , events_url : String
                , followers_url : String
                , following_url : String
                , gists_url : String
                , gravatar_id : Maybe String
                , html_url : String
                , id : Int
                , node_id : String
                , login : String
                , organizations_url : String
                , received_events_url : String
                , repos_url : String
                , site_admin : Bool
                , starred_url : String
                , subscriptions_url : String
                , type_ : String
                , url : String
                }
            , private : Bool
            , pulls_url : String
            , releases_url : String
            , stargazers_url : String
            , statuses_url : String
            , subscribers_url : String
            , subscription_url : String
            , tags_url : String
            , teams_url : String
            , trees_url : String
            , url : String
            , clone_url : String
            , default_branch : String
            , forks : Int
            , forks_count : Int
            , git_url : String
            , has_downloads : Bool
            , has_issues : Bool
            , has_projects : Bool
            , has_wiki : Bool
            , has_pages : Bool
            , homepage : Maybe String
            , language : Maybe String
            , master_branch : String
            , archived : Bool
            , disabled : Bool
            , visibility : String
            , mirror_url : Maybe String
            , open_issues : Int
            , open_issues_count : Int
            , permissions :
                { admin : Bool
                , maintain : Bool
                , push : Bool
                , triage : Bool
                , pull : Bool
                }
            , temp_clone_token : String
            , allow_merge_commit : Bool
            , allow_squash_merge : Bool
            , allow_rebase_merge : Bool
            , license :
                Maybe { key : String
                , name : String
                , url : Maybe String
                , spdx_id : Maybe String
                , node_id : String
                }
            , pushed_at : String
            , size : Int
            , ssh_url : String
            , stargazers_count : Int
            , svn_url : String
            , topics : List String
            , watchers : Int
            , watchers_count : Int
            , created_at : String
            , updated_at : String
            , allow_forking : Bool
            , is_template : Bool
            , web_commit_signoff_required : Bool
            }
        , sha : String
        , user :
            { avatar_url : String
            , events_url : String
            , followers_url : String
            , following_url : String
            , gists_url : String
            , gravatar_id : Maybe String
            , html_url : String
            , id : Int
            , node_id : String
            , login : String
            , organizations_url : String
            , received_events_url : String
            , repos_url : String
            , site_admin : Bool
            , starred_url : String
            , subscriptions_url : String
            , type_ : String
            , url : String
            }
        }
    , base :
        { label : String
        , ref : String
        , repo :
            { archive_url : String
            , assignees_url : String
            , blobs_url : String
            , branches_url : String
            , collaborators_url : String
            , comments_url : String
            , commits_url : String
            , compare_url : String
            , contents_url : String
            , contributors_url : String
            , deployments_url : String
            , description : Maybe String
            , downloads_url : String
            , events_url : String
            , fork : Bool
            , forks_url : String
            , full_name : String
            , git_commits_url : String
            , git_refs_url : String
            , git_tags_url : String
            , hooks_url : String
            , html_url : String
            , id : Int
            , is_template : Bool
            , node_id : String
            , issue_comment_url : String
            , issue_events_url : String
            , issues_url : String
            , keys_url : String
            , labels_url : String
            , languages_url : String
            , merges_url : String
            , milestones_url : String
            , name : String
            , notifications_url : String
            , owner :
                { avatar_url : String
                , events_url : String
                , followers_url : String
                , following_url : String
                , gists_url : String
                , gravatar_id : Maybe String
                , html_url : String
                , id : Int
                , node_id : String
                , login : String
                , organizations_url : String
                , received_events_url : String
                , repos_url : String
                , site_admin : Bool
                , starred_url : String
                , subscriptions_url : String
                , type_ : String
                , url : String
                }
            , private : Bool
            , pulls_url : String
            , releases_url : String
            , stargazers_url : String
            , statuses_url : String
            , subscribers_url : String
            , subscription_url : String
            , tags_url : String
            , teams_url : String
            , trees_url : String
            , url : String
            , clone_url : String
            , default_branch : String
            , forks : Int
            , forks_count : Int
            , git_url : String
            , has_downloads : Bool
            , has_issues : Bool
            , has_projects : Bool
            , has_wiki : Bool
            , has_pages : Bool
            , homepage : Maybe String
            , language : Maybe String
            , master_branch : String
            , archived : Bool
            , disabled : Bool
            , visibility : String
            , mirror_url : Maybe String
            , open_issues : Int
            , open_issues_count : Int
            , permissions :
                { admin : Bool
                , maintain : Bool
                , push : Bool
                , triage : Bool
                , pull : Bool
                }
            , temp_clone_token : String
            , allow_merge_commit : Bool
            , allow_squash_merge : Bool
            , allow_rebase_merge : Bool
            , license : Debug.Todo
            , pushed_at : String
            , size : Int
            , ssh_url : String
            , stargazers_count : Int
            , svn_url : String
            , topics : List String
            , watchers : Int
            , watchers_count : Int
            , created_at : String
            , updated_at : String
            , allow_forking : Bool
            , web_commit_signoff_required : Bool
            }
        , sha : String
        , user :
            { avatar_url : String
            , events_url : String
            , followers_url : String
            , following_url : String
            , gists_url : String
            , gravatar_id : Maybe String
            , html_url : String
            , id : Int
            , node_id : String
            , login : String
            , organizations_url : String
            , received_events_url : String
            , repos_url : String
            , site_admin : Bool
            , starred_url : String
            , subscriptions_url : String
            , type_ : String
            , url : String
            }
        }
    , _links :
        { comments : Link
        , commits : Link
        , statuses : Link
        , html : Link
        , issue : Link
        , review_comments : Link
        , review_comment : Link
        , self : Link
        }
    , author_association : AuthorAssociation
    , auto_merge : AutoMerge
    , draft : Bool
    , merged : Bool
    , mergeable : Maybe Bool
    , rebaseable : Maybe Bool
    , mergeable_state : String
    , merged_by : Debug.Todo
    , comments : Int
    , review_comments : Int
    , maintainer_can_modify : Bool
    , commits : Int
    , additions : Int
    , deletions : Int
    , changed_files : Int
    }


type alias PublicUser =
    { login : String
    , id : Int
    , node_id : String
    , avatar_url : String
    , gravatar_id : Maybe String
    , url : String
    , html_url : String
    , followers_url : String
    , following_url : String
    , gists_url : String
    , starred_url : String
    , subscriptions_url : String
    , organizations_url : String
    , repos_url : String
    , events_url : String
    , received_events_url : String
    , type_ : String
    , site_admin : Bool
    , name : Maybe String
    , company : Maybe String
    , blog : Maybe String
    , location : Maybe String
    , email : Maybe String
    , hireable : Maybe Bool
    , bio : Maybe String
    , twitter_username : Maybe String
    , public_repos : Int
    , public_gists : Int
    , followers : Int
    , following : Int
    , created_at : String
    , updated_at : String
    , plan :
        { collaborators : Int, name : String, space : Int, private_repos : Int }
    , suspended_at : Maybe String
    , private_gists : Int
    , total_private_repos : Int
    , owned_private_repos : Int
    , disk_usage : Int
    , collaborators : Int
    }


type alias ProtectedBranchRequiredStatusCheck =
    { url : String
    , enforcement_level : String
    , contexts : List String
    , checks : List { context : String, app_id : Maybe Int }
    , contexts_url : String
    , strict : Bool
    }


type alias ProtectedBranchPullRequestReview =
    { url : String
    , dismissal_restrictions :
        { users : List SimpleUser
        , teams : List Team
        , apps : List Integration
        , url : String
        , users_url : String
        , teams_url : String
        }
    , bypass_pull_request_allowances :
        { users : List SimpleUser, teams : List Team, apps : List Integration }
    , dismiss_stale_reviews : Bool
    , require_code_owner_reviews : Bool
    , required_approving_review_count : Int
    }


type alias ProtectedBranchAdminEnforced =
    { url : String, enabled : Bool }


type alias ProtectedBranch =
    { url : String
    , required_status_checks : StatusCheckPolicy
    , required_pull_request_reviews :
        { url : String
        , dismiss_stale_reviews : Bool
        , require_code_owner_reviews : Bool
        , required_approving_review_count : Int
        , dismissal_restrictions :
            { url : String
            , users_url : String
            , teams_url : String
            , users : List SimpleUser
            , teams : List Team
            , apps : List Integration
            }
        , bypass_pull_request_allowances :
            { users : List SimpleUser
            , teams : List Team
            , apps : List Integration
            }
        }
    , required_signatures : { url : String, enabled : Bool }
    , enforce_admins : { url : String, enabled : Bool }
    , required_linear_history : { enabled : Bool }
    , allow_force_pushes : { enabled : Bool }
    , allow_deletions : { enabled : Bool }
    , restrictions : BranchRestrictionPolicy
    , required_conversation_resolution : { enabled : Bool }
    , block_creations : { enabled : Bool }
    }


type alias ProjectColumn =
    { url : String
    , project_url : String
    , cards_url : String
    , id : Int
    , node_id : String
    , name : String
    , created_at : String
    , updated_at : String
    }


type alias ProjectCollaboratorPermission =
    { permission : String, user : Debug.Todo }


type alias ProjectCard =
    { url : String
    , id : Int
    , node_id : String
    , note : Maybe String
    , creator : Debug.Todo
    , created_at : String
    , updated_at : String
    , archived : Bool
    , column_name : String
    , project_id : String
    , column_url : String
    , content_url : String
    , project_url : String
    }


type alias Project =
    { owner_url : String
    , url : String
    , html_url : String
    , columns_url : String
    , id : Int
    , node_id : String
    , name : String
    , body : Maybe String
    , number : Int
    , state : String
    , creator : Debug.Todo
    , created_at : String
    , updated_at : String
    , organization_permission : String
    , private : Bool
    }


type alias PrivateUser =
    { login : String
    , id : Int
    , node_id : String
    , avatar_url : String
    , gravatar_id : Maybe String
    , url : String
    , html_url : String
    , followers_url : String
    , following_url : String
    , gists_url : String
    , starred_url : String
    , subscriptions_url : String
    , organizations_url : String
    , repos_url : String
    , events_url : String
    , received_events_url : String
    , type_ : String
    , site_admin : Bool
    , name : Maybe String
    , company : Maybe String
    , blog : Maybe String
    , location : Maybe String
    , email : Maybe String
    , hireable : Maybe Bool
    , bio : Maybe String
    , twitter_username : Maybe String
    , public_repos : Int
    , public_gists : Int
    , followers : Int
    , following : Int
    , created_at : String
    , updated_at : String
    , private_gists : Int
    , total_private_repos : Int
    , owned_private_repos : Int
    , disk_usage : Int
    , collaborators : Int
    , two_factor_authentication : Bool
    , plan :
        { collaborators : Int, name : String, space : Int, private_repos : Int }
    , suspended_at : Maybe String
    , business_plus : Bool
    , ldap_dn : String
    }


type alias PorterLargeFile =
    { ref_name : String, path : String, oid : String, size : Int }


type alias PorterAuthor =
    { id : Int
    , remote_id : String
    , remote_name : String
    , email : String
    , name : String
    , url : String
    , import_url : String
    }


type alias PendingDeployment =
    { environment :
        { id : Int
        , node_id : String
        , name : String
        , url : String
        , html_url : String
        }
    , wait_timer : Int
    , wait_timer_started_at : Maybe String
    , current_user_can_approve : Bool
    , reviewers : List { type_ : DeploymentReviewerType, reviewer : Debug.Todo }
    }


type alias ParticipationStats =
    { all : List Int, owner : List Int }


type alias PagesSourceHash =
    { branch : String, path : String }


type alias PagesHttpsCertificate =
    { state : String
    , description : String
    , domains : List String
    , expires_at : String
    }


type alias PagesHealthCheck =
    { domain :
        { host : String
        , uri : String
        , nameservers : String
        , dns_resolves : Bool
        , is_proxied : Maybe Bool
        , is_cloudflare_ip : Maybe Bool
        , is_fastly_ip : Maybe Bool
        , is_old_ip_address : Maybe Bool
        , is_a_record : Maybe Bool
        , has_cname_record : Maybe Bool
        , has_mx_records_present : Maybe Bool
        , is_valid_domain : Bool
        , is_apex_domain : Bool
        , should_be_a_record : Maybe Bool
        , is_cname_to_github_user_domain : Maybe Bool
        , is_cname_to_pages_dot_github_dot_com : Maybe Bool
        , is_cname_to_fastly : Maybe Bool
        , is_pointed_to_github_pages_ip : Maybe Bool
        , is_non_github_pages_ip_present : Maybe Bool
        , is_pages_domain : Bool
        , is_served_by_pages : Maybe Bool
        , is_valid : Bool
        , reason : Maybe String
        , responds_to_https : Bool
        , enforces_https : Bool
        , https_error : Maybe String
        , is_https_eligible : Maybe Bool
        , caa_error : Maybe String
        }
    , alt_domain :
        Maybe { host : String
        , uri : String
        , nameservers : String
        , dns_resolves : Bool
        , is_proxied : Maybe Bool
        , is_cloudflare_ip : Maybe Bool
        , is_fastly_ip : Maybe Bool
        , is_old_ip_address : Maybe Bool
        , is_a_record : Maybe Bool
        , has_cname_record : Maybe Bool
        , has_mx_records_present : Maybe Bool
        , is_valid_domain : Bool
        , is_apex_domain : Bool
        , should_be_a_record : Maybe Bool
        , is_cname_to_github_user_domain : Maybe Bool
        , is_cname_to_pages_dot_github_dot_com : Maybe Bool
        , is_cname_to_fastly : Maybe Bool
        , is_pointed_to_github_pages_ip : Maybe Bool
        , is_non_github_pages_ip_present : Maybe Bool
        , is_pages_domain : Bool
        , is_served_by_pages : Maybe Bool
        , is_valid : Bool
        , reason : Maybe String
        , responds_to_https : Bool
        , enforces_https : Bool
        , https_error : Maybe String
        , is_https_eligible : Maybe Bool
        , caa_error : Maybe String
        }
    }


type alias PageDeployment =
    { status_url : String, page_url : String, preview_url : String }


type alias PageBuildStatus =
    { url : String, status : String }


type alias PageBuild =
    { url : String
    , status : String
    , error : { message : Maybe String }
    , pusher : Debug.Todo
    , commit : String
    , duration : Int
    , created_at : String
    , updated_at : String
    }


type alias Page =
    { url : String
    , status : Maybe String
    , cname : Maybe String
    , protected_domain_state : Maybe String
    , pending_domain_unverified_at : Maybe String
    , custom_404 : Bool
    , html_url : String
    , build_type : Maybe String
    , source : PagesSourceHash
    , public : Bool
    , https_certificate : PagesHttpsCertificate
    , https_enforced : Bool
    }


type alias PackagesBillingUsage =
    { total_gigabytes_bandwidth_used : Int
    , total_paid_gigabytes_bandwidth_used : Int
    , included_gigabytes_bandwidth : Int
    }


type alias PackageVersion =
    { id : Int
    , name : String
    , url : String
    , package_html_url : String
    , html_url : String
    , license : String
    , description : String
    , created_at : String
    , updated_at : String
    , deleted_at : String
    , metadata :
        { package_type : String
        , container : { tags : List String }
        , docker : { tag : List String }
        }
    }


type alias Package =
    { id : Int
    , name : String
    , package_type : String
    , url : String
    , html_url : String
    , version_count : Int
    , visibility : String
    , owner : Debug.Todo
    , repository : Debug.Todo
    , created_at : String
    , updated_at : String
    }


type alias OrganizationSimple =
    { login : String
    , id : Int
    , node_id : String
    , url : String
    , repos_url : String
    , events_url : String
    , hooks_url : String
    , issues_url : String
    , members_url : String
    , public_members_url : String
    , avatar_url : String
    , description : Maybe String
    }


type alias OrganizationSecretScanningAlert =
    { number : AlertNumber
    , created_at : AlertCreatedAt
    , updated_at : Debug.Todo
    , url : AlertUrl
    , html_url : AlertHtmlUrl
    , locations_url : String
    , state : SecretScanningAlertState
    , resolution : SecretScanningAlertResolution
    , resolved_at : Maybe String
    , resolved_by : Debug.Todo
    , secret_type : String
    , secret_type_display_name : String
    , secret : String
    , repository : SimpleRepository
    , push_protection_bypassed : Maybe Bool
    , push_protection_bypassed_by : Debug.Todo
    , push_protection_bypassed_at : Maybe String
    , resolution_comment : Maybe String
    }


type alias OrganizationInvitation =
    { id : Int
    , login : Maybe String
    , email : Maybe String
    , role : String
    , created_at : String
    , failed_at : Maybe String
    , failed_reason : Maybe String
    , inviter : SimpleUser
    , team_count : Int
    , node_id : String
    , invitation_teams_url : String
    }


type alias OrganizationFull =
    { login : String
    , id : Int
    , node_id : String
    , url : String
    , repos_url : String
    , events_url : String
    , hooks_url : String
    , issues_url : String
    , members_url : String
    , public_members_url : String
    , avatar_url : String
    , description : Maybe String
    , name : String
    , company : String
    , blog : String
    , location : String
    , email : String
    , twitter_username : Maybe String
    , is_verified : Bool
    , has_organization_projects : Bool
    , has_repository_projects : Bool
    , public_repos : Int
    , public_gists : Int
    , followers : Int
    , following : Int
    , html_url : String
    , created_at : String
    , type_ : String
    , total_private_repos : Int
    , owned_private_repos : Int
    , private_gists : Maybe Int
    , disk_usage : Maybe Int
    , collaborators : Maybe Int
    , billing_email : Maybe String
    , plan :
        { name : String
        , space : Int
        , private_repos : Int
        , filled_seats : Int
        , seats : Int
        }
    , default_repository_permission : Maybe String
    , members_can_create_repositories : Maybe Bool
    , two_factor_requirement_enabled : Maybe Bool
    , members_allowed_repository_creation_type : String
    , members_can_create_public_repositories : Bool
    , members_can_create_private_repositories : Bool
    , members_can_create_internal_repositories : Bool
    , members_can_create_pages : Bool
    , members_can_create_public_pages : Bool
    , members_can_create_private_pages : Bool
    , members_can_fork_private_repositories : Maybe Bool
    , web_commit_signoff_required : Bool
    , updated_at : String
    , advanced_security_enabled_for_new_repositories : Bool
    , dependabot_alerts_enabled_for_new_repositories : Bool
    , dependabot_security_updates_enabled_for_new_repositories : Bool
    , dependency_graph_enabled_for_new_repositories : Bool
    , secret_scanning_enabled_for_new_repositories : Bool
    , secret_scanning_push_protection_enabled_for_new_repositories : Bool
    }


type alias OrganizationFineGrainedPermission =
    { name : String, description : String }


type alias OrganizationDependabotSecret =
    { name : String
    , created_at : String
    , updated_at : String
    , visibility : String
    , selected_repositories_url : String
    }


type alias OrganizationCustomRepositoryRole =
    { id : Int
    , name : String
    , description : Maybe String
    , base_role : String
    , permissions : List String
    , organization : SimpleUser
    , created_at : String
    , updated_at : String
    }


type alias OrganizationActionsSecret =
    { name : String
    , created_at : String
    , updated_at : String
    , visibility : String
    , selected_repositories_url : String
    }


type alias OrgMembership =
    { url : String
    , state : String
    , role : String
    , organization_url : String
    , organization : OrganizationSimple
    , user : Debug.Todo
    , permissions : { can_create_repository : Bool }
    }


type alias OrgHook =
    { id : Int
    , url : String
    , ping_url : String
    , deliveries_url : String
    , name : String
    , events : List String
    , active : Bool
    , config :
        { url : String
        , insecure_ssl : String
        , content_type : String
        , secret : String
        }
    , updated_at : String
    , created_at : String
    , type_ : String
    }


type alias MovedColumnInProjectIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , project_card :
        { id : Int
        , url : String
        , project_id : Int
        , project_url : String
        , column_name : String
        , previous_column_name : String
        }
    }


type alias MinimalRepository =
    { id : Int
    , node_id : String
    , name : String
    , full_name : String
    , owner : SimpleUser
    , private : Bool
    , html_url : String
    , description : Maybe String
    , fork : Bool
    , url : String
    , archive_url : String
    , assignees_url : String
    , blobs_url : String
    , branches_url : String
    , collaborators_url : String
    , comments_url : String
    , commits_url : String
    , compare_url : String
    , contents_url : String
    , contributors_url : String
    , deployments_url : String
    , downloads_url : String
    , events_url : String
    , forks_url : String
    , git_commits_url : String
    , git_refs_url : String
    , git_tags_url : String
    , git_url : String
    , issue_comment_url : String
    , issue_events_url : String
    , issues_url : String
    , keys_url : String
    , labels_url : String
    , languages_url : String
    , merges_url : String
    , milestones_url : String
    , notifications_url : String
    , pulls_url : String
    , releases_url : String
    , ssh_url : String
    , stargazers_url : String
    , statuses_url : String
    , subscribers_url : String
    , subscription_url : String
    , tags_url : String
    , teams_url : String
    , trees_url : String
    , clone_url : String
    , mirror_url : Maybe String
    , hooks_url : String
    , svn_url : String
    , homepage : Maybe String
    , language : Maybe String
    , forks_count : Int
    , stargazers_count : Int
    , watchers_count : Int
    , size : Int
    , default_branch : String
    , open_issues_count : Int
    , is_template : Bool
    , topics : List String
    , has_issues : Bool
    , has_projects : Bool
    , has_wiki : Bool
    , has_pages : Bool
    , has_downloads : Bool
    , archived : Bool
    , disabled : Bool
    , visibility : String
    , pushed_at : Maybe String
    , created_at : Maybe String
    , updated_at : Maybe String
    , permissions :
        { admin : Bool
        , maintain : Bool
        , push : Bool
        , triage : Bool
        , pull : Bool
        }
    , role_name : String
    , temp_clone_token : String
    , delete_branch_on_merge : Bool
    , subscribers_count : Int
    , network_count : Int
    , code_of_conduct : CodeOfConduct
    , license :
        Maybe { key : String
        , name : String
        , spdx_id : String
        , url : String
        , node_id : String
        }
    , forks : Int
    , open_issues : Int
    , watchers : Int
    , allow_forking : Bool
    , web_commit_signoff_required : Bool
    }


type alias MilestonedIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , milestone : { title : String }
    }


type alias Milestone =
    { url : String
    , html_url : String
    , labels_url : String
    , id : Int
    , node_id : String
    , number : Int
    , state : String
    , title : String
    , description : Maybe String
    , creator : Debug.Todo
    , open_issues : Int
    , closed_issues : Int
    , created_at : String
    , updated_at : String
    , closed_at : Maybe String
    , due_on : Maybe String
    }


type alias Migration =
    { id : Int
    , owner : Debug.Todo
    , guid : String
    , state : String
    , lock_repositories : Bool
    , exclude_metadata : Bool
    , exclude_git_data : Bool
    , exclude_attachments : Bool
    , exclude_releases : Bool
    , exclude_owner_projects : Bool
    , org_metadata_only : Bool
    , repositories : List Repository
    , url : String
    , created_at : String
    , updated_at : String
    , node_id : String
    , archive_url : String
    , exclude : List Json.Encode.Value
    }


type alias Metadata =
    {}


type alias MergedUpstream =
    { message : String, merge_type : String, base_branch : String }


type alias MarketplacePurchase =
    { url : String
    , type_ : String
    , id : Int
    , login : String
    , organization_billing_email : String
    , email : Maybe String
    , marketplace_pending_change :
        Maybe { is_installed : Bool
        , effective_date : String
        , unit_count : Maybe Int
        , id : Int
        , plan : MarketplaceListingPlan
        }
    , marketplace_purchase :
        { billing_cycle : String
        , next_billing_date : Maybe String
        , is_installed : Bool
        , unit_count : Maybe Int
        , on_free_trial : Bool
        , free_trial_ends_on : Maybe String
        , updated_at : String
        , plan : MarketplaceListingPlan
        }
    }


type alias MarketplaceListingPlan =
    { url : String
    , accounts_url : String
    , id : Int
    , number : Int
    , name : String
    , description : String
    , monthly_price_in_cents : Int
    , yearly_price_in_cents : Int
    , price_model : String
    , has_free_trial : Bool
    , unit_name : Maybe String
    , state : String
    , bullets : List String
    }


type alias MarketplaceAccount =
    { url : String
    , id : Int
    , type_ : String
    , node_id : String
    , login : String
    , email : Maybe String
    , organization_billing_email : Maybe String
    }


type alias Manifest =
    { name : String
    , file : { source_location : String }
    , metadata : Metadata
    , resolved : {}
    }


type alias LockedIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , lock_reason : Maybe String
    }


type alias LinkWithType =
    { href : String, type_ : String }


type alias Link =
    { href : String }


type alias LicenseSimple =
    { key : String
    , name : String
    , url : Maybe String
    , spdx_id : Maybe String
    , node_id : String
    , html_url : String
    }


type alias LicenseContent =
    { name : String
    , path : String
    , sha : String
    , size : Int
    , url : String
    , html_url : Maybe String
    , git_url : Maybe String
    , download_url : Maybe String
    , type_ : String
    , content : String
    , encoding : String
    , _links : { git : Maybe String, html : Maybe String, self : String }
    , license : Debug.Todo
    }


type alias License =
    { key : String
    , name : String
    , spdx_id : Maybe String
    , url : Maybe String
    , node_id : String
    , html_url : String
    , description : String
    , implementation : String
    , permissions : List String
    , conditions : List String
    , limitations : List String
    , body : String
    , featured : Bool
    }


type alias Language =
    {}


type alias LabeledIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , label : { name : String, color : String }
    }


type alias LabelSearchResultItem =
    { id : Int
    , node_id : String
    , url : String
    , name : String
    , color : String
    , default : Bool
    , description : Maybe String
    , score : Float
    , text_matches : SearchResultTextMatches
    }


type alias Label =
    { id : Int
    , node_id : String
    , url : String
    , name : String
    , description : Maybe String
    , color : String
    , default : Bool
    }


type alias KeySimple =
    { id : Int, key : String }


type alias Key =
    { key : String
    , id : Int
    , url : String
    , title : String
    , created_at : String
    , verified : Bool
    , read_only : Bool
    }


type alias Job =
    { id : Int
    , run_id : Int
    , run_url : String
    , run_attempt : Int
    , node_id : String
    , head_sha : String
    , url : String
    , html_url : Maybe String
    , status : String
    , conclusion : Maybe String
    , started_at : String
    , completed_at : Maybe String
    , name : String
    , steps :
        List { status : String
        , conclusion : Maybe String
        , name : String
        , number : Int
        , started_at : Maybe String
        , completed_at : Maybe String
        }
    , check_run_url : String
    , labels : List String
    , runner_id : Maybe Int
    , runner_name : Maybe String
    , runner_group_id : Maybe Int
    , runner_group_name : Maybe String
    }


type alias IssueSearchResultItem =
    { url : String
    , repository_url : String
    , labels_url : String
    , comments_url : String
    , events_url : String
    , html_url : String
    , id : Int
    , node_id : String
    , number : Int
    , title : String
    , locked : Bool
    , active_lock_reason : Maybe String
    , assignees : Maybe (List SimpleUser)
    , user : Debug.Todo
    , labels :
        List { id : Int
        , node_id : String
        , url : String
        , name : String
        , color : String
        , default : Bool
        , description : Maybe String
        }
    , state : String
    , state_reason : Maybe String
    , assignee : Debug.Todo
    , milestone : Debug.Todo
    , comments : Int
    , created_at : String
    , updated_at : String
    , closed_at : Maybe String
    , text_matches : SearchResultTextMatches
    , pull_request :
        { merged_at : Maybe String
        , diff_url : Maybe String
        , html_url : Maybe String
        , patch_url : Maybe String
        , url : Maybe String
        }
    , body : String
    , score : Float
    , author_association : AuthorAssociation
    , draft : Bool
    , repository : Repository
    , body_html : String
    , body_text : String
    , timeline_url : String
    , performed_via_github_app : Debug.Todo
    , reactions : ReactionRollup
    }


type alias IssueEventRename =
    { from : String, to : String }


type alias IssueEventProjectCard =
    { url : String
    , id : Int
    , project_url : String
    , project_id : Int
    , column_name : String
    , previous_column_name : String
    }


type alias IssueEventMilestone =
    { title : String }


type alias IssueEventLabel =
    { name : Maybe String, color : Maybe String }


type alias IssueEventForIssue =
    Debug.Todo


type alias IssueEventDismissedReview =
    { state : String
    , review_id : Int
    , dismissal_message : Maybe String
    , dismissal_commit_id : Maybe String
    }


type alias IssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : Debug.Todo
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , issue : Debug.Todo
    , label : IssueEventLabel
    , assignee : Debug.Todo
    , assigner : Debug.Todo
    , review_requester : Debug.Todo
    , requested_reviewer : Debug.Todo
    , requested_team : Team
    , dismissed_review : IssueEventDismissedReview
    , milestone : IssueEventMilestone
    , project_card : IssueEventProjectCard
    , rename : IssueEventRename
    , author_association : AuthorAssociation
    , lock_reason : Maybe String
    , performed_via_github_app : Debug.Todo
    }


type alias IssueComment =
    { id : Int
    , node_id : String
    , url : String
    , body : String
    , body_text : String
    , body_html : String
    , html_url : String
    , user : Debug.Todo
    , created_at : String
    , updated_at : String
    , issue_url : String
    , author_association : AuthorAssociation
    , performed_via_github_app : Debug.Todo
    , reactions : ReactionRollup
    }


type alias Issue =
    { id : Int
    , node_id : String
    , url : String
    , repository_url : String
    , labels_url : String
    , comments_url : String
    , events_url : String
    , html_url : String
    , number : Int
    , state : String
    , state_reason : Maybe String
    , title : String
    , body : Maybe String
    , user : Debug.Todo
    , labels : List Json.Encode.Value
    , assignee : Debug.Todo
    , assignees : Maybe (List SimpleUser)
    , milestone : Debug.Todo
    , locked : Bool
    , active_lock_reason : Maybe String
    , comments : Int
    , pull_request :
        { merged_at : Maybe String
        , diff_url : Maybe String
        , html_url : Maybe String
        , patch_url : Maybe String
        , url : Maybe String
        }
    , closed_at : Maybe String
    , created_at : String
    , updated_at : String
    , draft : Bool
    , closed_by : Debug.Todo
    , body_html : String
    , body_text : String
    , timeline_url : String
    , repository : Repository
    , performed_via_github_app : Debug.Todo
    , author_association : AuthorAssociation
    , reactions : ReactionRollup
    }


type alias InteractionLimitResponse =
    { limit : InteractionGroup, origin : String, expires_at : String }


type alias InteractionLimit =
    { limit : InteractionGroup, expiry : InteractionExpiry }


type alias InteractionGroup =
    String


type alias InteractionExpiry =
    String


type alias Integration =
    { id : Int
    , slug : String
    , node_id : String
    , owner : Debug.Todo
    , name : String
    , description : Maybe String
    , external_url : String
    , html_url : String
    , created_at : String
    , updated_at : String
    , permissions :
        { issues : String
        , checks : String
        , metadata : String
        , contents : String
        , deployments : String
        }
    , events : List String
    , installations_count : Int
    , client_id : String
    , client_secret : String
    , webhook_secret : Maybe String
    , pem : String
    }


type alias InstallationToken =
    { token : String
    , expires_at : String
    , permissions : AppPermissions
    , repository_selection : String
    , repositories : List Repository
    , single_file : String
    , has_multiple_single_files : Bool
    , single_file_paths : List String
    }


type alias Installation =
    { id : Int
    , account : Maybe {}
    , repository_selection : String
    , access_tokens_url : String
    , repositories_url : String
    , html_url : String
    , app_id : Int
    , target_id : Int
    , target_type : String
    , permissions : AppPermissions
    , events : List String
    , created_at : String
    , updated_at : String
    , single_file_name : Maybe String
    , has_multiple_single_files : Bool
    , single_file_paths : List String
    , app_slug : String
    , suspended_by : Debug.Todo
    , suspended_at : Maybe String
    , contact_email : Maybe String
    }


type alias Import =
    { vcs : Maybe String
    , use_lfs : Bool
    , vcs_url : String
    , svc_root : String
    , tfvc_project : String
    , status : String
    , status_text : Maybe String
    , failed_step : Maybe String
    , error_message : Maybe String
    , import_percent : Maybe Int
    , commit_count : Maybe Int
    , push_percent : Maybe Int
    , has_large_files : Bool
    , large_files_size : Int
    , large_files_count : Int
    , project_choices :
        List { vcs : String, tfvc_project : String, human_name : String }
    , message : String
    , authors_count : Maybe Int
    , url : String
    , html_url : String
    , authors_url : String
    , repository_url : String
    , svn_root : String
    }


type alias Hovercard =
    { contexts : List { message : String, octicon : String } }


type alias HookResponse =
    { code : Maybe Int, status : Maybe String, message : Maybe String }


type alias HookDeliveryItem =
    { id : Int
    , guid : String
    , delivered_at : String
    , redelivery : Bool
    , duration : Float
    , status : String
    , status_code : Int
    , event : String
    , action : Maybe String
    , installation_id : Maybe Int
    , repository_id : Maybe Int
    }


type alias HookDelivery =
    { id : Int
    , guid : String
    , delivered_at : String
    , redelivery : Bool
    , duration : Float
    , status : String
    , status_code : Int
    , event : String
    , action : Maybe String
    , installation_id : Maybe Int
    , repository_id : Maybe Int
    , url : String
    , request : { headers : Maybe {}, payload : Maybe {} }
    , response : { headers : Maybe {}, payload : Maybe String }
    }


type alias Hook =
    { type_ : String
    , id : Int
    , name : String
    , active : Bool
    , events : List String
    , config :
        { email : String
        , password : String
        , room : String
        , subdomain : String
        , url : WebhookConfigUrl
        , insecure_ssl : WebhookConfigInsecureSsl
        , content_type : WebhookConfigContentType
        , digest : String
        , secret : WebhookConfigSecret
        , token : String
        }
    , updated_at : String
    , created_at : String
    , url : String
    , test_url : String
    , ping_url : String
    , deliveries_url : String
    , last_response : HookResponse
    }


type alias GpgKey =
    { id : Int
    , name : Maybe String
    , primary_key_id : Maybe Int
    , key_id : String
    , public_key : String
    , emails : List { email : String, verified : Bool }
    , subkeys :
        List { id : Int
        , primary_key_id : Int
        , key_id : String
        , public_key : String
        , emails : List Json.Encode.Value
        , subkeys : List Json.Encode.Value
        , can_sign : Bool
        , can_encrypt_comms : Bool
        , can_encrypt_storage : Bool
        , can_certify : Bool
        , created_at : String
        , expires_at : Maybe String
        , raw_key : Maybe String
        , revoked : Bool
        }
    , can_sign : Bool
    , can_encrypt_comms : Bool
    , can_encrypt_storage : Bool
    , can_certify : Bool
    , created_at : String
    , expires_at : Maybe String
    , revoked : Bool
    , raw_key : Maybe String
    }


type alias GitignoreTemplate =
    { name : String, source : String }


type alias GitUser =
    { name : String, email : String, date : String }


type alias GitTree =
    { sha : String
    , url : String
    , truncated : Bool
    , tree :
        List { path : String
        , mode : String
        , type_ : String
        , sha : String
        , size : Int
        , url : String
        }
    }


type alias GitTag =
    { node_id : String
    , tag : String
    , sha : String
    , url : String
    , message : String
    , tagger : { date : String, email : String, name : String }
    , object : { sha : String, type_ : String, url : String }
    , verification : Verification
    }


type alias GitRef =
    { ref : String
    , node_id : String
    , url : String
    , object : { type_ : String, sha : String, url : String }
    }


type alias GitCommit =
    { sha : String
    , node_id : String
    , url : String
    , author : { date : String, email : String, name : String }
    , committer : { date : String, email : String, name : String }
    , message : String
    , tree : { sha : String, url : String }
    , parents : List { sha : String, url : String, html_url : String }
    , verification :
        { verified : Bool
        , reason : String
        , signature : Maybe String
        , payload : Maybe String
        }
    , html_url : String
    }


type alias GistSimple =
    { forks :
        Maybe (List { id : String
        , url : String
        , user : PublicUser
        , created_at : String
        , updated_at : String
        })
    , history : Maybe (List GistHistory)
    , fork_of :
        Maybe { url : String
        , forks_url : String
        , commits_url : String
        , id : String
        , node_id : String
        , git_pull_url : String
        , git_push_url : String
        , html_url : String
        , files : {}
        , public : Bool
        , created_at : String
        , updated_at : String
        , description : Maybe String
        , comments : Int
        , user : Debug.Todo
        , comments_url : String
        , owner : Debug.Todo
        , truncated : Bool
        , forks : List Json.Encode.Value
        , history : List Json.Encode.Value
        }
    , url : String
    , forks_url : String
    , commits_url : String
    , id : String
    , node_id : String
    , git_pull_url : String
    , git_push_url : String
    , html_url : String
    , files : {}
    , public : Bool
    , created_at : String
    , updated_at : String
    , description : Maybe String
    , comments : Int
    , user : Maybe String
    , comments_url : String
    , owner : SimpleUser
    , truncated : Bool
    }


type alias GistHistory =
    { user : Debug.Todo
    , version : String
    , committed_at : String
    , change_status : { total : Int, additions : Int, deletions : Int }
    , url : String
    }


type alias GistCommit =
    { url : String
    , version : String
    , user : Debug.Todo
    , change_status : { total : Int, additions : Int, deletions : Int }
    , committed_at : String
    }


type alias GistComment =
    { id : Int
    , node_id : String
    , url : String
    , body : String
    , user : Debug.Todo
    , created_at : String
    , updated_at : String
    , author_association : AuthorAssociation
    }


type alias FullRepository =
    { id : Int
    , node_id : String
    , name : String
    , full_name : String
    , owner : SimpleUser
    , private : Bool
    , html_url : String
    , description : Maybe String
    , fork : Bool
    , url : String
    , archive_url : String
    , assignees_url : String
    , blobs_url : String
    , branches_url : String
    , collaborators_url : String
    , comments_url : String
    , commits_url : String
    , compare_url : String
    , contents_url : String
    , contributors_url : String
    , deployments_url : String
    , downloads_url : String
    , events_url : String
    , forks_url : String
    , git_commits_url : String
    , git_refs_url : String
    , git_tags_url : String
    , git_url : String
    , issue_comment_url : String
    , issue_events_url : String
    , issues_url : String
    , keys_url : String
    , labels_url : String
    , languages_url : String
    , merges_url : String
    , milestones_url : String
    , notifications_url : String
    , pulls_url : String
    , releases_url : String
    , ssh_url : String
    , stargazers_url : String
    , statuses_url : String
    , subscribers_url : String
    , subscription_url : String
    , tags_url : String
    , teams_url : String
    , trees_url : String
    , clone_url : String
    , mirror_url : Maybe String
    , hooks_url : String
    , svn_url : String
    , homepage : Maybe String
    , language : Maybe String
    , forks_count : Int
    , stargazers_count : Int
    , watchers_count : Int
    , size : Int
    , default_branch : String
    , open_issues_count : Int
    , is_template : Bool
    , topics : List String
    , has_issues : Bool
    , has_projects : Bool
    , has_wiki : Bool
    , has_pages : Bool
    , has_downloads : Bool
    , archived : Bool
    , disabled : Bool
    , visibility : String
    , pushed_at : String
    , created_at : String
    , updated_at : String
    , permissions :
        { admin : Bool
        , maintain : Bool
        , push : Bool
        , triage : Bool
        , pull : Bool
        }
    , allow_rebase_merge : Bool
    , template_repository : Debug.Todo
    , temp_clone_token : Maybe String
    , allow_squash_merge : Bool
    , allow_auto_merge : Bool
    , delete_branch_on_merge : Bool
    , allow_merge_commit : Bool
    , allow_update_branch : Bool
    , use_squash_pr_title_as_default : Bool
    , squash_merge_commit_title : String
    , squash_merge_commit_message : String
    , merge_commit_title : String
    , merge_commit_message : String
    , allow_forking : Bool
    , web_commit_signoff_required : Bool
    , subscribers_count : Int
    , network_count : Int
    , license : Debug.Todo
    , organization : Debug.Todo
    , parent : Repository
    , source : Repository
    , forks : Int
    , master_branch : String
    , open_issues : Int
    , watchers : Int
    , anonymous_access_enabled : Bool
    , code_of_conduct : CodeOfConductSimple
    , security_and_analysis : SecurityAndAnalysis
    }


type alias FileCommit =
    { content :
        Maybe { name : String
        , path : String
        , sha : String
        , size : Int
        , url : String
        , html_url : String
        , git_url : String
        , download_url : String
        , type_ : String
        , _links : { self : String, git : String, html : String }
        }
    , commit :
        { sha : String
        , node_id : String
        , url : String
        , html_url : String
        , author : { date : String, name : String, email : String }
        , committer : { date : String, name : String, email : String }
        , message : String
        , tree : { url : String, sha : String }
        , parents : List { url : String, html_url : String, sha : String }
        , verification :
            { verified : Bool
            , reason : String
            , signature : Maybe String
            , payload : Maybe String
            }
        }
    }


type alias Feed =
    { timeline_url : String
    , user_url : String
    , current_user_public_url : String
    , current_user_url : String
    , current_user_actor_url : String
    , current_user_organization_url : String
    , current_user_organization_urls : List String
    , security_advisories_url : String
    , _links :
        { timeline : LinkWithType
        , user : LinkWithType
        , security_advisories : LinkWithType
        , current_user : LinkWithType
        , current_user_public : LinkWithType
        , current_user_actor : LinkWithType
        , current_user_organization : LinkWithType
        , current_user_organizations : List LinkWithType
        }
    }


type alias Event =
    { id : String
    , type_ : Maybe String
    , actor : Actor
    , repo : { id : Int, name : String, url : String }
    , org : Actor
    , payload :
        { action : String
        , issue : Issue
        , comment : IssueComment
        , pages :
            List { page_name : String
            , title : String
            , summary : Maybe String
            , action : String
            , sha : String
            , html_url : String
            }
        }
    , public : Bool
    , created_at : Maybe String
    }


type alias EnvironmentApprovals =
    { environments :
        List { id : Int
        , node_id : String
        , name : String
        , url : String
        , html_url : String
        , created_at : String
        , updated_at : String
        }
    , state : String
    , user : SimpleUser
    , comment : String
    }


type alias Environment =
    { id : Int
    , node_id : String
    , name : String
    , url : String
    , html_url : String
    , created_at : String
    , updated_at : String
    , protection_rules : List Debug.Todo
    , deployment_branch_policy : DeploymentBranchPolicySettings
    }


type alias Enterprise =
    { description : Maybe String
    , html_url : String
    , website_url : Maybe String
    , id : Int
    , node_id : String
    , name : String
    , slug : String
    , created_at : Maybe String
    , updated_at : Maybe String
    , avatar_url : String
    }


type alias EnabledRepositories =
    String


type alias EnabledOrganizations =
    String


type alias EmptyObject =
    {}


type alias Email =
    { email : String
    , primary : Bool
    , verified : Bool
    , visibility : Maybe String
    }


type alias DiffEntry =
    { sha : String
    , filename : String
    , status : String
    , additions : Int
    , deletions : Int
    , changes : Int
    , blob_url : String
    , raw_url : String
    , contents_url : String
    , patch : String
    , previous_filename : String
    }


type alias DeploymentStatus =
    { url : String
    , id : Int
    , node_id : String
    , state : String
    , creator : Debug.Todo
    , description : String
    , environment : String
    , target_url : String
    , created_at : String
    , updated_at : String
    , deployment_url : String
    , repository_url : String
    , environment_url : String
    , log_url : String
    , performed_via_github_app : Debug.Todo
    }


type alias DeploymentSimple =
    { url : String
    , id : Int
    , node_id : String
    , task : String
    , original_environment : String
    , environment : String
    , description : Maybe String
    , created_at : String
    , updated_at : String
    , statuses_url : String
    , repository_url : String
    , transient_environment : Bool
    , production_environment : Bool
    , performed_via_github_app : Debug.Todo
    }


type alias DeploymentReviewerType =
    String


type alias DeploymentBranchPolicySettings =
    Maybe { protected_branches : Bool, custom_branch_policies : Bool }


type alias DeploymentBranchPolicyNamePattern =
    { name : String }


type alias DeploymentBranchPolicy =
    { id : Int, node_id : String, name : String }


type alias Deployment =
    { url : String
    , id : Int
    , node_id : String
    , sha : String
    , ref : String
    , task : String
    , payload : Json.Encode.Value
    , original_environment : String
    , environment : String
    , description : Maybe String
    , creator : Debug.Todo
    , created_at : String
    , updated_at : String
    , statuses_url : String
    , repository_url : String
    , transient_environment : Bool
    , production_environment : Bool
    , performed_via_github_app : Debug.Todo
    }


type alias DeployKey =
    { id : Int
    , key : String
    , url : String
    , title : String
    , verified : Bool
    , created_at : String
    , read_only : Bool
    , added_by : Maybe String
    , last_used : Maybe String
    }


type alias DependencyGraphDiff =
    List { change_type : String
    , manifest : String
    , ecosystem : String
    , name : String
    , version : String
    , package_url : Maybe String
    , license : Maybe String
    , source_repository_url : Maybe String
    , vulnerabilities :
        List { severity : String
        , advisory_ghsa_id : String
        , advisory_summary : String
        , advisory_url : String
        }
    , scope : String
    }


type alias Dependency =
    { package_url : String
    , metadata : Metadata
    , relationship : String
    , scope : String
    , dependencies : List String
    }


type alias DependabotSecret =
    { name : String, created_at : String, updated_at : String }


type alias DependabotPublicKey =
    { key_id : String, key : String }


type alias DependabotAlertSecurityVulnerability =
    { package : DependabotAlertPackage
    , severity : String
    , vulnerable_version_range : String
    , first_patched_version : Maybe { identifier : String }
    }


type alias DependabotAlertSecurityAdvisory =
    { ghsa_id : String
    , cve_id : Maybe String
    , summary : String
    , description : String
    , vulnerabilities : List DependabotAlertSecurityVulnerability
    , severity : String
    , cvss : { score : Float, vector_string : Maybe String }
    , cwes : List { cwe_id : String, name : String }
    , identifiers : List { type_ : String, value : String }
    , references : List { url : String }
    , published_at : String
    , updated_at : String
    , withdrawn_at : Maybe String
    }


type alias DependabotAlertPackage =
    { ecosystem : String, name : String }


type alias DependabotAlert =
    { number : AlertNumber
    , state : String
    , dependency :
        { package : DependabotAlertPackage
        , manifest_path : String
        , scope : Maybe String
        }
    , security_advisory : DependabotAlertSecurityAdvisory
    , security_vulnerability : DependabotAlertSecurityVulnerability
    , url : AlertUrl
    , html_url : AlertHtmlUrl
    , created_at : AlertCreatedAt
    , updated_at : AlertUpdatedAt
    , dismissed_at : AlertDismissedAt
    , dismissed_by : Debug.Todo
    , dismissed_reason : Maybe String
    , dismissed_comment : Maybe String
    , fixed_at : AlertFixedAt
    }


type alias DemilestonedIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , milestone : { title : String }
    }


type alias ConvertedNoteToIssueIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Integration
    , project_card :
        { id : Int
        , url : String
        , project_id : Int
        , project_url : String
        , column_name : String
        , previous_column_name : String
        }
    }


type alias ContributorActivity =
    { author : Debug.Todo
    , total : Int
    , weeks : List { w : Int, a : Int, d : Int, c : Int }
    }


type alias Contributor =
    { login : String
    , id : Int
    , node_id : String
    , avatar_url : String
    , gravatar_id : Maybe String
    , url : String
    , html_url : String
    , followers_url : String
    , following_url : String
    , gists_url : String
    , starred_url : String
    , subscriptions_url : String
    , organizations_url : String
    , repos_url : String
    , events_url : String
    , received_events_url : String
    , type_ : String
    , site_admin : Bool
    , contributions : Int
    , email : String
    , name : String
    }


type alias ContentTree =
    { type_ : String
    , size : Int
    , name : String
    , path : String
    , sha : String
    , url : String
    , git_url : Maybe String
    , html_url : Maybe String
    , download_url : Maybe String
    , entries :
        List { type_ : String
        , size : Int
        , name : String
        , path : String
        , content : String
        , sha : String
        , url : String
        , git_url : Maybe String
        , html_url : Maybe String
        , download_url : Maybe String
        , _links : { git : Maybe String, html : Maybe String, self : String }
        }
    , _links : { git : Maybe String, html : Maybe String, self : String }
    }


type alias ContentTraffic =
    { path : String, title : String, count : Int, uniques : Int }


type alias ContentSymlink =
    { type_ : String
    , target : String
    , size : Int
    , name : String
    , path : String
    , sha : String
    , url : String
    , git_url : Maybe String
    , html_url : Maybe String
    , download_url : Maybe String
    , _links : { git : Maybe String, html : Maybe String, self : String }
    }


type alias ContentSubmodule =
    { type_ : String
    , submodule_git_url : String
    , size : Int
    , name : String
    , path : String
    , sha : String
    , url : String
    , git_url : Maybe String
    , html_url : Maybe String
    , download_url : Maybe String
    , _links : { git : Maybe String, html : Maybe String, self : String }
    }


type alias ContentFile =
    { type_ : String
    , encoding : String
    , size : Int
    , name : String
    , path : String
    , content : String
    , sha : String
    , url : String
    , git_url : Maybe String
    , html_url : Maybe String
    , download_url : Maybe String
    , _links : { git : Maybe String, html : Maybe String, self : String }
    , target : String
    , submodule_git_url : String
    }


type alias ContentDirectory =
    List { type_ : String
    , size : Int
    , name : String
    , path : String
    , content : String
    , sha : String
    , url : String
    , git_url : Maybe String
    , html_url : Maybe String
    , download_url : Maybe String
    , _links : { git : Maybe String, html : Maybe String, self : String }
    }


type alias CommunityProfile =
    { health_percentage : Int
    , description : Maybe String
    , documentation : Maybe String
    , files :
        { code_of_conduct : Debug.Todo
        , code_of_conduct_file : Debug.Todo
        , license : Debug.Todo
        , contributing : Debug.Todo
        , readme : Debug.Todo
        , issue_template : Debug.Todo
        , pull_request_template : Debug.Todo
        }
    , updated_at : Maybe String
    , content_reports_enabled : Bool
    }


type alias CommunityHealthFile =
    { url : String, html_url : String }


type alias CommitSearchResultItem =
    { url : String
    , sha : String
    , html_url : String
    , comments_url : String
    , commit :
        { author : { name : String, email : String, date : String }
        , committer : Debug.Todo
        , comment_count : Int
        , message : String
        , tree : { sha : String, url : String }
        , url : String
        , verification : Verification
        }
    , author : Debug.Todo
    , committer : Debug.Todo
    , parents : List { url : String, html_url : String, sha : String }
    , repository : MinimalRepository
    , score : Float
    , node_id : String
    , text_matches : SearchResultTextMatches
    }


type alias CommitComparison =
    { url : String
    , html_url : String
    , permalink_url : String
    , diff_url : String
    , patch_url : String
    , base_commit : Commit
    , merge_base_commit : Commit
    , status : String
    , ahead_by : Int
    , behind_by : Int
    , total_commits : Int
    , commits : List Commit
    , files : List DiffEntry
    }


type alias CommitComment =
    { html_url : String
    , url : String
    , id : Int
    , node_id : String
    , body : String
    , path : Maybe String
    , position : Maybe Int
    , line : Maybe Int
    , commit_id : String
    , user : Debug.Todo
    , created_at : String
    , updated_at : String
    , author_association : AuthorAssociation
    , reactions : ReactionRollup
    }


type alias CommitActivity =
    { days : List Int, total : Int, week : Int }


type alias Commit =
    { url : String
    , sha : String
    , node_id : String
    , html_url : String
    , comments_url : String
    , commit :
        { url : String
        , author : Debug.Todo
        , committer : Debug.Todo
        , message : String
        , comment_count : Int
        , tree : { sha : String, url : String }
        , verification : Verification
        }
    , author : Debug.Todo
    , committer : Debug.Todo
    , parents : List { sha : String, url : String, html_url : String }
    , stats : { additions : Int, deletions : Int, total : Int }
    , files : List DiffEntry
    }


type alias CombinedCommitStatus =
    { state : String
    , statuses : List SimpleCommitStatus
    , sha : String
    , total_count : Int
    , repository : MinimalRepository
    , commit_url : String
    , url : String
    }


type alias CombinedBillingUsage =
    { days_left_in_billing_cycle : Int
    , estimated_paid_storage_for_month : Int
    , estimated_storage_for_month : Int
    }


type alias Collaborator =
    { login : String
    , id : Int
    , email : Maybe String
    , name : Maybe String
    , node_id : String
    , avatar_url : String
    , gravatar_id : Maybe String
    , url : String
    , html_url : String
    , followers_url : String
    , following_url : String
    , gists_url : String
    , starred_url : String
    , subscriptions_url : String
    , organizations_url : String
    , repos_url : String
    , events_url : String
    , received_events_url : String
    , type_ : String
    , site_admin : Bool
    , permissions :
        { pull : Bool
        , triage : Bool
        , push : Bool
        , maintain : Bool
        , admin : Bool
        }
    , role_name : String
    }


type alias CodespacesUserPublicKey =
    { key_id : String, key : String }


type alias CodespacesSecret =
    { name : String
    , created_at : String
    , updated_at : String
    , visibility : String
    , selected_repositories_url : String
    }


type alias CodespacesPublicKey =
    { key_id : String
    , key : String
    , id : Int
    , url : String
    , title : String
    , created_at : String
    }


type alias CodespacesOrgSecret =
    { name : String
    , created_at : String
    , updated_at : String
    , visibility : String
    , selected_repositories_url : String
    }


type alias CodespaceMachine =
    { name : String
    , display_name : String
    , operating_system : String
    , storage_in_bytes : Int
    , memory_in_bytes : Int
    , cpus : Int
    , prebuild_availability : Maybe String
    }


type alias CodespaceExportDetails =
    { state : Maybe String
    , completed_at : Maybe String
    , branch : Maybe String
    , sha : Maybe String
    , id : String
    , export_url : String
    , html_url : Maybe String
    }


type alias Codespace =
    { id : Int
    , name : String
    , display_name : Maybe String
    , environment_id : Maybe String
    , owner : SimpleUser
    , billable_owner : SimpleUser
    , repository : MinimalRepository
    , machine : Debug.Todo
    , devcontainer_path : Maybe String
    , prebuild : Maybe Bool
    , created_at : String
    , updated_at : String
    , last_used_at : String
    , state : String
    , url : String
    , git_status :
        { ahead : Int
        , behind : Int
        , has_unpushed_changes : Bool
        , has_uncommitted_changes : Bool
        , ref : String
        }
    , location : String
    , idle_timeout_minutes : Maybe Int
    , web_url : String
    , machines_url : String
    , start_url : String
    , stop_url : String
    , pulls_url : Maybe String
    , recent_folders : List String
    , runtime_constraints :
        { allowed_port_privacy_settings : Maybe (List String) }
    , pending_operation : Maybe Bool
    , pending_operation_disabled_reason : Maybe String
    , idle_timeout_notice : Maybe String
    , retention_period_minutes : Maybe Int
    , retention_expires_at : Maybe String
    , last_known_stop_notice : Maybe String
    }


type alias CodeownersErrors =
    { errors :
        List { line : Int
        , column : Int
        , source : String
        , kind : String
        , suggestion : Maybe String
        , message : String
        , path : String
        }
    }


type alias CodeSearchResultItem =
    { name : String
    , path : String
    , sha : String
    , url : String
    , git_url : String
    , html_url : String
    , repository : MinimalRepository
    , score : Float
    , file_size : Int
    , language : Maybe String
    , last_modified_at : String
    , line_numbers : List String
    , text_matches : SearchResultTextMatches
    }


type alias CodeScanningSarifsStatus =
    { processing_status : String
    , analyses_url : Maybe String
    , errors : Maybe (List String)
    }


type alias CodeScanningSarifsReceipt =
    { id : CodeScanningAnalysisSarifId, url : String }


type alias CodeScanningRef =
    String


type alias CodeScanningOrganizationAlertItems =
    { number : AlertNumber
    , created_at : AlertCreatedAt
    , updated_at : AlertUpdatedAt
    , url : AlertUrl
    , html_url : AlertHtmlUrl
    , instances_url : AlertInstancesUrl
    , state : CodeScanningAlertState
    , fixed_at : AlertFixedAt
    , dismissed_by : Debug.Todo
    , dismissed_at : AlertDismissedAt
    , dismissed_reason : CodeScanningAlertDismissedReason
    , dismissed_comment : CodeScanningAlertDismissedComment
    , rule : CodeScanningAlertRule
    , tool : CodeScanningAnalysisTool
    , most_recent_instance : CodeScanningAlertInstance
    , repository : SimpleRepository
    }


type alias CodeScanningCodeqlDatabase =
    { id : Int
    , name : String
    , language : String
    , uploader : SimpleUser
    , content_type : String
    , size : Int
    , created_at : String
    , updated_at : String
    , url : String
    }


type alias CodeScanningAnalysisUrl =
    String


type alias CodeScanningAnalysisToolVersion =
    Maybe String


type alias CodeScanningAnalysisToolName =
    String


type alias CodeScanningAnalysisToolGuid =
    Maybe String


type alias CodeScanningAnalysisTool =
    { name : CodeScanningAnalysisToolName
    , version : CodeScanningAnalysisToolVersion
    , guid : CodeScanningAnalysisToolGuid
    }


type alias CodeScanningAnalysisSarifId =
    String


type alias CodeScanningAnalysisSarifFile =
    String


type alias CodeScanningAnalysisEnvironment =
    String


type alias CodeScanningAnalysisDeletion =
    { next_analysis_url : Maybe String, confirm_delete_url : Maybe String }


type alias CodeScanningAnalysisCreatedAt =
    String


type alias CodeScanningAnalysisCommitSha =
    String


type alias CodeScanningAnalysisCategory =
    String


type alias CodeScanningAnalysisAnalysisKey =
    String


type alias CodeScanningAnalysis =
    { ref : CodeScanningRef
    , commit_sha : CodeScanningAnalysisCommitSha
    , analysis_key : CodeScanningAnalysisAnalysisKey
    , environment : CodeScanningAnalysisEnvironment
    , category : CodeScanningAnalysisCategory
    , error : String
    , created_at : CodeScanningAnalysisCreatedAt
    , results_count : Int
    , rules_count : Int
    , id : Int
    , url : CodeScanningAnalysisUrl
    , sarif_id : CodeScanningAnalysisSarifId
    , tool : CodeScanningAnalysisTool
    , deletable : Bool
    , warning : String
    }


type alias CodeScanningAlertState =
    String


type alias CodeScanningAlertSetState =
    String


type alias CodeScanningAlertRuleSummary =
    { id : Maybe String
    , name : String
    , tags : Maybe (List String)
    , severity : Maybe String
    , description : String
    }


type alias CodeScanningAlertRule =
    { id : Maybe String
    , name : String
    , severity : Maybe String
    , security_severity_level : Maybe String
    , description : String
    , full_description : String
    , tags : Maybe (List String)
    , help : Maybe String
    , help_uri : Maybe String
    }


type alias CodeScanningAlertLocation =
    { path : String
    , start_line : Int
    , end_line : Int
    , start_column : Int
    , end_column : Int
    }


type alias CodeScanningAlertItems =
    { number : AlertNumber
    , created_at : AlertCreatedAt
    , updated_at : AlertUpdatedAt
    , url : AlertUrl
    , html_url : AlertHtmlUrl
    , instances_url : AlertInstancesUrl
    , state : CodeScanningAlertState
    , fixed_at : AlertFixedAt
    , dismissed_by : Debug.Todo
    , dismissed_at : AlertDismissedAt
    , dismissed_reason : CodeScanningAlertDismissedReason
    , dismissed_comment : CodeScanningAlertDismissedComment
    , rule : CodeScanningAlertRuleSummary
    , tool : CodeScanningAnalysisTool
    , most_recent_instance : CodeScanningAlertInstance
    }


type alias CodeScanningAlertInstance =
    { ref : CodeScanningRef
    , analysis_key : CodeScanningAnalysisAnalysisKey
    , environment : CodeScanningAlertEnvironment
    , category : CodeScanningAnalysisCategory
    , state : CodeScanningAlertState
    , commit_sha : String
    , message : { text : String }
    , location : CodeScanningAlertLocation
    , html_url : String
    , classifications : List CodeScanningAlertClassification
    }


type alias CodeScanningAlertEnvironment =
    String


type alias CodeScanningAlertDismissedReason =
    Maybe String


type alias CodeScanningAlertDismissedComment =
    Maybe String


type alias CodeScanningAlertClassification =
    Maybe String


type alias CodeScanningAlert =
    { number : AlertNumber
    , created_at : AlertCreatedAt
    , updated_at : AlertUpdatedAt
    , url : AlertUrl
    , html_url : AlertHtmlUrl
    , instances_url : AlertInstancesUrl
    , state : CodeScanningAlertState
    , fixed_at : AlertFixedAt
    , dismissed_by : Debug.Todo
    , dismissed_at : AlertDismissedAt
    , dismissed_reason : CodeScanningAlertDismissedReason
    , dismissed_comment : CodeScanningAlertDismissedComment
    , rule : CodeScanningAlertRule
    , tool : CodeScanningAnalysisTool
    , most_recent_instance : CodeScanningAlertInstance
    }


type alias CodeOfConductSimple =
    { url : String, key : String, name : String, html_url : Maybe String }


type alias CodeOfConduct =
    { key : String
    , name : String
    , url : String
    , body : String
    , html_url : Maybe String
    }


type alias CodeFrequencyStat =
    List Int


type alias CloneTraffic =
    { count : Int, uniques : Int, clones : List Traffic }


type alias CheckSuitePreference =
    { preferences :
        { auto_trigger_checks : List { app_id : Int, setting : Bool } }
    , repository : MinimalRepository
    }


type alias CheckSuite =
    { id : Int
    , node_id : String
    , head_branch : Maybe String
    , head_sha : String
    , status : Maybe String
    , conclusion : Maybe String
    , url : Maybe String
    , before : Maybe String
    , after : Maybe String
    , pull_requests : Maybe (List PullRequestMinimal)
    , app : Debug.Todo
    , repository : MinimalRepository
    , created_at : Maybe String
    , updated_at : Maybe String
    , head_commit : SimpleCommit
    , latest_check_runs_count : Int
    , check_runs_url : String
    , rerequestable : Bool
    , runs_rerequestable : Bool
    }


type alias CheckRun =
    { id : Int
    , head_sha : String
    , node_id : String
    , external_id : Maybe String
    , url : String
    , html_url : Maybe String
    , details_url : Maybe String
    , status : String
    , conclusion : Maybe String
    , started_at : Maybe String
    , completed_at : Maybe String
    , output :
        { title : Maybe String
        , summary : Maybe String
        , text : Maybe String
        , annotations_count : Int
        , annotations_url : String
        }
    , name : String
    , check_suite : Maybe { id : Int }
    , app : Debug.Todo
    , pull_requests : List PullRequestMinimal
    , deployment : DeploymentSimple
    }


type alias CheckAnnotation =
    { path : String
    , start_line : Int
    , end_line : Int
    , start_column : Maybe Int
    , end_column : Maybe Int
    , annotation_level : Maybe String
    , title : Maybe String
    , message : Maybe String
    , raw_details : Maybe String
    , blob_href : String
    }


type alias BranchWithProtection =
    { name : String
    , commit : Commit
    , _links : { html : String, self : String }
    , protected : Bool
    , protection : BranchProtection
    , protection_url : String
    , pattern : String
    , required_approving_review_count : Int
    }


type alias BranchShort =
    { name : String, commit : { sha : String, url : String }, protected : Bool }


type alias BranchRestrictionPolicy =
    { url : String
    , users_url : String
    , teams_url : String
    , apps_url : String
    , users :
        List { login : String
        , id : Int
        , node_id : String
        , avatar_url : String
        , gravatar_id : String
        , url : String
        , html_url : String
        , followers_url : String
        , following_url : String
        , gists_url : String
        , starred_url : String
        , subscriptions_url : String
        , organizations_url : String
        , repos_url : String
        , events_url : String
        , received_events_url : String
        , type_ : String
        , site_admin : Bool
        }
    , teams :
        List { id : Int
        , node_id : String
        , url : String
        , html_url : String
        , name : String
        , slug : String
        , description : Maybe String
        , privacy : String
        , permission : String
        , members_url : String
        , repositories_url : String
        , parent : Maybe String
        }
    , apps :
        List { id : Int
        , slug : String
        , node_id : String
        , owner :
            { login : String
            , id : Int
            , node_id : String
            , url : String
            , repos_url : String
            , events_url : String
            , hooks_url : String
            , issues_url : String
            , members_url : String
            , public_members_url : String
            , avatar_url : String
            , description : String
            , gravatar_id : String
            , html_url : String
            , followers_url : String
            , following_url : String
            , gists_url : String
            , starred_url : String
            , subscriptions_url : String
            , organizations_url : String
            , received_events_url : String
            , type_ : String
            , site_admin : Bool
            }
        , name : String
        , description : String
        , external_url : String
        , html_url : String
        , created_at : String
        , updated_at : String
        , permissions :
            { metadata : String
            , contents : String
            , issues : String
            , single_file : String
            }
        , events : List String
        }
    }


type alias BranchProtection =
    { url : String
    , enabled : Bool
    , required_status_checks : ProtectedBranchRequiredStatusCheck
    , enforce_admins : ProtectedBranchAdminEnforced
    , required_pull_request_reviews : ProtectedBranchPullRequestReview
    , restrictions : BranchRestrictionPolicy
    , required_linear_history : { enabled : Bool }
    , allow_force_pushes : { enabled : Bool }
    , allow_deletions : { enabled : Bool }
    , block_creations : { enabled : Bool }
    , required_conversation_resolution : { enabled : Bool }
    , name : String
    , protection_url : String
    , required_signatures : { url : String, enabled : Bool }
    }


type alias Blob =
    { content : String
    , encoding : String
    , url : String
    , sha : String
    , size : Maybe Int
    , node_id : String
    , highlighted_content : String
    }


type alias BasicError =
    { message : String
    , documentation_url : String
    , url : String
    , status : String
    }


type alias BaseGist =
    { url : String
    , forks_url : String
    , commits_url : String
    , id : String
    , node_id : String
    , git_pull_url : String
    , git_push_url : String
    , html_url : String
    , files : {}
    , public : Bool
    , created_at : String
    , updated_at : String
    , description : Maybe String
    , comments : Int
    , user : Debug.Todo
    , comments_url : String
    , owner : SimpleUser
    , truncated : Bool
    , forks : List Json.Encode.Value
    , history : List Json.Encode.Value
    }


type alias Autolink =
    { id : Int
    , key_prefix : String
    , url_template : String
    , is_alphanumeric : Bool
    }


type alias AutoMerge =
    Maybe { enabled_by : SimpleUser
    , merge_method : String
    , commit_title : String
    , commit_message : String
    }


type alias Authorization =
    { id : Int
    , url : String
    , scopes : Maybe (List String)
    , token : String
    , token_last_eight : Maybe String
    , hashed_token : Maybe String
    , app : { client_id : String, name : String, url : String }
    , note : Maybe String
    , note_url : Maybe String
    , updated_at : String
    , created_at : String
    , fingerprint : Maybe String
    , user : Debug.Todo
    , installation : Debug.Todo
    , expires_at : Maybe String
    }


type alias AuthorAssociation =
    String


type alias AuthenticationToken =
    { token : String
    , expires_at : String
    , permissions : {}
    , repositories : List Repository
    , single_file : Maybe String
    , repository_selection : String
    }


type alias AssignedIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Integration
    , assignee : SimpleUser
    , assigner : SimpleUser
    }


type alias Artifact =
    { id : Int
    , node_id : String
    , name : String
    , size_in_bytes : Int
    , url : String
    , archive_download_url : String
    , expired : Bool
    , created_at : Maybe String
    , expires_at : Maybe String
    , updated_at : Maybe String
    , workflow_run :
        Maybe { id : Int
        , repository_id : Int
        , head_repository_id : Int
        , head_branch : String
        , head_sha : String
        }
    }


type alias AppPermissions =
    { actions : String
    , administration : String
    , checks : String
    , contents : String
    , deployments : String
    , environments : String
    , issues : String
    , metadata : String
    , packages : String
    , pages : String
    , pull_requests : String
    , repository_hooks : String
    , repository_projects : String
    , secret_scanning_alerts : String
    , secrets : String
    , security_events : String
    , single_file : String
    , statuses : String
    , vulnerability_alerts : String
    , workflows : String
    , members : String
    , organization_administration : String
    , organization_custom_roles : String
    , organization_hooks : String
    , organization_plan : String
    , organization_projects : String
    , organization_packages : String
    , organization_secrets : String
    , organization_self_hosted_runners : String
    , organization_user_blocking : String
    , team_discussions : String
    }


type alias ApiOverview =
    { verifiable_password_authentication : Bool
    , ssh_key_fingerprints :
        { sHA256_RSA : String
        , sHA256_DSA : String
        , sHA256_ECDSA : String
        , sHA256_ED25519 : String
        }
    , ssh_keys : List String
    , hooks : List String
    , web : List String
    , api : List String
    , git : List String
    , packages : List String
    , pages : List String
    , importer : List String
    , actions : List String
    , dependabot : List String
    }


type alias AllowedActions =
    String


type alias AlertUrl =
    String


type alias AlertUpdatedAt =
    String


type alias AlertNumber =
    Int


type alias AlertInstancesUrl =
    String


type alias AlertHtmlUrl =
    String


type alias AlertFixedAt =
    Maybe String


type alias AlertDismissedAt =
    Maybe String


type alias AlertCreatedAt =
    String


type alias AdvancedSecurityActiveCommittersUser =
    { user_login : String, last_pushed_date : String }


type alias AdvancedSecurityActiveCommittersRepository =
    { name : String
    , advanced_security_committers : Int
    , advanced_security_committers_breakdown :
        List AdvancedSecurityActiveCommittersUser
    }


type alias AdvancedSecurityActiveCommitters =
    { total_advanced_security_committers : Int
    , total_count : Int
    , repositories : List AdvancedSecurityActiveCommittersRepository
    }


type alias AddedToProjectIssueEvent =
    { id : Int
    , node_id : String
    , url : String
    , actor : SimpleUser
    , event : String
    , commit_id : Maybe String
    , commit_url : Maybe String
    , created_at : String
    , performed_via_github_app : Debug.Todo
    , project_card :
        { id : Int
        , url : String
        , project_id : Int
        , project_url : String
        , column_name : String
        , previous_column_name : String
        }
    }


type alias Actor =
    { id : Int
    , login : String
    , display_login : String
    , gravatar_id : Maybe String
    , url : String
    , avatar_url : String
    }


type alias ActionsWorkflowAccessToRepository =
    { access_level : String }


type alias ActionsSetDefaultWorkflowPermissions =
    { default_workflow_permissions : ActionsDefaultWorkflowPermissions
    , can_approve_pull_request_reviews : ActionsCanApprovePullRequestReviews
    }


type alias ActionsSecret =
    { name : String, created_at : String, updated_at : String }


type alias ActionsRepositoryPermissions =
    { enabled : ActionsEnabled
    , allowed_actions : AllowedActions
    , selected_actions_url : SelectedActionsUrl
    }


type alias ActionsPublicKey =
    { key_id : String
    , key : String
    , id : Int
    , url : String
    , title : String
    , created_at : String
    }


type alias ActionsOrganizationPermissions =
    { enabled_repositories : EnabledRepositories
    , selected_repositories_url : String
    , allowed_actions : AllowedActions
    , selected_actions_url : SelectedActionsUrl
    }


type alias ActionsGetDefaultWorkflowPermissions =
    { default_workflow_permissions : ActionsDefaultWorkflowPermissions
    , can_approve_pull_request_reviews : ActionsCanApprovePullRequestReviews
    }


type alias ActionsEnterprisePermissions =
    { enabled_organizations : EnabledOrganizations
    , selected_organizations_url : String
    , allowed_actions : AllowedActions
    , selected_actions_url : SelectedActionsUrl
    }


type alias ActionsEnabled =
    Bool


type alias ActionsDefaultWorkflowPermissions =
    String


type alias ActionsCanApprovePullRequestReviews =
    Bool


type alias ActionsCacheUsageOrgEnterprise =
    { total_active_caches_count : Int, total_active_caches_size_in_bytes : Int }


type alias ActionsCacheUsageByRepository =
    { full_name : String
    , active_caches_size_in_bytes : Int
    , active_caches_count : Int
    }


type alias ActionsCacheList =
    { total_count : Int
    , actions_caches :
        List { id : Int
        , ref : String
        , key : String
        , version : String
        , last_accessed_at : String
        , created_at : String
        , size_in_bytes : Int
        }
    }


type alias ActionsBillingUsage =
    { total_minutes_used : Int
    , total_paid_minutes_used : Int
    , included_minutes : Int
    , minutes_used_breakdown :
        { uBUNTU : Int
        , mACOS : Int
        , wINDOWS : Int
        , ubuntu_4_core : Int
        , ubuntu_8_core : Int
        , ubuntu_16_core : Int
        , ubuntu_32_core : Int
        , ubuntu_64_core : Int
        , windows_4_core : Int
        , windows_8_core : Int
        , windows_16_core : Int
        , windows_32_core : Int
        , windows_64_core : Int
        , total : Int
        }
    }


