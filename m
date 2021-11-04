Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745594457A7
	for <lists+linux-arch@lfdr.de>; Thu,  4 Nov 2021 17:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhKDQ5K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Nov 2021 12:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhKDQ5F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Nov 2021 12:57:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA27461183;
        Thu,  4 Nov 2021 16:54:25 +0000 (UTC)
Date:   Thu, 4 Nov 2021 16:54:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: flush_dcache_page vs kunmap_local
Message-ID: <YYQQPuhVUHqfldDg@arm.com>
References: <YYP1lAq46NWzhOf0@casper.infradead.org>
 <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 04, 2021 at 08:30:55AM -0700, Linus Torvalds wrote:
> On Thu, Nov 4, 2021 at 8:03 AM Matthew Wilcox <willy@infradead.org> wrote:
> > Linus offers the opinion that kunmap calls should imply a
> > flush_dcache_page().  Christoph added calls to flush_dcache_page()
> > in commit 8dad53a11f8d.  Was this "voodoo programming", or was there
> > a real problem being addressed?
> 
> I don't think anybody actually uses/cares about flush_dcache_page() at
> all, and pretty much all uses are random and voodoo.

We do. flush_dcache_page() is not just about virtual caches. On arm32/64
(and powerpc), even with PIPT-like caches, we use it to flag a page's
D-cache as no longer clean. Subsequently in set_pte_at(), if the mapping
is executable, we do the cache maintenance to ensure the I and D caches
are coherent with each other.

I wouldn't add this call to kmap/kunmap_local(), it would be a slight
unnecessary overhead (we had a customer complaining about kmap_atomic()
breaking write-streaming, I think the new kmap_local() solved this
problem, if in the right context).

-- 
Catalin
