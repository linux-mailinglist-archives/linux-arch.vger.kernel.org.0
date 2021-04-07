Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920DD356B5F
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 13:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347357AbhDGLhK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 07:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhDGLhK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 07:37:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DE2C061756;
        Wed,  7 Apr 2021 04:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2t0FxK0eZ9tbM+DeDFFhi/Gfb5dxvlFCBC8Lc3GTEVc=; b=eu1QGQ+xTWtWV/pDVqaRjoR9in
        umqpvmIlS2xj4iQzqX+NQh9c/SqNW+BQ94JOjLI+oIxPu/q65tC4XlR6WB0hDa6cFosY7pnhBfmpe
        /fIEyDMEj3+lAgjXFbtVeUVJsI7eteDFxnY+ozO4/A0mdDspFTfYZYdU3258xlXaWocHbHSZ+vm4P
        LV4o+de+6wSxUmdpJtyAricd4yRdhD+REoFgz1Yiutyf/hIisjliBcoxOOjasArYbxxctlMM7+zR4
        25AMoqKeYu9cz0p3x+6htfPpkwOjJ5YXYx3J6Dh1XMjj7d4jnvMNZKK0cBVeCsVGMvL8sTXW7aptZ
        n58nqxdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU6UI-004tQo-A8; Wed, 07 Apr 2021 11:36:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66B363001FB;
        Wed,  7 Apr 2021 13:36:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D45A23D3AF81; Wed,  7 Apr 2021 13:36:45 +0200 (CEST)
Date:   Wed, 7 Apr 2021 13:36:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stafford Horne <shorne@gmail.com>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YG2ZTSFMGrikYWuL@hirez.programming.kicks-ass.net>
References: <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
 <YGNNCEAMSWbBU+hd@hirez.programming.kicks-ass.net>
 <20210330223514.GE1171117@lianli.shorne-pla.net>
 <CAK8P3a0hj2pYr-CuNJkjO==RafZ=J+6kCo4HTWEwvvRXPcngJA@mail.gmail.com>
 <CAJF2gTRxPMURTE3M5WMQ_0q1yZ6K8nraGsFjGLUmpG9nYS_hng@mail.gmail.com>
 <20210406085626.GE3288043@lianli.shorne-pla.net>
 <CAK8P3a3Pf3TbGoVP7JP7gfPV-WDM8MHV_hdqSwNKKFDr1Sb3zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Pf3TbGoVP7JP7gfPV-WDM8MHV_hdqSwNKKFDr1Sb3zQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 10:42:50AM +0200, Arnd Bergmann wrote:
> Since there are really only a handful of instances in the kernel
> that use the cmpxchg() or xchg() on u8/u16 variables, it would seem
> best to just disallow those completely 

Not going to happen. xchg16 is optimal for qspinlock and if we replace
that with a cmpxchg loop on x86 we're regressing.

> Interestingly, the s390 version using __sync_val_compare_and_swap()
> seems to produce nice output on all architectures that have atomic
> instructions, with any supported compiler, to the point where I think
> we could just use that to replace most of the inline-asm versions except
> for arm64:
> 
> #define cmpxchg(ptr, o, n)                                              \
> ({                                                                      \
>         __typeof__(*(ptr)) __o = (o);                                   \
>         __typeof__(*(ptr)) __n = (n);                                   \
>         (__typeof__(*(ptr))) __sync_val_compare_and_swap((ptr),__o,__n);\
> })

It generates the LL/SC loop, but doesn't do sensible optimizations when
it's again used in a loop itself. That is, it generates a loop of a
loop, just like what you'd expect, which is sub-optimal for LL/SC.

> Not how gcc's acquire/release behavior of __sync_val_compare_and_swap()
> relates to what the kernel wants here.
> 
> The gcc documentation also recommends using the standard
> __atomic_compare_exchange_n() builtin instead, which would allow
> constructing release/acquire/relaxed versions as well, but I could not
> get it to produce equally good output. (possibly I was using it wrong)

I'm scared to death of the C11 crap, the compiler will 'optimize' them
when it feels like it and use the C11 memory model rules for it, which
are not compatible with the kernel rules.

But the same thing applies, it won't do the right thing for composites.
