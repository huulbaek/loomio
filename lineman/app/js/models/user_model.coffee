angular.module('loomioApp').factory 'UserModel', (RecordStoreService) ->
  class UserModel
    constructor: (data = {}) ->
      @id = data.id
      @name = data.name
      @avatarKind = data.avatar_kind
      @avatarUrl = data.avatar_url
      @avatarInitials = data.avatar_initials

    plural: 'users'