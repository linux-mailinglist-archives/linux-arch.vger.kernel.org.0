Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB1FC19B157
	for <lists+linux-arch@lfdr.de>; Wed,  1 Apr 2020 18:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgDAQeL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Apr 2020 12:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387696AbgDAQeL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Apr 2020 12:34:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD3A21582;
        Wed,  1 Apr 2020 16:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758850;
        bh=uTdpVzB4sMS1kq2S/jZxD1mCnBHts7WJPO28p1TG1uE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AhSy97Z1a0DxYTbCKWG0HJI/YELNG8gYEXfmmUZX1BJgMC11K9JvlWVCo8nKsaWZo
         rwIUvsyGwTgmJuZ0vGCLOBluG/GGOsf1rEJ+XnrLIRui/ddMT1j98D8l+VvRDCfvP7
         I4f/4LTlxHoxJd8X6Ob88mKUCkJblsp80vb0w828=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B64FA3522887; Wed,  1 Apr 2020 09:34:09 -0700 (PDT)
Date:   Wed, 1 Apr 2020 09:34:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Documentation/litmus-tests: Add litmus tests for
 atomic APIs
Message-ID: <20200401163409.GZ19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200326024022.7566-1-boqun.feng@gmail.com>
 <20200327221843.GA226939@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327221843.GA226939@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 27, 2020 at 06:18:43PM -0400, Joel Fernandes wrote:
> On Thu, Mar 26, 2020 at 10:40:18AM +0800, Boqun Feng wrote:
> > A recent discussion raises up the requirement for having test cases for
> > atomic APIs:
> > 
> > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > 
> > , and since we already have a way to generate a test module from a
> > litmus test with klitmus[1]. It makes sense that we add more litmus
> > tests for atomic APIs. And based on the previous discussion, I create a
> > new directory Documentation/atomic-tests and put these litmus tests
> > here.
> > 
> > This patchset starts the work by adding the litmus tests which are
> > already used in atomic_t.txt, and also improve the atomic_t.txt to make
> > it consistent with the litmus tests.
> > 
> > Previous version:
> > v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/
> > v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/
> > v3: https://lore.kernel.org/linux-doc/20200227004049.6853-1-boqun.feng@gmail.com/
> 
> For full series:
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued in place of the following commits, with Joel's and Alan's tags
added, thank you all!

							Thanx, Paul

c13c55d4 tools/memory-model: Add an exception for limitations on _unless() family
59ffd85 Documentation/locking/atomic: Fix atomic-set litmus test
23c19c8 Documentation/locking/atomic: Introduce atomic-tests directory
3bd201c Documentation/locking/atomic: Add a litmus test for atomic_set()
833f53b Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()

> One question I had was in the existing atomic_set() documentation, it talks
> about atomic_add_unless() implementation based on locking could have issues.
> It says the way to fix such cases is:
> 
> Quote:
>     the typical solution is to then implement atomic_set{}() with
>     atomic_xchg().
> 
> I didn't get how using atomic_xchg() fixes it. Is the assumption there that
> atomic_xchg() would be implemented using locking to avoid atomic_set() having
> issues? If so, we could clarify that in the document.
> 
> thanks,
> 
>  - Joel
> 
> > 
> > Changes since v3:
> > 
> > *	Merge two patches on atomic-set litmus test into one as per
> > 	Alan. (Alan, you have acked only one of the two patches, so I
> > 	don't add you acked-by for the combined patch).
> > 
> > *	Move the atomic litmus tests into litmus-tests/atomic to align
> > 	with Joel's recent patches on RCU litmus tests.
> > 
> > I think we still haven't reach to a conclusion for the difference of
> > atomic_add_unless() in herdtools, and I'm currently reading the source
> > code of herd to resovle this. This is just an updated version to resolve
> > ealier comments and react on Joel's RCU litmus tests.
> > 
> > Regards,
> > Boqun
> > 
> > [1]: http://diy.inria.fr/doc/litmus.html#klitmus
> > 
> > Boqun Feng (4):
> >   tools/memory-model: Add an exception for limitations on _unless()
> >     family
> >   Documentation/litmus-tests: Introduce atomic directory
> >   Documentation/litmus-tests/atomic: Add a test for atomic_set()
> >   Documentation/litmus-tests/atomic: Add a test for
> >     smp_mb__after_atomic()
> > 
> >  Documentation/atomic_t.txt                    | 24 +++++++-------
> >  ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
> >  ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
> >  Documentation/litmus-tests/atomic/README      | 16 ++++++++++
> >  tools/memory-model/README                     | 10 ++++--
> >  5 files changed, 91 insertions(+), 15 deletions(-)
> >  create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
> >  create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> >  create mode 100644 Documentation/litmus-tests/atomic/README
> > 
> > -- 
> > 2.25.1
> > 
