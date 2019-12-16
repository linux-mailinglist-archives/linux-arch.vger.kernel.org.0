Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 750DF1207CE
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 15:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfLPOAp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 09:00:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbfLPOAp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 09:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s54BERw2fpNV/hAfXK6/L7r6aYOnHlfMZty4DDidJZU=; b=N/+wLlRFtWeb0dRIfQxHTqs9S
        JxPUPv9IcCx5VM/r8on0VzQ06MmfYsipd+yvTi07w+SgN4KvJQQURi/95PxAN9dtnkXyJ7C6sCFhc
        vqHd7ci8UqxfleA3GzMgebj8vpPcVSgwDnxJO0AdElZqvEnC3ICsk0WQ2OHT422xr/N+kRzll85dA
        CW/f0fLoGvcLnsi/kBBVUZicfl7bebPeFLEz7Q0QjAGZ94QMHTZnKrlvjw4rZ1+D5SzYaWQL7hUhU
        j7U009QLh2JvBz2Ry7TjaBry6Bk/1fywM4dTqSlDKcwsrCVGiBZLmHwVv8zPc0PUZ+nE55HWSJOtj
        qa78h1r2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igqv5-0007cS-Tp; Mon, 16 Dec 2019 14:00:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A0EB3007F2;
        Mon, 16 Dec 2019 14:58:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2044C29D747A1; Mon, 16 Dec 2019 15:00:17 +0100 (CET)
Date:   Mon, 16 Dec 2019 15:00:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Burton <paulburton@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Richard Henderson <rth@twiddle.net>,
        Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 05/17] asm-generic/tlb: Rename
 HAVE_RCU_TABLE_NO_INVALIDATE
Message-ID: <20191216140017.GF2827@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122955.940455408@infradead.org>
 <87woawzc1t.fsf@linux.ibm.com>
 <20191216123752.GM2844@hirez.programming.kicks-ass.net>
 <d52ea890-c2ea-88f3-9d62-b86e60ee77ae@linux.ibm.com>
 <20191216132004.GO2844@hirez.programming.kicks-ass.net>
 <a9ae27c8-aa84-cda3-355c-7abb3b450d38@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ae27c8-aa84-cda3-355c-7abb3b450d38@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 16, 2019 at 07:10:30PM +0530, Aneesh Kumar K.V wrote:
> On 12/16/19 6:50 PM, Peter Zijlstra wrote:
> > On Mon, Dec 16, 2019 at 06:43:53PM +0530, Aneesh Kumar K.V wrote:
> > > On 12/16/19 6:07 PM, Peter Zijlstra wrote:
> > 
> > > > I'm confused, are you saing you're happy to have PowerPC eat the extra
> > > > TLB invalidates? I thought you cared about PPC performance :-)
> > > > 
> > > > 
> > > 
> > > Instead can we do
> > > 
> > > static inline void tlb_table_invalidate(struct mmu_gather *tlb)
> > > {
> > > #ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
> > > 	 * Invalidate page-table caches used by hardware walkers. Then we still
> > > 	 * need to RCU-sched wait while freeing the pages because software
> > > 	 * walkers can still be in-flight.
> > > 	 */
> > > 	tlb_flush_mmu_tlbonly(tlb);
> > > #endif
> > > }
> > 
> > How does that not break ARM/ARM64/s390 and x86 ?
> > 
> 
> Hmm I missed that usage of RCU_TABLE_NO_INVALIDATE.

What use? Only PPC and SPARC64 use that option. The reason they can use
it is because they don't have a hardware walker (with exception of
PPC-Radix, which I suppose your below patch fudges ?!).

So HAVE_RCU_TABLE_FREE will provide tlb_remove_table() for the use of
freeing page-tables/directories. This is required for all architectures
that have software walkers and !IPI TLBI.

Arm, Arm64, Power, Sparc64, s390 and x86 use this option. While x86
natively has IPI based TLBI, a bunch of the virtualization solutions got
rid of the IPI for performance.

Of those, Arm, Arm64, s390, x86 (and PPC-Radix) also have hardware
walkers on those page-tables, and thus _must_ TLBI in between unhooking
and freeing these pages.

PPC-Hash and Sparc64 OTOH only ever access the linux page-tables through
the software walker and thus can forgo this TLBI, and _THAT_ is what
TABLE_NO_INVALIDATE is about (there actually is a comment that clearly
states this).

> Ok I guess we need to revert this change that went upstream this merge
> window then
> 
> commit 52162ec784fa05f3a4b1d8e84421279998be3773
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Date:   Thu Oct 24 13:28:00 2019 +0530
> 
>     powerpc/mm/book3s64/radix: Use freed_tables instead of need_flush_all
> 

This really looks like you've got PPC-Radix wrong. As soon as you got
hardware walkers on the linux page-tables, you must not use
TABLE_NO_INVALIDATE.
