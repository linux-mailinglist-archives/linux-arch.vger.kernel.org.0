Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1D4F1208EB
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 15:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfLPOu6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 09:50:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfLPOu6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 09:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y3dsY+rCZ72stCfTD3m+0TsmTj/a4NlFQ0hd6IQYEPE=; b=lKMXj16A/yhZR/XjFy7+ZjF8B
        2bUZJOzvcQsK9xwHXf8tjsXQOXRKjUh6GBlMdQrCSbGiqz1LyP/9dzCE4qkaP09VIVxfbKC5gMcu1
        WXcrxCYzpFa9fPXh/JEMhJyImklEZeBWsVfEkcXiqp8iCEa1XaAQ09Wui5gKRaXxnGtjnBplpB5is
        dJjgkX33tJ7LdVSkzUQYX4CVoZ/Xk/A8nL0YRQz7yjFIemb2vchlxD1kKirmFo9YWHVLkujUJD22T
        WvlRkH+xkMjgeEKfG1tIY0PWvF7OWX5sp7QWxrl/GtT9+k2fzmY9UwKQ57KQ8/L2zTh+eQ9peyhEd
        hBWcq5leA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igrhs-0001L1-Gl; Mon, 16 Dec 2019 14:50:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 974E0301747;
        Mon, 16 Dec 2019 15:49:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79DAE2B2A1923; Mon, 16 Dec 2019 15:50:41 +0100 (CET)
Date:   Mon, 16 Dec 2019 15:50:41 +0100
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
Message-ID: <20191216145041.GG2827@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122955.940455408@infradead.org>
 <87woawzc1t.fsf@linux.ibm.com>
 <20191216123752.GM2844@hirez.programming.kicks-ass.net>
 <d52ea890-c2ea-88f3-9d62-b86e60ee77ae@linux.ibm.com>
 <20191216132004.GO2844@hirez.programming.kicks-ass.net>
 <a9ae27c8-aa84-cda3-355c-7abb3b450d38@linux.ibm.com>
 <33ed03aa-a34c-3a81-0f83-20c3e8d4eff7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ed03aa-a34c-3a81-0f83-20c3e8d4eff7@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 16, 2019 at 07:24:24PM +0530, Aneesh Kumar K.V wrote:

> So __p*_free_tlb() routines on ppc64 just mark that we need a page walk
> cache flush and the actual flush in done in tlb_flush_mmu.

Not quite, your __p*_free_tlb() goes to pgtable_free_tlb() which call
tlb_remove_table().

> As per
> 
> d86564a2f085b79ec046a5cba90188e61235280 (mm/tlb, x86/mm: Support
> invalidating TLB caches for RCU_TABLE_FREE ) that is not sufficient?

96bc9567cbe1 ("asm-generic/tlb, arch: Invert CONFIG_HAVE_RCU_TABLE_INVALIDATE")

And no. Since you have TABLE_NO_INVALIDATE set, tlb_remove_table() will
not TLBI when it fails to allocate a batch page, which is an error for
PPC-Radix.

There is also no TLBI when the batch page is full and the RCU callback
happens, which is also a bug on PPC-Radix.
