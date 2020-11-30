Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8822C8CDB
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 19:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgK3Scs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 13:32:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbgK3Scs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Nov 2020 13:32:48 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 853A12087C
        for <linux-arch@vger.kernel.org>; Mon, 30 Nov 2020 18:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606761126;
        bh=1+dkmgdZJ7A0XGOrHZ54DD0H5z4iBA9FoEkfBleyJuY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E+N75pAfswxeCzlmUfdYFaAfJdyhCr88GdgNA+vYDu+vRp/DMAd3A1tTDLo8eOe3l
         jq1Q25CW+GhROdJlSMw44bGNpCfAk3NZSjtqSvcVqfYt2bwNgIyKHg8LwAdjgroeU1
         Of/Ltl09+ycHVRyBE7iH8o3f/rVW310krhjO43ns=
Received: by mail-wm1-f53.google.com with SMTP id h21so334764wmb.2
        for <linux-arch@vger.kernel.org>; Mon, 30 Nov 2020 10:32:06 -0800 (PST)
X-Gm-Message-State: AOAM5322HTooqNIUE8B9Vw2NYQDum4Q1Dcqt584tNHHFh/COs4t/C2NB
        BsfxJC24NjjQpOYFH3uy78BMqVQiiP/m90YeN6Tigw==
X-Google-Smtp-Source: ABdhPJw56yUaWzacL4hoCkQBOBa3nkJxkwwfEXbkRg72FmSGtd4KgK5OT4oDDcgUyJ0h6IZ4izTuF89S8vIfMMUXW10=
X-Received: by 2002:a7b:c303:: with SMTP id k3mr134104wmj.21.1606761125012;
 Mon, 30 Nov 2020 10:32:05 -0800 (PST)
MIME-Version: 1.0
References: <20201128160141.1003903-1-npiggin@gmail.com> <20201128160141.1003903-7-npiggin@gmail.com>
 <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com> <CALCETrWBtCfD+jZ3S+O8FK-HFPODuhbDEbbfWvS=-iPATNFAOA@mail.gmail.com>
In-Reply-To: <CALCETrWBtCfD+jZ3S+O8FK-HFPODuhbDEbbfWvS=-iPATNFAOA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 30 Nov 2020 10:31:51 -0800
X-Gmail-Original-Message-ID: <CALCETrXAR_9EGaOF8ymVkZycxgZkYk0dR+NjEpTfVzdcS3sOVw@mail.gmail.com>
Message-ID: <CALCETrXAR_9EGaOF8ymVkZycxgZkYk0dR+NjEpTfVzdcS3sOVw@mail.gmail.com>
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
To:     Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

other arch folk: there's some background here:

https://lkml.kernel.org/r/CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com

On Sun, Nov 29, 2020 at 12:16 PM Andy Lutomirski <luto@kernel.org> wrote:
>
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

Indeed, on x86, we do this:

[   11.558844]  flush_tlb_mm_range.cold+0x18/0x1d
[   11.559905]  tlb_finish_mmu+0x10e/0x1a0
[   11.561068]  exit_mmap+0xc8/0x1a0
[   11.561932]  mmput+0x29/0xd0
[   11.562688]  do_exit+0x316/0xa90
[   11.563588]  do_group_exit+0x34/0xb0
[   11.564476]  __x64_sys_exit_group+0xf/0x10
[   11.565512]  do_syscall_64+0x34/0x50

and we have info->freed_tables set.

What are the architectures that have large systems like?

x86: we already zap lazies, so it should cost basically nothing to do
a little loop at the end of __mmput() to make sure that no lazies are
left.  If we care about paravirt performance, we could implement one
of the optimizations I mentioned above to fix up the refcounts instead
of sending an IPI to any remaining lazies.

arm64: AFAICT arm64's flush uses magic arm64 hardware support for
remote flushes, so any lazy mm references will still exist after
exit_mmap().  (arm64 uses lazy TLB, right?)  So this is kind of like
the x86 paravirt case.  Are there large enough arm64 systems that any
of this matters?

s390x: The code has too many acronyms for me to understand it fully,
but I think it's more or less the same situation as arm64.  How big do
s390x systems come?

power: Ridiculously complicated, seems to vary by system and kernel config.

So, Nick, your unconditional IPI scheme is apparently a big
improvement for power, and it should be an improvement and have low
cost for x86.  On arm64 and s390x it will add more IPIs on process
exit but reduce contention on context switching depending on how lazy
TLB works.  I suppose we could try it for all architectures without
any further optimizations.  Or we could try one of the perhaps
excessively clever improvements I linked above.  arm64, s390x people,
what do you think?
