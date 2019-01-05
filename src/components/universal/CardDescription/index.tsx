import * as React from 'react';
import styled  from 'styled-components';

interface WrapperProps {
  fontSize?: string;
  theme?: any;
};

const Wrapper = styled.div`
  font-family: ${(props: WrapperProps) => props.theme.primaryFont};
  font-size: ${(props: WrapperProps) => props.theme.fontSize[props.fontSize || 'default']};
  
  @media (max-width: 500px) {
      font-size: ${(props: WrapperProps) => props.theme.fontSize.XXL};
  }
`;

export interface CardDescriptionProps {
    children: string;
};

export default class CardDescription extends React.Component<CardDescriptionProps, undefined> {
    
    render() {
        return (
            <Wrapper>
                {this.props.children}
            </Wrapper>
        );
    }
}
