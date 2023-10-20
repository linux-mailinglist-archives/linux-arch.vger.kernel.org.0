Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80727D1115
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 15:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377490AbjJTN5p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Oct 2023 09:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377432AbjJTN5o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 09:57:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543331A3;
        Fri, 20 Oct 2023 06:57:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB60AC433C8;
        Fri, 20 Oct 2023 13:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697810261;
        bh=NWWSj3PLnRvOGqG39XXNzVNGIizV32NCvVENn8XsJmk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=asUxzodMQUUeoeJBAgHWO1iQhtqNT1Xd/1E/pQ3wn1fUNswRVHYlnO3umpma6B3T3
         0RK0JIISXPODwWLOWFFHGhwvZw3cLgAcO/5rwVAY0QFKQOQYon4OdBBjCq2XsXN9f3
         yez3cPd2R6iwZmV22FTmFSi5jzaqVOrkUwYk6+s/U/fQH9Wh+zxihOCIBhJ6Wj5k66
         hJGmOaNnaTMm4uELqrYIuBTdvBItsa1tJsHb/Jdc+tN0yVQnPdq0sLMRtx8YpMBh0P
         AbrUDd/tgWAKPY6m6BR3qt4g1iQyn3Nu1vdLdXO0OtzRtcd9i/c1nwNxcSJlaLSggL
         JBErRhmIJXWjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7D476CE018A; Fri, 20 Oct 2023 06:57:40 -0700 (PDT)
Date:   Fri, 20 Oct 2023 06:57:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
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
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH memory-model] docs: memory-barriers: Add note on compiler
 transformation and address deps
Message-ID: <2694e6e1-3282-4a69-b955-06afd7d7f87f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ceaeba0a-fc30-4635-802a-668c859a58b2@paulmck-laptop>
 <4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com>
 <1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com>
 <f363d6e0-5682-43e7-9a3f-6b896c3cd920@paulmck-laptop>
 <b96cfbc1-f6b0-2fa6-b72d-d57c34bbf14b@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b96cfbc1-f6b0-2fa6-b72d-d57c34bbf14b@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 20, 2023 at 11:29:24AM +0200, Jonas Oberhauser wrote:
> 
> Am 10/19/2023 um 6:39 PM schrieb Paul E. McKenney:
> > On Wed, Oct 18, 2023 at 12:11:58PM +0200, Jonas Oberhauser wrote:
> > > Hi Paul,
> > > [...]
> > The compiler is forbidden from inventing pointer comparisons.
> 
> TIL :) Btw, do you remember a discussion where this is clarified? A quick
> search didn't turn up anything.

This was a verbal discussion with Richard Smith at the 2020 C++ Standards
Committee meeting in Prague.  I honestly do not know what standardese
supports this.

> > > Best wishes,
> > > 
> > > jonas
> > > 
> > > Am 10/6/2023 um 6:39 PM schrieb Jonas Oberhauser:
> > > > Hi Paul,
> > > > 
> > > > The "more up-to-date information" makes it sound like (some of) the
> > > > information in this section is out-of-date/no longer valid.
> > The old smp_read_barrier_depends() that these section cover really
> > does no longer exist.
> 
> You mean that they *intend to* cover? smp_read_barrier_depends never appears
> in the text, so anyone reading this section without prior knowledge has no
> way of realizing that this is what the sections are talking about.

It also doesn't appear in the kernel anymore.

> On the other hand the implicit address dependency barriers that do exist are
> mentioned in the text. And that part is still true.

And this relevant discussion is moving to rcu_dereference.rst, and the
current text is just for people who read memory-barriers.txt some time
back and are expecting to find the same information in the same place.

So if there are things that rcu_dereference.rst is missing, they do
need to be added.

