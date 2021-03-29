Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43A134CE93
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 13:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhC2LR3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 07:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhC2LRI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Mar 2021 07:17:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2800C061574;
        Mon, 29 Mar 2021 04:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4UdovOzzD5ec59edrOEACZLGsw7JMG5HefZR9P8pjKQ=; b=cPRFkoNQHAbMU9tRdeNwtqz3+d
        qHFec7nHAZDvU0Ahe8+oBC+NKb6VmmRQI9JNHzcnmokL9w1uoXvk/B7GJ8vVbAHQVT2fzhrtj89IF
        f2mpN5QbvAnkjifXIKy9sNGtjDQikf1unThCvUTVW5/AhrGsbLD6Ey2PDAZnAD+lIFHZvxL90+8kh
        PkL4PPt0HQLrDDVQOdJDfmrdCWPEz+GwX4I5no0r+CLfvfu44AgLlewiWAsiWWvXhPIVBYzvopSbZ
        b69wWaGOFTk3otZgRqoZSlkk7F03M4ApNEd3eWYOa97hoW2vuiav4AuWnLq+kSYDaG8erRQfKP1uv
        jxkszZ2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQpt9-000c4H-PT; Mon, 29 Mar 2021 11:16:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 16AEE304B90;
        Mon, 29 Mar 2021 13:16:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0661120145926; Mon, 29 Mar 2021 13:16:53 +0200 (CEST)
Date:   Mon, 29 Mar 2021 13:16:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YGG3JIBVO0w6W3fg@hirez.programming.kicks-ass.net>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 29, 2021 at 11:41:19AM +0200, Arnd Bergmann wrote:
> On Mon, Mar 29, 2021 at 9:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Sat, Mar 27, 2021 at 06:06:38PM +0000, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Some architectures don't have sub-word swap atomic instruction,
> > > they only have the full word's one.
> > >
> > > The sub-word swap only improve the performance when:
> > > NR_CPUS < 16K
> > >  *  0- 7: locked byte
> > >  *     8: pending
> > >  *  9-15: not used
> > >  * 16-17: tail index
> > >  * 18-31: tail cpu (+1)
> > >
> > > The 9-15 bits are wasted to use xchg16 in xchg_tail.
> > >
> > > Please let architecture select xchg16/xchg32 to implement
> > > xchg_tail.
> >
> > So I really don't like this, this pushes complexity into the generic
> > code for something that's really not needed.
> >
> > Lots of RISC already implement sub-word atomics using word ll/sc.
> > Obviously they're not sharing code like they should be :/ See for
> > example arch/mips/kernel/cmpxchg.c.
> 
> That is what the previous version of the patch set did, right?
> 
> I think this v4 is nicer because the code is already there in
> qspinlock.c and just gets moved around, and the implementation
> is likely more efficient this way. The mips version could be made
> more generic, but it is also less efficient than a simple xchg
> since it requires an indirect function call plus nesting a pair of
> loops instead in place of the single single ll/sc loop in the 32-bit
> xchg.
> 
> I think the weakly typed xchg/cmpxchg implementation causes
> more problems than it solves, and we'd be better off using
> a stronger version in general, with the 8-bit and 16-bit exchanges
> using separate helpers in the same way that the fixed-length
> cmpxchg64 is separate already, there are only a couple of instances
> for each of these in the kernel.
> 
> Unfortunately, there is roughly a 50:50 split between fixed 32-bit
> and long/pointer-sized xchg/cmpxchg users in the kernel, so
> making the interface completely fixed-type would add a ton of
> churn. I created an experimental patch for this, but it's probably
> not worth it.

The mips code is pretty horrible. Using a cmpxchg loop on an ll/sc arch
is jus daft. And that's exactly what the generic xchg_tail() thing does
too.

A single LL/SC loop that sets either the upper or lower 16 bits of the
word is always better.

Anyway, an additional 'funny' is that I suspect you cannot prove fwd
progress of the entire primitive with any of this on. But who cares
about details anyway.. :/

And the whole WFE optimization that was relevant for the ticket lock, is
_still_ relevant for qspinlock, except that seems to have gone missing
again.

I just don't have much confidence here that people actually understand
what they're doing or why.
