Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCAD1CC6E2
	for <lists+linux-arch@lfdr.de>; Sun, 10 May 2020 07:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgEJFF5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 May 2020 01:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgEJFF5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 10 May 2020 01:05:57 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D4F924962
        for <linux-arch@vger.kernel.org>; Sun, 10 May 2020 05:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589087156;
        bh=vbN4FCynuJdq8UF08ebL/0cCBsxmV6T9aKAxAXwlaOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kssPEAiiG4pI+0Oi7Le8CCyWcIMpfRLaKap81BYw9kxGm9Ku9oMbuUevux1X7BR9o
         tlCSEOu9TfNaQnuRx03MOB57HXjGlymCOXZUkAUqVAy8iq+KqshT36JbVqQnHusO0X
         w2BbzV3kllzzR/5Lhg7BV6vEoU4q0z4RLEw5Jduo=
Received: by mail-wm1-f44.google.com with SMTP id m24so4617767wml.2
        for <linux-arch@vger.kernel.org>; Sat, 09 May 2020 22:05:56 -0700 (PDT)
X-Gm-Message-State: AGi0PubCjXhldSTZX73G7rrtHICt7ewmy+dZ59ffYDOi7Oz6osuLcED8
        hvTbwYWQsPIpA15dn/ZYBfQts2Bowas16N0anP7/vQ==
X-Google-Smtp-Source: APiQypI0KDg5AXXIYQmGcwfpwrQdJDQg6XvS3yh8r5do94CcWLBfbhtgNr6SJJ1dTLwyb6gEIpg6o9VFUE1OtV27i+Y=
X-Received: by 2002:a7b:c5d3:: with SMTP id n19mr17292077wmk.21.1589087154678;
 Sat, 09 May 2020 22:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200508144043.13893-1-joro@8bytes.org> <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de> <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
 <20200509175217.GV8135@suse.de> <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
 <20200509215713.GE18353@8bytes.org>
In-Reply-To: <20200509215713.GE18353@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 9 May 2020 22:05:43 -0700
X-Gmail-Original-Message-ID: <CALCETrWyQA=4y57PsKhhcRWpxfCufBpda5g7gyEVSST6H5FNJQ@mail.gmail.com>
Message-ID: <CALCETrWyQA=4y57PsKhhcRWpxfCufBpda5g7gyEVSST6H5FNJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 9, 2020 at 2:57 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> Hi Andy,
>
> On Sat, May 09, 2020 at 12:05:29PM -0700, Andy Lutomirski wrote:

> > So, unless I'm missing something here, there is an absolute maximum of
> > 512 top-level entries that ever need to be synchronized.
>
> And here is where your assumption is wrong. On 32-bit PAE systems it is
> not the top-level entries that need to be synchronized for vmalloc, but
> the second-level entries. And dependent on the kernel configuration,
> there are (in total, not only vmalloc) 1536, 1024, or 512 of these
> second-level entries. How much of them are actually used for vmalloc
> depends on the size of the system RAM (but is at least 64), because
> the vmalloc area begins after the kernel direct-mapping (with an 8MB
> unmapped hole).

I spent some time looking at the code, and I'm guessing you're talking
about the 3-level !SHARED_KERNEL_PMD case.  I can't quite figure out
what's going on.

Can you explain what is actually going on that causes different
mms/pgds to have top-level entries in the kernel range that point to
different tables?  Because I'm not seeing why this makes any sense.

>
> > Now, there's an additional complication.  On x86_64, we have a rule:
> > those entries that need to be synced start out null and may, during
> > the lifetime of the system, change *once*.  They are never unmapped or
> > modified after being allocated.  This means that those entries can
> > only ever point to a page *table* and not to a ginormous page.  So,
> > even if the hardware were to support ginormous pages (which, IIRC, it
> > doesn't), we would be limited to merely immense and not ginormous
> > pages in the vmalloc range.  On x86_32, I don't think we have this
> > rule right now.  And this means that it's possible for one of these
> > pages to be unmapped or modified.
>
> The reason for x86-32 being different is that the address space is
> orders of magnitude smaller than on x86-64. We just have 4 top-level
> entries with PAE paging and can't afford to partition kernel-adress
> space on that level like we do on x86-64. That is the reason the address
> space is partitioned on the second (PMD) level, which is also the reason
> vmalloc synchronization needs to happen on that level. And because
> that's not enough yet, its also the page-table level to map huge-pages.

Why does it need to be partitioned at all?  The only thing that comes
to mind is that the LDT range is per-mm.  So I can imagine that the
PAE case with a 3G user / 1G kernel split has to have the vmalloc
range and the LDT range in the same top-level entry.  Yuck.

>
> > So my suggestion is that just apply the x86_64 rule to x86_32 as well.
> > The practical effect will be that 2-level-paging systems will not be
> > able to use huge pages in the vmalloc range, since the rule will be
> > that the vmalloc-relevant entries in the top-level table must point to
> > page *tables* instead of huge pages.
>
> I could very well live with prohibiting huge-page ioremap mappings for
> x86-32. But as I wrote before, this doesn't solve the problems I am
> trying to address with this patch-set, or would only address them if
> significant amount of total system memory is used.
>
> The pre-allocation solution would work for x86-64, it would only need
> 256kb of preallocated memory for the vmalloc range to never synchronize
> or fault again. I have thought about that and did the math before
> writing this patch-set, but doing the math for 32 bit drove me away from
> it for reasons written above.
>

If it's *just* the LDT that's a problem, we could plausibly shrink the
user address range a little bit and put the LDT in the user portion.
I suppose this could end up creating its own set of problems involving
tracking which code owns which page tables.

> And since a lot of the vmalloc_sync_(un)mappings problems I debugged
> were actually related to 32-bit, I want a solution that works for 32 and
> 64-bit x86 (at least until support for x86-32 is removed). And I think
> this patch-set provides a solution that works well for both.

I'm not fundamentally objecting to your patch set, but I do want to
understand what's going on that needs this stuff.

>
>
>         Joerg
