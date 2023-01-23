@Functional @projectsWebService @projectsController
Feature: Verify that ProjectsWebService is able to use its projects controller and all of its endpoints

  Background:
    Given I have an Api Testing Project
    When I call the health check endpoint for projects service
    Then the health check should show that the service is up

  @httpGET @getProjectDetails
  Scenario: Verify that project details can be accessed through the project/api/v3/details/{id} endpoint
    Given The projects service's "project/api/v3/details/{id}" endpoint exists and accepts GET
    When I create a new projects service request to get project details
    Then I set the get project request's project id as the api testing project's id
    * I am using the V3 endpoint in projects service for my get project request
    When I send the get project details request to the get project details endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a com.aetion.projects.dto.ProjectDetailsDTO
    * the ProjectDetailsDTO should have an id of the api testing project's id

  @httpGET @getProjectByFolder
  Scenario: Verify that get project by folder can be accessed through the project/api/v3/folders/{id} endpoint
    Given The projects service's "project/api/v3/folders/{id}" endpoint exists and accepts GET
    When I create a new projects service request to get project by folder
    Then I set the get project by folder request's folder type as measure
    Then I set the get project by folder request's folder id as the api testing project's measure folder id
    When I send the get project by folder request to the get project by folder endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a com.aetion.projects.dto.ProjectDetailsDTO
    * the ProjectDetailsDTO should have an id of the api testing project's id

  @httpGET @listProjects
  Scenario: Verify that list projects can be accessed through the project/api/v3/list endpoint
    Given The projects service's "project/api/v3/list" endpoint exists and accepts GET
    When I send the list projects request to the list projects endpoint in projects service
    And I am using the V3 endpoint in projects service for my list projects request
    When I send the list projects request to the list projects endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a com.aetion.projects.dto.PagedDTO

  @httpGET @getProjectCohortJobLibraryForId
  Scenario: Verify that getProjectCohortJobLibraryForId can be accessed through the api/v3/project/{id}/library/cohortJob endpoint
    Given The projects service's "api/v3/project/{id}/library/cohortJob" endpoint exists and accepts GET
    When I create a new projects service request to get project's cohort job library
    And I am using the V3 endpoint in projects service for my get project request
    Then I set the get project request's project id as the api testing project's id
    When I send the get project request to the get project's cohort job library endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a java.lang.Long
    * the Long in the response body should match the folder id, the api testing project's cohort job folder id

  @httpGET @getProjectResultLibraryForId
  Scenario: Verify that getProjectResultJobLibraryForId can be accessed through the api/v3/project/{id}/library/resultJob endpoint
    Given The projects service's "api/v3/project/{id}/library/resultJob" endpoint exists and accepts GET
    When I create a new projects service request to get a project's result job library
    And I am using the V3 endpoint in projects service for my get project request
    Then I set the get project request's project id as the api testing project's id
    When I send the get project request to the get project's result job library endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a java.lang.Long
    * the Long in the response body should match the folder id, the api testing project's result job folder id

  @httpGET @getInternalProjects
  Scenario: Verify that getInternalProjects can be accessed through the api/v3/project/internals endpoint
    Given The projects service's "api/v3/project/internals" endpoint exists and accepts GET
    When I create a new projects service request to get internal projects for an instance
    And I am using the V3 endpoint in projects service for my get projects request
    Then I add the api testing project's id to the get projects request's id list
    When I send the get projects request to the get internal projects for an instance endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a collection, java.util.List, of java.lang.Long
    Then the project ids should match the internal projects' ids sent

  @httpGET @getProjectNames
  Scenario: Verify that getInternalProjects can be accessed through the api/v3/project/names endpoint
    Given The projects service's "api/v3/project/names" endpoint exists and accepts GET
    When I create a new projects service request to get projects' names
    And I am using the V3 endpoint in projects service for my get projects request
    Then I add the api testing project's id to the get projects request's id list
    When I send the get projects request to the get projects' names endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a collection, java.util.List, of com.aetion.projects.dto.ProjectIdAndName
    Then the project id and names should match the project id names in the get projects request

  @httpPOST @createProject
  Scenario: Verify that createProject can be accessed through the api/v3/project endpoint
    Given The projects service's "api/v3/project" endpoint exists and accepts POST
    When I create a new projects service request to create a project
    And I am using the V3 endpoint in projects service for my create a project request
    And I add my user id and the new project's name as "API Testing: Create Project" to the create project request
    When I send the create project request to the create a project endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a com.aetion.projects.dto.ProjectDetailsDTO
    * the ProjectDetailsDTO should have a createdByUserId of my user id
    And I remember the project I created

  @httpDELETE @deleteProject
  Scenario: Verify that deleteProject can be accessed through the api/v3/project/{id} endpoint
    Given The projects service's "api/v3/project/{id}" endpoint exists and accepts DELETE
    When I create a new projects service request to delete a project
    And I am using the V3 endpoint in projects service for my get project request
    Then I set the get project request's project id as the created project's id
    When I send the get project request to the delete a project endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a com.aetion.projects.dto.ProjectDetailsDTO
    * the ProjectDetailsDTO should have an id of the created project's id
    * the project's state should show that it is deleted

  @httpPUT @archiveProject
  Scenario: Verify that archiveProject can be accessed through the api/v3/project/archive/{id} endpoint
    Given The projects service's "api/v3/project/archive/{id}" endpoint exists and accepts PUT
    When I create a new projects service request to archive a project
    And I am using the V3 endpoint in projects service for my get project request
    Then I set the get project request's project id as the api testing project's id
    When I send the get project request to the archive a project endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a com.aetion.projects.dto.ProjectDetailsDTO
    * the ProjectDetailsDTO should have an id of the api testing project's id
    * the project's state should show that it is archived

  @httpPUT @unarchive
  Scenario: Verify that unarchive can be accessed through the api/v3/project/unarchive/{id} endpoint
    Given The projects service's "api/v3/project/unarchive/{id}" endpoint exists and accepts PUT
    When I create a new projects service request to unarchive a project
    And I am using the V3 endpoint in projects service for my get project request
    Then I set the get project request's project id as the api testing project's id
    When I send the get project request to the unarchive a project endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a com.aetion.projects.dto.ProjectDetailsDTO
    * the ProjectDetailsDTO should have an id of the api testing project's id
    * the project's state should show that it is active

  @httpPOST @cloneProject
  Scenario: Verify that cloneProject can be accessed through the api/v3/project/clone/{userId}/{id} endpoint
    Given The projects service's "api/v3/project/unarchive/{userId}/{id}" endpoint exists and accepts POST
    When I create a new projects service request to clone a project
    And I am using the V3 endpoint in projects service for my clone a project request
    Then I set the clone project request's project id as the api testing project's id
    Then I set the clone project request's x-user-id header's user id as my own
    When I send the clone a project request to the clone a project endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a com.aetion.projects.dto.ProjectCloneDTO
    * the ProjectCloneDTO should have the original project's folder ids
    And I remember the project I cloned

  @httpPUT @updateProject
  Scenario: Verify that updateProject can be accessed through the api/v3/project/update/{userId}/{id} endpoint
    Given The projects service's "api/v3/project/update/{userId}/{id}" endpoint exists and accepts PUT
    When I create a new projects service request to update a project
    And I am using the V3 endpoint in projects service for my update project request
    Then I set the update project request's project id as the created project's id
    Then I set the update project request's x-user-id header's user id as my own
    * I set the update project request's description as a random 10 character alphanumeric String
    When I send the update project request to the update project endpoint in projects service
    Then I should have received an OK response
    * the response should contain valid JSON
    * the response body should contain a com.aetion.projects.dto.ProjectDetailsDTO
    * the ProjectDetailsDTO should have the updated description
    And I remember the project I updated
