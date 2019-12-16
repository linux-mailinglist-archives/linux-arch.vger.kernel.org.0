Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6371206FC
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 14:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbfLPNUm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 08:20:42 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39922 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfLPNUm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 08:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AIBNLHtUi45jjfcVIL9A+S21fh6ASfhp4YxY7c5nbV0=; b=EekAYTbgHV8U4aNxc1/MCeO3Q
        J3YIWEqsUPf4ThjMCPzenT99XhnYOyeCGIXk0fydclAME38x9AfcTJnxUxBPN40vl1kquSjyyqhux
        2brkNugJGgIYmteTLGXIOMlFlL2XldHeBx6KWIqd7H0cveUnkDusYVCQBeYmmvJUXU4Rw4IZp7pV0
        sXNWGH+w04Ho9bM4GSUsPeInODngOMXkuga/vyZ+K/H+mmdWp/NtFPwlxUVW9D42kkf+OdKz5sVtu
        UoEDJBfNI7uT/J2M4Au5funK7rzqsuWkrS5/3aHTo9fp4LldlXRWvQsLN5fi1wcfp+7axY5bD9xdD
        v+573oERw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igqIC-0006kI-Lg; Mon, 16 Dec 2019 13:20:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5087E3035D4;
        Mon, 16 Dec 2019 14:18:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 10B7529D74791; Mon, 16 Dec 2019 14:20:04 +0100 (CET)
Date:   Mon, 16 Dec 2019 14:20:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Will Deacon <will@kernel.org>,
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
Message-ID: <20191216132004.GO2844@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122955.940455408@infradead.org>
 <87woawzc1t.fsf@linux.ibm.com>
 <20191216123752.GM2844@hirez.programming.kicks-ass.net>
 <d52ea890-c2ea-88f3-9d62-b86e60ee77ae@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d52ea890-c2ea-88f3-9d62-b86e60ee77ae@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 16, 2019 at 06:43:53PM +0530, Aneesh Kumar K.V wrote:
> On 12/16/19 6:07 PM, Peter Zijlstra wrote:

> > I'm confused, are you saing you're happy to have PowerPC eat the extra
> > TLB invalidates? I thought you cared about PPC performance :-)
> > 
> > 
> 
> Instead can we do
> 
> static inline void tlb_table_invalidate(struct mmu_gather *tlb)
> {
> #ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
> 	 * Invalidate page-table caches used by hardware walkers. Then we still
> 	 * need to RCU-sched wait while freeing the pages because software
> 	 * walkers can still be in-flight.
> 	 */
> 	tlb_flush_mmu_tlbonly(tlb);
> #endif
> }

How does that not break ARM/ARM64/s390 and x86 ?
