Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A06C1209BE
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 16:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfLPPbW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 10:31:22 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41304 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbfLPPbW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 10:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=a8LsOaGDs/Z3fBnFkqVotZhvYgNBIldUCQVm7RoIjUw=; b=owOuxhkOKLqC2aX5Ubb+i3Lrc
        1J/D+0WnBgyS8URosr+J53C7mFpvAzCVyLGKXTcQfUfPOOnkM8BjFyyCZswOaf4LRVcAQfbYBIYDE
        o1XBGZfki3nEpN3bvWg1RB0E5nC7B0dqfG6j8kTTnYlwT22Dby4B45p4JklKVMbFes5e7eN7xjpBO
        xI93EfP5FSRaOvV7kRi+AUGzG0CD22v5XS0gxv80irPuOCwmsv7iac5YzdmNjpzvtdt+nbdn2/JYg
        rFMSL7vf31OneaqLAe2jCNoqMB1dMgB352yWfH56PYzpTwfdZ7wZZO3YV3XTa85eubc90XSYRF0EW
        fgdfN3KSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igsKh-0000Ou-6E; Mon, 16 Dec 2019 15:30:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 096BD3035D4;
        Mon, 16 Dec 2019 16:29:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE7E72B2A192E; Mon, 16 Dec 2019 16:30:47 +0100 (CET)
Date:   Mon, 16 Dec 2019 16:30:47 +0100
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
Message-ID: <20191216153047.GM2871@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122955.940455408@infradead.org>
 <87woawzc1t.fsf@linux.ibm.com>
 <20191216123752.GM2844@hirez.programming.kicks-ass.net>
 <d52ea890-c2ea-88f3-9d62-b86e60ee77ae@linux.ibm.com>
 <20191216132004.GO2844@hirez.programming.kicks-ass.net>
 <a9ae27c8-aa84-cda3-355c-7abb3b450d38@linux.ibm.com>
 <33ed03aa-a34c-3a81-0f83-20c3e8d4eff7@linux.ibm.com>
 <20191216145041.GG2827@hirez.programming.kicks-ass.net>
 <20191216151419.GL2871@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216151419.GL2871@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 16, 2019 at 04:14:19PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 03:50:41PM +0100, Peter Zijlstra wrote:
> > On Mon, Dec 16, 2019 at 07:24:24PM +0530, Aneesh Kumar K.V wrote:
> > 
> > > So __p*_free_tlb() routines on ppc64 just mark that we need a page walk
> > > cache flush and the actual flush in done in tlb_flush_mmu.
> > 
> > Not quite, your __p*_free_tlb() goes to pgtable_free_tlb() which call
> > tlb_remove_table().
> > 
> > > As per
> > > 
> > > d86564a2f085b79ec046a5cba90188e61235280 (mm/tlb, x86/mm: Support
> > > invalidating TLB caches for RCU_TABLE_FREE ) that is not sufficient?
> > 
> > 96bc9567cbe1 ("asm-generic/tlb, arch: Invert CONFIG_HAVE_RCU_TABLE_INVALIDATE")
> > 
> > And no. Since you have TABLE_NO_INVALIDATE set, tlb_remove_table() will
> > not TLBI when it fails to allocate a batch page, which is an error for
> > PPC-Radix.
> > 
> > There is also no TLBI when the batch page is full and the RCU callback
> > happens, which is also a bug on PPC-Radix.
> 
> It seems to me you need something like this here patch, all you need to
> add is a suitable definition of tlb_needs_table_invalidate() for Power.

I'm thinking this:

#define tlb_needs_table_invalidate()	radix_enabled()

should work for you. When you have Radix you need that TLBI, if you have
Hash you don't.
