import * as React from 'react';
import styled  from 'styled-components';

import Logo from 'components/Logo';
import Text from 'components/Text';

const Wrapper = styled.div`
  background: rgba(0, 11, 99, 0.8);
  color: ${(props) => props.theme.colors.lightAccent};
  font-family: ${(props) => props.theme.primaryFont};
  font-size: ${(props) => props.theme.fontSize.M};
  width: 100%;
  height: 100%;
`;

const LogoWrapper = styled.tr`
  width: 10vw;
  display: inline-block;
`;

const DescriptionWrapper = styled.tr`
  display: inline-block;
  padding-right: 4vw;
  width: 20vw;
`;

export interface DetailsPaneProps {
    description: string;
};

export default class DetailsPane extends React.Component<DetailsPaneProps, undefined> {

    render() {
        return (
            <Wrapper>
                 <table>
                    <tr>
                        <LogoWrapper>
                           <Logo type='Rocket' />
                        </LogoWrapper>
                        <DescriptionWrapper>
                           <Text translate>{this.props.description}</Text>
                        </DescriptionWrapper>
                    </tr>
                 </table>
            </Wrapper>
        );
    }
}
