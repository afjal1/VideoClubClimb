const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "flutter3": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://jaajfl2j7bbydfwebhmkivdc4i.appsync-api.us-east-1.amazonaws.com/graphql",
                    "region": "us-east-1",
                    "authorizationType": "AMAZON_COGNITO_USER_POOLS",
                    "apiKey": "da2-mfjjxrmo5bewbhcoj4k2zdiani"
                }
            }
        }
    },
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:9f671a94-4d63-4783-9c94-fce0c15991a5",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_ud0JjjUNI",
                        "AppClientId": "5bqm5fpvj8611kup97r38385od",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "socialProviders": [],
                        "usernameAttributes": [
                            "EMAIL"
                        ],
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "flutter3-storage153730-staging",
                        "Region": "us-east-1"
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://jaajfl2j7bbydfwebhmkivdc4i.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "flutter3_AMAZON_COGNITO_USER_POOLS"
                    },
                    "flutter3_AWS_IAM": {
                        "ApiUrl": "https://jaajfl2j7bbydfwebhmkivdc4i.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "flutter3_AWS_IAM"
                    },
                    "flutter3_API_KEY": {
                        "ApiUrl": "https://jaajfl2j7bbydfwebhmkivdc4i.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-mfjjxrmo5bewbhcoj4k2zdiani",
                        "ClientDatabasePrefix": "flutter3_API_KEY"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "flutter3-storage153730-staging",
                "region": "us-east-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';