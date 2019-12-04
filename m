Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0F1112985
	for <lists+linux-arch@lfdr.de>; Wed,  4 Dec 2019 11:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLDKtS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Dec 2019 05:49:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:59866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDKtS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 05:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bzEyGREtuXLN+BJxDXXMIaaMU5KjR8ry9dUjVmcDpeU=; b=gxYkV6vZObIYRZTv3aSY6JqJx
        ajMdvZ4eP8CRwMNtZoKDZ2Uoj9SyNpex4TQGBG4QjfWiMOFgBqgN280jfkuKAcfs8xW3jzyEJRX1k
        9gfzx/4W3ajHtjI23hu1lESGb/LL+Cu7ME++Y6nk5U6lpc6ncAQdnIF58wm4FTMOChNCFX+X+KBaF
        mPu52L3jpoDb7in+11K70kLmjzxk0cunAvU2cR8GaDQMyEX0ssfYbgB7dfAXGHHM4G2uk+FWEcL5W
        8ItWr0uDhCakCPhq5avym6TKiFur1RGgx+OZGUUC/i5h7mcvxzCXqf/nt1vU9RvJXJ/Jcuzq5oqRZ
        wUtC6+8ZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icSC2-0005Cu-Tg; Wed, 04 Dec 2019 10:47:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0B4D3011DD;
        Wed,  4 Dec 2019 11:46:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A5082007B378; Wed,  4 Dec 2019 11:47:33 +0100 (CET)
Date:   Wed, 4 Dec 2019 11:47:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Message-ID: <20191204104733.GR2844@hirez.programming.kicks-ass.net>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 03, 2019 at 12:19:00PM +0100, Geert Uytterhoeven wrote:
> Hoi Peter,
> 
> On Tue, Feb 19, 2019 at 11:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > Generic mmu_gather provides everything SH needs (range tracking and
> > cache coherency).
> >
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Nick Piggin <npiggin@gmail.com>
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > Cc: Rich Felker <dalias@libc.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I got remote access to an SH7722-based Migo-R again, which spews a long
> sequence of BUGs during userspace startup.  I've bisected this to commit
> c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").

Whoopsy.. also, is this really the first time anybody booted an SH
kernel in over a year ?!?

> Do you have a clue?

Does the below help?

diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 22d968bfe9bb..73a2c00de6c5 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -36,9 +36,8 @@ do {							\
 #if CONFIG_PGTABLE_LEVELS > 2
 #define __pmd_free_tlb(tlb, pmdp, addr)			\
 do {							\
-	struct page *page = virt_to_page(pmdp);		\
-	pgtable_pmd_page_dtor(page);			\
-	tlb_remove_page((tlb), page);			\
+	pgtable_pmd_page_dtor(pmdp);			\
+	tlb_remove_page((tlb), (pmdp));			\
 } while (0);
 #endif
 
