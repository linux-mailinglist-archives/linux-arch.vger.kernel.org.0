Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDEB44693D
	for <lists+linux-arch@lfdr.de>; Fri,  5 Nov 2021 20:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhKETne (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Nov 2021 15:43:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231938AbhKETne (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 Nov 2021 15:43:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C62F360FC3;
        Fri,  5 Nov 2021 19:40:52 +0000 (UTC)
Date:   Fri, 5 Nov 2021 19:40:49 +0000
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
Message-ID: <YYWIwRTo6JhETUTb@arm.com>
References: <YYP1lAq46NWzhOf0@casper.infradead.org>
 <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
 <YYQQPuhVUHqfldDg@arm.com>
 <CAHk-=wiDjjL50BBU=i8BFz3Rv5+-pGysEyCD+mcc_K_g0140oQ@mail.gmail.com>
 <YYQgvTn2NQdZK2Ku@arm.com>
 <CAHk-=wjv--WRm9ay-D615xRwe+tUhZSg7dM0h32Rcf5TNMrD1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjv--WRm9ay-D615xRwe+tUhZSg7dM0h32Rcf5TNMrD1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 04, 2021 at 11:23:56AM -0700, Linus Torvalds wrote:
> On Thu, Nov 4, 2021 at 11:04 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > We still have VIVT processors supported in the kernel and a few where
> > the VIPT cache is aliasing (some ARMv6 CPUs). On these,
> > flush_dcache_page() is still used to ensure the user aliases are
> > coherent with the kernel one, so it's not just about the I/D-cache
> > coherency.
> 
> Maybe we could try to split it up and make each function have more
> well-defined rules? One of the issues with the flush_dcache thing is
> that it's always been so ad-hoc and it's not been hugely clear.
[...]
> So VIVT arm (and whoever else) would continue to do the cache flushing
> at kunmap_local time (or kmap - I don't think it matters which one you
> do, as long as you make sure there are no stale contents from the
> previous use of that address).
> 
> And then we'd relegate flush_dcache_page() purely for uses where
> somebody modifies the data and wants to make sure it ends up being
> coherent with subsequent uses (whether kmap and VIVT or I$/D$
> coherency issues)?

For PIPT hardware (I suppose most newish architectures),
flush_dcache_page() only matters with separate I$ and D$. So we can
indeed redefine it as only meaningful when a user page has been written
by the kernel (and maybe we can give it a better name).

For VIVT, kmap/kunmap() can take care of synchronising the aliases. If
the kmap'ed page has a user mapping, kmap() would also need to flush the
aliases, not just kunmap() (currently relying on flush_dcache_page() for
the read side as well). I suspect this is going to make kmap() more
expensive for those highmem pages only used by the kernel, or for pages
not yet mapped in user space (say during a page fault on mmap'ed file).
Long time ago on arm32 we used to do a check with page_mapping() and
mapping_mapped() but I think the latter disappeared from the kernel.

> > The cachetlb.rst doc states the two cases where flush_dcache_page()
> > should be called:
> >
> > 1. After writing to a page cache page (that's what we need on arm64 for
> >    the I-cache).
> >
> > 2. Before reading from a page cache page and user mappings potentially
> >    exist. I think arm32 ensures the D-cache user aliases are coherent
> >    with the kernel one (added rmk to confirm).
> 
> I think the "kernel cache coherency" matters too. The PTE contents
> thing seems relevant if we use kmap for that...
> 
> So I do think that the "page cache or user mapping" is not necessarily
> the only case.

At least the arm32 set_pte() for VIVT caches does its own D$ flushing on
the kmap() address. So kunmap() flushing is not strictly necessary for
this specific case (I think). But there may be other cases where it
matters.

> But personally I consider these situations so broken at a hardware
> level that I can't find it in myself to care too deeply.

We've had them supported in mainline for so many years, and working
(mostly, there was the odd driver that did not call the right API). But
I'm fine with deprecating them, making them slower in favour of cleaner
semantics of kmap, flush_dcache_page etc.

> Because user space with non-coherent I$/D$ should do its own cache
> flushing if it does "read()" to modify an executable range - exactly
> the same way it has to do it for just doing regular stores to that
> range.

Yes, if the user did a read(), it should flush the caches it cares
about. I don't think we even have a flush_dcache_page() call in the
kernel in these cases, just copy_to_user(). Basically the kernel should
only flush if it wrote via its own mapping (linear, kmap).

However, with mmap(PROT_EXEC), the user expects the I$/D$ to be coherent
without explicit user cache maintenance, even with PIPT hardware. That's
where flush_dcache_page() matters.

We also had some weird bugs with a dynamic loader mapping a page
initially as PROT_READ|PROT_EXEC, doing an
mprotect(PROT_READ|PROT_WRITE) just to write some data (not text, so it
never thought explicit cache flushing by user was needed) and back to
mprotect(PROT_READ|PROT_EXEC). Because of the CoW, the new page did not
have the I$/D$ synchronised, leading to the occasional SIGILL. Again,
flush_dcache_page() after CoW is need, though hidden in the arch code
(we do this on arm64 in copy_user_highpage()).

-- 
Catalin
