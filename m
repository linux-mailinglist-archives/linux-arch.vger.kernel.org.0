Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7438422FE88
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jul 2020 02:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgG1AiW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jul 2020 20:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgG1AiW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 20:38:22 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45DDC061794
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 17:38:21 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c3so2849643lfb.3
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 17:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ta7oAGSOk1hpMj1IM8G7zlCFfLXZkJdHtbS5NNv18qc=;
        b=Y9ZcA3LMPXiXY0pSaCbmSQKEwtV5OEziKnfGuRteee6ZN/rSR4GQS6+u60HY9VjcuA
         KQBIRPnQtsFAEJ5tXZ6pXgmvAVPSNELYW/gdJEzo1suuHRpd4tAJyZHFxQtJkTg3PtVY
         GEvWDRCLJdQRxGNqMWjw9kAUDIsm0lRk4fZPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ta7oAGSOk1hpMj1IM8G7zlCFfLXZkJdHtbS5NNv18qc=;
        b=PvmknYWLbG8cqLAz97sUPlyyWuig2k1WKQxCWjdJXbvHv5LK1NmEoNnev2Tuabnd5O
         pe74dRhsSgNqR3MzBQnJGdjo85RiCCwFMf+GIAjV68CJaDKlIT7+kUpp3yxyRs8iCDMz
         5owbn2pYbRky2lSrlUFHTD0RyBzcauBXlAvnd2G/kYS9obkpMTtKiwJ1chYSCVNOZGJi
         7YdcpOch1EhR4XqZGLjCNoa7W+4tH90Dy+0+Kp+p4MaxJ60wQl0496KvD+mM7CZfY1sk
         S+R3pgzoxBLVacH9df9N5gVX51NqStD9dtXaDEueVgntABEFNSovDwMoe5qAreHdat22
         orGw==
X-Gm-Message-State: AOAM533jY7FNykbKkakhUtt1X/khBbZBYw/JHlQFVzPF7YwDtLnyBdwu
        l3wNjirUDCvfeJYb1JlE7XCROL/B4UA=
X-Google-Smtp-Source: ABdhPJwsax12IIEhhF1/zr+WO1guNdHVoEWsLrryvo1Sr8WANwR9w8u5aEVucjBnBoglxFq9WUADqg==
X-Received: by 2002:a19:a95:: with SMTP id 143mr13069989lfk.174.1595896699862;
        Mon, 27 Jul 2020 17:38:19 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id n29sm3868940lfi.9.2020.07.27.17.38.17
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 17:38:18 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id q7so19262281ljm.1
        for <linux-arch@vger.kernel.org>; Mon, 27 Jul 2020 17:38:17 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr10338762lji.70.1595896697586;
 Mon, 27 Jul 2020 17:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200723211432.b31831a0df3bc2cbdae31b40@linux-foundation.org>
 <20200724041508.QlTbrHnfh%akpm@linux-foundation.org> <CAHk-=wguPA=pDskR-eMMjwR5LDEaMXrqbmDbrKr0u=wV1LE4rg@mail.gmail.com>
 <CAHk-=wh4kmU5FdT=Yy7N9wA=se=ALbrquCrOkjCMhiQnOBLvDA@mail.gmail.com>
 <0323de82-cfbd-8506-fa9c-a702703dd654@linux.alibaba.com> <20200727110512.GB25400@gaia>
 <39560818-463f-da3a-fc9e-3a4a0a082f61@linux.alibaba.com> <eb1f5cb4-7c3d-df42-f4aa-804e12df45e2@linux.alibaba.com>
 <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com> <89c6671a-39ba-d1cc-9bac-2e6717916220@linux.alibaba.com>
In-Reply-To: <89c6671a-39ba-d1cc-9bac-2e6717916220@linux.alibaba.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jul 2020 17:38:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg8vswrKBhKSzfyLJ-UVENeydK-RMVEHT+puDPyWr+bnQ@mail.gmail.com>
Message-ID: <CAHk-=wg8vswrKBhKSzfyLJ-UVENeydK-RMVEHT+puDPyWr+bnQ@mail.gmail.com>
Subject: Re: [patch 01/15] mm/memory.c: avoid access flag update TLB flush for
 retried page fault
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Yu Xu <xuyu@linux.alibaba.com>,
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

On Mon, Jul 27, 2020 at 3:43 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> With the commit ("mm: drop mmap_sem before calling balance_dirty_pages()
> in write fault") the retried fault may happen much more frequently than
> before since it would drop mmap lock as long as dirty throttling happens.

Sure. And that probably explains why it shows up as a regression.

That said, the fact that it showed up as a regression that clearly
probably means that the whole spurious TLB flush has always been a
low-grade problem, and the extra retries just made it much more
noticeable because now there was a change to it.

The fact that we have that (very questionable) optimization to only do
it for writes kind of reinforces that notion - it has happened before,
it's just never been fixed properly, and it's just never been
noticeable on most machines because this is all a no-op on x86.

I think Catalin's patch - with some way to fix the problem with KVM -
is the way to go.

That said, testing FAULT_FLAG_TRIED and suppressing the spurious TLB
fill for that case is certainly always safe. At worst, we'll take
another fault, and then do the TLB flush at _that_ point when not
retrying.

So it's the FAULT_FLAG_WRITE test that I think is bogus, or at least
should be protected by some architecture decision (with a comment
about why it's ok for that architecture, ie the ARM kind of "old PTE's
will never be in the TLB, and if it's not a write fault we know it
doesn't depend on the dirty bit either")

Of course, it may be that on every architecture that requires SW
accessed bits, the "old PTE's will never be in the TLB is true".

Except I think I know at least one architecture where that isn't true.
On alpha, the way the acccessed bit works is exactly the same way the
dirty bit works - except it's done for reads, instead of writes.

So on at least one architecture, access faults and dirty faults are
100% equivalent, just using read/write bits respectively.

Of course, alpha doesn't really matter any more. But it's an example
of an architecture where "old" does not necessarily mean "cannot be in
the TLB", and where testing for FAULT_FLAG_WRITE looks buggy.

Again: I think in practice, it's really *really* hard to hit the
problem with accessed bits, unlike dirty bits. Normally, PTE's are all
instantiated young if they are in the TLB. You have to kind of work at
it to get an old PTE _and_ then hit the "now access it exactly at the
same time from two different CPU's, and watch one CPU keep taking page
faults forever because it never flushes its TLB entry".

Of course, it is so long since I worked with alpha that maybe there's
some other reason this can't happen. Like "PAL-code always flushes the
TLB entry of the faulting address".

Which all hardware should do, dammit. It's all kinds of stupid to
cache a faulting TLB entry. The fault is thousands of times more
expensive than a reload would be, even if  it were intentional and
done repeatedly (which sounds like an insane thing to optimize for
anyway).

So one way to fix this problem would be to just specify that "every
pagefault handler _must_ flush the local-CPU TLB entry that the fault
happened for if the architecture doesn't already do that in hardware
or microcode".

And then we'd just remove the spurious TLB flush code entirely.

                     Linus
