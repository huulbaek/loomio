angular.module('loomioApp').directive 'proposal', ->
  scope: {proposal: '=', discussion: '=', currentUser: '='}
  restrict: 'E'
  templateUrl: 'generated/templates/proposal.html'
  replace: true
  controller: 'ProposalController'
  link: (scope, element, attrs) ->