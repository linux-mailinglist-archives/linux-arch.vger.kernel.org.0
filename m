Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBCE2C80F5
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 10:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgK3J0c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 04:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgK3J0b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Nov 2020 04:26:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A3BC0613D2;
        Mon, 30 Nov 2020 01:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4dY4EOkG53RHP6M1jV6qxthiECmU22437CkB/VPnVPw=; b=kbQGkp1u8lv60ej2mi34V4mTz0
        N8a3Ez89RDu9lKYw76gAQyyX4evCA66FdyQJveREpKWf3AV58pF4mJjBEPUd7MQos+KYNuk8RDGEN
        sh+Zc+1F45nsR3AapUUzVrd1wQkIKgS99MhYVVkhjfPOHphpcbIBCgYFiPh557zukzfsSuu5fuBGP
        tVD5hdB91z5EfXbvmHYzNrB/zkTO/Rj+qGDA7wEC3F3Mynk1troqL16mzp01WYZxOPKo/f2GikU41
        jAHYbokoPtpCzotPYSODIsX08cc+6ZQQ/LUA7JxAacs4u8VFci8A+OqeitAohkQmbvqFrxeY466Bn
        tiJGqL4Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjfQy-0007TZ-F6; Mon, 30 Nov 2020 09:25:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C56F301179;
        Mon, 30 Nov 2020 10:25:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B33020107BE2; Mon, 30 Nov 2020 10:25:23 +0100 (CET)
Date:   Mon, 30 Nov 2020 10:25:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb
 option
Message-ID: <20201130092523.GK2414@hirez.programming.kicks-ass.net>
References: <20201128160141.1003903-1-npiggin@gmail.com>
 <20201128160141.1003903-7-npiggin@gmail.com>
 <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
 <CALCETrWBtCfD+jZ3S+O8FK-HFPODuhbDEbbfWvS=-iPATNFAOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWBtCfD+jZ3S+O8FK-HFPODuhbDEbbfWvS=-iPATNFAOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Nov 29, 2020 at 12:16:26PM -0800, Andy Lutomirski wrote:
> On Sat, Nov 28, 2020 at 7:54 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Sat, Nov 28, 2020 at 8:02 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > On big systems, the mm refcount can become highly contented when doing
> > > a lot of context switching with threaded applications (particularly
> > > switching between the idle thread and an application thread).
> > >
> > > Abandoning lazy tlb slows switching down quite a bit in the important
> > > user->idle->user cases, so so instead implement a non-refcounted scheme
> > > that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
> > > any remaining lazy ones.
> > >
> > > Shootdown IPIs are some concern, but they have not been observed to be
> > > a big problem with this scheme (the powerpc implementation generated
> > > 314 additional interrupts on a 144 CPU system during a kernel compile).
> > > There are a number of strategies that could be employed to reduce IPIs
> > > if they turn out to be a problem for some workload.
> >
> > I'm still wondering whether we can do even better.
> >
> 
> Hold on a sec.. __mmput() unmaps VMAs, frees pagetables, and flushes
> the TLB.  On x86, this will shoot down all lazies as long as even a
> single pagetable was freed.  (Or at least it will if we don't have a
> serious bug, but the code seems okay.  We'll hit pmd_free_tlb, which
> sets tlb->freed_tables, which will trigger the IPI.)  So, on
> architectures like x86, the shootdown approach should be free.  The
> only way it ought to have any excess IPIs is if we have CPUs in
> mm_cpumask() that don't need IPI to free pagetables, which could
> happen on paravirt.
> 
> Can you try to figure out why you saw any increase in IPIs?  It would
> be nice if we can make the new code unconditional.

Power doesn't do IPI based TLBI.
