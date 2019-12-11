Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFC311AAE3
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfLKMbn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Dec 2019 07:31:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbfLKMbm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 Dec 2019 07:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+ZJ1DOKZOq/0j+v4BO/2WlQxRCr7GEKCNwB8JR0YAik=; b=ddpzUjpPmxkTKtzj7fKv8rcz3A
        YKfmo8Y8IeDliNTqcxKrsXSnpR4uU9o1TKeMsoeXW9Uox7y7K+MNJUWtU8UgySEi4LSC0nLKV49IP
        4pgdnDEVoF75K7Uzjbw9OOYDhN621bhspd5JqaMePUyJw0vpbEyS8zzbodbVWzcXeQYIFBw5RNIjd
        kIgmXThqHI/r6tdwzY2BuLg4UQpYBayEYi7/YDiFgCNNHrVEbtUggrYw6dCBRs1H8Wh+z3Nu3pV7K
        i71g0NWdh13A4Smypw5ftx0m1dSDmv+5/tq7/f6ccPg3BFr/PPElpf+QBLRiB7ZPXqh0sHoUpVF1n
        8QwOuO0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if193-0001Ph-2y; Wed, 11 Dec 2019 12:31:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0271030719C;
        Wed, 11 Dec 2019 13:29:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5AF6420137CBE; Wed, 11 Dec 2019 13:31:02 +0100 (CET)
Message-Id: <20191211122956.572325873@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 11 Dec 2019 13:07:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
Subject: [PATCH 16/17] nds32/tlb: Fix __p*_free_tlb()
References: <20191211120713.360281197@infradead.org>
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
@@ -6,7 +6,12 @@
 
 #include <asm-generic/tlb.h>
 
-#define __pte_free_tlb(tlb, pte, addr)	pte_free((tlb)->mm, pte)
+#define __pte_free_tlb(tlb, pte, address)	\
+do {						\
+	pgtable_pte_page_dtor(pte);		\
+	tlb_remove_table((tlb), (pte));		\
+} while (0)
+
 #define __pmd_free_tlb(tlb, pmd, addr)	pmd_free((tln)->mm, pmd)
 
 #endif


