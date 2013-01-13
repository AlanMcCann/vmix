module Vmix
  module Configuration
    # An array of valid keys in the options hash when configuring a {Oas::Client}
    VALID_OPTIONS_KEYS = [
      :api_endpoint,
      :download_endpoint,
      :authentication,
      :token,
      :partner_id,
      :api_password].freeze

    # The endpoint that will be used to connect if none is set
    DEFAULT_API_ENDPOINT = "api.vmixcore.com/apis".freeze

    # The download endpoint that will be used to download media if none is set
    DEFAULT_DOWNLOAD_ENDPOINT = "media.vmixcore.com/vmixcore/download".freeze

    # The account that will be used to connect if none is set
    DEFAULT_AUTHENTICATION = 'token'.freeze

    # By default, don't set a token
    DEFAULT_TOKEN = nil

    # By default, don't set a username
    DEFAULT_PARTNERID = nil

    # By default, don't set a password
    DEFAULT_API_PASSWORD = nil

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self if block_given?
    end

    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k) }
      options
    end

    def reset
      self.api_endpoint = DEFAULT_API_ENDPOINT
      self.download_endpoint = DEFAULT_DOWNLOAD_ENDPOINT
      self.authentication = DEFAULT_AUTHENTICATION
      self.token = DEFAULT_TOKEN
      self.partner_id = DEFAULT_PARTNERID
      self.api_password = DEFAULT_API_PASSWORD
    end

    VMIX_METHODS =
      {
        # collection.php
        "collection" =>
          ["addCollectionToGroup",
          "addCollectionToGroup",
          "addMediaToCollection",
          "addNetworkMediaToAssets",
          "createCollection",
          "deleteCollection",
          "editCollection",
          "editCollectionMediaPosition",
          "editCollectionPrefs",
          "getCollectionMedias",
          "getCollectionPrefs",
          "getCollections",
          "getMediaCollections",
          "removeCollectionFromGroup",
          "removeMediaFromCollection",
          "removeNetworkMediaFromAssets"],

        # crypt.php
        "crypt" =>
          ["decrypt",
          "encrypt",
          "getKey"],

        # media.php

        "media" =>
          ["addToEncodeQueue",
          "createMetadataAttribute",
          "createSource",
          "genUploadToken",
          "getApprovalQueuedMediaCount",
          "getApprovalQueuedMedias",
          "getMedia",
          "getMediaCount",
          "getMediaFiles",
          "getMediaList",
          "getMediaMetadata",
          "getMediaUrl",
          "getMetadataAttributes",
          "getSource",
          "getStatusMap",
          "insertApprovalQueue",
          "removeFromApprovalQueue",
          "searchMedia",
          "setDefaultThumbnail",
          "updateMediaData"],

        # ReportedPost.php

        "ReportedPost" =>
          ["getReports",
          "editReportStatus",
          "createReport"],

        # stats.php

        "stats" =>
          ["getTopRankedMedia",
          "getRatingRankedMedia"],

        # comments.php
        "comments" =>
          ["addComment",
          "editComment",
          "editCommentStatus",
          "getComment",
          "getComments",
          "getCount"],

        # genre.php
        "genre" =>
          ["createGenre",
          "deleteGenre",
          "editGenre",
          "getGenres"],


        # ratings.php

        "ratings" =>
          ["createRatingGroup",
          "createRatingSystem",
          "deleteRatingSystemGroup",
          "createRatingSystemGroup",
          "getRatingGroups",
          "getRatings",
          "getRatingSummaries",
          "getRatingSummary",
          "getRatingSystems",
          "getRatingSystemsByGroup",
          "saveRatings",
          "updateRating",
          "updateRatingGroup",
          "updateRatingSystem"],


        # reports.php

        "reports" =>
          ["getTopApplications",
          "getTopCollections",
          "getTopDomains",
          "getTopGenres",
          "getTopMedia",
          "getTopPartners",
          "getExposure"],


        # tags.php

        "tags" =>
          ["createTags",
          "deleteTags",
          "fetchTagCloud",
          "fetchTags",
          "fetchTagsByTargetIds",
          "fetchTargetsByTag",
          "replaceTags"],
      }
  end
end