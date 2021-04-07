Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7D0356E9D
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 16:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352877AbhDGO3g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 10:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhDGO3e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 10:29:34 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158DEC061756;
        Wed,  7 Apr 2021 07:29:25 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id h136so3997136vka.7;
        Wed, 07 Apr 2021 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RrhplHEW9q4d4F2AHFjRpj1n00z5X3YyF8zpTfRSZEQ=;
        b=DW9Y5KjGvU2yBGp9bPuo/LtmusFtpNJ53EdSdllv8/hBrdn8yjuCk4TX21DjDIzCqs
         8Epv8EhP7pkUSbtM2AGCrAi3H5cnasOs7yLUsdNqWnW+mYicauNf0x4oBHn6m0+3PWk8
         0Sl94xjjsqigSqsj+NxQ55ZKShHmtqcJSM9UcpEsVTWbCzsGPZcJCA1YcR5WRVA4SJNa
         L3Qbqg06CRduvti69UL1RiCjT3Pg5MEpmKjSVqWMb4WU1QuaqUS05rdXYgySLsoe8fYE
         td96MHExqIAxSKRURHJ8YBjHSkCKtvCqI1vvkX8efLklahklx6jTvIp1JvS0wdGT4uQl
         Hr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RrhplHEW9q4d4F2AHFjRpj1n00z5X3YyF8zpTfRSZEQ=;
        b=Q7cgsf+q22dYJiC3A1quSnsadrE0Spx/lIMV4VQzk//c7qGgQdkszdszjP8UNVSLkq
         RtkUsXBX6tk6hj4ZTdUDT+GI5EW3x3nUGXhqyUyntt3qUNA46XpwLgBZ0A5dyLQ+onN+
         uvmaRFop3s56fBACUcV8jK53GVGxL+PzYwLvTEZFaZTaF2ehBJd5VTnM+nSjspGl0bfJ
         6QU7tB0GbqdQoAPHcm1CjNZ8v8L1oAhkzHZVHb4CTAma7VbH9FhNAt+7W61m00BtKf5s
         YfJrqx0/SlzqCaGcScBJYZCIrM9YqmWjvOE2G+2dr7oA4CYNdQXHEl4NWScUEPQ8pTcT
         uL2A==
X-Gm-Message-State: AOAM5311SXVaPUrDuOlgg12b4dMkYjTQJ+WaQYBDQq94lqMcxgoXII43
        AidK19cIm7aexx6djXRWeIo/fErTU+ABgBugRmo=
X-Google-Smtp-Source: ABdhPJy6Hg+rsTi1P6bo6wi7EKEqiwOO7Rb2mBxRJDCxdvZywLSUQAaS33Vao9Z7pxmRUnNi1vgVo8GSBPCu+3i9Gyg=
X-Received: by 2002:a1f:5682:: with SMTP id k124mr1995507vkb.20.1617805764137;
 Wed, 07 Apr 2021 07:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net> <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net> <CAJF2gTS4jexKsSiXBY=5rz53LjcLUZ1K4pxjYJDVQCWx_8JTuA@mail.gmail.com>
 <YGwKpmPkn5xIxIyx@hirez.programming.kicks-ass.net> <20210407094224.GA3393992@infradead.org>
In-Reply-To: <20210407094224.GA3393992@infradead.org>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>
Date:   Wed, 7 Apr 2021 16:29:12 +0200
Message-ID: <CAHB2gtROGuoNzv5f9QrhWX=3ZtZmUM=SAjYhKqP7dTiTTQwkqA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
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

On Wed, Apr 7, 2021 at 11:43 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Apr 06, 2021 at 09:15:50AM +0200, Peter Zijlstra wrote:
> > Anyway, given you have such a crap architecture (and here I thought
> > RISC-V was supposed to be a modern design *sigh*), you had better go
> > look at the sparc64 atomic implementation which has a software backoff
> > for failed CAS in order to make fwd progress.
>
> It wasn't supposed to be modern.  It was supposed to use boring old
> ideas.  Where it actually did that it is a great ISA, in parts where
> academics actually tried to come up with cool or state of the art
> ideas (interrupt handling, tlb shootdowns, the totally fucked up
> memory model) it turned into a trainwreck.

Gentlemen, please rethink your wording.
RISC-V is neither "crap" nor a "trainwreck", regardless if you like it or not.

The comparison with sparc64 is not applicable, as sparc64 does not
have LL/SC instructions.

Further, it is not the case that RISC-V has no guarantees at all.
It just does not provide a forward progress guarantee for a
synchronization implementation,
that writes in an endless loop to a memory location while trying to
complete an LL/SC
loop on the same memory location at the same time.
If there's a reasonable algorithm, that relies on forward progress in this case,
then we should indeed think about that, but I haven't seen one so far.
The whole MCF lock idea is to actually spin on different memory
locations per CPU
to improve scalability (reduce cacheline bouncing). That's a clear indicator,
that well-scaling synchronization algorithms need to avoid contended cache lines
anyways.

RISC-V defines LR/SC loops consisting of up to 16 instructions as
constrained LR/SC loops.
Such constrained LR/SC loops provide the required forward guarantees,
that are expected
(similar to what other architectures, like AArch64, have).

What RISC-V does not have is sub-word atomics and if required, we
would have to implement
them as LL/SC sequences. And yes, using atomic instructions is
preferred over using LL/SC,
because atomics will tend to perform better (less instructions and
less spilled registers).
But that actually depends on the actual ISA implementation.

Respectfully,
Christoph
