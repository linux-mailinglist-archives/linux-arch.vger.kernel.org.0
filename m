Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28A20A308
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 18:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390007AbgFYQdI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 12:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390052AbgFYQdH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jun 2020 12:33:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC242076E;
        Thu, 25 Jun 2020 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593102787;
        bh=3b6HJKzOFQGON9qntdJqHeKqhJ4WFeZddwTNZpl41Vs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qRStPjX9dSkSvmQ5PpHgZqr4D7gl5JYrJwhNy397jiAVPu8LAqZw5MF3cLJGh4Gxw
         vbo+qIRuKY6pAx/j66TU0KMSrkv8gGz35phvgzxZinrdMtjkgrWVwb6fKl8rhVahT/
         Ahar2wFsuUNkNTLMrPrTSBC2u6orJWCkR9fDGxIg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D4C61352129E; Thu, 25 Jun 2020 09:33:06 -0700 (PDT)
Date:   Thu, 25 Jun 2020 09:33:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: LKMM patches for next merge window
Message-ID: <20200625163306.GR9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200624185400.GA13594@paulmck-ThinkPad-P72>
 <20200624232402.GA465543@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624232402.GA465543@andrea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 25, 2020 at 01:24:02AM +0200, Andrea Parri wrote:
> On Wed, Jun 24, 2020 at 11:54:00AM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > Here is the list of LKMM patches I am considering for the next merge
> > window and the status of each.  Any I am missing or any that need to
> > wait or be modified?
> > 
> > 						Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > 3ce5d69 docs: fix references for DMA*.txt files
> > 	Could someone please provide an ack?
> 
> Fixing the N-th commit "move docs without updating in-tree references".
> ;-/
> 
> Most importantly there appears to be some on-going discussion about it,
> cf.
> 
>   https://lkml.kernel.org/r/20200623072240.GA974@lst.de
> 
> (could you please sort this out?)

I doubt that anything I can say or do will have much effect on those
who love to hate and who hate to love .rst, and vice versa.  It could
be worse -- I could jump into the fray advocating *TYPO, which was the
first text-formatting package that I ever used.  And good luck finding
any information on *TYPO at this point.  ;-)

But good point, I will adjust my branches to keep Mauro's commit off
the list for v5.9 for the moment.

							Thanx, Paul

>   Andrea
> 
> 
> > 
> > ac1a749 tools/memory-model: Add recent references
> > be1ce3e tools/memory-model: Fix "conflict" definition
> > 24dca63 Documentation: LKMM: Add litmus test for RCU GP guarantee where updater frees object
> > 47ec95b Documentation: LKMM: Add litmus test for RCU GP guarantee where reader stores
> > bb2c938 MAINTAINERS: Update maintainers for new Documentation/litmus-tests
> > 05bee9a tools/memory-model: Add an exception for limitations on _unless() family
> > dc76257 Documentation/litmus-tests: Introduce atomic directory
> > d059e50 Documentation/litmus-tests/atomic: Add a test for atomic_set()
> > 7eecf76 Documentation/litmus-tests/atomic: Add a test for smp_mb__after_atomic()
> > 116f054 tools/memory-model: Fix reference to litmus test in recipes.txt
> > ffd32d4 Documentation/litmus-tests: Merge atomic's README into top-level one
> > a08ae99 Documentation/litmus-tests: Cite an RCU litmus test
> > 843285eb tools/memory-model/README: Expand dependency of klitmus7
> > 0296c57 tools/memory-model/README: Mention herdtools7 7.56 in compatibility table
> > 47e4f0a Documentation/litmus-tests: Add note on herd7 7.56 in atomic litmus test
> > 	All ready to go.
