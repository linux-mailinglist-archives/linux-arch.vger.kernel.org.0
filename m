Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA06631E93C
	for <lists+linux-arch@lfdr.de>; Thu, 18 Feb 2021 12:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhBRLpw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Feb 2021 06:45:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:37714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhBRKpm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 18 Feb 2021 05:45:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613643933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s56Gnw396EhRPm1YevA7eLB2KjutFFHIZPiy2hOTxEM=;
        b=A9MqyQw+uGhARjd9EqBxsZ4pVorl1rxQ2pnTECvYBMZUd3tcI8ZcXKSNfsXKlEzsZwlgy4
        kBdzERLSQASsLtQFB/lm5Ifsli67inMrXKgnu8AA9uhsmo259oTESajGpXVylgsoEhb7PR
        P4QBZEcvbiTdUv8WNCMjQckNPvqvXeQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 32F03ADE3;
        Thu, 18 Feb 2021 10:25:33 +0000 (UTC)
Date:   Thu, 18 Feb 2021 11:25:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
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
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH RFC] mm/madvise: introduce MADV_POPULATE to
 prefault/prealloc memory
Message-ID: <YC5Am6a4KMSA8XoK@dhcp22.suse.cz>
References: <20210217154844.12392-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217154844.12392-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed 17-02-21 16:48:44, David Hildenbrand wrote:
> When we manage sparse memory mappings dynamically in user space - also
> sometimes involving MADV_NORESERVE - we want to dynamically populate/

Just wondering what is MADV_NORESERVE? I do not see anything like that
in the Linus tree. Did you mean MAP_NORESERVE?

> discard memory inside such a sparse memory region. Example users are
> hypervisors (especially implementing memory ballooning or similar
> technologies like virtio-mem) and memory allocators. In addition, we want
> to fail in a nice way if populating does not succeed because we are out of
> backend memory (which can happen easily with file-based mappings,
> especially tmpfs and hugetlbfs).

by "fail in a nice way" you mean before a #PF would fail and SIGBUS
which would be harder to handle?

[...]
> Because we don't have a proper interface, what applications
> (like QEMU and databases) end up doing is touching (i.e., writing) all
> individual pages. However, it requires expensive signal handling (SIGBUS);
> for example, this is problematic in hypervisors like QEMU where SIGBUS
> handlers might already be used by other subsystems concurrently to e.g,
> handle hardware errors. "Simply" doing preallocation from another thread
> is not that easy.

OK, that clarifies my above question.

> 
> Let's introduce MADV_POPULATE with the following semantics
> 1. MADV_POPULATED does not work on PROT_NONE and special VMAs. It works
>    on everything else.

This would better clarify what "does not work" means. I assume those are
ignored and do not report any error?

> 2. Errors during MADV_POPULATED (especially OOM) are reported.

How do you want to achieve that? gup/page fault handler will allocate
memory and trigger the oom without caller noticing that. You would
somehow have to weaken the allocation context to GFP_RETRY_MAYFAIL or
NORETRY to achieve the error handling.

>    If we hit
>    hardware errors on pages, ignore them - nothing we really can or
>    should do.
> 3. On errors during MADV_POPULATED, some memory might have been
>    populated. Callers have to clean up if they care.

How does caller find out? madvise reports 0 on success so how do you
find out how much has been populated?

> 4. Concurrent changes to the virtual memory layour are tolerated - we
>    process each and every PFN only once, though.

I do not understand this. madvise is about virtual address space not a
physical address space.

> 5. If MADV_POPULATE succeeds, all memory in the range can be accessed
>    without SIGBUS. (of course, not if user space changed mappings in the
>    meantime or KSM kicked in on anonymous memory).

I do not see how KSM would change anything here and maybe it is not
really important to mention it. KSM should be really transparent from
the users space POV. Parallel and destructive virtual address space
operations are also expected to change the outcome and there is nothing
kernel do about at and provide any meaningful guarantees. I guess we
want to assume a reasonable userspace behavior here.

> Although sparse memory mappings are the primary use case, this will
> also be useful for ordinary preallocations where MAP_POPULATE is not
> desired (e.g., in QEMU, where users can trigger preallocation of
> guest RAM after the mapping was created).
> 
> Looking at the history, MADV_POPULATE was already proposed in 2013 [1],
> however, the main motivation back than was performance improvements
> (which should also still be the case, but it's a seconary concern).

Well, I think it is more of a concern than prior-spectre era when
syscalls were quite cheap.
-- 
Michal Hocko
SUSE Labs
