Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F051CC4CE
	for <lists+linux-arch@lfdr.de>; Sat,  9 May 2020 23:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgEIV5U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 May 2020 17:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgEIV5U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 May 2020 17:57:20 -0400
X-Greylist: delayed 112585 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 May 2020 14:57:19 PDT
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD78C061A0C;
        Sat,  9 May 2020 14:57:19 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id A91AA389; Sat,  9 May 2020 23:57:15 +0200 (CEST)
Date:   Sat, 9 May 2020 23:57:13 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <jroedel@suse.de>, X86 ML <x86@kernel.org>,
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
Message-ID: <20200509215713.GE18353@8bytes.org>
References: <20200508144043.13893-1-joro@8bytes.org>
 <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de>
 <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
 <20200509175217.GV8135@suse.de>
 <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andy,

On Sat, May 09, 2020 at 12:05:29PM -0700, Andy Lutomirski wrote:
> 1. Non-PAE.  There is a single 4k top-level page table per mm, and
> this table contains either 512 or 1024 entries total. Of those
> entries, some fraction (half or less) control the kernel address
> space, and some fraction of *that* is for vmalloc space.  Those
> entries are the *only* thing that needs syncing -- all mms will either
> have null (not present) in those slots or will have pointers to the
> *same* next-level-down directories.

Not entirely correct, on 32-bit non-PAE there are two levels with 1024
entries each. In Linux these map to PMD and PTE levels. With 1024
entries each PMD maps 4MB of address space.

How much of these 1024 top-level entries are used for the kernel is
configuration dependent in Linux, it can be 768, 512, or 256.

> 2. PAE.  Depending on your perspective, there could be a grand total
> of four top-level paging pointers, of which one (IIRC) is for the
> kernel.

That is again configuration dependent, up to 3 of the top-level pointers
could be used for kernel-space.

> That points to the same place for all mms.  Or, if you look at it the
> other way, PAE is just like #1 except that the top-level table has
> only four entries and only one points to VMALLOC space.

There are more differences. In PAE an entry is 64-bit, which means each
PMD-entry only maps 2MB of address space, which means you need two PTE
pages to map the same amount of address space you could map with one
page without PAE paging.
And as noted above, all 3 of the top-level pointers can point to vmalloc
space (not exclusivly).
 
> So, unless I'm missing something here, there is an absolute maximum of
> 512 top-level entries that ever need to be synchronized.

And here is where your assumption is wrong. On 32-bit PAE systems it is
not the top-level entries that need to be synchronized for vmalloc, but
the second-level entries. And dependent on the kernel configuration,
there are (in total, not only vmalloc) 1536, 1024, or 512 of these
second-level entries. How much of them are actually used for vmalloc
depends on the size of the system RAM (but is at least 64), because
the vmalloc area begins after the kernel direct-mapping (with an 8MB
unmapped hole).

With 512MB of RAM you need 256 entries for the kernel direct-mapping (I
ignore the ISA hole here). After that there are 4 unmapped entries and
the rest is vmalloc, minus some fixmap and ldt mappings at the end of
the address space. I havn't looked up the exact number, but 4 entries
(8MB) for this should be close to the real value.

	  1536 total PMD entries
	-  256 for direct-mapping
	-    4 for ISA hole
	-    4 for stuff at the end of the address space

	= 1272 PMD entries for VMALLOC space which need synchronization.

With less RAM it is even more, and to get rid of faulting and
synchronization you need to pre-allocate a 4k PTE page for each of these
PMD entries.

> Now, there's an additional complication.  On x86_64, we have a rule:
> those entries that need to be synced start out null and may, during
> the lifetime of the system, change *once*.  They are never unmapped or
> modified after being allocated.  This means that those entries can
> only ever point to a page *table* and not to a ginormous page.  So,
> even if the hardware were to support ginormous pages (which, IIRC, it
> doesn't), we would be limited to merely immense and not ginormous
> pages in the vmalloc range.  On x86_32, I don't think we have this
> rule right now.  And this means that it's possible for one of these
> pages to be unmapped or modified.

The reason for x86-32 being different is that the address space is
orders of magnitude smaller than on x86-64. We just have 4 top-level
entries with PAE paging and can't afford to partition kernel-adress
space on that level like we do on x86-64. That is the reason the address
space is partitioned on the second (PMD) level, which is also the reason
vmalloc synchronization needs to happen on that level. And because
that's not enough yet, its also the page-table level to map huge-pages.

> So my suggestion is that just apply the x86_64 rule to x86_32 as well.
> The practical effect will be that 2-level-paging systems will not be
> able to use huge pages in the vmalloc range, since the rule will be
> that the vmalloc-relevant entries in the top-level table must point to
> page *tables* instead of huge pages.

I could very well live with prohibiting huge-page ioremap mappings for
x86-32. But as I wrote before, this doesn't solve the problems I am
trying to address with this patch-set, or would only address them if
significant amount of total system memory is used.

The pre-allocation solution would work for x86-64, it would only need
256kb of preallocated memory for the vmalloc range to never synchronize
or fault again. I have thought about that and did the math before
writing this patch-set, but doing the math for 32 bit drove me away from
it for reasons written above.

And since a lot of the vmalloc_sync_(un)mappings problems I debugged
were actually related to 32-bit, I want a solution that works for 32 and
64-bit x86 (at least until support for x86-32 is removed). And I think
this patch-set provides a solution that works well for both.


	Joerg
