import * as React from 'react';
import styled  from 'styled-components';

const Wrapper = styled.span`
    @media (max-width: 550px) {
        & img {
            height: 2vw;
        }
    }
`;

export interface BadgeProps {
    src: string;
}

export default class Badge extends React.Component<BadgeProps, undefined> {
    
    render() {
        return (
            <Wrapper>
                <img src={`https://img.shields.io/${this.props.src}`} />
            </Wrapper>
        );
    }
}
