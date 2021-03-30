Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218F634DF0F
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 05:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhC3DOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 23:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhC3DO0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Mar 2021 23:14:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC07D61864;
        Tue, 30 Mar 2021 03:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617074049;
        bh=6eSMLRiak11IODOB+CePI7a65DX9N8EkAy9ZzrCIP+E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KdMi5KiMduBWy6xItpcEY9isb6e1nAEdmm9B7NVKTZqjF7+XWdljKvaUejdZRj94U
         qX67Y1c/XOgi9ZKIGLXXCN4VvmqEwFf8du1gXCAXZD3bTU4HmKJ0MLlEWg/JIAwinH
         WXgA5tPnnDNdUb2WG2acEptutFjaiM2ZY08Tl7DYFPvkKg2VJ1N4OCgFtiCsoGXX7k
         WEF9v+hEtplZ766rLquAVZYq5UOENcf9DfrgULGkGDm8uLzhLQkFGtDGkJjmlALSGK
         aMMzRqLK9GmKpYm5j27NOW0PIxO+ssEnNA45LMd+ldPrTaoq7fPTZATXycZfHSAbc6
         UkH9hUYA93fGQ==
Received: by mail-lj1-f178.google.com with SMTP id u9so18196746ljd.11;
        Mon, 29 Mar 2021 20:14:08 -0700 (PDT)
X-Gm-Message-State: AOAM533xojLaMbVQuvvFH3mkmvGx3B2EVx5uSVuhMeA4INfHaQmx6mS5
        4sPhQIQFMgvUYOKnrNO7zXlqEbDThzhjTcj0ePU=
X-Google-Smtp-Source: ABdhPJybBWMS4ER6LoDJh0lOBZ6phOaqhlXDyrhTcDXbHrJqobU5QYkYxbC743xlAK9DNTW0TUKWXN1k7NjP7snB74o=
X-Received: by 2002:a05:651c:211e:: with SMTP id a30mr13812844ljq.18.1617074047272;
 Mon, 29 Mar 2021 20:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org> <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net> <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
In-Reply-To: <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 30 Mar 2021 11:13:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
Message-ID: <CAJF2gTRncV1+GT7nBpYkvfpyaG57o9ecaHBjoR6gEQAkG2ELrg@mail.gmail.com>
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
>
> That also means you really don't want to build super complex locking
> primitives on top, because that live-lock will percolate through.
Do you mean the below implementation has live-lock risk?
+static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
+{
+       u32 old, new, val = atomic_read(&lock->val);
+
+       for (;;) {
+               new = (val & _Q_LOCKED_PENDING_MASK) | tail;
+               old = atomic_cmpxchg(&lock->val, val, new);
+               if (old == val)
+                       break;
+
+               val = old;
+       }
+       return old;
+}


>
> Step 1 would be to get your architecute fixed such that it can provide
> fwd progress guarantees for LL/SC. Otherwise there's absolutely no point
> in building complex systems with it.

Quote Waiman's comment [1] on xchg16 optimization:

"This optimization is needed to make the qspinlock achieve performance
parity with ticket spinlock at light load."

[1] https://lore.kernel.org/kvm/1429901803-29771-6-git-send-email-Waiman.Long@hp.com/

So for a non-xhg16 machine:
 - ticket-lock for small numbers of CPUs
 - qspinlock for large numbers of CPUs

Okay, I'll put all of them into the next patch :P

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
