import 'package:picnic_app/core/data/graphql/templates/gql_template.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_comment.dart';
import 'package:picnic_app/core/data/graphql/templates/gql_template_success_payload.dart';

String get createCommentMutation => '''
mutation (\$postId: ID!, \$parentId: ID!, \$text: String!){
  createComment(data: {
    postId: \$postId
    parentId: \$parentId
    text: \$text
  }){
    ${GqlTemplate().comment}
  }
}
''';

String get deleteCommentMutation => '''
mutation deleteComment(\$params: DeleteCommentInput!) {
  deleteComment(data: \$params) {
    ${GqlTemplate().successPayload}
  }
}
''';

String get pinCommentMutation => '''
mutation pinComment(\$commentId: ID!, \$order: Int!) {
  pinComment(commentId: \$commentId, order: \$order) {
    ${GqlTemplate().successPayload}
  }
}
''';

String get unpinCommentMutation => '''
mutation unpinComment(\$commentId: ID!) {
  unpinComment(commentId: \$commentId) {
    ${GqlTemplate().successPayload}
  }
}
''';

const String reactCommentMutation = r'''
mutation ($id: String!, $react: Boolean!) {
    setReactComment(data: {
        id: $id
        react: $react
        reaction: ":heart:"
    }){
        success
    }
}
''';

String get getCommentByIdQuery => """
query(\$id: ID!){
        getComment(id: \$id){   
            ${GqlTemplate().comment}
        }
    }
""";
