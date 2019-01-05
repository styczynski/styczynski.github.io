import * as React from 'react';
import styled  from 'styled-components';

import CardImage from 'components/CardImage';
import CardTitle from 'components/CardTitle';
import CardDescription from 'components/CardDescription';
import Badge from 'components/Badge';

const Wrapper = styled.div`
  padding: 1.2vw;
  margin: 1vw;
  width: 100%;
  border-left: 0.3vw solid ${(props) => props.theme.colors.primary};
  background: transparent;
  font-family: ${(props) => props.theme.primaryFont};
  color: ${(props) => props.theme.colors.primaryText};
  cursor: pointer;
  
  &:hover {
    border-left: 0.3vw solid ${(props) => props.theme.colors.primary};
    background: ${(props) => props.theme.colors.primaryGradient};
    color: ${(props) => props.theme.colors.accent};
  }
`;

const CardImageCell = styled.td`
  padding-top: 0;
`;

const CardTitleCell = styled.td`
  padding-top: 0;
`;

const BadgeWrapper = styled.div`
  display: inline-block;
  margin-right: 0.5vw;
`;

export interface CardProps {
    title: string;
    badges?: Array<string>;
    description?: any;
    image?: string;
    link?: string;
}

export default class Card extends React.Component<CardProps, undefined> {
    
    constructor(props) {
        super(props);
        
        this.handleClick = this.handleClick.bind(this);
    }
    
    handleClick() {
        if(this.props.link) {
            window.location.href = this.props.link;
        }
    }
    
    render() {
        return (
            <Wrapper onClick={this.handleClick}>
                <table>
                    <tbody>
                        <tr>
                            {
                                (!this.props.image)?(null):(
                                    <CardImageCell>
                                        <CardImage src={this.props.image} />
                                    </CardImageCell>
                                )
                            }
                            <CardTitleCell>
                                <CardTitle>
                                    {this.props.title}
                                </CardTitle>
                                {(this.props.badges || []).map(badge => {
                                    return (
                                        <BadgeWrapper>
                                            <Badge src={badge} />
                                        </BadgeWrapper>
                                    );
                                })}
                            </CardTitleCell>
                        </tr>
                    </tbody>
                </table>
                {
                    (!this.props.description)?(null):(
                        <div>
                            <CardDescription>
                                {this.props.description}
                            </CardDescription>
                        </div>
                    )
                }
            </Wrapper>
        );
    }
}
