Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26825A85AC
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 20:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiHaScc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 14:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiHaScP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 14:32:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6909E11B3CA;
        Wed, 31 Aug 2022 11:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFA5DB82276;
        Wed, 31 Aug 2022 18:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96713C433C1;
        Wed, 31 Aug 2022 18:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661970443;
        bh=oEHypOLBHy6WPhJaawTtdgVBGVSPkKMoNZ/Oavk7OLs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IT+XEBuox1oVQ9wF5uoF1KW3YETq3IrGjd6OjgqiKtwdgK+yhkIaYsm3p0Wuh0k6Q
         65IR3kFEVnM/phw4px+XbMr/5gEuBp2AdSJMmqFU/mJ/26UMRuT50cKZoWL7t9VEvt
         kgIiyxeY8uIbSFNMlAFSlv/ZTpOi9HxbomS6kVdDDpg3qagfV0glTFZcDMCb4s0CGV
         tCV3dvbRXEG7CnwHb+Ux0EKhGZObFgrdb71oEo3AJGna1NDZybAY+7AXmpIDkNXaMu
         n7oJ3vwiI3ssCclreEa8WfbZ09aqc4SJACYRmIobP9770Jv0UgXH1mtELVLkDn50cI
         y8NdqKyZJ1Opg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 402D35C015D; Wed, 31 Aug 2022 11:27:23 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:27:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <Paul.Heidekrueger@in.tum.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
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
Message-ID: <20220831182723.GM6159@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220830204446.3590197-1-paul.heidekrueger@in.tum.de>
 <663d568d-a343-d44b-d33d-29998bff8f70@joelfernandes.org>
 <98f2b194-1fe6-3cd8-36cf-da017c35198f@joelfernandes.org>
 <Yw7AEx1w6oWn86cm@rowland.harvard.edu>
 <935D3930-C369-4B0E-ACDC-5BFDFA85AA72@in.tum.de>
 <Yw+cm+awhfi6IUHr@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yw+cm+awhfi6IUHr@rowland.harvard.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 31, 2022 at 01:38:35PM -0400, Alan Stern wrote:
