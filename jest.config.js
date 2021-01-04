module.exports = {
    "roots": [
      "<rootDir>/frontend/candidates"
    ],
    "transform": {
      "^.+\\.tsx?$": "ts-jest",
      ".+\\.(css|styl|less|sass|scss)$": "jest-transform-css"
    },
    "snapshotSerializers": [
      "enzyme-to-json/serializer"
    ],
    "setupFilesAfterEnv": [
      "<rootDir>/frontend/candidates/setupEnzyme.tsx"
    ]
}