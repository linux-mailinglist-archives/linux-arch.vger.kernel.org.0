Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB29F5AB456
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiIBOy2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 10:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbiIBOyD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 10:54:03 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 682CC25292
        for <linux-arch@vger.kernel.org>; Fri,  2 Sep 2022 07:18:22 -0700 (PDT)
Received: (qmail 272737 invoked by uid 1000); 2 Sep 2022 10:18:21 -0400
Date:   Fri, 2 Sep 2022 10:18:21 -0400
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
Message-ID: <YxIQrT+jFteFd8+e@rowland.harvard.edu>
References: <20220830204446.3590197-1-paul.heidekrueger@in.tum.de>
 <663d568d-a343-d44b-d33d-29998bff8f70@joelfernandes.org>
 <98f2b194-1fe6-3cd8-36cf-da017c35198f@joelfernandes.org>
 <Yw7AEx1w6oWn86cm@rowland.harvard.edu>
 <935D3930-C369-4B0E-ACDC-5BFDFA85AA72@in.tum.de>
 <Yw+cm+awhfi6IUHr@rowland.harvard.edu>
 <EE1FA3DC-5A38-45EC-97AB-44B19C1C7707@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EE1FA3DC-5A38-45EC-97AB-44B19C1C7707@in.tum.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 02, 2022 at 10:40:34AM +0200, Paul Heidekrüger wrote:
> On 31. Aug 2022, at 19:38, Alan Stern <stern@rowland.harvard.edu> wrote:
> >>> Finally, a read event X and another memory access event Y are linked by a
> >>> control dependency if Y syntactically lies within an arm of an if
> >>> statement and X affects the evaluation of the if condition via a data or
> >>> address dependency.  Similarly for switch statements.
> >> 
> >> What do you think?
> > 
> > I like the second one.  How about combining the last two sentences?  
> > 
> > 	... via a data or address dependency (or similarly for a switch 
> > 	statement).
> 
> Yes, sounds good!
> 
> > Now I suppose someone will pipe up and ask about the conditional 
> > expressions in "for", "while" and "do" statements...  :-)
> 
> Happy to have obliged :-)
> https://lore.kernel.org/all/20F4C097-24B4-416B-95EE-AC11F5952B44@in.tum.de/
> 
> Do you think the text should explicitly address control dependencies in the
> context of loops as well? If yes, would it be a separate patch, or would it
> make sense to combine it with this one?

Anything else should be a separate patch.

For the time being, I'm happy not to worry about loops.  In the end
we'll probably have to describe them as though they were unrolled,
with all the complications that entails.

Alan
