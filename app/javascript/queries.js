import { gql } from "apollo-boost";

export const getName = gql`
    query {
        data {
            id
            description
            balance
            name
            notes
          }
    }`;