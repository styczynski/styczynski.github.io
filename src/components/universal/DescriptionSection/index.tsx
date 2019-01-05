import * as React from 'react';
import styled  from 'styled-components';

import Description from 'components/Description';
import DescriptionBlock from 'components/DescriptionBlock';
import Text from 'components/Text';
import Card from 'components/Card';
import DetailsPane from 'components/DetailsPane';
import * as Popover from 'react-popover';
import Logo, { LogoType } from 'components/Logo';

export interface SectionItem {
    title: string;
    link: string;
    description: string;
    badges?: Array<string>;
    more: string;
};

const ActiveDescriptionWrapper = styled.div`
    height: 20vw;
    color: ${(props) => props.theme.colors.primaryText};
`;

export interface DescriptionSectionProps {
    children?: Array<SectionItem>;
    logo: string;
    text: string;
    block?: boolean;
    fullBar?: boolean;
};

interface DescriptionSectionState {
    hovered: boolean;
    activeCards: Map<number, boolean>;
    activeMoreCardIndex: number;
};

export default class DescriptionSection extends React.Component<DescriptionSectionProps, DescriptionSectionState> {
    state: DescriptionSectionState;
    
    constructor(props) {
        super(props);
        
        this.state = {
            hovered: false,
            activeCards: new Map(),
            activeMoreCardIndex: null
        };
        
        this.getActiveCardIndex = this.getActiveCardIndex.bind(this);
        this.handleMouseOverCard = this.handleMouseOverCard.bind(this);
        this.handleMouseOutCard = this.handleMouseOutCard.bind(this);
        this.handleMoreCard = this.handleMoreCard.bind(this);
        this.handleMoreHideCard = this.handleMoreHideCard.bind(this);
        this.handleMouseOver = this.handleMouseOver.bind(this);
        this.handleMouseOut = this.handleMouseOut.bind(this);
    }
    
    handleMoreCard(item: SectionItem, index: number) {
        this.setState({
            activeMoreCardIndex: index
        });
    }
    
    handleMoreHideCard(item: SectionItem, index: number) {
        this.setState({
            activeMoreCardIndex: null
        });
    }
    
    handleMouseOverCard(item: SectionItem, index: number) {
        this.setState({
            activeCards: new Map(this.state.activeCards).set(index, true)
        });
    }
    
    handleMouseOutCard(item: SectionItem, index: number) {
        this.setState({
            activeCards: new Map(this.state.activeCards).set(index, false)
        });
    }
    
    handleMouseOver() {
        this.setState({
            hovered: true
        });
    }
    
    handleMouseOut() {
        this.setState({
            hovered: false
        });
    }
    
    getActiveCardIndex() {
        let result = null;
        if(!this.state.hovered) return null;
        this.state.activeCards.forEach((isActive, cardIndex) => {
            if(result === null && isActive) {
                result = cardIndex;
            }
        });
        return result;
    }
    
    render() {
        const DescriptionComponent = (this.props.block)?(DescriptionBlock):(Description);
        
        let contentNode = (
            <Logo type={this.props.logo} />
        );
        
        const activeCardIndex = this.getActiveCardIndex();
        /*if(activeCardIndex !== null && !this.props.block) {
            contentNode = (
                <ActiveDescriptionWrapper>
                    <DetailsPane />
                </ActiveDescriptionWrapper>
            );
        }*/
        
        return (
            <DescriptionComponent
              size='L'
              text={<Text translate>{this.props.text}</Text>}
              onMouseOver={this.handleMouseOver}
              onMouseOut={this.handleMouseOut}
              fullBar={this.props.fullBar}
              content={
                  <div>
                      {
                          (this.props.children || []).map((item, index) => {
                              return (
                                   <Popover
                                       body={<DetailsPane description={item.more}/>}
                                       isOpen={index === this.state.activeMoreCardIndex}
                                       onOuterAction={() => this.handleMoreHideCard(item, index)}
                                   >
                                       <Card
                                           title={item.title}
                                           link={item.link}
                                           badges={item.badges}
                                           description={<Text translate>{item.description}</Text>}
                                           onMouseOver={() => this.handleMouseOverCard(item, index)}
                                           onMouseOut={() => this.handleMouseOutCard(item, index)}
                                           onMore={() => this.handleMoreCard(item, index)}
                                           more
                                           hoverable={!this.props.fullBar}
                                       />
                                   </Popover>
                              );
                          })
                      }
                  </div>
              }
            >
                {contentNode}
            </DescriptionComponent>
        );
    }
}