> > > > But after reading the sections, it seems the information is valid, but
> > > > discusses mostly the history of address dependency barriers.
> > > > 
> > > > Given that the sepcond part  specifically already starts with a
> > > > disclaimer that this information is purely relevant to people interested
> > > > in history or working on alpha, I think it would make more sense to
> > > > modify things slightly differently.
> > > > 
> > > > Firstly I'd remove the "historical" part in the first section, and add
> > > > two short paragraphs explaining that
> > > > 
> > > > - every marked access implies a address dependency barrier
> > This is covered in rcu_dereference.rst.
> 
> Let me quote a much wiser man than myself here: "
> 
> The problem is that people insist on diving into the middle of documents,
> so sometimes repetition is a necessary form of self defense.  ;-)
> 
> "

;-) ;-) ;-)

> The main reason I would like to add this here at the very top is that
> 
> - this section serves to frigthen children about the dangers of address
> dependencies,
> 
> - never mentions a way to add them - I need to happen to read another
> section of the manual to find that out

Both are now the job of rcu_dereference.rst.

> - and says this information is historical without specifying which parts are
> still relevant

Readers not interested in history should just go to rcu_dereference.rst,
and if pieces are missing from rcu_dereference.rst, they should be
added there.  (Except of course not the historical points that are not
relevant to the current kernel.)

> (and the parts that are still there are all still relevant, while the parts
> that only the authors know was intended to be there and is out-of-date is
> already gone).

The question is instead what parts that are still relevant are missing
from rcu_dereference.rst.

> So I would add a disclaimer specifying that (since 4.15) *all* marked
> accesses imply read dependency barriers which resolve most of the issues
> mentioned in the remainder of the article.
> However, some issues remain because the dependencies that are preserved by
> such barriers are just *semantic* dependencies, and readers should check
> rcu_dereference.rst for examples of what that implies.

Or maybe it is now time to remove those sections from memory-barriers.txt,
leaving only the first section's pointer to rcu_dereference.rst.
It still feels a bit early to me, and I am still trying to figure out
why you care so much about these sections.  ;-)

> > [...]
> > most situations would be better served by an _acquire() suffix than by
> > a relaxed version of [...] an atomic [...]
> 
> I completely agree. I even considered removing address dependencies
> altogether from the company-internal memory models.
> But people sometimes get a little bit angry and start asking many questions.
> The valuable time of the model maintainer should be considered when
> designing memory models.

Yeah, that is always a tough tradeoff, to be sure!

> > > > - address dependencies considered by the model are *semantic*
> > > > dependencies, meaning that a *syntactic* dependency is not sufficient to
> > > > imply ordering; see the rcu file for some examples where compilers can
> > > > elide syntactic dependencies
> > There is a bunch of text in rcu_dereference.rst to this effect.  Or
> > is there some aspect that is missing from that document?
> 
> That's what I meant by "see the rcu file" --- include a link to
> rcu_dereference.rst in that paragraph.
> So that people know to check out rcu_dereference.rst for more explanations
> to this effect.

You mean this paragraph?

 (2) Address-dependency barriers (historical).
     [!] This section is marked as HISTORICAL: For more up-to-date
     information, including how compiler transformations related to pointer
     comparisons can sometimes cause problems, see
     Documentation/RCU/rcu_dereference.rst.

If so, that last line is intended to be the required link.

Or am I looking in the wrong place?

> > The longer-term direction, perhaps a few years from now, is for the
> > first section to simply reference rcu_dereference.rst and for the second
> > section to be removed completely.
> 
> Sounds good to me, but that doesn't mean we need to compromise the
> readability in the interim :)

Some compromise is needed for people that read the document some time
back and are looking for something specific.

> > [...]
> > The problem is that people insist on diving into the middle of documents,
> > so sometimes repetition is a necessary form of self defense.  ;-)
> > 
> > But I very much appreciate your review and feedback, and I also apologize
> > for my slowness.
> 
> Thanks for the response, I started thinking my mails aren't getting through
> again.

Again, apologies!

							Thanx, Paul
