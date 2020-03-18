import { gql } from "apollo-boost";

export const getName = gql`
    query {
        data (where: {name: {_eq: "John Smith"}}) {
            id
            description
            balance
            name
            notes
          }
    }`;