#!/usr/bin/perl -w
# Card Game by Robin May 16, 2013
#Rank: A(1),2,3,4,5,6,7,8,9,T(10),J(Jack),Q(Queen),K(King)
#Suite: C(Clubs), D(Diamonds), H(Hearts), and S(Spades)
#index:1,2,3,...,52
#deck is an array

use strict; 
use warnings;

#define a deck
#my @deck0=('AC','2C','3C','4C','5C','6C','7C','8C','9C','TC','JC','QC','KC',
#'AD','2D','3D','4D','5D','6D','7D','8D','9D','TD','JD','QD','KD',
#'AH','2H','3H','4H','5H','6H','7H','8H','9H','TH','JH','QH','KH',
#'AS','2S','3S','4S','5S','6S','7S','8S','9S','TS','JS','QS','KS'
#);
my @deck0=('AC','2C','3C','4C','5C','6C','7C','8C','9C','TC','JC','QC','KC',
);
my @draw_deck=();

#1. Draw(index)		---> Return Rank & Suit at random position
sub Draw
{
#print ("Array length is ",@deck0+0,"\n");
my $draw_index=int(rand(@deck0+0));
my $draw_card=$deck0[$draw_index-1];
splice(@deck0,($draw_index-1), 1);
print ("The random drawn card is ",$draw_card," , and ",@deck0+0," cards left in the deck now.\n");
@draw_deck=(@draw_deck,$draw_card);
}

#2. Find(Rank&Suit) 	---> Return index when input Rank & Suit
sub Find
{
print "Please input rank: A(1),2,3,4,5,6,7,8,9,T(10),J(Jack),Q(Queen),K(King)";
chomp(my $rank = <STDIN>);
$rank =~ tr/a-z/A-Z/;
print "Please input Suite: C(Clubs), D(Diamonds), H(Hearts), and S(Spades)";
chomp(my $suit = <STDIN>);
$suit =~ tr/a-z/A-Z/;
my $i;
for ($i=0;$i<@deck0+0;$i++)
{
	if (substr($deck0[$i],0,1) eq $rank and substr($deck0[$i],1,1) eq $suit )
	{
		print ("The Card ",$rank,$suit," is in the ",$i+1," postion.\n");
		exit;
	}

}
print("The Card ",$rank,$suit," is not in the deck, maybe you have drawn it already, please reset, and find it again.\n")
}

#3. Shuffling(deck)	---> deck
sub Shuffling
{
my $length=@deck0+0;
my @new_deck=();
my $i;
for ($i=0;$i<$length;$i++)
{
	my $draw_index=int(rand(@deck0+0));
	my $draw_card=$deck0[$draw_index-1];
	@new_deck=(@new_deck,$draw_card);
	splice(@deck0, $draw_index-1, 1);
}
@deck0=@new_deck;
}


#4. TriShuffle(deck)	---> deck
sub TriShuffle
{
my $deck0=@deck0+0;
my $deck1=int(rand($deck0-2))+1;
my $deck2=int(rand($deck0-$deck1-1))+1;
my $deck3=$deck0-$deck1-$deck2;
#print ($deck1+$deck2+$deck3,"= ",$deck1,"+",$deck2,"+",$deck3,"\n");
my @new_deck1=splice(@deck0, $deck1,$deck2);
my @new_deck2=splice(@deck0, $deck1,($deck0-$deck2));
#print (@deck0," **",@new_deck1," ** ",@new_deck2,"\n");

my $random_order=int(rand(6));
#print ($random_order,"\n");
if ($random_order==0)   {@deck0=(@deck0,@new_deck1,@new_deck2);}
elsif ($random_order==1){@deck0=(@deck0,@new_deck2,@new_deck1);}
elsif ($random_order==2){@deck0=(@new_deck1,@deck0,@new_deck2);}
elsif ($random_order==3){@deck0=(@new_deck1,@new_deck2,@deck0);}
elsif ($random_order==4){@deck0=(@new_deck2,@deck0,@new_deck1);}
elsif ($random_order==5){@deck0=(@new_deck2,@new_deck1,@deck0);}
else{print ("Wrong!!!\n");}
}

#5. RealShuffle(deck)	---> deck
sub RealShuffle
{
#Split the card into nearly half, mininum is 40%, and maximum is 60%
my $near_half=0.2*rand(1)+0.4;
my $deck_0=@deck0+0;

my $deck_1=int($deck_0*$near_half);
my @new_deck1=splice(@deck0, 0,$deck_1);
my @new_deck2=splice(@deck0, 0,$deck_0);
my $card;
my $i;

if($deck_1 <($deck_0-$deck_1))
{
for ($i=0;$i<$deck_1;$i++)
{
$card=$new_deck1[0];
splice(@new_deck1, 0,1);
@deck0=(@deck0,$card);
$card=$new_deck2[0];
splice(@new_deck2, 0,1);
@deck0=(@deck0,$card)
}
@deck0=(@deck0,@new_deck2);
}
else
{
for ($i=0;$i<($deck_0-$deck_1);$i++)
{
$card=$new_deck1[0];
splice(@new_deck1, 0,1);
@deck0=(@deck0,$card);
$card=$new_deck2[0];
splice(@new_deck2, 0,1);
@deck0=(@deck0,$card)
}
@deck0=(@deck0,@new_deck1);
}
#print ("Length:",@deck0+0,"  ",@deck0,"\n");
}

#6. Reset(deck)		---> deck
sub Reset
{
@deck0=(@deck0,@draw_deck);
Shuffling();
}

my $function=7;
while($function!=0){
print ("1. Drawing a card\t2. Finding a card\t3. Shuffling randomly\n");
print ("4. 3-way-cut Shuffle\t5. Realistic Shuffle\t6. Resetting\n");
print ("0.Exit\n");
print "Please choose function number: (0-6): ";
chomp($function = <STDIN>);
if ($function==1)	{Draw();print ("Done. The deck is ",@deck0," now.\n\n")}
elsif ($function==2)	{Find();print ("Done. The deck is ",@deck0," now.\n\n")}
elsif ($function==3)	{Shuffling();print ("Done. The deck is ",@deck0," now.\n\n")}
elsif ($function==4)	{TriShuffle();print ("Done. The deck is ",@deck0," now.\n\n")}
elsif ($function==5)	{RealShuffle();print ("Done. The deck is ",@deck0," now.\n\n")}
elsif ($function==6)	{Reset();print ("Done. The deck is ",@deck0," now.\n\n")}
elsif ($function==0)	{print "Thank you! Play again next time ! \n\n";}
else{print ("Wrong choice! Please choose again!\n\n");}
}
