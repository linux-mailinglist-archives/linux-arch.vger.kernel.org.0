Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEAE445944
	for <lists+linux-arch@lfdr.de>; Thu,  4 Nov 2021 19:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhKDSH2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Nov 2021 14:07:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232102AbhKDSH2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Nov 2021 14:07:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1366F610E7;
        Thu,  4 Nov 2021 18:04:47 +0000 (UTC)
Date:   Thu, 4 Nov 2021 18:04:45 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: flush_dcache_page vs kunmap_local
Message-ID: <YYQgvTn2NQdZK2Ku@arm.com>
References: <YYP1lAq46NWzhOf0@casper.infradead.org>
 <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
 <YYQQPuhVUHqfldDg@arm.com>
 <CAHk-=wiDjjL50BBU=i8BFz3Rv5+-pGysEyCD+mcc_K_g0140oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiDjjL50BBU=i8BFz3Rv5+-pGysEyCD+mcc_K_g0140oQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+ rmk

On Thu, Nov 04, 2021 at 10:08:40AM -0700, Linus Torvalds wrote:
> On Thu, Nov 4, 2021 at 9:54 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > We do. flush_dcache_page() is not just about virtual caches. On arm32/64
> > (and powerpc), even with PIPT-like caches, we use it to flag a page's
> > D-cache as no longer clean. Subsequently in set_pte_at(), if the mapping
> > is executable, we do the cache maintenance to ensure the I and D caches
> > are coherent with each other.
> 
> Ugh,. ok, so we have two very different use-cases for that function.
> 
> Perhaps more importantly, they have hugely different semantics. For
> you, it's about pages that can be mapped executable, so it's only
> relevant for mappable pages.
> 
> For the traditional broken pure virtual cache case, it's not about
> user mappings at all, it's about any data structure that we might have
> in highmem.
> 
> Of course, I think we got rid of most of the other uses of highmem,
> and we no longer put any "normal" kernel data in highmem pages. There
> used to be patches that did inodes and things like that in highmem,
> and they actually depended on the "cache the virtual address so that
> it's always the same" behavior.

We can still have ptes in highmem.

> > I wouldn't add this call to kmap/kunmap_local(), it would be a slight
> > unnecessary overhead (we had a customer complaining about kmap_atomic()
> > breaking write-streaming, I think the new kmap_local() solved this
> > problem, if in the right context).
> 
> kmap_local() ends up being (I think) fundamentally broken for virtual
> cache coherency anyway, because two different CPU's can see two
> different virtual addresses at the same time for the same page (in
> ways that the old kmap interfaces could not).

Luckily I don't think we have a (working) SMP system with VIVT caches.
On UP, looking at arm, for VIVT caches it flushes the D-cache before
kunmap_local() (arch_kmap_local_pre_unmap()). So any new kmap_local()
would see the correct data even if it's in a different location.

> So maybe the answer is "let's forget about the old virtual cache
> coherence issue, and make it purely about the I$ mapping case".

We still have VIVT processors supported in the kernel and a few where
the VIPT cache is aliasing (some ARMv6 CPUs). On these,
flush_dcache_page() is still used to ensure the user aliases are
coherent with the kernel one, so it's not just about the I/D-cache
coherency.

> At that point, kmap is irrelevant from a virtual address standpoint
> and so it doesn't make much sense to fliush on kunmap - but anybody
> who writes to a page still needs that flush_dcache_page() thing.

The cachetlb.rst doc states the two cases where flush_dcache_page()
should be called:

1. After writing to a page cache page (that's what we need on arm64 for
   the I-cache).

2. Before reading from a page cache page and user mappings potentially
   exist. I think arm32 ensures the D-cache user aliases are coherent
   with the kernel one (added rmk to confirm).

Now, whether the kernel code does call flush_dcache_page() in the above
scenarios is another matter. But if we are to remove the 2nd case, for
VIVT/aliasing-VIPT hardware we'd need kmap() to perform some cache
maintenance even if the page is not in highmem.

-- 
Catalin
