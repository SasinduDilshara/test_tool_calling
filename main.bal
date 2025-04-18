import ballerina/io;
import ballerinax/azure.openai.chat as chat;
import ballerina/time;

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

const TOTAL_ITERATIONS = 100;
int numberOfErrors = 0;
decimal totalDiff = 0;

record {
    decimal average;
    boolean isError;
}[] results = [];

public function main() returns error? {
    int index = 0;

    check io:fileWriteCsv("./epoch_results.csv", <map<anydata>[]>[], option = io:OVERWRITE);

    while index < TOTAL_ITERATIONS {
        decimal st = time:monotonicNow();
        chat:CreateChatCompletionResponse|error result = chatClient->/deployments/[deploymentId]/chat/completions.post(apiVersion, chatBody);
        decimal diff = time:monotonicNow() - st;

        if result is error {
            if result.message().includes("Error occurred while attempting to parse the response") {
                numberOfErrors += 1;
                index = index + 1;
            }
            
            io:println("Error occured:- ", result.message(), ":- ", numberOfErrors);
            continue;
        }

        io:println(index, ":- ", diff);
        totalDiff = totalDiff + diff;
        index = index + 1;

        check io:fileWriteCsv("./epoch_results.csv", [{
            index,
            diff
        }], option = io:APPEND);
    }

    io:println("avg for the batch", totalDiff/TOTAL_ITERATIONS);
    check io:fileWriteCsv("./final_results.csv", [{
        average: totalDiff/(TOTAL_ITERATIONS - numberOfErrors),
        numberOfErrors
    }], option = io:OVERWRITE);
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
