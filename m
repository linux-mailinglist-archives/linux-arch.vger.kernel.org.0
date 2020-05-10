Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD871CC950
	for <lists+linux-arch@lfdr.de>; Sun, 10 May 2020 10:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgEJIPV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 May 2020 04:15:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:60116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgEJIPV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 10 May 2020 04:15:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AF43EAC69;
        Sun, 10 May 2020 08:15:21 +0000 (UTC)
Date:   Sun, 10 May 2020 10:15:16 +0200
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
Message-ID: <20200510081516.GX8135@suse.de>
References: <20200508144043.13893-1-joro@8bytes.org>
 <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
 <20200508213609.GU8135@suse.de>
 <CALCETrVxP87o2+aaf=RLW--DSpMrs=BXSQphN6bG5Y4X+OY8GQ@mail.gmail.com>
 <20200509175217.GV8135@suse.de>
 <CALCETrVU-+G3K5ABBRSEMiwnskL4mZsVcoTESZXnu34J7TaOqw@mail.gmail.com>
 <20200509215713.GE18353@8bytes.org>
 <CALCETrWyQA=4y57PsKhhcRWpxfCufBpda5g7gyEVSST6H5FNJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWyQA=4y57PsKhhcRWpxfCufBpda5g7gyEVSST6H5FNJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 09, 2020 at 10:05:43PM -0700, Andy Lutomirski wrote:
> On Sat, May 9, 2020 at 2:57 PM Joerg Roedel <joro@8bytes.org> wrote:
> I spent some time looking at the code, and I'm guessing you're talking
> about the 3-level !SHARED_KERNEL_PMD case.  I can't quite figure out
> what's going on.
> 
> Can you explain what is actually going on that causes different
> mms/pgds to have top-level entries in the kernel range that point to
> different tables?  Because I'm not seeing why this makes any sense.

There are three cases where the PMDs are not shared on x86-32:

	1) With non-PAE the top-level is already the PMD level, because
	   the page-table only has two levels. Since the top-level can't
	   be shared, the PMDs are also not shared.

	2) For some reason Xen-PV also does not share kernel PMDs on PAE
	   systems, but I havn't looked into why.

	3) On 32-bit PAE with PTI enabled the kernel address space
	   contains the LDT mapping, which is also different per-PGD.
	   There is one PMD entry reserved for the LDT, giving it 2MB of
	   address space. I implemented it this way to keep the 32-bit
	   implementation of PTI mostly similar to the 64-bit one.

> Why does it need to be partitioned at all?  The only thing that comes
> to mind is that the LDT range is per-mm.  So I can imagine that the
> PAE case with a 3G user / 1G kernel split has to have the vmalloc
> range and the LDT range in the same top-level entry.  Yuck.

PAE with 3G user / 1G kernel has _all_ of the kernel mappings in one
top-level entry (direct-mapping, vmalloc, ldt, fixmap).

> If it's *just* the LDT that's a problem, we could plausibly shrink the
> user address range a little bit and put the LDT in the user portion.
> I suppose this could end up creating its own set of problems involving
> tracking which code owns which page tables.

Yeah, for the PTI case it is only the LDT that causes the unshared
kernel PMDs, but even if we move the LDT somewhere else we still have
two-level paging and the xen-pv case.


	Joerg

