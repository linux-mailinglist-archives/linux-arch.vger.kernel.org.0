Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793A922FAC7
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jul 2020 22:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgG0U5D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 16:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0U5C (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 16:57:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8AEC0619D2
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 13:57:01 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m15so9101228lfp.7
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 13:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uohsPYq+BX230M7M3jLJE/AhykJk1PPKqAuzVuVWr0I=;
        b=SZ6cq29lpdq/W16Movw9sLDqEpQG6dsTIAo3iY5pMf0J5NBT0iq73DA6PrVOmzwNpf
         p9r6jH63+XidlozxL5/E7HHHaE/tZA+zRrCRVLBC2vZNDEY7P/FHlUNprtWwv4+gfJjW
         49ItkQNuWhtYxgT/X+HbL/ctWs2fxNZy3juwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uohsPYq+BX230M7M3jLJE/AhykJk1PPKqAuzVuVWr0I=;
        b=uRKyniJTTyWh4in9GdU2bkZgJNZoFPdBjFcjkv0KQLV0kb9WvaMc7RjCPkkfuTdBrI
         KhFG6lpUFegnwgrzH8Jm36tgXwIVKE722vGBtlGYYBahIUDKIPu8CwZRAFaa9VCjpU+g
         W/aIm3hpJdXQ2TMvuQpmVei4GsrqBMx+E93ECGgnDYE8Sr17mlnOGdk9CjlPN99K1/6i
         HSd/eeeNH5/RNcmRVEaGucYOEwDoPgAX/WDKG3PaAay4G+rpwmiNCKHpH7dUja/oAono
         4A4J19o5Psbku8LsOzMLhLHymsRDv0iz38P0Fe5ezs1a6n0YcSfuOq3z8pgCX0uJXR+1
         kEqA==
X-Gm-Message-State: AOAM533UR4mlL3k5zA8hNTYib6KlKLa/qiHNGZH0yida8ok+1DXJUusX
        fPk/Up4j/DCQEKFiulFL5u79k8f/0Hg=
X-Google-Smtp-Source: ABdhPJzg4yQ98pUyGbDUFB5IZy+E5qNHtImpH0UkrFBM3GRB5l4dfoM/XtU/uoBZUF2V+9YGkMe8Zw==
X-Received: by 2002:a19:cb51:: with SMTP id b78mr12616384lfg.130.1595883419817;
        Mon, 27 Jul 2020 13:56:59 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id u21sm2437522lff.91.2020.07.27.13.56.58
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 13:56:58 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id i80so9752273lfi.13
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 13:56:58 -0700 (PDT)
X-Received: by 2002:ac2:522b:: with SMTP id i11mr12752744lfl.30.1595883417969;
 Mon, 27 Jul 2020 13:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200723211432.b31831a0df3bc2cbdae31b40@linux-foundation.org>
 <20200724041508.QlTbrHnfh%akpm@linux-foundation.org> <CAHk-=wguPA=pDskR-eMMjwR5LDEaMXrqbmDbrKr0u=wV1LE4rg@mail.gmail.com>
 <CAHk-=wh4kmU5FdT=Yy7N9wA=se=ALbrquCrOkjCMhiQnOBLvDA@mail.gmail.com>
 <7de20d4a-f86c-8e1f-b238-65f02b560325@linux.alibaba.com> <CAHk-=wi8ztx7E3fmU3anHSUzxC9g+ac7kdBOop9UWdvdG-jFOg@mail.gmail.com>
 <45015c63-e719-a58a-7d07-6c156273a890@linux.alibaba.com> <CAHk-=wjve+T9+-nTsxssKQL__mucv_SpLoq1C0xv5NB_n0+wqQ@mail.gmail.com>
 <20200727184239.GA21230@gaia>
In-Reply-To: <20200727184239.GA21230@gaia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jul 2020 13:56:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjX+DjY+ww5_SJ5UKJ3hUy-8S7HZPp6vj7Hbwc5zou3zQ@mail.gmail.com>
Message-ID: <CAHk-=wjX+DjY+ww5_SJ5UKJ3hUy-8S7HZPp6vj7Hbwc5zou3zQ@mail.gmail.com>
Subject: Re: [patch 01/15] mm/memory.c: avoid access flag update TLB flush for
 retried page fault
To:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        Hugh Dickins <hughd@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Xu <xuyu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[ The arch list is going to be missing some of the emails in this
thread, but they are all on lore:

      https://lore.kernel.org/linux-mm/20200727184239.GA21230@gaia/

   and I think the context is probably sufficient even without that. ]

On Mon, Jul 27, 2020 at 11:42 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> At least on arm64 (and arm32), old ptes are not cached in the TLB, so
> there is no need to flush if the only action was to make the pte young
> from old. However, this may not be the same on other architectures.
>
> Also not sure about races with making a pte old then young again, some
> CPU could get confused.

Hmm. I'd love to extend the interface (at the same time we fix the
bogus traditional default) to show what the old pte state was, but the
whole point is that we don't even know.

