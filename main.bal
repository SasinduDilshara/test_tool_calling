import ballerina/io;
import ballerinax/azure.openai.chat as chat;

configurable string apiKey = ?;
configurable string serviceUrl = ?;
configurable string deploymentId = ?;
configurable string apiVersion = ?;

string prompt = "Provide detailed information for the user 'Elon Musk'";

chat:CreateChatCompletionRequest chatBody = {
    messages: [
        {role: "user", "content": prompt}
    ],
    tools: [
        {
            'type: "function",
            'function: {
                name: "get_results",
                description: prompt,
                parameters: jsonSchema
            }
        }
    ]
};

final chat:Client chatClient = check new (
    config = {
        auth: {apiKey: apiKey},
        timeout: 25
    },
    serviceUrl = serviceUrl
);

public function main() returns error? {
    chat:CreateChatCompletionResponse chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    chatResult = check chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
    record {|
        chat:ChatCompletionResponseMessage message?;
        chat:ContentFilterChoiceResults content_filter_results?;
        int index?;
        string finish_reason?;
        anydata...;
    |}[]? choices = chatResult.choices;

    if (choices is ()) {
        io:println("No completion found!");
        return;
    }

    io:println(choices[0].message?.tool_calls);
}


record {} jsonSchema = {
    "required": [
        "address",
        "certifications",
        "contactInfo",
        "educationHistory",
        "hobbies",
        "job",
        "name",
        "skills"
    ],
    "type": "object",
    "properties": {
        "name": {
            "type": "string"
        },
        "address": {
            "required": [
                "city",
                "street",
                "zipCode"
            ],
            "type": "object",
            "properties": {
                "street": {
                    "type": "string"
                },
                "city": {
                    "type": "string"
                },
                "zipCode": {
                    "type": "string"
                }
            }
        },
        "job": {
            "required": [
                "company",
                "department",
                "projects",
                "title"
            ],
            "type": "object",
            "properties": {
                "title": {
                    "type": "string"
                },
                "company": {
                    "required": [
                        "headquarters",
                        "industry",
                        "name",
                        "website"
                    ],
                    "type": "object",
                    "properties": {
                        "name": {
                            "type": "string"
                        },
                        "industry": {
                            "type": "string"
                        },
                        "headquarters": {
                            "required": [
                                "city",
                                "street",
                                "zipCode"
                            ],
                            "type": "object",
                            "properties": {
                                "street": {
                                    "type": "string"
                                },
                                "city": {
                                    "type": "string"
                                },
                                "zipCode": {
                                    "type": "string"
                                }
                            }
                        },
                        "website": {
                            "type": "string"
                        }
                    }
                },
                "department": {
                    "type": "string"
                },
                "projects": {
                    "type": "array",
                    "items": {
                        "required": [
                            "description",
                            "name",
                            "team",
                            "technologyUsed",
                            "yearStarted"
                        ],
                        "type": "object",
                        "properties": {
                            "name": {
                                "type": "string"
                            },
                            "description": {
                                "type": "string"
                            },
                            "technologyUsed": {
                                "type": "string"
                            },
                            "yearStarted": {
                                "type": "integer",
                                "format": "int64"
                            },
                            "team": {
                                "required": [
                                    "members",
                                    "name",
                                    "role"
                                ],
                                "type": "object",
                                "properties": {
                                    "name": {
                                        "type": "string"
                                    },
                                    "role": {
                                        "type": "string"
                                    },
                                    "members": {
                                        "type": "array",
                                        "items": {
                                            "type": "string"
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        },
        "contactInfo": {
            "required": [
                "email",
                "phoneNumber",
                "socialMedia"
            ],
            "type": "object",
            "properties": {
                "phoneNumber": {
                    "type": "string"
                },
                "email": {
                    "type": "string"
                },
                "socialMedia": {
                    "type": "string"
                }
            }
        },
        "educationHistory": {
            "type": "array",
            "items": {
                "required": [
                    "degree",
                    "institution",
                    "major",
                    "yearOfGraduation"
                ],
                "type": "object",
                "properties": {
                    "degree": {
                        "type": "string"
                    },
                    "institution": {
                        "type": "string"
                    },
                    "yearOfGraduation": {
                        "type": "integer",
                        "format": "int64"
                    },
                    "major": {
                        "type": "string"
                    }
                }
            }
        },
        "skills": {
            "type": "array",
            "items": {
                "required": [
                    "name",
                    "proficiencyLevel"
                ],
                "type": "object",
                "properties": {
                    "name": {
                        "type": "string"
                    },
                    "proficiencyLevel": {
                        "type": "string"
                    }
                }
            }
        },
        "certifications": {
            "type": "array",
            "items": {
                "required": [
                    "issuedBy",
                    "title",
                    "yearIssued"
                ],
                "type": "object",
                "properties": {
                    "title": {
                        "type": "string"
                    },
                    "issuedBy": {
                        "type": "string"
                    },
                    "yearIssued": {
                        "type": "integer",
                        "format": "int64"
                    }
                }
            }
        },
        "hobbies": {
            "type": "array",
            "items": {
                "required": [
                    "description",
                    "name"
                ],
                "type": "object",
                "properties": {
                    "name": {
                        "type": "string"
                    },
                    "description": {
                        "type": "string"
                    }
                }
            }
        }
    }
};
