Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE2DE34CEBC
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 13:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhC2LUJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 07:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231726AbhC2LTn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Mar 2021 07:19:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8FD766193A;
        Mon, 29 Mar 2021 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617016782;
        bh=j7SIgfFWVMLoa2fKOiGrGvajt0FjTnG/iQTsS4gCWqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VkTFoEy2moVtohhFfxYKcRZGdY9J2izAqu/m9Z+qifrntBWsoS4luLMma+IXXWdcA
         Ia0FqVi4ANgsnIwlPaNNVTJpibPgtgBbHG4I2zHS/58G/1VTuZ3mfJRhpR9NEBsFQG
         3RmlTKX1lxZLJ/Yuy53lL0gTED5bwGmrCXGRR6kQ5Db+JEl5Rm/w9VajmdUZljD7iB
         hzDz/ESGJmCzXDIjsOrJRmV8s7Nm6yu8JWxJifYSZzwpJVip9sPNq21CmLzunLXzEu
         c+nrjP2Q+c8/IxdXtOo9CeTZ+aRnzhLzYdHe35Uc6RBn4m4V0zpnxSzimjs8a0NMZ6
         qhSS6ufPG+/wA==
Received: by mail-lj1-f172.google.com with SMTP id u20so15407921lja.13;
        Mon, 29 Mar 2021 04:19:42 -0700 (PDT)
X-Gm-Message-State: AOAM531/CFHooc1bqg8wJTR9XTeoiCeuEfxe0aVUoZBaojeG32Eh9Vga
        VGlI8raVWxgab3G8fyfwVMHaI/kUhtbKpOJIaKY=
X-Google-Smtp-Source: ABdhPJyqN0jUJ06ve3rtXE5fF7gRq//Pm5/j6JGVeUsiDXKkjGEaSyxfsLRRZG3qNTABD5ko9AsHaFW6yGsSFlpEatk=
X-Received: by 2002:a2e:994e:: with SMTP id r14mr17623961ljj.115.1617016780900;
 Mon, 29 Mar 2021 04:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
In-Reply-To: <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 29 Mar 2021 19:19:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
Message-ID: <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
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

On Mon, Mar 29, 2021 at 3:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Mar 27, 2021 at 06:06:38PM +0000, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Some architectures don't have sub-word swap atomic instruction,
> > they only have the full word's one.
> >
> > The sub-word swap only improve the performance when:
> > NR_CPUS < 16K
> >  *  0- 7: locked byte
> >  *     8: pending
> >  *  9-15: not used
> >  * 16-17: tail index
> >  * 18-31: tail cpu (+1)
> >
> > The 9-15 bits are wasted to use xchg16 in xchg_tail.
> >
> > Please let architecture select xchg16/xchg32 to implement
> > xchg_tail.
>
> So I really don't like this, this pushes complexity into the generic
> code for something that's really not needed.
>
> Lots of RISC already implement sub-word atomics using word ll/sc.
> Obviously they're not sharing code like they should be :/ See for
> example arch/mips/kernel/cmpxchg.c.
I see, we've done two versions of this:
 - Using cmpxchg codes from MIPS by Michael
 - Re-write with assembly codes by Guo

But using the full-word atomic xchg instructions implement xchg16 has
the semantic risk for atomic operations.

I don't think export xchg16 in a none-sub-word atomic machine is correct.

>
> Also, I really do think doing ticket locks first is a far more sensible
> step.
NACK by Anup

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
