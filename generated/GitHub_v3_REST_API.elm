module GitHub_v3_REST_API exposing (..)

{-| 
-}


import Http
import Json.Decode
import Result


get toMsg =
    Http.get { url = "/", expect = Http.expectJson toMsg 55 }


getApp toMsg =
    Http.get { url = "/app", expect = Http.expectJson toMsg 55 }


getAppHookConfig toMsg =
    Http.get { url = "/app/hook/config", expect = Http.expectJson toMsg 55 }


getAppHookDeliveries toMsg =
    Http.get { url = "/app/hook/deliveries", expect = Http.expectJson toMsg 55 }


getAppHookDeliveriesDeliveryId toMsg =
    Http.get
        { url = "/app/hook/deliveries/{delivery_id}"
        , expect = Http.expectJson toMsg 55
        }


getAppInstallations toMsg =
    Http.get { url = "/app/installations", expect = Http.expectJson toMsg 55 }


getAppInstallationsInstallationId toMsg =
    Http.get
        { url = "/app/installations/{installation_id}"
        , expect = Http.expectJson toMsg 55
        }


getAppsAppSlug toMsg =
    Http.get { url = "/apps/{app_slug}", expect = Http.expectJson toMsg 55 }


getCodesOfConduct toMsg =
    Http.get { url = "/codes_of_conduct", expect = Http.expectJson toMsg 55 }


getCodesOfConductKey toMsg =
    Http.get
        { url = "/codes_of_conduct/{key}", expect = Http.expectJson toMsg 55 }


getEmojis toMsg =
    Http.get { url = "/emojis", expect = Http.expectJson toMsg 55 }


