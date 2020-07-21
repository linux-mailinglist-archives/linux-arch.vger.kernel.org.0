Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813D122839F
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgGUPWa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 11:22:30 -0400
Received: from mail.efficios.com ([167.114.26.124]:48708 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgGUPW3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 11:22:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B74E72CC666;
        Tue, 21 Jul 2020 11:22:28 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id upMwOGFpg_bC; Tue, 21 Jul 2020 11:22:28 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5870B2CC665;
        Tue, 21 Jul 2020 11:22:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5870B2CC665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1595344948;
        bh=8uCfUfdQu4oiK+bNjIHkykJf9WIgaALv0rxaHjwJr0E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RqlkE4zVklECaxgeEECd1ul22p1CQT7ScOQBrY2/z5PANaX24xgz3b5ttCog1+uvi
         87lYZRgkYGyBlftIRnErWHjpcLipK4MC/HJlE08bJovtVbKPiajoKGtCx3smOBtOZe
         gmqRx/6ufGZy/xt3vJbp4rKPREWlvusJzUgA244/qb0TtUAeXv08r/tzVviS9oCASG
         8xV2/jAxu71lpFnOTRWeH9fZSxLSopk8YPrXq3XcPaxSt/niiCJqtIEIXyFwfxm3R5
         m1OOCxW2+aLYPclYCvGEqN7WdVBhv1b6TNXkE0Y2F0YKAHdybJmQc9gh/FcyHoLpx4
         gHXfyvODcnJSg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dO6tyL1LYrsh; Tue, 21 Jul 2020 11:22:28 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 481932CC991;
        Tue, 21 Jul 2020 11:22:28 -0400 (EDT)
Date:   Tue, 21 Jul 2020 11:22:28 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>
Message-ID: <2141750915.22379.1595344948206.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200721151947.GD10769@hirez.programming.kicks-ass.net>
References: <1594868476.6k5kvx8684.astroid@bobo.none> <1314561373.18530.1594993363050.JavaMail.zimbra@efficios.com> <1595213677.kxru89dqy2.astroid@bobo.none> <2055788870.20749.1595263590675.JavaMail.zimbra@efficios.com> <1595324577.x3bf55tpgu.astroid@bobo.none> <20200721150656.GN119549@hirez.programming.kicks-ass.net> <616209816.22376.1595344513051.JavaMail.zimbra@efficios.com> <20200721151947.GD10769@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Thread-Index: 3qMKvpn4CTaC/gUF9DBM4QQjSdBktA==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Jul 21, 2020, at 11:19 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Jul 21, 2020 at 11:15:13AM -0400, Mathieu Desnoyers wrote:
>> ----- On Jul 21, 2020, at 11:06 AM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > On Tue, Jul 21, 2020 at 08:04:27PM +1000, Nicholas Piggin wrote:
>> > 
>> >> That being said, the x86 sync core gap that I imagined could be fixed
>> >> by changing to rq->curr == rq->idle test does not actually exist because
>> >> the global membarrier does not have a sync core option. So fixing the
>> >> exit_lazy_tlb points that this series does *should* fix that. So
>> >> PF_KTHREAD may be less problematic than I thought from implementation
>> >> point of view, only semantics.
>> > 
>> > So I've been trying to figure out where that PF_KTHREAD comes from,
>> > commit 227a4aadc75b ("sched/membarrier: Fix p->mm->membarrier_state racy
>> > load") changed 'p->mm' to '!(p->flags & PF_KTHREAD)'.
>> > 
>> > So the first version:
>> > 
>> >  https://lkml.kernel.org/r/20190906031300.1647-5-mathieu.desnoyers@efficios.com
>> > 
>> > appears to unconditionally send the IPI and checks p->mm in the IPI
>> > context, but then v2:
>> > 
>> >  https://lkml.kernel.org/r/20190908134909.12389-1-mathieu.desnoyers@efficios.com
>> > 
>> > has the current code. But I've been unable to find the reason the
>> > 'p->mm' test changed into '!(p->flags & PF_KTHREAD)'.
>> 
>> Looking back at my inbox, it seems like you are the one who proposed to
>> skip all kthreads:
>> 
>> https://lkml.kernel.org/r/20190904124333.GQ2332@hirez.programming.kicks-ass.net
> 
> I had a feeling it might've been me ;-) I just couldn't find the email.
> 
>> > The comment doesn't really help either; sure we have the whole lazy mm
>> > thing, but that's ->active_mm, not ->mm.
>> > 
>> > Possibly it is because {,un}use_mm() do not have sufficient barriers to
>> > make the remote p->mm test work? Or were we over-eager with the !p->mm
>> > doesn't imply kthread 'cleanups' at the time?
>> 
>> The nice thing about adding back kthreads to the threads considered for
>> membarrier
>> IPI is that it has no observable effect on the user-space ABI. No pre-existing
>> kthread
>> rely on this, and we just provide an additional guarantee for future kthread
>> implementations.
>> 
>> > Also, I just realized, I still have a fix for use_mm() now
>> > kthread_use_mm() that seems to have been lost.
>> 
>> I suspect we need to at least document the memory barriers in kthread_use_mm and
>> kthread_unuse_mm to state that they are required by membarrier if we want to
>> ipi kthreads as well.
> 
> Right, so going by that email you found it was mostly a case of being
> lazy, but yes, if we audit the kthread_{,un}use_mm() barriers and add
> any other bits that might be needed, covering kthreads should be
> possible.
> 
> No objections from me for making it so.

I'm OK on making membarrier cover kthreads using mm as well, provided we
audit kthread_{,un}use_mm() to make sure the proper barriers are in place
after setting task->mm and before clearing it.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
