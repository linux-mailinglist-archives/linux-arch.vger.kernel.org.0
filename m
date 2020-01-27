Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF4149F90
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2020 09:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgA0IMI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jan 2020 03:12:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgA0IMI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jan 2020 03:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IUm93oOamnFo5hv3nJSbaylh1DDwQYJBt4Fpf5TYElU=; b=jTFjC7I67Cn2qeRKe1K6/I5jT
        yvg1vVFv5/oMehurUQgdtZgH4P1zAgC7IEs/6W4kcTxi86ngyic/hviSfjT5kLXfIM94MNeDRePVF
        suzzEIMOHDLZiJxHBCoWtpUqssbdXyP4KXWOLn8vbMsuZAUYuRAJZ9PmLOpBlTYHjK0zrKGtdHvGS
        AMGOSLfYnWMydVEwDDwURS295o9cLVcvZEpnRM4vW1IcTrPns9y77JpoypCxFTt/ouF4kko/cJOvq
        YSQxKkAUuPH8pvIoHRc0/aEvhhLUXVqU+mCFMlPwbg2d3WCFP2gOQcQRQaG4mKDcYhzRarLqY99+c
        9o4VxNdlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivzUg-00074m-49; Mon, 27 Jan 2020 08:11:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B8214300F4B;
        Mon, 27 Jan 2020 09:09:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C2F8203CF5D4; Mon, 27 Jan 2020 09:11:34 +0100 (CET)
Date:   Mon, 27 Jan 2020 09:11:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
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
Subject: Re: [PATCH mk-II 08/17] asm-generic/tlb: Provide
 MMU_GATHER_TABLE_FREE
Message-ID: <20200127081134.GI14914@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122956.112607298@infradead.org>
 <20191212093205.GU2827@hirez.programming.kicks-ass.net>
 <20200126155205.GA19169@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126155205.GA19169@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 26, 2020 at 07:52:05AM -0800, Guenter Roeck wrote:
> On Thu, Dec 12, 2019 at 10:32:05AM +0100, Peter Zijlstra wrote:
> > As described in the comment, the correct order for freeing pages is:
> > 
> >  1) unhook page
> >  2) TLB invalidate page
> >  3) free page
> > 
> > This order equally applies to page directories.
> > 
> > Currently there are two correct options:
> > 
> >  - use tlb_remove_page(), when all page directores are full pages and
> >    there are no futher contraints placed by things like software
> >    walkers (HAVE_FAST_GUP).
> > 
> >  - use MMU_GATHER_RCU_TABLE_FREE and tlb_remove_table() when the
> >    architecture does not do IPI based TLB invalidate and has
> >    HAVE_FAST_GUP (or software TLB fill).
> > 
> > This however leaves architectures that don't have page based
> > directories but don't need RCU in a bind. For those, provide
> > MMU_GATHER_TABLE_FREE, which provides the independent batching for
> > directories without the additional RCU freeing.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> 
> Various sparc64 builds (allnoconfig, tinyconfig, as well as builds
> with SMP disabled):
> 
> mm/mmu_gather.c: In function '__tlb_remove_table_free':
> mm/mmu_gather.c:101:3: error: implicit declaration of function '__tlb_remove_table'; did you mean 'tlb_remove_table'?

Thanks; I'll respin these patches against Aneesh' pile and make sure to
look into this when I do so.


