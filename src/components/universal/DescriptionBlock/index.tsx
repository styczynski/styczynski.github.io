import * as React from 'react';
import styled  from 'styled-components';

interface WrapperProps {
  fontSize?: string;
  theme?: any;
  fullBar?: boolean;
};

const Wrapper = styled.div<WrapperProps>`
  border: none;
  font-family: ${(props: WrapperProps) => props.theme.primaryFont};
  font-size: ${(props: WrapperProps) => props.theme.fontSize[props.fontSize || 'default']};
  color: ${(props: WrapperProps) => props.theme.colors.lightAccent};
  padding: ${(props: WrapperProps) => (props.fullBar)?('2.2vw'):('1.2vw')};
  width: ${(props: WrapperProps) => (props.fullBar)?('100vw'):('100%')};
  background: ${(props: WrapperProps) => (props.fullBar)?(props.theme.colors.primaryGradient):('transparent')};
  ${(props: WrapperProps) => (props.fullBar)?('position: relative; left: -4vw;'):('')}
`;

interface ContentWrapperProps {
  fontSize?: string,
  theme?: any
};

const ContentWrapper = styled.td<ContentWrapperProps>`
  width: 25vw;
  float: right;
`;

interface DescriptionWrapperProps {
  fontSize?: string;
  theme?: any;
  fullBar?: boolean;
};

const DescriptionTextWrapper = styled.div<DescriptionWrapperProps>`
  color: ${(props: DescriptionWrapperProps) => (props.fullBar)?(props.theme.colors.lightAccent):(props.theme.colors.primaryText)};
  font-family: ${(props: DescriptionWrapperProps) => props.theme.primaryFont};
  font-size: ${(props: DescriptionWrapperProps) => props.theme.fontSize[props.fontSize || 'default']};
  
  @media (max-width: 500px) {
      font-size: ${(props: WrapperProps) => props.theme.fontSize.XXL};
  }
`;


export interface DescriptionBoxProps {
    size?: string;
    children?: any;
    text?: any;
    content?: any;
    fullBar?: boolean;
}

export default class DescriptionBox extends React.Component<DescriptionBoxProps, undefined> {
    render() {
        return (
            <Wrapper fullBar={this.props.fullBar} fontSize={this.props.size}>
                <DescriptionTextWrapper fullBar={this.props.fullBar} fontSize={this.props.size}>
                    <ContentWrapper>
                        {this.props.children}
                    </ContentWrapper>
                    {this.props.text}
                    {this.props.content}
                </DescriptionTextWrapper>
            </Wrapper>
        );
    }
}
