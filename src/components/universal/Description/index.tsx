import * as React from 'react';
import styled  from 'styled-components';

interface WrapperProps {
  fontSize?: string,
  theme?: any
};

const Wrapper = styled.div<WrapperProps>`
  border: none;
  font-family: ${(props: WrapperProps) => props.theme.primaryFont};
  font-size: ${(props: WrapperProps) => props.theme.fontSize[props.fontSize || 'default']};
  color: ${(props: WrapperProps) => props.theme.colors.lightAccent};
  padding: 1.2vw;
  width: 100%;
`;

interface ContentWrapperProps {
  fontSize?: string,
  theme?: any
};

const ContentWrapper = styled.td<ContentWrapperProps>`
  width: 25vw;
`;

interface DescriptionWrapperProps {
  fontSize?: string,
  theme?: any
};

const DescriptionWrapper = styled.td<DescriptionWrapperProps>`
  height: 1px;
`;

//${props => props.theme.colors.primaryGradient};
const Divider = styled.div<DescriptionWrapperProps>`
  background: transparent;
  height: 100%;
  width: 0.30vw;
  min-height: 13vw;
  float: left;
  margin-right: 3vw;
`;

const Table = styled.table`
  width: 100%;
`;

interface DescriptionTextWrapperProps {
  fontSize?: string;
  theme?: any;
};

const DescriptionTextWrapper = styled.div<DescriptionTextWrapperProps>`
  color: ${(props: DescriptionTextWrapperProps) => props.theme.colors.primaryText};
  font-family: ${(props: DescriptionTextWrapperProps) => props.theme.primaryFont};
  font-size: ${(props: DescriptionTextWrapperProps) => props.theme.fontSize[props.fontSize || 'default']};
  
  @media (max-width: 500px) {
      font-size: ${(props: WrapperProps) => props.theme.fontSize.XXL};
  }
`;


export interface DescriptionProps {
    size?: string;
    children?: any;
    text?: any;
    content?: any;
    fullBar?: boolean;
    onMouseOver?: () => void;
    onMouseOut?: () => void;
}

export default class Description extends React.Component<DescriptionProps, undefined> {
    render() {
        return (
            <Wrapper
                fontSize={this.props.size}
                onMouseOver={this.props.onMouseOver}
                onMouseOut={this.props.onMouseOut}
            >
                <Table>
                    <tbody>
                        <tr>
                            <ContentWrapper>
                                {this.props.children}
                            </ContentWrapper>
                            <DescriptionWrapper>
                                <Divider />
                                <DescriptionTextWrapper fontSize={this.props.size}>
                                    {this.props.text}
                                    {this.props.content}
                                </DescriptionTextWrapper>
                            </DescriptionWrapper>
                        </tr>
                    </tbody>
                </Table>
            </Wrapper>
        );
    }
}
