import * as React from 'react';
import styled  from 'styled-components';

import CardImage from 'components/CardImage';
import CardTitle from 'components/CardTitle';
import CardDescription from 'components/CardDescription';
import Badge from 'components/Badge';

interface WrapperProps {
    theme: any;
    hoverable?: boolean;
    onMouseOver: () => void;
    onMouseOut: () => void;    
};

const Wrapper = styled.div<WrapperProps>`
  padding: 1.2vw;
  margin: 1vw;
  width: 100%;
  max-width: 80vw;
  border-left: 0.3vw solid ${(props: WrapperProps) => props.theme.colors.primary};
  background: transparent;
  font-family: ${(props: WrapperProps) => props.theme.primaryFont};
  color: ${(props: WrapperProps) => (props.hoverable === false)?(props.theme.colors.accent):(props.theme.colors.primaryText)};
  cursor: pointer;
  
  &:hover {
    border-left: 0.3vw solid ${(props: WrapperProps) => props.theme.colors.primary};
    background: ${(props: WrapperProps) => props.theme.colors.primaryGradient};
    color: ${(props: WrapperProps) => props.theme.colors.accent};
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

const MoreWrapper = styled.div`
  font-family: ${(props) => props.theme.primaryFont};
  width: 10vw;
  border: solid 0.15vw transparent;
  
  &:hover {
    border: solid 0.15vw ${(props) => props.theme.colors.lightAccent};
  }
  
  @media (max-width: 768px) {
    display: none;
  }
`;

export interface CardProps {
    title: string;
    badges?: Array<string>;
    description?: any;
    image?: string;
    link?: string;
    more?: boolean;
    hoverable?: boolean;
    onMore?: () => void;
    onMouseOver?: () => void;
    onMouseOut?: () => void;
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
            <Wrapper
                onMouseOver={this.props.onMouseOver}
                onMouseOut={this.props.onMouseOut}
                hoverable={this.props.hoverable}
            >
                <table onClick={this.handleClick}>
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
                {
                    (!this.props.more)?(null):(
                        <MoreWrapper
                            onClick={this.props.onMore}
                        >
                            More...
                        </MoreWrapper>
                    )
                }
            </Wrapper>
        );
    }
}
