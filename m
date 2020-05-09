Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1301CC359
	for <lists+linux-arch@lfdr.de>; Sat,  9 May 2020 19:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgEIRwW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 May 2020 13:52:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54418 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgEIRwW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 9 May 2020 13:52:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5F09FACFA;
        Sat,  9 May 2020 17:52:23 +0000 (UTC)
Date:   Sat, 9 May 2020 19:52:17 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
Message-ID: <20200509175217.GV8135@suse.de>
References: <20200508144043.13893-1-joro@8bytes.org>
 <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de>
 <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 08, 2020 at 04:49:17PM -0700, Andy Lutomirski wrote:
> On Fri, May 8, 2020 at 2:36 PM Joerg Roedel <jroedel@suse.de> wrote:
> >
> > On Fri, May 08, 2020 at 02:33:19PM -0700, Andy Lutomirski wrote:
> > > On Fri, May 8, 2020 at 7:40 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > > What's the maximum on other system types?  It might make more sense to
> > > take the memory hit and pre-populate all the tables at boot so we
> > > never have to sync them.
> >
> > Need to look it up for 5-level paging, with 4-level paging its 64 pages
> > to pre-populate the vmalloc area.
> >
> > But that would not solve the problem on x86-32, which needs to
> > synchronize unmappings on the PMD level.
> 
> What changes in this series with x86-32?

This series sets ARCH_PAGE_TABLE_SYNC_MASK to PGTBL_PMD_MODIFIED, so
that the synchronization happens every time PMD(s) in the vmalloc areas
are changed. Before this series this synchronization only happened at
arbitrary places calling vmalloc_sync_(un)mappings().

> We already do that synchronization, right?  IOW, in the cases where
> the vmalloc *fault* code does anything at all, we should have a small
> bound for how much memory to preallocate and, if we preallocate it,
> then there is nothing to sync and nothing to fault.  And we have the
> benefit that we never need to sync anything on 64-bit, which is kind
> of nice.

Don't really get you here, what is pre-allocated and why is there no
need to sync and fault then?

> Do we actually need PMD-level things for 32-bit?  What if we just
> outlawed huge pages in the vmalloc space on 32-bit non-PAE?

Disallowing huge-pages would at least remove the need to sync
unmappings, but we still need to sync new PMD entries. Remember that the
size of the vmalloc area on 32 bit is dynamic and depends on the VM-split
and the actual amount of RAM on the system.

A machine wit 512MB of RAM and a 1G/3G split will have around 2.5G of
VMALLOC address space. And if we want to avoid vmalloc-faults there, we
need to pre-allocate all PTE pages for that area (and the amount of PTE
pages needed increases when RAM decreases).

On a machine with 512M of RAM we would need ca. 1270+ PTE pages, which
is around 5M (or 1% of total system memory).

Regards,

	Joerg
