Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84C934EDA2
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhC3QVw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 12:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhC3QVh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Mar 2021 12:21:37 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4C9C061764
        for <linux-arch@vger.kernel.org>; Tue, 30 Mar 2021 09:21:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u10so20561487lju.7
        for <linux-arch@vger.kernel.org>; Tue, 30 Mar 2021 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sD2dqYMXeFiKEoj9JxONMxx5R6jrqHrbtb78j2OsOAQ=;
        b=D6p0Ji51dTK2Fo2jj9xMuHdWUaEfxd4F1U8503my1cLLcqzj0D0vbF5w9hn/15Crhr
         UmdIwRQVMUjiRvvNqx9RHFWmPhg1iEW03S+gZ6gywq9iSbfkazDORknc4uio5sP8W3CQ
         /wrxxyxxgMiScIB9laarimIxOfSxqSn4+0ywMPUedsGbJYSEuAKzMClTPh5BR2WKnwZM
         NYCd6jHR3BdoqJPeho5998vytNjWra4Y/3c6QPg4QkhM4dtRwTmFlVEAxODZiQ0sOJ1o
         h0+UDg5osUL41P8VIjToy6X0npHKMjfQmKa2QZiEnwH4V7LPlPrykLT/mAEV9gz7cBHC
         IRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sD2dqYMXeFiKEoj9JxONMxx5R6jrqHrbtb78j2OsOAQ=;
        b=CYJovWB4qPBeafXdCL4cALXkKHC3sh5WOtUIlG3uedesCHTTVmxc/eIfOUgL38NuHt
         6YFoy8ZZZcVpPIfFfbkoMnbFvmSWugHplgT6MIJ9S7fdcmnYAfBJmtG4BQaGVNTgytGq
         1IEMxVM5Bm/mvtD71LTw50C2wQuquI4hLao4bgYdKhbTQ4Vb0JL/RoU5S1p5LmSA9m1x
         kKQGv0AY0OhqofnDRbo8fx+u8UDs6dZ3lRvIzFS+vBvCmAqgWet94s+N8TS4aNgYJI76
         TvqJPbd6yHBPapEG7yJlYhfacHWsfXqi+KtmO4n3K51tPusMm5zflXIR8SQNilqjCSwc
         1EWg==
X-Gm-Message-State: AOAM531FTKbYtjzR68v7P2ShfDmYiJPQvHOvYkDr/5zpqtVC1e8oLRpl
        +XD5pwpfDaB2bEDH/TPClgQbsyHPOexijb8Sc9n9zA==
X-Google-Smtp-Source: ABdhPJzpocE1IkELvDijbdY/Z3ooshHcOlM7jaZGC02K2KN7kINlC+Y5w9/d1Drl2UKjoC1usvoUqA4nO6OKv5TerQg=
X-Received: by 2002:a2e:7d04:: with SMTP id y4mr2339858ljc.94.1617121294587;
 Tue, 30 Mar 2021 09:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210317110644.25343-1-david@redhat.com> <20210317110644.25343-3-david@redhat.com>
 <CAG48ez0BQ3Vd3nDLEvyiSU0XALgUQ=c-fAwcFVScUkgo_9qVuQ@mail.gmail.com> <2bab28c7-08c0-7ff0-c70e-9bf94da05ce1@redhat.com>
In-Reply-To: <2bab28c7-08c0-7ff0-c70e-9bf94da05ce1@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 30 Mar 2021 18:21:07 +0200
Message-ID: <CAG48ez20rLRNPZj6hLHQ_PLT8H60kTac-uXRiLByD70Q7+qsdQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE)
 to prefault/prealloc memory
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 30, 2021 at 5:01 PM David Hildenbrand <david@redhat.com> wrote:
> >> +long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
> >> +                           unsigned long end, bool write, int *locked)
> >> +{
> >> +       struct mm_struct *mm = vma->vm_mm;
> >> +       unsigned long nr_pages = (end - start) / PAGE_SIZE;
> >> +       int gup_flags;
> >> +
> >> +       VM_BUG_ON(!PAGE_ALIGNED(start));
> >> +       VM_BUG_ON(!PAGE_ALIGNED(end));
> >> +       VM_BUG_ON_VMA(start < vma->vm_start, vma);
> >> +       VM_BUG_ON_VMA(end > vma->vm_end, vma);
> >> +       mmap_assert_locked(mm);
> >> +
> >> +       /*
> >> +        * FOLL_HWPOISON: Return -EHWPOISON instead of -EFAULT when we hit
> >> +        *                a poisoned page.
> >> +        * FOLL_POPULATE: Always populate memory with VM_LOCKONFAULT.
> >> +        * !FOLL_FORCE: Require proper access permissions.
> >> +        */
> >> +       gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK | FOLL_HWPOISON;
> >> +       if (write)
> >> +               gup_flags |= FOLL_WRITE;
> >> +
> >> +       /*
> >> +        * See check_vma_flags(): Will return -EFAULT on incompatible mappings
> >> +        * or with insufficient permissions.
> >> +        */
> >> +       return __get_user_pages(mm, start, nr_pages, gup_flags,
> >> +                               NULL, NULL, locked);
> >
> > You mentioned in the commit message that you don't want to actually
> > dirty all the file pages and force writeback; but doesn't
> > POPULATE_WRITE still do exactly that? In follow_page_pte(), if
> > FOLL_TOUCH and FOLL_WRITE are set, we mark the page as dirty:
>
> Well, I mention that POPULATE_READ explicitly doesn't do that. I
> primarily set it because populate_vma_page_range() also sets it.
>
> Is it safe to *not* set it? IOW, fault something writable into a page
> table (where the CPU could dirty it without additional page faults)
> without marking it accessed? For me, this made logically sense. Thus I
> also understood why populate_vma_page_range() set it.

FOLL_TOUCH doesn't have anything to do with installing the PTE - it
essentially means "the caller of get_user_pages wants to read/write
the contents of the returned page, so please do the same things you
would do if userspace was accessing the page". So in particular, if
you look up a page via get_user_pages() with FOLL_WRITE|FOLL_TOUCH,
that tells the MM subsystem "I will be writing into this page directly
from the kernel, bypassing the userspace page tables, so please mark
it as dirty now so that it will be properly written back later". Part
of that is that it marks the page as recently used, which has an
effect on LRU pageout behavior, I think - as far as I understand, that
is why populate_vma_page_range() uses FOLL_TOUCH.

If you look at __get_user_pages(), you can see that it is split up
into two major parts: faultin_page() for creating PTEs, and
follow_page_mask() for grabbing pages from PTEs. faultin_page()
ignores FOLL_TOUCH completely; only follow_page_mask() uses it.

In a way I guess maybe you do want the "mark as recently accessed"
part that FOLL_TOUCH would give you without FOLL_WRITE? But I think
you very much don't want the dirtying that FOLL_TOUCH|FOLL_WRITE leads
to. Maybe the ideal approach would be to add a new FOLL flag to say "I
only want to mark as recently used, I don't want to dirty". Or maybe
it's enough to just leave out the FOLL_TOUCH entirely, I don't know.
