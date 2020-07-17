Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38646223A1B
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 13:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgGQLOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 07:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGQLOj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 07:14:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81221C061755;
        Fri, 17 Jul 2020 04:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mXdH0EdEU6Cy2G+amp6Zc6DclrxoI0Xq6oO6KLBpmqE=; b=yjSqa+5fwh6Wy8j+pNJsjC/qU1
        B2W55tXrcly0UqYSpaENQEh4QFIfSAwqFfE+vAJgyC6OLtPX9la8lpviT1MifASoGfPTlDnAlsFvJ
        1c7lO2spg8rO5c925FNqxh1Z9SaTqtPcBMJ2TFskFB3abEcjcuuaM3ZvTLwzF6SNJJP0jWPMprbG/
        wDNzdmdXu8XExJClvzvqC7btCKV0ixVINJH7odcI9gFbt8hDwfQyEzNMiQmv+yNKd/h1tTAO/7mmI
        DdVsystUlYxe9pki8bthn8jpHCIaw8jgSwxbdgw4wr0T2AMqTmkLQ82Lfkon8Q/Fl65+OKpC0AK1a
        mraN58Yg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwOJZ-0001Zo-Nd; Fri, 17 Jul 2020 11:14:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82068306FFE;
        Fri, 17 Jul 2020 13:14:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CBE5F203D4097; Fri, 17 Jul 2020 13:14:02 +0200 (CEST)
Message-ID: <20200717111349.883694582@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 17 Jul 2020 13:10:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-sh@vger.kernel.org,
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
        Paul Walmsley <paul.walmsley@sifive.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 09/11] nds32/tlb: Fix __p*_free_tlb()
References: <20200717111005.024867618@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Just like regular pages, page directories need to observe the
following order:

 1) unhook
 2) TLB invalidate
 3) free

to ensure it is safe against concurrent accesses.

Even though NDS32 is UP only, we still need to observe this order
because mmu_gather is preemptible.

NDS32 does not in fact have PMDs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/nds32/include/asm/tlb.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/arch/nds32/include/asm/tlb.h
+++ b/arch/nds32/include/asm/tlb.h
@@ -6,6 +6,11 @@
 
 #include <asm-generic/tlb.h>
 
-#define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
+#define __pte_free_tlb(tlb, pte, address)	\
+do {						\
+	pgtable_pte_page_dtor(pte);		\
+	tlb_remove_table((tlb), (pte));		\
+} while (0)
+
 
 #endif


