Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6245C7D158D
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjJTSNd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Oct 2023 14:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjJTSNc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 14:13:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F51DD5B;
        Fri, 20 Oct 2023 11:13:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F76C433C8;
        Fri, 20 Oct 2023 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697825609;
        bh=wOR5O9YegoVKw4ww+kiBFNh2VRvivdmGmXTHFswo0y8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ohtghylusGZ935EjRwomKqdPUesyozWCBjsi60LQHc4ypSYGZzersCHunwDzY1YZE
         QIRI5iMhZKdKFXQqXo2FKV/ikYfCt4k6Vq1LKUlSXqh+mJlGU2vEPU///LSwTemMjb
         6CDba3ArYel5UBERl9jsKfJCWIu95FJO86jG+pEla0tH5MyXNjOPQSYPS4p0qKikbi
         MbjC9RCSTxPuoOYpoZfa5Wzg9yKkHa1MFlm9XXARJ8R1b5j9mzTfDEDK0v5AqRss+Z
         QC3egmArFh9AeIX+cZTwi/HA5JyJmEL6hGhgWbH45iq/c5GN8oUfv9GYXnx5xAGtaT
         m78rkgscsUU6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 52983CE059F; Fri, 20 Oct 2023 11:13:29 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:13:29 -0700
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
Message-ID: <79233008-4be2-4442-9600-f9ac1a654312@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ceaeba0a-fc30-4635-802a-668c859a58b2@paulmck-laptop>
 <4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com>
 <1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com>
 <f363d6e0-5682-43e7-9a3f-6b896c3cd920@paulmck-laptop>
 <b96cfbc1-f6b0-2fa6-b72d-d57c34bbf14b@huaweicloud.com>
 <2694e6e1-3282-4a69-b955-06afd7d7f87f@paulmck-laptop>
 <0bf4cda3-cc43-0e77-e47b-43e1402ed276@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bf4cda3-cc43-0e77-e47b-43e1402ed276@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 20, 2023 at 06:00:19PM +0200, Jonas Oberhauser wrote:
> 
> Am 10/20/2023 um 3:57 PM schrieb Paul E. McKenney:
> > On Fri, Oct 20, 2023 at 11:29:24AM +0200, Jonas Oberhauser wrote:
> > > Am 10/19/2023 um 6:39 PM schrieb Paul E. McKenney:
> > > > On Wed, Oct 18, 2023 at 12:11:58PM +0200, Jonas Oberhauser wrote:
> > > > > Hi Paul,
> > > > > [...]
> > > > The compiler is forbidden from inventing pointer comparisons.
> > > TIL :) Btw, do you remember a discussion where this is clarified? A quick
> > > search didn't turn up anything.
> > This was a verbal discussion with Richard Smith at the 2020 C++ Standards
> > Committee meeting in Prague.  I honestly do not know what standardese
> > supports this.
> 
> Then this e-mail thread shall be my evidence for future discussion.

I am sure that Richard will be delighted, especially given that he
did not seem at all happy with this don't-invent-pointer-comparisons
rule.  ;-)

> > > > > Best wishes,
> > > > > 
> > > > > jonas
> > > > > 
> > > > > Am 10/6/2023 um 6:39 PM schrieb Jonas Oberhauser:
> > > > > > Hi Paul,
> > > > > > 
> > > > > > The "more up-to-date information" makes it sound like (some of) the
> > > > > > information in this section is out-of-date/no longer valid.
> > > > The old smp_read_barrier_depends() that these section cover really
> > > > does no longer exist.
> > > 
> > > (and the parts that are still there are all still relevant, while the parts
> > > that only the authors know was intended to be there and is out-of-date is
> > > already gone).
> > The question is instead what parts that are still relevant are missing
> > from rcu_dereference.rst.
> > 
> > > So I would add a disclaimer specifying that (since 4.15) *all* marked
> > > accesses imply read dependency barriers which resolve most of the issues
> > > mentioned in the remainder of the article.
> > > However, some issues remain because the dependencies that are preserved by
> > > such barriers are just *semantic* dependencies, and readers should check
> > > rcu_dereference.rst for examples of what that implies.
> > Or maybe it is now time to remove those sections from memory-barriers.txt,
> > leaving only the first section's pointer to rcu_dereference.rst.
> 
> That would also make sense to me.
> 
> > It still feels a bit early to me, and I am still trying to figure out
> > why you care so much about these sections.  ;-)
> 
> I honestly don't care about the sections themselves, but I do care about 1)
> address dependency ordering and 2) not confusing people more than necessary.
> IMHO the sections right now are more confusing than necessary.
> As I said before, I think they should clarify what exactly is historical in
> a short sentence. E.g.
> 
>  (2) Address-dependency barriers (historical).
>      [!] This section is marked as HISTORICAL: it covers the obsolete barrier
>      smp_read_barrier_depends(), the semantics of which is now implicit in all
>      marked accesses. For more up-to-date information, including how compiler
>      transformations related to pointer comparisons can sometimes cause problems,
>      see Documentation/RCU/rcu_dereference.rst.
> 
> I think this tiny rewrite makes it much more clear. Specifically it tells *why* the text is historical (and why we maybe don't need to read it anymore).

Good point!  I reworked this a bit and added it to both HISTORICAL
sections, with your Suggested-by.

> Btw, when I raised my concerns about what should be there I didn't mean to imply those points are missing, just trying to sketch what the paragraph should look like in my opinion.
> The paragraphs you are adding already had several of those points.

Very good, but I did have to ask.  It wouldn't be the first time that
I left something out.  ;-)

