Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 736411205F3
	for <lists+linux-arch@lfdr.de>; Mon, 16 Dec 2019 13:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLPMjD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Dec 2019 07:39:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39466 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfLPMjD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 07:39:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c88RMelWbUgUiJroWa0Q0HLfhfNHGH7r6t3skBuZYFU=; b=XRZMxrgL4mXQitjiaHR/vTJzl
        OiXWCYBgvU4/QgW7TOQLLk3vijwtgoULXNuuag+CGBE4W//7PBd4XrtGPhLNpwfwUbsYAVnFpDIos
        JBgvxayPVZKPeIwz/yeAl21ZbYmkrTuMyrqxloImgsH3iPP2/GYw8gxOYj+/6wyF7CF0ysOL4G+nO
        4huaSdYpFYtqTdO8fNHTZdS8gqUWr7PHTj34GM5vIZIWb0g4sYsbL8ajNGiTNBRUhCDO3zuMReRvL
        AzmyMhV5V0/tSyXjv664vXjdN14UJgBsqce8S1p+YoCwFeO674JWwmT16Zd+loev4G23/hPGZYTbY
        e0tgk3YbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1igpdM-00064m-Dp; Mon, 16 Dec 2019 12:37:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06AD13007F2;
        Mon, 16 Dec 2019 13:36:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBF192B1A6BF5; Mon, 16 Dec 2019 13:37:52 +0100 (CET)
Date:   Mon, 16 Dec 2019 13:37:52 +0100
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
Message-ID: <20191216123752.GM2844@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122955.940455408@infradead.org>
 <87woawzc1t.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woawzc1t.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 16, 2019 at 06:01:58PM +0530, Aneesh Kumar K.V wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > Towards a more consistent naming scheme.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/Kconfig              |    3 ++-
> >  arch/powerpc/Kconfig      |    2 +-
> >  arch/sparc/Kconfig        |    2 +-
> >  include/asm-generic/tlb.h |    2 +-
> >  mm/mmu_gather.c           |    2 +-
> >  5 files changed, 6 insertions(+), 5 deletions(-)
> >
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -396,8 +396,9 @@ config HAVE_ARCH_JUMP_LABEL_RELATIVE
> >  config MMU_GATHER_RCU_TABLE_FREE
> >  	bool
> >  
> > -config HAVE_RCU_TABLE_NO_INVALIDATE
> > +config MMU_GATHER_NO_TABLE_INVALIDATE
> >  	bool
> > +	depends on MMU_GATHER_RCU_TABLE_FREE
> 
> 
> Can we drop this Kernel config option instead use
> MMU_GATHER_RCU_TABLE_FREE? IMHO reducing the kernel config related to
> mmu_gather can reduce the complexity. 

I'm confused, are you saing you're happy to have PowerPC eat the extra
TLB invalidates? I thought you cared about PPC performance :-)