It is, by definition, gone.

We got a fault for something that is no longer the case, and we didn't
modify anything in the page tables. And so we know that the TLB didn't
- at the time of the fault - match what we now see in the page tables.

So we don't even know if we "made the pte young from old". Somebody
*else* did that part. Maybe two CPU's both hit the HW page table walk
at roughly the same time, both saw and old entry and triggered a sw
fault, one CPU then won the race to the page table spinlock, and
marked it young.

And then the other CPU comes along, says "ok, nothing seems to have
changed, it's a spurious fault as far as I can tell, now what?"

It *could* be that "old->young" transition. But it *could* also have
been that the other CPU did a write access and turned things writable
(in addition to turning it young). We don't even know.

So if arm doesn't cache old ptes in the TLB, then I guess for ARM, the
"only try to flush for write faults" is fine, because the only
possible stale bit in the TLB would be the dirty bit.

And _maybe_ that ends up being true on other architectures too. But it
does sound very very dodgy.

Maybe we should just pass in the fault information we have (ie just
give flush_tlb_fix_spurious_fault() the whole vmf pointer), and then
the architecture can make their own decision based on that.

So if the architecture can say "the only case that might be cached is
a non-dirty old PTE that I need to flush now because it's a write
fault, and not flushing it would possibly cause an endless loop", then
that test for

        if (vmf->flags & FAULT_FLAG_WRITE)

is the right thing.

NOTE! The vmf does have a bit that is called "orig_pte", and has the
comment "Value of PTE at the time of fault" associated with it. That
comment is bogus.

We don't _really_ know what the original pte was, and that "orig_pte"
is just the one we loaded fairly early, and before we took the page
table lock. We've made decisions based on the value, but we've also
already checked that after taking the page table lock, the pte still
matches.

So that vmf structure may be less useful than you'd think. The only
really useful information in there is likely just the address and the
fault flags.

Even the vma is by definition not really useful. The vma we looked up
may not be the same vma that the original hardware fault happened
with. If we took a fault, and some other CPU got around to do a mmap()
before we got the mmap semaphore in the fault handler, we'll have the
*new* vma, but the spurious fault might have come from another source
entirely.

But again - any *serious* page table updates we should have
synchronized against, and the other CPU will have done the TLB
shootdown etc. So we shouldn't need to do anything. The only thing
that matters is the trivial bits that _may_ have been changed without
bothering with a cross-CPU TLB flush.

So it's likely only dirty/accessed bits. But I really do have this
strong memory of us at least at some point deciding that we can avoid
it for some other "this operation only ever _adds_ permissions,
doesn't take them away" case.

I can't find that code, though, so it might be either early-onset
Alzheimer's, or some historical footnote that just isn't true any
longer.

That said, I *can* find places where we delay TLB flushes a _lot_. So
another CPU may be modifying the page tables, and the flush happens
much much later.

For example: look at fork(). We'll mark the source page table as being
read-only for COW purposes, but we'll delay the actual TLB flush to
long long after we did so (but we'll do so with the mmap lock held for
writing to protect against stack growing).

So it's not even like the page table lock really synchronizes the page
table changes with the faults and the TLB flush. The mmap lock for
writing may do that too.

So there's a fairly large window for these "spurious" faults, where
the fault may have happened relatively much earlier, and things have
changed a *lot* by the time we actually got all our locks, and saw
"hey, I see nothing to change in the page tables, the fault is
spurious".

                Linus