getEnterpriseInstallationEnterpriseOrOrgServerStatistics toMsg =
    Http.get
        { url = "/enterprise-installation/{enterprise_or_org}/server-statistics"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsCacheUsage toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/cache/usage"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsPermissions toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/permissions"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsPermissionsOrganizations toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/permissions/organizations"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsPermissionsSelectedActions toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/permissions/selected-actions"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsPermissionsWorkflow toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/permissions/workflow"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsRunnerGroups toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/runner-groups"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsRunnerGroupsRunnerGroupId toMsg =
    Http.get
        { url =
            "/enterprises/{enterprise}/actions/runner-groups/{runner_group_id}"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsRunnerGroupsRunnerGroupIdOrganizations toMsg =
    Http.get
        { url =
            "/enterprises/{enterprise}/actions/runner-groups/{runner_group_id}/organizations"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsRunnerGroupsRunnerGroupIdRunners toMsg =
    Http.get
        { url =
            "/enterprises/{enterprise}/actions/runner-groups/{runner_group_id}/runners"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsRunners toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/runners"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsRunnersDownloads toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/runners/downloads"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsRunnersRunnerId toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/runners/{runner_id}"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseActionsRunnersRunnerIdLabels toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/actions/runners/{runner_id}/labels"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseCodeScanningAlerts toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/code-scanning/alerts"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseSecretScanningAlerts toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/secret-scanning/alerts"
        , expect = Http.expectJson toMsg 55
        }


getEnterprisesEnterpriseSettingsBillingAdvancedSecurity toMsg =
    Http.get
        { url = "/enterprises/{enterprise}/settings/billing/advanced-security"
        , expect = Http.expectJson toMsg 55
        }


getEvents toMsg =
    Http.get { url = "/events", expect = Http.expectJson toMsg 55 }


getFeeds toMsg =
    Http.get { url = "/feeds", expect = Http.expectJson toMsg 55 }


getGists toMsg =
    Http.get { url = "/gists", expect = Http.expectJson toMsg 55 }


getGistsPublic toMsg =
    Http.get { url = "/gists/public", expect = Http.expectJson toMsg 55 }


getGistsStarred toMsg =
    Http.get { url = "/gists/starred", expect = Http.expectJson toMsg 55 }


getGistsGistId toMsg =
    Http.get { url = "/gists/{gist_id}", expect = Http.expectJson toMsg 55 }


getGistsGistIdComments toMsg =
    Http.get
        { url = "/gists/{gist_id}/comments", expect = Http.expectJson toMsg 55 }


getGistsGistIdCommentsCommentId toMsg =
    Http.get
        { url = "/gists/{gist_id}/comments/{comment_id}"
        , expect = Http.expectJson toMsg 55
        }


getGistsGistIdCommits toMsg =
    Http.get
        { url = "/gists/{gist_id}/commits", expect = Http.expectJson toMsg 55 }


getGistsGistIdForks toMsg =
    Http.get
        { url = "/gists/{gist_id}/forks", expect = Http.expectJson toMsg 55 }


getGistsGistIdStar toMsg =
    Http.get
        { url = "/gists/{gist_id}/star", expect = Http.expectJson toMsg 55 }


getGistsGistIdSha toMsg =
    Http.get
        { url = "/gists/{gist_id}/{sha}", expect = Http.expectJson toMsg 55 }


getGitignoreTemplates toMsg =
    Http.get { url = "/gitignore/templates", expect = Http.expectJson toMsg 55 }


getGitignoreTemplatesName toMsg =
    Http.get
        { url = "/gitignore/templates/{name}"
        , expect = Http.expectJson toMsg 55
        }


getInstallationRepositories toMsg =
    Http.get
        { url = "/installation/repositories"
        , expect = Http.expectJson toMsg 55
        }


getIssues toMsg =
    Http.get { url = "/issues", expect = Http.expectJson toMsg 55 }


getLicenses toMsg =
    Http.get { url = "/licenses", expect = Http.expectJson toMsg 55 }


getLicensesLicense toMsg =
    Http.get { url = "/licenses/{license}", expect = Http.expectJson toMsg 55 }


getMarketplaceListingAccountsAccountId toMsg =
    Http.get
        { url = "/marketplace_listing/accounts/{account_id}"
        , expect = Http.expectJson toMsg 55
        }


getMarketplaceListingPlans toMsg =
    Http.get
        { url = "/marketplace_listing/plans"
        , expect = Http.expectJson toMsg 55
        }


getMarketplaceListingPlansPlanIdAccounts toMsg =
    Http.get
        { url = "/marketplace_listing/plans/{plan_id}/accounts"
        , expect = Http.expectJson toMsg 55
        }


getMarketplaceListingStubbedAccountsAccountId toMsg =
    Http.get
        { url = "/marketplace_listing/stubbed/accounts/{account_id}"
        , expect = Http.expectJson toMsg 55
        }


getMarketplaceListingStubbedPlans toMsg =
    Http.get
        { url = "/marketplace_listing/stubbed/plans"
        , expect = Http.expectJson toMsg 55
        }


getMarketplaceListingStubbedPlansPlanIdAccounts toMsg =
    Http.get
        { url = "/marketplace_listing/stubbed/plans/{plan_id}/accounts"
        , expect = Http.expectJson toMsg 55
        }


getMeta toMsg =
    Http.get { url = "/meta", expect = Http.expectJson toMsg 55 }


getNetworksOwnerRepoEvents toMsg =
    Http.get
        { url = "/networks/{owner}/{repo}/events"
        , expect = Http.expectJson toMsg 55
        }


getNotifications toMsg =
    Http.get { url = "/notifications", expect = Http.expectJson toMsg 55 }


getNotificationsThreadsThreadId toMsg =
    Http.get
        { url = "/notifications/threads/{thread_id}"
        , expect = Http.expectJson toMsg 55
        }


getNotificationsThreadsThreadIdSubscription toMsg =
    Http.get
        { url = "/notifications/threads/{thread_id}/subscription"
        , expect = Http.expectJson toMsg 55
        }


getOctocat toMsg =
    Http.get { url = "/octocat", expect = Http.expectJson toMsg 55 }


getOrganizations toMsg =
    Http.get { url = "/organizations", expect = Http.expectJson toMsg 55 }


getOrganizationsOrganizationIdCustomRoles toMsg =
    Http.get
        { url = "/organizations/{organization_id}/custom_roles"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrg toMsg =
    Http.get { url = "/orgs/{org}", expect = Http.expectJson toMsg 55 }


getOrgsOrgActionsCacheUsage toMsg =
    Http.get
        { url = "/orgs/{org}/actions/cache/usage"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsCacheUsageByRepository toMsg =
    Http.get
        { url = "/orgs/{org}/actions/cache/usage-by-repository"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsPermissions toMsg =
    Http.get
        { url = "/orgs/{org}/actions/permissions"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsPermissionsRepositories toMsg =
    Http.get
        { url = "/orgs/{org}/actions/permissions/repositories"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsPermissionsSelectedActions toMsg =
    Http.get
        { url = "/orgs/{org}/actions/permissions/selected-actions"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsPermissionsWorkflow toMsg =
    Http.get
        { url = "/orgs/{org}/actions/permissions/workflow"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsRunnerGroups toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runner-groups"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsRunnerGroupsRunnerGroupId toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runner-groups/{runner_group_id}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsRunnerGroupsRunnerGroupIdRepositories toMsg =
    Http.get
        { url =
            "/orgs/{org}/actions/runner-groups/{runner_group_id}/repositories"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsRunnerGroupsRunnerGroupIdRunners toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runner-groups/{runner_group_id}/runners"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsRunners toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runners"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsRunnersDownloads toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runners/downloads"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsRunnersRunnerId toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runners/{runner_id}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsRunnersRunnerIdLabels toMsg =
    Http.get
        { url = "/orgs/{org}/actions/runners/{runner_id}/labels"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsSecrets toMsg =
    Http.get
        { url = "/orgs/{org}/actions/secrets"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsSecretsPublicKey toMsg =
    Http.get
        { url = "/orgs/{org}/actions/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsSecretsSecretName toMsg =
    Http.get
        { url = "/orgs/{org}/actions/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgActionsSecretsSecretNameRepositories toMsg =
    Http.get
        { url = "/orgs/{org}/actions/secrets/{secret_name}/repositories"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgBlocks toMsg =
    Http.get { url = "/orgs/{org}/blocks", expect = Http.expectJson toMsg 55 }


getOrgsOrgBlocksUsername toMsg =
    Http.get
        { url = "/orgs/{org}/blocks/{username}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgCodeScanningAlerts toMsg =
    Http.get
        { url = "/orgs/{org}/code-scanning/alerts"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgCodespaces toMsg =
    Http.get
        { url = "/orgs/{org}/codespaces", expect = Http.expectJson toMsg 55 }


getOrgsOrgCodespacesSecrets toMsg =
    Http.get
        { url = "/orgs/{org}/codespaces/secrets"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgCodespacesSecretsPublicKey toMsg =
    Http.get
        { url = "/orgs/{org}/codespaces/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgCodespacesSecretsSecretName toMsg =
    Http.get
        { url = "/orgs/{org}/codespaces/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgCodespacesSecretsSecretNameRepositories toMsg =
    Http.get
        { url = "/orgs/{org}/codespaces/secrets/{secret_name}/repositories"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgDependabotSecrets toMsg =
    Http.get
        { url = "/orgs/{org}/dependabot/secrets"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgDependabotSecretsPublicKey toMsg =
    Http.get
        { url = "/orgs/{org}/dependabot/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgDependabotSecretsSecretName toMsg =
    Http.get
        { url = "/orgs/{org}/dependabot/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgDependabotSecretsSecretNameRepositories toMsg =
    Http.get
        { url = "/orgs/{org}/dependabot/secrets/{secret_name}/repositories"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgEvents toMsg =
    Http.get { url = "/orgs/{org}/events", expect = Http.expectJson toMsg 55 }


getOrgsOrgFailedInvitations toMsg =
    Http.get
        { url = "/orgs/{org}/failed_invitations"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgFineGrainedPermissions toMsg =
    Http.get
        { url = "/orgs/{org}/fine_grained_permissions"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgHooks toMsg =
    Http.get { url = "/orgs/{org}/hooks", expect = Http.expectJson toMsg 55 }


getOrgsOrgHooksHookId toMsg =
    Http.get
        { url = "/orgs/{org}/hooks/{hook_id}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgHooksHookIdConfig toMsg =
    Http.get
        { url = "/orgs/{org}/hooks/{hook_id}/config"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgHooksHookIdDeliveries toMsg =
    Http.get
        { url = "/orgs/{org}/hooks/{hook_id}/deliveries"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgHooksHookIdDeliveriesDeliveryId toMsg =
    Http.get
        { url = "/orgs/{org}/hooks/{hook_id}/deliveries/{delivery_id}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgInstallation toMsg =
    Http.get
        { url = "/orgs/{org}/installation", expect = Http.expectJson toMsg 55 }


getOrgsOrgInstallations toMsg =
    Http.get
        { url = "/orgs/{org}/installations", expect = Http.expectJson toMsg 55 }


getOrgsOrgInteractionLimits toMsg =
    Http.get
        { url = "/orgs/{org}/interaction-limits"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgInvitations toMsg =
    Http.get
        { url = "/orgs/{org}/invitations", expect = Http.expectJson toMsg 55 }


getOrgsOrgInvitationsInvitationIdTeams toMsg =
    Http.get
        { url = "/orgs/{org}/invitations/{invitation_id}/teams"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgIssues toMsg =
    Http.get { url = "/orgs/{org}/issues", expect = Http.expectJson toMsg 55 }


getOrgsOrgMembers toMsg =
    Http.get { url = "/orgs/{org}/members", expect = Http.expectJson toMsg 55 }


getOrgsOrgMembersUsername toMsg =
    Http.get
        { url = "/orgs/{org}/members/{username}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgMembersUsernameCodespaces toMsg =
    Http.get
        { url = "/orgs/{org}/members/{username}/codespaces"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgMembershipsUsername toMsg =
    Http.get
        { url = "/orgs/{org}/memberships/{username}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgMigrations toMsg =
    Http.get
        { url = "/orgs/{org}/migrations", expect = Http.expectJson toMsg 55 }


getOrgsOrgMigrationsMigrationId toMsg =
    Http.get
        { url = "/orgs/{org}/migrations/{migration_id}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgMigrationsMigrationIdArchive toMsg =
    Http.get
        { url = "/orgs/{org}/migrations/{migration_id}/archive"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgMigrationsMigrationIdRepositories toMsg =
    Http.get
        { url = "/orgs/{org}/migrations/{migration_id}/repositories"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgOutsideCollaborators toMsg =
    Http.get
        { url = "/orgs/{org}/outside_collaborators"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgPackages toMsg =
    Http.get { url = "/orgs/{org}/packages", expect = Http.expectJson toMsg 55 }


getOrgsOrgPackagesPackageTypePackageName toMsg =
    Http.get
        { url = "/orgs/{org}/packages/{package_type}/{package_name}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgPackagesPackageTypePackageNameVersions toMsg =
    Http.get
        { url = "/orgs/{org}/packages/{package_type}/{package_name}/versions"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgPackagesPackageTypePackageNameVersionsPackageVersionId toMsg =
    Http.get
        { url =
            "/orgs/{org}/packages/{package_type}/{package_name}/versions/{package_version_id}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgProjects toMsg =
    Http.get { url = "/orgs/{org}/projects", expect = Http.expectJson toMsg 55 }


getOrgsOrgPublicMembers toMsg =
    Http.get
        { url = "/orgs/{org}/public_members"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgPublicMembersUsername toMsg =
    Http.get
        { url = "/orgs/{org}/public_members/{username}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgRepos toMsg =
    Http.get { url = "/orgs/{org}/repos", expect = Http.expectJson toMsg 55 }


getOrgsOrgSecretScanningAlerts toMsg =
    Http.get
        { url = "/orgs/{org}/secret-scanning/alerts"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgSecurityManagers toMsg =
    Http.get
        { url = "/orgs/{org}/security-managers"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgSettingsBillingActions toMsg =
    Http.get
        { url = "/orgs/{org}/settings/billing/actions"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgSettingsBillingAdvancedSecurity toMsg =
    Http.get
        { url = "/orgs/{org}/settings/billing/advanced-security"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgSettingsBillingPackages toMsg =
    Http.get
        { url = "/orgs/{org}/settings/billing/packages"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgSettingsBillingSharedStorage toMsg =
    Http.get
        { url = "/orgs/{org}/settings/billing/shared-storage"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeams toMsg =
    Http.get { url = "/orgs/{org}/teams", expect = Http.expectJson toMsg 55 }


getOrgsOrgTeamsTeamSlug toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugDiscussions toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/discussions"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugDiscussionsDiscussionNumber toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugDiscussionsDiscussionNumberComments toMsg =
    Http.get
        { url =
            "/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugDiscussionsDiscussionNumberCommentsCommentNumber toMsg =
    Http.get
        { url =
            "/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments/{comment_number}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugDiscussionsDiscussionNumberCommentsCommentNumberReactions toMsg =
    Http.get
        { url =
            "/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/comments/{comment_number}/reactions"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugDiscussionsDiscussionNumberReactions toMsg =
    Http.get
        { url =
            "/orgs/{org}/teams/{team_slug}/discussions/{discussion_number}/reactions"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugInvitations toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/invitations"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugMembers toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/members"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugMembershipsUsername toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/memberships/{username}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugProjects toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/projects"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugProjectsProjectId toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/projects/{project_id}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugRepos toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/repos"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugReposOwnerRepo toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/repos/{owner}/{repo}"
        , expect = Http.expectJson toMsg 55
        }


getOrgsOrgTeamsTeamSlugTeams toMsg =
    Http.get
        { url = "/orgs/{org}/teams/{team_slug}/teams"
        , expect = Http.expectJson toMsg 55
        }


getProjectsColumnsCardsCardId toMsg =
    Http.get
        { url = "/projects/columns/cards/{card_id}"
        , expect = Http.expectJson toMsg 55
        }


getProjectsColumnsColumnId toMsg =
    Http.get
        { url = "/projects/columns/{column_id}"
        , expect = Http.expectJson toMsg 55
        }


getProjectsColumnsColumnIdCards toMsg =
    Http.get
        { url = "/projects/columns/{column_id}/cards"
        , expect = Http.expectJson toMsg 55
        }


getProjectsProjectId toMsg =
    Http.get
        { url = "/projects/{project_id}", expect = Http.expectJson toMsg 55 }


getProjectsProjectIdCollaborators toMsg =
    Http.get
        { url = "/projects/{project_id}/collaborators"
        , expect = Http.expectJson toMsg 55
        }


getProjectsProjectIdCollaboratorsUsernamePermission toMsg =
    Http.get
        { url = "/projects/{project_id}/collaborators/{username}/permission"
        , expect = Http.expectJson toMsg 55
        }


getProjectsProjectIdColumns toMsg =
    Http.get
        { url = "/projects/{project_id}/columns"
        , expect = Http.expectJson toMsg 55
        }


getRateLimit toMsg =
    Http.get { url = "/rate_limit", expect = Http.expectJson toMsg 55 }


getReposOwnerRepo toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}", expect = Http.expectJson toMsg 55 }


getReposOwnerRepoActionsArtifacts toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/artifacts"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsArtifactsArtifactId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/artifacts/{artifact_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsArtifactsArtifactIdArchiveFormat toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/actions/artifacts/{artifact_id}/{archive_format}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsCacheUsage toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/cache/usage"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsCaches toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/caches"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsJobsJobId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/jobs/{job_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsJobsJobIdLogs toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/jobs/{job_id}/logs"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsPermissions toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/permissions"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsPermissionsAccess toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/permissions/access"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsPermissionsSelectedActions toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/permissions/selected-actions"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsPermissionsWorkflow toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/permissions/workflow"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunners toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runners"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunnersDownloads toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runners/downloads"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunnersRunnerId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runners/{runner_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunnersRunnerIdLabels toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runners/{runner_id}/labels"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRuns toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunsRunId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs/{run_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunsRunIdApprovals toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs/{run_id}/approvals"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunsRunIdArtifacts toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs/{run_id}/artifacts"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunsRunIdAttemptsAttemptNumber toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/actions/runs/{run_id}/attempts/{attempt_number}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunsRunIdAttemptsAttemptNumberJobs toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/actions/runs/{run_id}/attempts/{attempt_number}/jobs"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunsRunIdAttemptsAttemptNumberLogs toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/actions/runs/{run_id}/attempts/{attempt_number}/logs"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunsRunIdJobs toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs/{run_id}/jobs"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunsRunIdLogs toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs/{run_id}/logs"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunsRunIdPendingDeployments toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/actions/runs/{run_id}/pending_deployments"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsRunsRunIdTiming toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/runs/{run_id}/timing"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsSecrets toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/secrets"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsSecretsPublicKey toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsSecretsSecretName toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsWorkflows toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/workflows"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsWorkflowsWorkflowId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/workflows/{workflow_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsWorkflowsWorkflowIdRuns toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/workflows/{workflow_id}/runs"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoActionsWorkflowsWorkflowIdTiming toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/actions/workflows/{workflow_id}/timing"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoAssignees toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/assignees"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoAssigneesAssignee toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/assignees/{assignee}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoAutolinks toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/autolinks"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoAutolinksAutolinkId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/autolinks/{autolink_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoBranches toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/branches"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoBranchesBranch toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/branches/{branch}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoBranchesBranchProtection toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/branches/{branch}/protection"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoBranchesBranchProtectionEnforceAdmins toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/enforce_admins"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoBranchesBranchProtectionRequiredPullRequestReviews toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/required_pull_request_reviews"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoBranchesBranchProtectionRequiredSignatures toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/required_signatures"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoBranchesBranchProtectionRequiredStatusChecks toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/required_status_checks"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoBranchesBranchProtectionRequiredStatusChecksContexts toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/required_status_checks/contexts"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoBranchesBranchProtectionRestrictions toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/restrictions"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoBranchesBranchProtectionRestrictionsApps toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/restrictions/apps"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoBranchesBranchProtectionRestrictionsTeams toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/restrictions/teams"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoBranchesBranchProtectionRestrictionsUsers toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/branches/{branch}/protection/restrictions/users"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCheckRunsCheckRunId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/check-runs/{check_run_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCheckRunsCheckRunIdAnnotations toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/check-runs/{check_run_id}/annotations"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCheckSuitesCheckSuiteId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/check-suites/{check_suite_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCheckSuitesCheckSuiteIdCheckRuns toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/check-suites/{check_suite_id}/check-runs"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodeScanningAlerts toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/code-scanning/alerts"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodeScanningAlertsAlertNumber toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/code-scanning/alerts/{alert_number}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodeScanningAlertsAlertNumberInstances toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/code-scanning/alerts/{alert_number}/instances"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodeScanningAnalyses toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/code-scanning/analyses"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodeScanningAnalysesAnalysisId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/code-scanning/analyses/{analysis_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodeScanningCodeqlDatabases toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/code-scanning/codeql/databases"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodeScanningCodeqlDatabasesLanguage toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/code-scanning/codeql/databases/{language}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodeScanningSarifsSarifId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/code-scanning/sarifs/{sarif_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodeownersErrors toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codeowners/errors"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodespaces toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodespacesDevcontainers toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces/devcontainers"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodespacesMachines toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces/machines"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodespacesNew toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces/new"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodespacesSecrets toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces/secrets"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodespacesSecretsPublicKey toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCodespacesSecretsSecretName toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/codespaces/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCollaborators toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/collaborators"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCollaboratorsUsername toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/collaborators/{username}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCollaboratorsUsernamePermission toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/collaborators/{username}/permission"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoComments toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/comments"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCommentsCommentId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/comments/{comment_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCommentsCommentIdReactions toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/comments/{comment_id}/reactions"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCommits toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCommitsCommitShaBranchesWhereHead toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{commit_sha}/branches-where-head"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCommitsCommitShaComments toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{commit_sha}/comments"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCommitsCommitShaPulls toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{commit_sha}/pulls"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCommitsRef toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{ref}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCommitsRefCheckRuns toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{ref}/check-runs"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCommitsRefCheckSuites toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{ref}/check-suites"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCommitsRefStatus toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{ref}/status"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCommitsRefStatuses toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/commits/{ref}/statuses"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCommunityProfile toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/community/profile"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoCompareBasehead toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/compare/{basehead}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoContentsPath toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/contents/{path}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoContributors toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/contributors"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoDependabotAlerts toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/dependabot/alerts"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoDependabotAlertsAlertNumber toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/dependabot/alerts/{alert_number}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoDependabotSecrets toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/dependabot/secrets"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoDependabotSecretsPublicKey toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/dependabot/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoDependabotSecretsSecretName toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/dependabot/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoDependencyGraphCompareBasehead toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/dependency-graph/compare/{basehead}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoDeployments toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/deployments"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoDeploymentsDeploymentId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/deployments/{deployment_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoDeploymentsDeploymentIdStatuses toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/deployments/{deployment_id}/statuses"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoDeploymentsDeploymentIdStatusesStatusId toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/deployments/{deployment_id}/statuses/{status_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoEnvironments toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/environments"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoEnvironmentsEnvironmentName toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/environments/{environment_name}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoEnvironmentsEnvironmentNameDeploymentBranchPolicies toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/environments/{environment_name}/deployment-branch-policies"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoEnvironmentsEnvironmentNameDeploymentBranchPoliciesBranchPolicyId toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/environments/{environment_name}/deployment-branch-policies/{branch_policy_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoEvents toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/events"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoForks toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/forks"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoGitBlobsFileSha toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/git/blobs/{file_sha}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoGitCommitsCommitSha toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/git/commits/{commit_sha}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoGitMatchingRefsRef toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/git/matching-refs/{ref}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoGitRefRef toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/git/ref/{ref}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoGitTagsTagSha toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/git/tags/{tag_sha}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoGitTreesTreeSha toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/git/trees/{tree_sha}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoHooks toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/hooks"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoHooksHookId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/hooks/{hook_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoHooksHookIdConfig toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/hooks/{hook_id}/config"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoHooksHookIdDeliveries toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/hooks/{hook_id}/deliveries"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoHooksHookIdDeliveriesDeliveryId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/hooks/{hook_id}/deliveries/{delivery_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoImport toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/import"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoImportAuthors toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/import/authors"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoImportLargeFiles toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/import/large_files"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoInstallation toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/installation"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoInteractionLimits toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/interaction-limits"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoInvitations toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/invitations"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoIssues toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoIssuesComments toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/comments"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoIssuesCommentsCommentId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/comments/{comment_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoIssuesCommentsCommentIdReactions toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/comments/{comment_id}/reactions"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoIssuesEvents toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/events"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoIssuesEventsEventId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/events/{event_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoIssuesIssueNumber toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/{issue_number}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoIssuesIssueNumberComments toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/{issue_number}/comments"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoIssuesIssueNumberEvents toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/{issue_number}/events"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoIssuesIssueNumberLabels toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/{issue_number}/labels"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoIssuesIssueNumberReactions toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/{issue_number}/reactions"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoIssuesIssueNumberTimeline toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/issues/{issue_number}/timeline"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoKeys toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/keys"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoKeysKeyId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/keys/{key_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoLabels toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/labels"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoLabelsName toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/labels/{name}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoLanguages toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/languages"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoLicense toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/license"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoMilestones toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/milestones"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoMilestonesMilestoneNumber toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/milestones/{milestone_number}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoMilestonesMilestoneNumberLabels toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/milestones/{milestone_number}/labels"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoNotifications toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/notifications"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPages toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pages"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPagesBuilds toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pages/builds"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPagesBuildsLatest toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pages/builds/latest"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPagesBuildsBuildId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pages/builds/{build_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPagesHealth toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pages/health"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoProjects toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/projects"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPulls toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPullsComments toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/comments"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPullsCommentsCommentId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/comments/{comment_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPullsCommentsCommentIdReactions toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/comments/{comment_id}/reactions"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPullsPullNumber toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPullsPullNumberComments toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/comments"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPullsPullNumberCommits toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/commits"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPullsPullNumberFiles toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/files"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPullsPullNumberMerge toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/merge"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPullsPullNumberRequestedReviewers toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/requested_reviewers"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPullsPullNumberReviews toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/reviews"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPullsPullNumberReviewsReviewId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/pulls/{pull_number}/reviews/{review_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoPullsPullNumberReviewsReviewIdComments toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/pulls/{pull_number}/reviews/{review_id}/comments"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoReadme toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/readme"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoReadmeDir toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/readme/{dir}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoReleases toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoReleasesAssetsAssetId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases/assets/{asset_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoReleasesLatest toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases/latest"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoReleasesTagsTag toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases/tags/{tag}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoReleasesReleaseId toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases/{release_id}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoReleasesReleaseIdAssets toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases/{release_id}/assets"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoReleasesReleaseIdReactions toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/releases/{release_id}/reactions"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoSecretScanningAlerts toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/secret-scanning/alerts"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoSecretScanningAlertsAlertNumber toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/secret-scanning/alerts/{alert_number}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoSecretScanningAlertsAlertNumberLocations toMsg =
    Http.get
        { url =
            "/repos/{owner}/{repo}/secret-scanning/alerts/{alert_number}/locations"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoStargazers toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/stargazers"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoStatsCodeFrequency toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/stats/code_frequency"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoStatsCommitActivity toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/stats/commit_activity"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoStatsContributors toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/stats/contributors"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoStatsParticipation toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/stats/participation"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoStatsPunchCard toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/stats/punch_card"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoSubscribers toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/subscribers"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoSubscription toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/subscription"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoTags toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/tags"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoTagsProtection toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/tags/protection"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoTarballRef toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/tarball/{ref}"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoTeams toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/teams"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoTopics toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/topics"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoTrafficClones toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/traffic/clones"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoTrafficPopularPaths toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/traffic/popular/paths"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoTrafficPopularReferrers toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/traffic/popular/referrers"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoTrafficViews toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/traffic/views"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoVulnerabilityAlerts toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/vulnerability-alerts"
        , expect = Http.expectJson toMsg 55
        }


getReposOwnerRepoZipballRef toMsg =
    Http.get
        { url = "/repos/{owner}/{repo}/zipball/{ref}"
        , expect = Http.expectJson toMsg 55
        }


getRepositories toMsg =
    Http.get { url = "/repositories", expect = Http.expectJson toMsg 55 }


getRepositoriesRepositoryIdEnvironmentsEnvironmentNameSecrets toMsg =
    Http.get
        { url =
            "/repositories/{repository_id}/environments/{environment_name}/secrets"
        , expect = Http.expectJson toMsg 55
        }


getRepositoriesRepositoryIdEnvironmentsEnvironmentNameSecretsPublicKey toMsg =
    Http.get
        { url =
            "/repositories/{repository_id}/environments/{environment_name}/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


getRepositoriesRepositoryIdEnvironmentsEnvironmentNameSecretsSecretName toMsg =
    Http.get
        { url =
            "/repositories/{repository_id}/environments/{environment_name}/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


getSearchCode toMsg =
    Http.get { url = "/search/code", expect = Http.expectJson toMsg 55 }


getSearchCommits toMsg =
    Http.get { url = "/search/commits", expect = Http.expectJson toMsg 55 }


getSearchIssues toMsg =
    Http.get { url = "/search/issues", expect = Http.expectJson toMsg 55 }


getSearchLabels toMsg =
    Http.get { url = "/search/labels", expect = Http.expectJson toMsg 55 }


getSearchRepositories toMsg =
    Http.get { url = "/search/repositories", expect = Http.expectJson toMsg 55 }


getSearchTopics toMsg =
    Http.get { url = "/search/topics", expect = Http.expectJson toMsg 55 }


getSearchUsers toMsg =
    Http.get { url = "/search/users", expect = Http.expectJson toMsg 55 }


getTeamsTeamId toMsg =
    Http.get { url = "/teams/{team_id}", expect = Http.expectJson toMsg 55 }


getTeamsTeamIdDiscussions toMsg =
    Http.get
        { url = "/teams/{team_id}/discussions"
        , expect = Http.expectJson toMsg 55
        }


getTeamsTeamIdDiscussionsDiscussionNumber toMsg =
    Http.get
        { url = "/teams/{team_id}/discussions/{discussion_number}"
        , expect = Http.expectJson toMsg 55
        }


getTeamsTeamIdDiscussionsDiscussionNumberComments toMsg =
    Http.get
        { url = "/teams/{team_id}/discussions/{discussion_number}/comments"
        , expect = Http.expectJson toMsg 55
        }


getTeamsTeamIdDiscussionsDiscussionNumberCommentsCommentNumber toMsg =
    Http.get
        { url =
            "/teams/{team_id}/discussions/{discussion_number}/comments/{comment_number}"
        , expect = Http.expectJson toMsg 55
        }


getTeamsTeamIdDiscussionsDiscussionNumberCommentsCommentNumberReactions toMsg =
    Http.get
        { url =
            "/teams/{team_id}/discussions/{discussion_number}/comments/{comment_number}/reactions"
        , expect = Http.expectJson toMsg 55
        }


getTeamsTeamIdDiscussionsDiscussionNumberReactions toMsg =
    Http.get
        { url = "/teams/{team_id}/discussions/{discussion_number}/reactions"
        , expect = Http.expectJson toMsg 55
        }


getTeamsTeamIdInvitations toMsg =
    Http.get
        { url = "/teams/{team_id}/invitations"
        , expect = Http.expectJson toMsg 55
        }


getTeamsTeamIdMembers toMsg =
    Http.get
        { url = "/teams/{team_id}/members", expect = Http.expectJson toMsg 55 }


getTeamsTeamIdMembersUsername toMsg =
    Http.get
        { url = "/teams/{team_id}/members/{username}"
        , expect = Http.expectJson toMsg 55
        }


getTeamsTeamIdMembershipsUsername toMsg =
    Http.get
        { url = "/teams/{team_id}/memberships/{username}"
        , expect = Http.expectJson toMsg 55
        }


getTeamsTeamIdProjects toMsg =
    Http.get
        { url = "/teams/{team_id}/projects", expect = Http.expectJson toMsg 55 }


getTeamsTeamIdProjectsProjectId toMsg =
    Http.get
        { url = "/teams/{team_id}/projects/{project_id}"
        , expect = Http.expectJson toMsg 55
        }


getTeamsTeamIdRepos toMsg =
    Http.get
        { url = "/teams/{team_id}/repos", expect = Http.expectJson toMsg 55 }


getTeamsTeamIdReposOwnerRepo toMsg =
    Http.get
        { url = "/teams/{team_id}/repos/{owner}/{repo}"
        , expect = Http.expectJson toMsg 55
        }


getTeamsTeamIdTeams toMsg =
    Http.get
        { url = "/teams/{team_id}/teams", expect = Http.expectJson toMsg 55 }


getUser toMsg =
    Http.get { url = "/user", expect = Http.expectJson toMsg 55 }


getUserBlocks toMsg =
    Http.get { url = "/user/blocks", expect = Http.expectJson toMsg 55 }


getUserBlocksUsername toMsg =
    Http.get
        { url = "/user/blocks/{username}", expect = Http.expectJson toMsg 55 }


getUserCodespaces toMsg =
    Http.get { url = "/user/codespaces", expect = Http.expectJson toMsg 55 }


getUserCodespacesSecrets toMsg =
    Http.get
        { url = "/user/codespaces/secrets", expect = Http.expectJson toMsg 55 }


getUserCodespacesSecretsPublicKey toMsg =
    Http.get
        { url = "/user/codespaces/secrets/public-key"
        , expect = Http.expectJson toMsg 55
        }


getUserCodespacesSecretsSecretName toMsg =
    Http.get
        { url = "/user/codespaces/secrets/{secret_name}"
        , expect = Http.expectJson toMsg 55
        }


getUserCodespacesSecretsSecretNameRepositories toMsg =
    Http.get
        { url = "/user/codespaces/secrets/{secret_name}/repositories"
        , expect = Http.expectJson toMsg 55
        }


getUserCodespacesCodespaceName toMsg =
    Http.get
        { url = "/user/codespaces/{codespace_name}"
        , expect = Http.expectJson toMsg 55
        }


getUserCodespacesCodespaceNameExportsExportId toMsg =
    Http.get
        { url = "/user/codespaces/{codespace_name}/exports/{export_id}"
        , expect = Http.expectJson toMsg 55
        }


getUserCodespacesCodespaceNameMachines toMsg =
    Http.get
        { url = "/user/codespaces/{codespace_name}/machines"
        , expect = Http.expectJson toMsg 55
        }


getUserEmails toMsg =
    Http.get { url = "/user/emails", expect = Http.expectJson toMsg 55 }


getUserFollowers toMsg =
    Http.get { url = "/user/followers", expect = Http.expectJson toMsg 55 }


getUserFollowing toMsg =
    Http.get { url = "/user/following", expect = Http.expectJson toMsg 55 }


getUserFollowingUsername toMsg =
    Http.get
        { url = "/user/following/{username}"
        , expect = Http.expectJson toMsg 55
        }


getUserGpgKeys toMsg =
    Http.get { url = "/user/gpg_keys", expect = Http.expectJson toMsg 55 }


getUserGpgKeysGpgKeyId toMsg =
    Http.get
        { url = "/user/gpg_keys/{gpg_key_id}"
        , expect = Http.expectJson toMsg 55
        }


getUserInstallations toMsg =
    Http.get { url = "/user/installations", expect = Http.expectJson toMsg 55 }


getUserInstallationsInstallationIdRepositories toMsg =
    Http.get
        { url = "/user/installations/{installation_id}/repositories"
        , expect = Http.expectJson toMsg 55
        }


getUserInteractionLimits toMsg =
    Http.get
        { url = "/user/interaction-limits", expect = Http.expectJson toMsg 55 }


getUserIssues toMsg =
    Http.get { url = "/user/issues", expect = Http.expectJson toMsg 55 }


getUserKeys toMsg =
    Http.get { url = "/user/keys", expect = Http.expectJson toMsg 55 }


getUserKeysKeyId toMsg =
    Http.get { url = "/user/keys/{key_id}", expect = Http.expectJson toMsg 55 }


getUserMarketplacePurchases toMsg =
    Http.get
        { url = "/user/marketplace_purchases"
        , expect = Http.expectJson toMsg 55
        }


getUserMarketplacePurchasesStubbed toMsg =
    Http.get
        { url = "/user/marketplace_purchases/stubbed"
        , expect = Http.expectJson toMsg 55
        }


getUserMembershipsOrgs toMsg =
    Http.get
        { url = "/user/memberships/orgs", expect = Http.expectJson toMsg 55 }


getUserMembershipsOrgsOrg toMsg =
    Http.get
        { url = "/user/memberships/orgs/{org}"
        , expect = Http.expectJson toMsg 55
        }


getUserMigrations toMsg =
    Http.get { url = "/user/migrations", expect = Http.expectJson toMsg 55 }


getUserMigrationsMigrationId toMsg =
    Http.get
        { url = "/user/migrations/{migration_id}"
        , expect = Http.expectJson toMsg 55
        }


getUserMigrationsMigrationIdArchive toMsg =
    Http.get
        { url = "/user/migrations/{migration_id}/archive"
        , expect = Http.expectJson toMsg 55
        }


getUserMigrationsMigrationIdRepositories toMsg =
    Http.get
        { url = "/user/migrations/{migration_id}/repositories"
        , expect = Http.expectJson toMsg 55
        }


getUserOrgs toMsg =
    Http.get { url = "/user/orgs", expect = Http.expectJson toMsg 55 }


getUserPackages toMsg =
    Http.get { url = "/user/packages", expect = Http.expectJson toMsg 55 }


getUserPackagesPackageTypePackageName toMsg =
    Http.get
        { url = "/user/packages/{package_type}/{package_name}"
        , expect = Http.expectJson toMsg 55
        }


getUserPackagesPackageTypePackageNameVersions toMsg =
    Http.get
        { url = "/user/packages/{package_type}/{package_name}/versions"
        , expect = Http.expectJson toMsg 55
        }


getUserPackagesPackageTypePackageNameVersionsPackageVersionId toMsg =
    Http.get
        { url =
            "/user/packages/{package_type}/{package_name}/versions/{package_version_id}"
        , expect = Http.expectJson toMsg 55
        }


getUserPublicEmails toMsg =
    Http.get { url = "/user/public_emails", expect = Http.expectJson toMsg 55 }


getUserRepos toMsg =
    Http.get { url = "/user/repos", expect = Http.expectJson toMsg 55 }


getUserRepositoryInvitations toMsg =
    Http.get
        { url = "/user/repository_invitations"
        , expect = Http.expectJson toMsg 55
        }


getUserSshSigningKeys toMsg =
    Http.get
        { url = "/user/ssh_signing_keys", expect = Http.expectJson toMsg 55 }


getUserSshSigningKeysSshSigningKeyId toMsg =
    Http.get
        { url = "/user/ssh_signing_keys/{ssh_signing_key_id}"
        , expect = Http.expectJson toMsg 55
        }


getUserStarred toMsg =
    Http.get { url = "/user/starred", expect = Http.expectJson toMsg 55 }


getUserStarredOwnerRepo toMsg =
    Http.get
        { url = "/user/starred/{owner}/{repo}"
        , expect = Http.expectJson toMsg 55
        }


getUserSubscriptions toMsg =
    Http.get { url = "/user/subscriptions", expect = Http.expectJson toMsg 55 }


getUserTeams toMsg =
    Http.get { url = "/user/teams", expect = Http.expectJson toMsg 55 }


getUsers toMsg =
    Http.get { url = "/users", expect = Http.expectJson toMsg 55 }


getUsersUsername toMsg =
    Http.get { url = "/users/{username}", expect = Http.expectJson toMsg 55 }


getUsersUsernameEvents toMsg =
    Http.get
        { url = "/users/{username}/events", expect = Http.expectJson toMsg 55 }


getUsersUsernameEventsOrgsOrg toMsg =
    Http.get
        { url = "/users/{username}/events/orgs/{org}"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameEventsPublic toMsg =
    Http.get
        { url = "/users/{username}/events/public"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameFollowers toMsg =
    Http.get
        { url = "/users/{username}/followers"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameFollowing toMsg =
    Http.get
        { url = "/users/{username}/following"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameFollowingTargetUser toMsg =
    Http.get
        { url = "/users/{username}/following/{target_user}"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameGists toMsg =
    Http.get
        { url = "/users/{username}/gists", expect = Http.expectJson toMsg 55 }


getUsersUsernameGpgKeys toMsg =
    Http.get
        { url = "/users/{username}/gpg_keys"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameHovercard toMsg =
    Http.get
        { url = "/users/{username}/hovercard"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameInstallation toMsg =
    Http.get
        { url = "/users/{username}/installation"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameKeys toMsg =
    Http.get
        { url = "/users/{username}/keys", expect = Http.expectJson toMsg 55 }


getUsersUsernameOrgs toMsg =
    Http.get
        { url = "/users/{username}/orgs", expect = Http.expectJson toMsg 55 }


getUsersUsernamePackages toMsg =
    Http.get
        { url = "/users/{username}/packages"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernamePackagesPackageTypePackageName toMsg =
    Http.get
        { url = "/users/{username}/packages/{package_type}/{package_name}"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernamePackagesPackageTypePackageNameVersions toMsg =
    Http.get
        { url =
            "/users/{username}/packages/{package_type}/{package_name}/versions"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernamePackagesPackageTypePackageNameVersionsPackageVersionId toMsg =
    Http.get
        { url =
            "/users/{username}/packages/{package_type}/{package_name}/versions/{package_version_id}"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameProjects toMsg =
    Http.get
        { url = "/users/{username}/projects"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameReceivedEvents toMsg =
    Http.get
        { url = "/users/{username}/received_events"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameReceivedEventsPublic toMsg =
    Http.get
        { url = "/users/{username}/received_events/public"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameRepos toMsg =
    Http.get
        { url = "/users/{username}/repos", expect = Http.expectJson toMsg 55 }


getUsersUsernameSettingsBillingActions toMsg =
    Http.get
        { url = "/users/{username}/settings/billing/actions"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameSettingsBillingPackages toMsg =
    Http.get
        { url = "/users/{username}/settings/billing/packages"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameSettingsBillingSharedStorage toMsg =
    Http.get
        { url = "/users/{username}/settings/billing/shared-storage"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameSshSigningKeys toMsg =
    Http.get
        { url = "/users/{username}/ssh_signing_keys"
        , expect = Http.expectJson toMsg 55
        }


getUsersUsernameStarred toMsg =
    Http.get
        { url = "/users/{username}/starred", expect = Http.expectJson toMsg 55 }


getUsersUsernameSubscriptions toMsg =
    Http.get
        { url = "/users/{username}/subscriptions"
        , expect = Http.expectJson toMsg 55
        }


getZen toMsg =
    Http.get { url = "/zen", expect = Http.expectJson toMsg 55 }


