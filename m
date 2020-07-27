Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F6822F7D7
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jul 2020 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbgG0SiE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgG0SiE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 14:38:04 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C052C0619D2
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 11:38:03 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g6so5756463ljn.11
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UMs2KPLrm95C8lKLWXfPmZFslzsuLvfR3ETDCOSYyE=;
        b=T2zY4KG7F529dnkETXU2OybV34vYFumkUprGlflRVqa2tbz75sY2fcNb/XT+J/YnjL
         9WSF4CAYQRYIBFniXh6rBnMWYl+M97uEj0pupUT2VWyXNHpCbsr2obhxHEGZIV6K8qwv
         prHHjJ1mSTlOP2djvRLwt3EH+DCr1KUXB6S0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UMs2KPLrm95C8lKLWXfPmZFslzsuLvfR3ETDCOSYyE=;
        b=bMqdxvdWPILMIZBi57Lrm8Qu+cNo9a4k4iGocE21+PQtlwikXo/d1A+LCrdzFKcorA
         JXqiL+iU5oQ3oZDcqIKOQAppzJ41TsSCftbXkeccghC5xWd299VsWaHuD7y9DCf5Ee5D
         zG5ewkY6Yf5i8PX86x9ovEY/+UaJE8El8wHTvRIu5P0i4CM53r+9K896r6CFd9AW6AMW
         yAlbOTIRFgjmqiQlEeAiwbF4A5LPeI2c61htysmbfnfk+Cghpw52hMGwvPMtieHE7I5C
         8sllIz/vmWV719d02KAGEjtAZcbZuBY61L0pa7gQcfau/0mNhUKzr1aNIKobtAtYDZzB
         rzTA==
X-Gm-Message-State: AOAM532PtNZvKSfZ5Dh7BKVNY3Uy/jUEsBCX2jlMwXRH69Nxvenqqy+B
        YCb+y7tdoHa8IcAx771ahjWrTM4psHw=
X-Google-Smtp-Source: ABdhPJxK7bZEr+bvdC2Wo4Ph5yjLxcVmB7FTS/9aIfBZD/XEovgf9e1kPBsRjkuN0nlcZSC/ZSfZXw==
X-Received: by 2002:a05:651c:104f:: with SMTP id x15mr9932867ljm.33.1595875081439;
        Mon, 27 Jul 2020 11:38:01 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id b16sm2494061ljp.124.2020.07.27.11.37.58
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 11:37:59 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id d17so18375858ljl.3
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 11:37:58 -0700 (PDT)
X-Received: by 2002:a2e:999a:: with SMTP id w26mr10222806lji.371.1595875078332;
 Mon, 27 Jul 2020 11:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200723211432.b31831a0df3bc2cbdae31b40@linux-foundation.org>
 <20200724041508.QlTbrHnfh%akpm@linux-foundation.org> <CAHk-=wguPA=pDskR-eMMjwR5LDEaMXrqbmDbrKr0u=wV1LE4rg@mail.gmail.com>
 <CAHk-=wh4kmU5FdT=Yy7N9wA=se=ALbrquCrOkjCMhiQnOBLvDA@mail.gmail.com>
 <0323de82-cfbd-8506-fa9c-a702703dd654@linux.alibaba.com> <20200727110512.GB25400@gaia>
 <39560818-463f-da3a-fc9e-3a4a0a082f61@linux.alibaba.com> <eb1f5cb4-7c3d-df42-f4aa-804e12df45e2@linux.alibaba.com>
In-Reply-To: <eb1f5cb4-7c3d-df42-f4aa-804e12df45e2@linux.alibaba.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jul 2020 11:37:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com>
Message-ID: <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com>
Subject: Re: [patch 01/15] mm/memory.c: avoid access flag update TLB flush for
 retried page fault