> On Wed, Aug 31, 2022 at 06:42:05PM +0200, Paul Heidekrüger wrote:
> > On 31. Aug 2022, at 03:57, Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > > On Tue, Aug 30, 2022 at 05:12:33PM -0400, Joel Fernandes wrote:
> > >> On 8/30/2022 5:08 PM, Joel Fernandes wrote:
> > >>> On 8/30/2022 4:44 PM, Paul Heidekrüger wrote:
> > >>>> The current informal control dependency definition in explanation.txt is
> > >>>> too broad and, as dicsussed, needs to be updated.
> > >>>> 
> > >>>> Consider the following example:
> > >>>> 
> > >>>>> if(READ_ONCE(x))
> > >>>>> 	return 42;
> > >>>>> 
> > >>>>> 	WRITE_ONCE(y, 42);
> > >>>>> 
> > >>>>> 	return 21;
> > >>>> 
> > >>>> The read event determines whether the write event will be executed "at
> > >>>> all" - as per the current definition - but the formal LKMM does not
> > >>>> recognize this as a control dependency.
> > >>>> 
> > >>>> Introduce a new defintion which includes the requirement for the second
> > >>>> memory access event to syntactically lie within the arm of a non-loop
> > >>>> conditional.
> > >>>> 
> > >>>> Link: https://lore.kernel.org/all/20220615114330.2573952-1-paul.heidekrueger@in.tum.de/
> > >>>> Cc: Marco Elver <elver@google.com>
> > >>>> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
> > >>>> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
> > >>>> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
> > >>>> Cc: Martin Fink <martin.fink@in.tum.de>
> > >>>> Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> > >>>> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> > >>>> ---
> > >>>> 
> > >>>> @Alan:
> > >>>> 
> > >>>> Since I got it wrong the last time, I'm adding you as a co-developer after my
> > >>>> SOB. I'm sorry if this creates extra work on your side due to you having to
> > >>>> resubmit the patch now with your SOB if I understand correctly, but since it's
> > >>>> based on your wording from the other thread, I definitely wanted to give you
> > >>>> credit.
> > >>>> 
> > >>>> tools/memory-model/Documentation/explanation.txt | 7 ++++---
> > >>>> 1 file changed, 4 insertions(+), 3 deletions(-)
> > >>>> 
> > >>>> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> > >>>> index ee819a402b69..0bca50cac5f4 100644
> > >>>> --- a/tools/memory-model/Documentation/explanation.txt
> > >>>> +++ b/tools/memory-model/Documentation/explanation.txt
> > >>>> @@ -464,9 +464,10 @@ to address dependencies, since the address of a location accessed
> > >>>> through a pointer will depend on the value read earlier from that
> > >>>> pointer.
> > >>>> 
> > >>>> -Finally, a read event and another memory access event are linked by a
> > >>>> -control dependency if the value obtained by the read affects whether
> > >>>> -the second event is executed at all.  Simple example:
> > >>>> +Finally, a read event X and another memory access event Y are linked by
> > >>>> +a control dependency if Y syntactically lies within an arm of an if,
> > >>>> +else or switch statement and the condition guarding Y is either data or
> > >>>> +address-dependent on X.  Simple example:
> > 
> > Thank you both for commenting!
> > 
> > > "if, else or switch" should be just "if or switch".  In C there is no 
> > > such thing as an "else" statement; an "else" clause is merely part of 
> > > an "if" statement.  In fact, maybe "body" would be more appropriate than 
> > > "arm", because "switch" statements don't have arms -- they have cases.
> > 
> > Right. What do you think of "branch"? "Body" to me suggests that there's
> > only one and therefore that the else clause isn't included.
> > 
> > Would it be fair to say that switch statements have branches? I guess
> > because switch statements are a convenient way of writing goto's, i.e.
> > jumps, it's a stretch and basically the same as saying "arm"?
> > 
> > Maybe we can avoid the arm / case clash by just having a definition for if
> > statements and appending something like "similarly for switch statements"?
> 
> That sounds good.
> 
> > >>> 'conditioning guarding Y' sounds confusing to me as it implies to me that the
> > >>> condition's evaluation depends on Y. I much prefer Alan's wording from the
> > >>> linked post saying something like 'the branch condition is data or address
> > >>> dependent on X, and Y lies in one of the arms'.
> > >>> 
> > >>> I have to ask though, why doesn't this imply that the second instruction never
> > >>> executes at all? I believe that would break the MP-pattern if it were not true.
> > >> 
> > >> About my last statement, I believe your patch does not disagree with the
> > >> correctness of the earlier text but just wants to improve it. If that's case
> > >> then that's fine.
> > > 
> > > The biggest difference between the original text and Paul's suggested 
> > > update is that the new text makes clear that Y has to lie within the 
> > > body of the "if" or "switch" statement.  If Y follows the end of the 
> > > if/else, as in the example at the top of this email, then it does have 
> > > not a control dependency on X (at least, not via that if/else), even 
> > > though the value read by X does determine whether or not Y will execute.
> > > 
> > > [It has to be said that this illustrates a big weakness of the LKMM: It 
> > > isn't cognizant of "goto"s or "return"s.  This naturally derives from 
> > > limitations of the herd tool, but the situation could be improved.  So 
> > > for instance, I don't think it would cause trouble to say that in:
> > > 
> > > 	if (READ_ONCE(x) == 0)
> > > 		return;
> > > 	WRITE_ONCE(y, 5);
> > > 
> > > there really is a control dependence from x to y, even though the 
> > > WRITE_ONCE is outside the body of the "if" statement.  Certainly the 
> > > compiler can't reorder the write before the read.  But AFAIK there's no 
> > > way to include a "return" statement in a litmus test for herd.  Or a 
> > > subroutine definition, for that matter.]
> > > 
> > > I agree that "condition guarding Y" is somewhat awkward.  "the 
> > > condition of the if (or the expression of the switch)" might be better, 
> > > even though it is somewhat awkward as well.  At least it's more 
> > > explicit.
> > 
> > Maybe we can reuse the wording from the data and address dependency
> > definition here and say "affects"?
> > 
> > Putting it all together:
> > 
> > > Finally, a read event X and another memory access event Y are linked by a
> > > control dependency if Y syntactically lies within a branch of an if or
> > > switch statement and X affects the evaluation of that statement's
> > > condition via a data or address dependency.
> > 
> > Alternatively without the arm / case clash:
> > 
> > > Finally, a read event X and another memory access event Y are linked by a
> > > control dependency if Y syntactically lies within an arm of an if
> > > statement and X affects the evaluation of the if condition via a data or
> > > address dependency.  Similarly for switch statements.
> > 
> > What do you think?
> 
> I like the second one.  How about combining the last two sentences?  
> 
> 	... via a data or address dependency (or similarly for a switch 
> 	statement).
> 
> Now I suppose someone will pipe up and ask about the conditional 
> expressions in "for", "while" and "do" statements...  :-)

What?  You don't like setjmp() and longjmp()?  ;-)

							Thanx, Paul
