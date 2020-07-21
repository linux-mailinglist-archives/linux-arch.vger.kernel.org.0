Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF5228376
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 17:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgGUPT7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 11:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgGUPT7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 11:19:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA15C061794;
        Tue, 21 Jul 2020 08:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UDgd79BY7gi8TqLDKkueThe0INr/de8/XZtWeBtTp4g=; b=1IvOQ6YEO1bgDDlBTYlRghsRlv
        x6BMvXrA/+9IbLHFeVn36I4gukr3Bn0cCKAe98VNUIWChuL16bJjc/bd3hPXxAasHTAKthuU/Zi1L
        A6hgB1abgU+vFB7TWrZ/bSs2B7H8p8oL09ta8vegyhRMyjcQXB2NF24/OxAecpjm5PhtPH9d3PR4X
        8UhJ8Ag99fmvxPY0yXuOIz5+pu46/IdKlobtn7BI2JJUx27uO6IU0a6x+1Z133R8gYvanTD7wecUQ
        ctczp/CH/WNRGibFW3GSKRLnVLScFDieEdSKBYR2C2N3yfCzMq4p8WGmHOzqQ5neJE9D6AZLrz0aK
        mAmEF/5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxu3Z-0001Uy-MG; Tue, 21 Jul 2020 15:19:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76765301AC6;
        Tue, 21 Jul 2020 17:19:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 691E220107F23; Tue, 21 Jul 2020 17:19:47 +0200 (CEST)
Date:   Tue, 21 Jul 2020 17:19:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Message-ID: <20200721151947.GD10769@hirez.programming.kicks-ass.net>
References: <1594868476.6k5kvx8684.astroid@bobo.none>
 <20200716110038.GA119549@hirez.programming.kicks-ass.net>
 <1594906688.ikv6r4gznx.astroid@bobo.none>
 <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com>
 <1595213677.kxru89dqy2.astroid@bobo.none>
 <2055788870.20749.1595263590675.JavaMail.zimbra@efficios.com>
 <1595324577.x3bf55tpgu.astroid@bobo.none>
 <20200721150656.GN119549@hirez.programming.kicks-ass.net>
 <616209816.22376.1595344513051.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <616209816.22376.1595344513051.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 11:15:13AM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 21, 2020, at 11:06 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Tue, Jul 21, 2020 at 08:04:27PM +1000, Nicholas Piggin wrote:
> > 
> >> That being said, the x86 sync core gap that I imagined could be fixed
> >> by changing to rq->curr == rq->idle test does not actually exist because
> >> the global membarrier does not have a sync core option. So fixing the
> >> exit_lazy_tlb points that this series does *should* fix that. So
> >> PF_KTHREAD may be less problematic than I thought from implementation
> >> point of view, only semantics.
> > 
> > So I've been trying to figure out where that PF_KTHREAD comes from,
> > commit 227a4aadc75b ("sched/membarrier: Fix p->mm->membarrier_state racy
> > load") changed 'p->mm' to '!(p->flags & PF_KTHREAD)'.
> > 
> > So the first version:
> > 
> >  https://lkml.kernel.org/r/20190906031300.1647-5-mathieu.desnoyers@efficios.com
> > 
> > appears to unconditionally send the IPI and checks p->mm in the IPI
> > context, but then v2:
> > 
> >  https://lkml.kernel.org/r/20190908134909.12389-1-mathieu.desnoyers@efficios.com
> > 
> > has the current code. But I've been unable to find the reason the
> > 'p->mm' test changed into '!(p->flags & PF_KTHREAD)'.
> 
> Looking back at my inbox, it seems like you are the one who proposed to
> skip all kthreads: 
> 
> https://lkml.kernel.org/r/20190904124333.GQ2332@hirez.programming.kicks-ass.net

I had a feeling it might've been me ;-) I just couldn't find the email.

> > The comment doesn't really help either; sure we have the whole lazy mm
> > thing, but that's ->active_mm, not ->mm.
> > 
> > Possibly it is because {,un}use_mm() do not have sufficient barriers to
> > make the remote p->mm test work? Or were we over-eager with the !p->mm
> > doesn't imply kthread 'cleanups' at the time?
> 
> The nice thing about adding back kthreads to the threads considered for membarrier
> IPI is that it has no observable effect on the user-space ABI. No pre-existing kthread
> rely on this, and we just provide an additional guarantee for future kthread
> implementations.
> 
> > Also, I just realized, I still have a fix for use_mm() now
> > kthread_use_mm() that seems to have been lost.
> 
> I suspect we need to at least document the memory barriers in kthread_use_mm and
> kthread_unuse_mm to state that they are required by membarrier if we want to
> ipi kthreads as well.

Right, so going by that email you found it was mostly a case of being
lazy, but yes, if we audit the kthread_{,un}use_mm() barriers and add
any other bits that might be needed, covering kthreads should be
possible.

No objections from me for making it so.