> > > > The longer-term direction, perhaps a few years from now, is for the
> > > > first section to simply reference rcu_dereference.rst and for the second
> > > > section to be removed completely.
> > > Sounds good to me, but that doesn't mean we need to compromise the
> > > readability in the interim :)
> > Some compromise is needed for people that read the document some time
> > back and are looking for something specific.
> 
> Yes. But the compromise should be "there's a blob of text other people don't
> need to read", not "there's a blob of text that will leave other people
> confused".

Fair enough in general, but I cannot promise to never confuse people.
This is after all memory ordering.  And different people will be confused
by different things.

But I do very much like your suggested clarification.  Please let me
know if I messed anything up in the translation.

							Thanx, Paul

------------------------------------------------------------------------

commit 566c71eee55b26ece5855ebbee6f8762495d78f7
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Fri Oct 20 11:04:27 2023 -0700

    doc: Clarify historical disclaimers in memory-barriers.txt
    
    This commit makes it clear that the reason that these sections are
    historical is that smp_read_barrier_depends() is no more.  It also
    removes the point about comparison operations, given that there are
    other optimizations that can break address dependencies.
    
    Suggested-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Cc: Alan Stern <stern@rowland.harvard.edu>
    Cc: Andrea Parri <parri.andrea@gmail.com>
    Cc: Will Deacon <will@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Boqun Feng <boqun.feng@gmail.com>
    Cc: Nicholas Piggin <npiggin@gmail.com>
    Cc: David Howells <dhowells@redhat.com>
    Cc: Jade Alglave <j.alglave@ucl.ac.uk>
    Cc: Luc Maranget <luc.maranget@inria.fr>
    Cc: Akira Yokosawa <akiyks@gmail.com>
    Cc: Daniel Lustig <dlustig@nvidia.com>
    Cc: Joel Fernandes <joel@joelfernandes.org>
    Cc: Jonathan Corbet <corbet@lwn.net>
    Cc: <linux-arch@vger.kernel.org>
    Cc: <linux-doc@vger.kernel.org>

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index d414e145f912..4202174a6262 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -396,10 +396,11 @@ Memory barriers come in four basic varieties:
 
 
  (2) Address-dependency barriers (historical).
-     [!] This section is marked as HISTORICAL: For more up-to-date
-     information, including how compiler transformations related to pointer
-     comparisons can sometimes cause problems, see
-     Documentation/RCU/rcu_dereference.rst.
+     [!] This section is marked as HISTORICAL: it covers the long-obsolete
+     smp_read_barrier_depends() macro, the semantics of which are now
+     implicit in all marked accesses.  For more up-to-date information,
+     including how compiler transformations can sometimes break address
+     dependencies, see Documentation/RCU/rcu_dereference.rst.
 
      An address-dependency barrier is a weaker form of read barrier.  In the
      case where two loads are performed such that the second depends on the
@@ -560,9 +561,11 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
 
 ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
 ----------------------------------------
-[!] This section is marked as HISTORICAL: For more up-to-date information,
-including how compiler transformations related to pointer comparisons can
-sometimes cause problems, see Documentation/RCU/rcu_dereference.rst.
+[!] This section is marked as HISTORICAL: it covers the long-obsolete
+smp_read_barrier_depends() macro, the semantics of which are now implicit
+in all marked accesses.  For more up-to-date information, including
+how compiler transformations can sometimes break address dependencies,
+see Documentation/RCU/rcu_dereference.rst.
 
 As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
 DEC Alpha, which means that about the only people who need to pay attention
