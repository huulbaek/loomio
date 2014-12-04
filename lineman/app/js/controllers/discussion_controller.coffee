angular.module('loomioApp').controller 'DiscussionController', ($scope, $modal, discussion, MessageChannelService, EventService, FileUploadService, UserAuthService) ->
  onMessageReceived = ->
    console.log 'on message received called, yay'
    $scope.$digest()

  MessageChannelService.subscribeTo("/discussion-#{discussion.id}", onMessageReceived)
  #MessageChannelService.subscribeTo("/events", onMessageReceived)

  $scope.discussion = discussion
  $scope.discussionCopy = discussion.copy()

  $scope.wrap = {}
  nextPage = 1

  busy = false
  $scope.lastPage = false

  $scope.editDiscussion = ->
    modalInstance = $modal.open
      templateUrl: 'generated/templates/discussion_form.html',
      controller: 'DiscussionFormController',
      resolve:
        discussion: -> $scope.discussion.copy()

  $scope.getNextPage = ->
    return false if busy or $scope.lastPage
    busy = true
    EventService.fetch {discussion_id: discussion.id, page: nextPage}, (events) ->
      $scope.lastPage = true if events.length == 0
      nextPage = nextPage + 1
      busy = false

  $scope.getNextPage()

  $scope.safeEvent = (kind) ->
    _.contains ['new_comment', 'new_motion', 'new_vote'], kind

  $scope.$on 'replyToCommentClicked', (event, originalComment) ->
    $scope.$broadcast('showReplyToCommentForm', originalComment)

  $scope.canStartProposals = ->
    !discussion.hasActiveProposal() and UserAuthService.currentUser.canStartProposals($scope.discussion)

  $scope.showContextMenu = ->
    $scope.canEditDiscussion($scope.discussion)

  $scope.canEditDiscussion = ->
    UserAuthService.currentUser.canEditDiscussion($scope.discussion)

  $scope.inboxPinned = ->
    UserAuthService.inboxPinned
