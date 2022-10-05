module GitHub_v3_REST_API exposing (..)

{-| 
-}


import Http
import Json.Decode
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


