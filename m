Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9201CC3E6
	for <lists+linux-arch@lfdr.de>; Sat,  9 May 2020 21:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgEITFn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 May 2020 15:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728244AbgEITFn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 9 May 2020 15:05:43 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D0412496A
        for <linux-arch@vger.kernel.org>; Sat,  9 May 2020 19:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589051142;
        bh=FJqt+joC1S4dk3WKw1lf1NUGd5hPWz0tRXbmftk/Hqk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h57cjbWT99eEJDd2NqihaM1VMl/CabhJPqmHMgBBpaAtYQP9hAFOj8dcDEsVxcA7S
         twDbZsiY/kZTxawUphk+iPtyx8L6jiJSsroopSiC7ekvJ/OkCL5LmRQXHxQ90L1jh3
         tyWFrxnmE8iYXRy298dtRj74/Hv/6K9pK+2mOCO0=
Received: by mail-wr1-f53.google.com with SMTP id g13so5836115wrb.8
        for <linux-arch@vger.kernel.org>; Sat, 09 May 2020 12:05:42 -0700 (PDT)
X-Gm-Message-State: AGi0PuZBL/dji8/x74wmXEYMHIRQo2VwcdF3NuJjVCAQW5z4ozPLe4NW
        mbAeSVMKKwn9p7F10WKT/mZ0zW7UqVCUMmvP5rbWhg==
X-Google-Smtp-Source: APiQypKo+N9nOe1pea23phVBcD9zIB6R4jO/fMYP4p09htgTDQfAoywcbcN8MwgE60i0o58ACaRTA736h38q6VDu9bQ=
X-Received: by 2002:adf:a389:: with SMTP id l9mr5001943wrb.18.1589051140875;
 Sat, 09 May 2020 12:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200508144043.13893-1-joro@8bytes.org> <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de> <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
 <20200509175217.GV8135@suse.de>
In-Reply-To: <20200509175217.GV8135@suse.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 9 May 2020 12:05:29 -0700
X-Gmail-Original-Message-ID: <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
Message-ID: <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
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

On Sat, May 9, 2020 at 10:52 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Fri, May 08, 2020 at 04:49:17PM -0700, Andy Lutomirski wrote:
> > On Fri, May 8, 2020 at 2:36 PM Joerg Roedel <jroedel@suse.de> wrote:
> > >
> > > On Fri, May 08, 2020 at 02:33:19PM -0700, Andy Lutomirski wrote:
> > > > On Fri, May 8, 2020 at 7:40 AM Joerg Roedel <joro@8bytes.org> wrote:
> > >
> > > > What's the maximum on other system types?  It might make more sense to
> > > > take the memory hit and pre-populate all the tables at boot so we
> > > > never have to sync them.
> > >
> > > Need to look it up for 5-level paging, with 4-level paging its 64 pages
> > > to pre-populate the vmalloc area.
> > >
> > > But that would not solve the problem on x86-32, which needs to
> > > synchronize unmappings on the PMD level.
> >
> > What changes in this series with x86-32?
>
> This series sets ARCH_PAGE_TABLE_SYNC_MASK to PGTBL_PMD_MODIFIED, so
> that the synchronization happens every time PMD(s) in the vmalloc areas
> are changed. Before this series this synchronization only happened at
> arbitrary places calling vmalloc_sync_(un)mappings().
>
> > We already do that synchronization, right?  IOW, in the cases where
> > the vmalloc *fault* code does anything at all, we should have a small
> > bound for how much memory to preallocate and, if we preallocate it,
> > then there is nothing to sync and nothing to fault.  And we have the
> > benefit that we never need to sync anything on 64-bit, which is kind
> > of nice.
>
> Don't really get you here, what is pre-allocated and why is there no
> need to sync and fault then?
>
> > Do we actually need PMD-level things for 32-bit?  What if we just
> > outlawed huge pages in the vmalloc space on 32-bit non-PAE?
>
> Disallowing huge-pages would at least remove the need to sync
> unmappings, but we still need to sync new PMD entries. Remember that the
> size of the vmalloc area on 32 bit is dynamic and depends on the VM-split
> and the actual amount of RAM on the system.
>
> A machine wit 512MB of RAM and a 1G/3G split will have around 2.5G of
> VMALLOC address space. And if we want to avoid vmalloc-faults there, we
> need to pre-allocate all PTE pages for that area (and the amount of PTE
> pages needed increases when RAM decreases).
>
> On a machine with 512M of RAM we would need ca. 1270+ PTE pages, which
> is around 5M (or 1% of total system memory).

I can never remember which P?D name goes with which level and which
machine type, but I don't think I agree with your math regardless.  On
x86, there are two fundamental situations that can occur:

1. Non-PAE.  There is a single 4k top-level page table per mm, and
this table contains either 512 or 1024 entries total. Of those
entries, some fraction (half or less) control the kernel address
space, and some fraction of *that* is for vmalloc space.  Those
entries are the *only* thing that needs syncing -- all mms will either
have null (not present) in those slots or will have pointers to the
*same* next-level-down directories.

2. PAE.  Depending on your perspective, there could be a grand total
of four top-level paging pointers, of which one (IIRC) is for the
kernel.  That points to the same place for all mms.  Or, if you look
at it the other way, PAE is just like #1 except that the top-level
table has only four entries and only one points to VMALLOC space.

So, unless I'm missing something here, there is an absolute maximum of
512 top-level entries that ever need to be synchronized.

Now, there's an additional complication.  On x86_64, we have a rule:
those entries that need to be synced start out null and may, during
the lifetime of the system, change *once*.  They are never unmapped or
modified after being allocated.  This means that those entries can
only ever point to a page *table* and not to a ginormous page.  So,
even if the hardware were to support ginormous pages (which, IIRC, it
doesn't), we would be limited to merely immense and not ginormous
pages in the vmalloc range.  On x86_32, I don't think we have this
rule right now.  And this means that it's possible for one of these
pages to be unmapped or modified.

So my suggestion is that just apply the x86_64 rule to x86_32 as well.
The practical effect will be that 2-level-paging systems will not be
able to use huge pages in the vmalloc range, since the rule will be
that the vmalloc-relevant entries in the top-level table must point to
page *tables* instead of huge pages.

On top of this, if we preallocate these entries, then the maximum
amount of memory we can possibly waste is 4k * (entries pointing to
vmalloc space - entries actually used for vmalloc space).  I don't
know what this number typically is, but I don't think it's very large.
Preallocating means that vmalloc faults *and* synchronization go away
entirely.  All of the page tables used for vmalloc will be entirely
shared by all mms, so all that's needed to modify vmalloc mappings is
to update init_mm and, if needed, flush TLBs.  No other page tables
will need modification at all.

On x86_64, the only real advantage is that the handful of corner cases
that make vmalloc faults unpleasant (mostly relating to vmap stacks)
go away.  On x86_32, a bunch of mind-bending stuff (everything your
series deletes but also almost everything your series *adds*) goes
away.  There may be a genuine tiny performance hit on 2-level systems
due to the loss of huge pages in vmalloc space, but I'm not sure I
care or that we use them anyway on these systems.  And PeterZ can stop
even thinking about RCU.

Am I making sense?


(Aside: I *hate* the PMD, etc terminology.  Even the kernel's C types
can't keep track of whether pmd_t* points to an entire paging
directory or to a single entry.  Similarly, everyone knows that a
pte_t is a "page table entry", except that pte_t* might instead be a
pointer to an array of 512 or 1024 page table entries.)
