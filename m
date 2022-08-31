Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C44B5A847F
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 19:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiHaRin (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 13:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiHaRii (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 13:38:38 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9847C419BC
        for <linux-arch@vger.kernel.org>; Wed, 31 Aug 2022 10:38:36 -0700 (PDT)
Received: (qmail 199346 invoked by uid 1000); 31 Aug 2022 13:38:35 -0400
Date:   Wed, 31 Aug 2022 13:38:35 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <Paul.Heidekrueger@in.tum.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH] tools/memory-model: Weaken ctrl dependency definition in
 explanation.txt
Message-ID: <Yw+cm+awhfi6IUHr@rowland.harvard.edu>
References: <20220830204446.3590197-1-paul.heidekrueger@in.tum.de>
 <663d568d-a343-d44b-d33d-29998bff8f70@joelfernandes.org>
 <98f2b194-1fe6-3cd8-36cf-da017c35198f@joelfernandes.org>
 <Yw7AEx1w6oWn86cm@rowland.harvard.edu>
 <935D3930-C369-4B0E-ACDC-5BFDFA85AA72@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <935D3930-C369-4B0E-ACDC-5BFDFA85AA72@in.tum.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 31, 2022 at 06:42:05PM +0200, Paul Heidekrüger wrote:
> On 31. Aug 2022, at 03:57, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Tue, Aug 30, 2022 at 05:12:33PM -0400, Joel Fernandes wrote:
> >> On 8/30/2022 5:08 PM, Joel Fernandes wrote:
> >>> On 8/30/2022 4:44 PM, Paul Heidekrüger wrote:
> >>>> The current informal control dependency definition in explanation.txt is
> >>>> too broad and, as dicsussed, needs to be updated.
> >>>> 
> >>>> Consider the following example:
> >>>> 
> >>>>> if(READ_ONCE(x))
> >>>>> 	return 42;
> >>>>> 
> >>>>> 	WRITE_ONCE(y, 42);
> >>>>> 
> >>>>> 	return 21;
> >>>> 
> >>>> The read event determines whether the write event will be executed "at
> >>>> all" - as per the current definition - but the formal LKMM does not
> >>>> recognize this as a control dependency.
> >>>> 
> >>>> Introduce a new defintion which includes the requirement for the second
> >>>> memory access event to syntactically lie within the arm of a non-loop
> >>>> conditional.
> >>>> 
> >>>> Link: https://lore.kernel.org/all/20220615114330.2573952-1-paul.heidekrueger@in.tum.de/
> >>>> Cc: Marco Elver <elver@google.com>
> >>>> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
> >>>> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
> >>>> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
> >>>> Cc: Martin Fink <martin.fink@in.tum.de>
> >>>> Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> >>>> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> >>>> ---
> >>>> 
> >>>> @Alan:
> >>>> 
> >>>> Since I got it wrong the last time, I'm adding you as a co-developer after my
> >>>> SOB. I'm sorry if this creates extra work on your side due to you having to
> >>>> resubmit the patch now with your SOB if I understand correctly, but since it's
> >>>> based on your wording from the other thread, I definitely wanted to give you
> >>>> credit.
> >>>> 
> >>>> tools/memory-model/Documentation/explanation.txt | 7 ++++---
> >>>> 1 file changed, 4 insertions(+), 3 deletions(-)
> >>>> 
> >>>> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> >>>> index ee819a402b69..0bca50cac5f4 100644
> >>>> --- a/tools/memory-model/Documentation/explanation.txt
> >>>> +++ b/tools/memory-model/Documentation/explanation.txt
> >>>> @@ -464,9 +464,10 @@ to address dependencies, since the address of a location accessed
> >>>> through a pointer will depend on the value read earlier from that
> >>>> pointer.
> >>>> 
> >>>> -Finally, a read event and another memory access event are linked by a
> >>>> -control dependency if the value obtained by the read affects whether
> >>>> -the second event is executed at all.  Simple example:
> >>>> +Finally, a read event X and another memory access event Y are linked by
> >>>> +a control dependency if Y syntactically lies within an arm of an if,
> >>>> +else or switch statement and the condition guarding Y is either data or
> >>>> +address-dependent on X.  Simple example:
> 
> Thank you both for commenting!
> 
> > "if, else or switch" should be just "if or switch".  In C there is no 
> > such thing as an "else" statement; an "else" clause is merely part of 
> > an "if" statement.  In fact, maybe "body" would be more appropriate than 
> > "arm", because "switch" statements don't have arms -- they have cases.
> 
> Right. What do you think of "branch"? "Body" to me suggests that there's
> only one and therefore that the else clause isn't included.
> 
> Would it be fair to say that switch statements have branches? I guess
> because switch statements are a convenient way of writing goto's, i.e.
> jumps, it's a stretch and basically the same as saying "arm"?
> 
> Maybe we can avoid the arm / case clash by just having a definition for if
> statements and appending something like "similarly for switch statements"?

That sounds good.

> >>> 'conditioning guarding Y' sounds confusing to me as it implies to me that the
> >>> condition's evaluation depends on Y. I much prefer Alan's wording from the
> >>> linked post saying something like 'the branch condition is data or address
> >>> dependent on X, and Y lies in one of the arms'.
> >>> 
> >>> I have to ask though, why doesn't this imply that the second instruction never
> >>> executes at all? I believe that would break the MP-pattern if it were not true.
> >> 
> >> About my last statement, I believe your patch does not disagree with the
> >> correctness of the earlier text but just wants to improve it. If that's case
> >> then that's fine.
> > 
> > The biggest difference between the original text and Paul's suggested 
> > update is that the new text makes clear that Y has to lie within the 
> > body of the "if" or "switch" statement.  If Y follows the end of the 
> > if/else, as in the example at the top of this email, then it does have 
> > not a control dependency on X (at least, not via that if/else), even 
> > though the value read by X does determine whether or not Y will execute.
> > 
> > [It has to be said that this illustrates a big weakness of the LKMM: It 
> > isn't cognizant of "goto"s or "return"s.  This naturally derives from 
> > limitations of the herd tool, but the situation could be improved.  So 
> > for instance, I don't think it would cause trouble to say that in:
> > 
> > 	if (READ_ONCE(x) == 0)
> > 		return;
> > 	WRITE_ONCE(y, 5);
> > 
> > there really is a control dependence from x to y, even though the 
> > WRITE_ONCE is outside the body of the "if" statement.  Certainly the 
> > compiler can't reorder the write before the read.  But AFAIK there's no 
> > way to include a "return" statement in a litmus test for herd.  Or a 
> > subroutine definition, for that matter.]
> > 
> > I agree that "condition guarding Y" is somewhat awkward.  "the 
> > condition of the if (or the expression of the switch)" might be better, 
> > even though it is somewhat awkward as well.  At least it's more 
> > explicit.
> 
> Maybe we can reuse the wording from the data and address dependency
> definition here and say "affects"?
> 
> Putting it all together:
> 
> > Finally, a read event X and another memory access event Y are linked by a
> > control dependency if Y syntactically lies within a branch of an if or
> > switch statement and X affects the evaluation of that statement's
> > condition via a data or address dependency.
> 
> Alternatively without the arm / case clash:
> 
> > Finally, a read event X and another memory access event Y are linked by a
> > control dependency if Y syntactically lies within an arm of an if
> > statement and X affects the evaluation of the if condition via a data or
> > address dependency.  Similarly for switch statements.
> 
> What do you think?

I like the second one.  How about combining the last two sentences?  

	... via a data or address dependency (or similarly for a switch 
	statement).

Now I suppose someone will pipe up and ask about the conditional 
expressions in "for", "while" and "do" statements...  :-)

Alan
