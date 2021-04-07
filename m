Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE535752B
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 21:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347438AbhDGTu7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 15:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbhDGTu7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 15:50:59 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B60C06175F;
        Wed,  7 Apr 2021 12:50:49 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id i81so19971018oif.6;
        Wed, 07 Apr 2021 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/6KYvi3qxRc6jQvr4Dp41laAk9y6iyvnOJ43zRUQVDs=;
        b=uMkSxAToTLC2pzNL2A1x2wHmlIPTWtxcS1voRqMd4Wk2cE46uuQ7CmmXoD0JOuyqs3
         j/r0v8HGBIUbdx9KJhzFTPBgwxULt9abG2boBigiWj6wq7Y5a2g+MTn9lwCslBJAFSSR
         QtSYtOj8NU2fJW44APqVse3qTz83MbIraafH5x/GUZ/N7W6mgTWaj9EmmwSXDyFBkxwN
         2JEKRMuJjRTE31eCYpYtlsO3t77N0npLqjK3Tf0enfqNZnvYdL/JJMlqo9upiPJAgcCS
         iFDueF1/k/mFno3kVcSmYVIkS1rnmhCagU6n7O5wZVkMTnDidjrh8Zv2mk9ZwPvvTaAp
         1uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/6KYvi3qxRc6jQvr4Dp41laAk9y6iyvnOJ43zRUQVDs=;
        b=Bj8B18w68Q6T54NCsLItGyXCqC1yAknCwVdg/gEypiqePd5K04v1F9t2VQY62e1MFS
         ZxX/bclL2aCLsuY+T5A4uDnkStQH9MDmIsGVBJsiCepbLLZFuz1tGEOf/53HtFZOJif7
         2E2R5rMbRUIZeucRWBZGFx4BOKiBmHHMdodz+bFB5ekSA1qvRBwZ8UEz9lFNMQLtqHFk
         IJrEGrRpR6Q6k6oB+qUO3JB6QSZa2kcdpe8piKh9e2WhmJeqCsKAIx8WaIDLcXc1rZvT
         Q1l2DbpqDgotTrl3TQsR/SJKbOksVqjCQuhZdKa8IQAkgdYAUHZtGljBCaRAsuSggLJ2
         44qQ==
X-Gm-Message-State: AOAM531XSMNxlGmG0ASA2BSB1qoMClB/18j3poEQRFSKby3BH6M31rNK
        Lq3BWfaSA8CjYxcaOYNJwXG7juHIi86fxfMv+Sg=
X-Google-Smtp-Source: ABdhPJwgDlWh7b9fwq5CxJcqk+iLb58LoK/PouPKlTof9Xft/P6tcdH2xc6ZBnvV9eIhMlUmggxqiokqoy1vOC0BVj8=
X-Received: by 2002:a05:6808:1cb:: with SMTP id x11mr3375444oic.89.1617825048444;
 Wed, 07 Apr 2021 12:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net> <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net> <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net> <CAJF2gTS4jexKsSiXBY=5rz53LjcLUZ1K4pxjYJDVQCWx_8JTuA@mail.gmail.com>
 <YGwKpmPkn5xIxIyx@hirez.programming.kicks-ass.net> <20210407094224.GA3393992@infradead.org>
 <CAHB2gtROGuoNzv5f9QrhWX=3ZtZmUM=SAjYhKqP7dTiTTQwkqA@mail.gmail.com> <YG3XDnNc+GaW1Tz4@hirez.programming.kicks-ass.net>
In-Reply-To: <YG3XDnNc+GaW1Tz4@hirez.programming.kicks-ass.net>
From:   =?UTF-8?Q?Christoph_M=C3=BCllner?= <christophm30@gmail.com>
Date:   Wed, 7 Apr 2021 21:50:37 +0200
Message-ID: <CAHB2gtRGMizmWsv+Quf1jA=mzj6-jD5Rgz-XX2jQuR4dn3oDgQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 7, 2021 at 6:00 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 07, 2021 at 04:29:12PM +0200, Christoph M=C3=BCllner wrote:
> > RISC-V defines LR/SC loops consisting of up to 16 instructions as
> > constrained LR/SC loops.  Such constrained LR/SC loops provide the
> > required forward guarantees, that are expected (similar to what other
> > architectures, like AArch64, have).
>
> The text quoted by others didn't seem to say such a thing, but whatever.

The RISC-V unpriv spec is public can be found here:
https://riscv.org/technical/specifications/
Version 20191213 discusses LR/SC-loops in section 8.3 (page 51).
So in case you are interested in the exact wording, you can find it there.

> > What RISC-V does not have is sub-word atomics and if required, we
> > would have to implement them as LL/SC sequences. And yes, using atomic
> > instructions is preferred over using LL/SC,
>
> (psudo asm, can't be bothered to figure out the actual syntax)
>
>         # setup r_and_mask, r_or_mask
>
> .L1
>         LL r, [word]
>         AND r, r, r_and_mask
>         OR r, r, r_or_mask
>         SC r, [word]
>         JNE .L1

I fully agree with this.
I've implemented a patch for that two weeks ago using the following helper:

+/*
+ * Mask and set given bits at a given address atomically.
+ * The masked old value will be returned.
+ */
+static inline u32 atomic_mask_and_set(u32* p, u32 mask, u32 val)
+{
+       u32 ret, tmp;
+       __asm__ __volatile__ (
+               "0:     lr.w %0, %2\n"
+               "       and  %0, %0, %3\n"
+               "       or   %1, %0, %4\n"
+               "       sc.w %1, %1, %2\n"
+               "       bnez %1, 0b\n"
+               : "+&r"(ret), "=3D&r" (tmp), "+A"(*p)
+               : "r" (mask), "rJ"(val)
+               : "memory");
+       return ret;
+}

However, Guo pushed out a new patchset in between and I decided to not cont=
inue
my approach to not undermine his approach.

I will sync up with Guo to provide a common patchset.

Thanks,
Christoph

> is what you need for LL/SC based xchg16, that's less than 16
> instructions. If RISC-V guarantees fwd progress on that, good, write it
> like that and lets end this thread.
>
> The fact that this is apparently hard, is not good.
