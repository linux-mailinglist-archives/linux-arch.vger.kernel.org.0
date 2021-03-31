Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3621350330
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhCaPWw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 11:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236182AbhCaPWt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 11:22:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 395376102A;
        Wed, 31 Mar 2021 15:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617204169;
        bh=PZdA6OkQUCLD5T11j2SNQAmYxalWfS4mcTSD9MYFgH8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YljbhkIq0F8lakNXom3/CkHs2H6x8QHGkFFZqK23JScFpSHb6ph/e3/HwgzbsPE31
         7QFsjXaAAT+a3BFbnwWMv2uOild3eZHsl5iPndsKmT7QkoVrdMwlibUjiK9VXljBFG
         6OIQ8lK0mAnujwVIabpBd8/0oUg8CBUZqmWHcDaP+TeYP1emj+mok6tCR74t6jerMd
         W5U2/Ppuh9xb7XDSZ5WTQTKiwqI5XD+YP6e5zC0ABMb6q3bZKI6+9EVfGAk+/IW3Ps
         Jn/RlcjuGMPL3ABiCCFI7LY/YDOOGddfU5zxolPsOqm11X9kfL2vGKxAq8+xzzhUYT
         MKzeNJTYHGlzw==
Received: by mail-lj1-f171.google.com with SMTP id f16so24361254ljm.1;
        Wed, 31 Mar 2021 08:22:49 -0700 (PDT)
X-Gm-Message-State: AOAM533N0fCjE2v86cW6NbSIAiU8YSyZ07PGI9FOl4AGfe0Yb2MXQ/xH
        xmHmGv5Mj4fDG0Fb9IP2e4o/uQvW5YShXnAe788=
X-Google-Smtp-Source: ABdhPJxH7HojAHVGxjaEG7h6yZ0vTSAW4NtjIt7Xau7864vwv4W45Y5iltVUKESj/hE0oy9GG5oWhEubNFctDEY0GLY=
X-Received: by 2002:a2e:919a:: with SMTP id f26mr2446120ljg.508.1617204167433;
 Wed, 31 Mar 2021 08:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net> <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
In-Reply-To: <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 31 Mar 2021 23:22:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS4jexKsSiXBY=5rz53LjcLUZ1K4pxjYJDVQCWx_8JTuA@mail.gmail.com>
Message-ID: <CAJF2gTS4jexKsSiXBY=5rz53LjcLUZ1K4pxjYJDVQCWx_8JTuA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 29, 2021 at 8:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 29, 2021 at 08:01:41PM +0800, Guo Ren wrote:
> > u32 a = 0x55aa66bb;
> > u16 *ptr = &a;
> >
> > CPU0                       CPU1
> > =========             =========
> > xchg16(ptr, new)     while(1)
> >                                     WRITE_ONCE(*(ptr + 1), x);
> >
> > When we use lr.w/sc.w implement xchg16, it'll cause CPU0 deadlock.
>
> Then I think your LL/SC is broken.
No, it's not broken LR.W/SC.W. Quote <8.3 Eventual Success of
Store-Conditional Instructions>:

"As a consequence of the eventuality guarantee, if some harts in an
execution environment are
executing constrained LR/SC loops, and no other harts or devices in
the execution environment
execute an unconditional store or AMO to that reservation set, then at
least one hart will
eventually exit its constrained LR/SC loop. By contrast, if other
harts or devices continue to
write to that reservation set, it is not guaranteed that any hart will
exit its LR/SC loop."

So I think it's a feature of LR/SC. How does the above code (also use
ll.w/sc.w to implement xchg16) running on arm64?

1: ldxr
    eor
    cbnz ... 2f
    stxr
    cbnz ... 1b   // I think it would deadlock for arm64.

"LL/SC fwd progress" which you have mentioned could guarantee stxr
success? How hardware could do that?

>
> That also means you really don't want to build super complex locking
> primitives on top, because that live-lock will percolate through.
>
> Step 1 would be to get your architecute fixed such that it can provide
> fwd progress guarantees for LL/SC. Otherwise there's absolutely no point
> in building complex systems with it.
--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
