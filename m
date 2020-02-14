Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3824015D569
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 11:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbgBNKU5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 05:20:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbgBNKU5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Feb 2020 05:20:57 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1069120873;
        Fri, 14 Feb 2020 10:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581675656;
        bh=9/hPWtp8YsjZFEEUcNmoaH6xEjTl1DSs4UF08Oz4AWs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ZLD/cx+Cex6Odvr4iY8/FFPCc01Dev5jgD/s84fX+C5qkEqRhg8OBX4Gk/I+RtIee
         ZgEbgmoK4STVB/b8Z51henezBfy2xNNGRzVAl4bv3l72y6tFxQiKcWaZqm0uSndXSg
         MNpeQ1mpchh2Q5tXLbb810HBpbVdfYodlZg8937A=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B29B03520C3C; Fri, 14 Feb 2020 02:20:52 -0800 (PST)
Date:   Fri, 14 Feb 2020 02:20:52 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
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
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 0/3] tools/memory-model: Add litmus tests for atomic APIs
Message-ID: <20200214102052.GA26532@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214040132.91934-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214040132.91934-1-boqun.feng@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 14, 2020 at 12:01:29PM +0800, Boqun Feng wrote:
> A recent discussion raises up the requirement for having test cases for
> atomic APIs:
> 
> 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> 
> , and since we already have a way to generate a test module from a
> litmus test with klitmus[1]. It makes sense that we add more litmus
> tests for atomic APIs into memory-model.
> 
> So I begin to do this and the plan is to add the litmus tests we already
> use in atomic_t.txt, ones from Paul's litmus collection[2], and any
> other valuable litmus test we come up while adding the previous two
> kinds of tests.
> 
> This patchset finishes the first part (adding atomic_t.txt litmus
> tests). I also improve the atomic_t.txt to make it consistent with the
> litmus tests.
> 
> One thing to note is patch #2 requires a modification to herd and I just
> made a PR to Luc's repo:
> 
> 	https://github.com/herd/herdtools7/pull/28
> 
> , so if this patchset looks good to everyone and someone plans to take
> it (and I assume is Paul), please wait until that PR is settled. And
> probably we need to bump the required herd version because of it.

Please let me know when you are ready for me to take them, and thank
you for doing this!

							Thanx, Paul

> Comments and suggesions are welcome!
> 
> Regards,
> Boqun
> 
> 
> [1]: http://diy.inria.fr/doc/litmus.html#klitmus
> [2]: https://github.com/paulmckrcu/litmus/tree/master/manual/atomic
> 
> *** BLURB HERE ***
> 
> Boqun Feng (3):
>   Documentation/locking/atomic: Fix atomic-set litmus test
>   tools/memory-model: Add a litmus test for atomic_set()
>   tools/memory-model: Add litmus test for RMW + smp_mb__after_atomic()
> 
>  Documentation/atomic_t.txt                    | 14 ++++-----
>  ...+mb__after_atomic-is-strong-acquire.litmus | 29 +++++++++++++++++++
>  .../Atomic-set-observable-to-RMW.litmus       | 24 +++++++++++++++
>  tools/memory-model/litmus-tests/README        |  8 +++++
>  4 files changed, 68 insertions(+), 7 deletions(-)
>  create mode 100644 tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
>  create mode 100644 tools/memory-model/litmus-tests/Atomic-set-observable-to-RMW.litmus
> 
> -- 
> 2.25.0
> 