To:     Yang Shi <yang.shi@linux.alibaba.com>,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Yu Xu <xuyu@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        Hugh Dickins <hughd@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>, mm-commits@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[ Adding linux-arch, just to make other architectures aware of this issue too.

  We have a "flush_tlb_fix_spurious_fault()" thing to take care of the
"TLB may contain stale entries, we can't take the same fault over and
over again" situation.

  On x86, it's a no-op, because x86 doesn't do that. x86 will re-walk
the page tables - or possibly just always invalidate the faulting TLB
entry - before taking a fault, so there can be no long-term stale
TLB's.

  Other architectures may or may not need explicit "invalidate this
TLB entry, because if you make no changes to the page tables, I'll
just otherwise take this fault again. Forever". That is what
"flush_tlb_fix_spurious_fault()" does.

  NOTE! One reason for a stale TLB entry is that another CPU has
already done the change, and is just _about_ to flush the TLB, but the
hardware took the fault before it did so. The code is under the page
table lock, but the hardware fault handler doesn't know or care. So by
the time we get to "flush_tlb_fix_spurious_fault()", we _will_ have
synchronized (because we took the page table lock), and it's entirely
possible that the architecture thus has nothing to do. Make it a
no-op.

  The other reason for a stale TLB entry is if you don't do the
cross-CPU flush for "minor" events that don't matter (ie turning
things dirty, things like that). Rather than flush the TLB, you _want_
the other CPU to take the fault in the (presumabl;y unlikely) case
that it had that old TLB entry in the first place, and thought _it_
needed to do mark it dirty.

  Anyway, theres' a reason for "flush_tlb_fix_spurious_fault()", but
not all architectures need it.

  HOWEVER.

  On architectures that don't explicitly define it, it falls back to a
default of "flush_tlb_page()", which sounds sane, but in fact is
completely insane and horribly horribly wrong.

  It's completely insane and horribly wrong, because that fallback
predates the "everybody is SMP" days. On UP, it's fine and sane.

  But on SMP, it's absolutely horrendously bad. Because
flush_tlb_fix_spurious_fault() should not do any cross-CPU
invalidates.

  It looks like arm64 got this nasty performance problem because of
this all, with the cross-CPU invalidates being insanely expensive, and
completely pointless  - and easy to hit in some circumstances.

  It looks like powerpc people at least thought about this, and only
do it if there is a coprocessor. Which sounds a bit confused, but I
don't know the rules.

  It looks like a lot of others are ok mainly because they don't do
SMP, or they don't have the kinds of loads where this matters.

  But I wanted to cc the arch mailing list, to make people more aware
of it. And we *should* change the default. It shouldn't be
"flush_tlb_page()". It _should_ be "local_flush_tlb_page()", but we
don't have that, although many architectures implement something like
that as part of their SMP invalidation support ]

On Mon, Jul 27, 2020 at 11:04 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> It looks Linus's patch has better data. It seems sane to me since
> Catalin's patch still needs flush TLB in the shared domain.

Well, my patch as posted never built at all, I think.

Looking back at that patch, I used FAULT_FLAG_RETRY. But that's not
the correct name for any of the bits.

So you must have fixed it. Did you make it use "FAULT_FLAG_TRIED"?
Because that's the right bit - don't flush if this is actually the
second (or more) attempt.

But I'm a bit worried that you would have used one of the other bits
(FAULT_FLAG_ALLOW_RETRY or FAULT_FLAG_RETRY_NOWAIT), and that would be
wrong. Those get set on the first attempt to say "you _may_ retry",
but they get set on the first one.

That just shows how much I tested the patch I sent out. It was
whitespace-damaged on purpose, but I still want to check.

The "FAULT_FLAG_TRIED" bit I believe is reasonable to test. That one
literally says "I've gone through this once already, don't bother with
spurious faults".  But I don't think it triggers much in practice. We
seldom actually retry faults, it needs a page that we actually start
IO on (and dropped the mmap lock for) to happen. It wouldn't happen on
the "turn existing page dirty" case, for example.

The "FAULT_FLAG_WRITE" bit is what we test right now. I think it's
wrong. I think it is a "this happens to work" bit, and cuts down on a
lot of common cases, by simply skipping something that might be needed
but basically never is.

So I think a lot of this is dodgy. It doesn't matter on x86, and
nobody cared. Because x86 will always re-walk the page tables before
taking an architectural fault (the same way it walks them for
dirty/accessed bit updates - you could think of x86 as doing all the
things everybody else does in software, they just do in the hw walker
micro-fault logic instead).

A local TLB invalidate of a single virtual address should be basically
free. We're talking single cycles kind of free. The problem here isn't
the flush_tlb_fix_spurious_fault() itself, the problem here is that
arm64 (and pretty much everybody else who uses the default fallback)
does something horribly horribly wrong, and doesn't do the free
version.

               Linus
