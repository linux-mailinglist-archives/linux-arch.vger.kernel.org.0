Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33C46D7FE3
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2019 21:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389589AbfJOTTi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Oct 2019 15:19:38 -0400
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:39728 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389571AbfJOTTb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Oct 2019 15:19:31 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 06607C0CD6;
        Tue, 15 Oct 2019 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571167170; bh=gJQnMGxonECDaNYPNrLwCIA62ffLbTLzgnjHo41zQDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDJW6c8glZg1PZKyzY2vkJMCet81A5IGMv4tqw9VLQicuO4zku/C5prsWa9YOcZp7
         w0cLntq0d/potp3TNdqfrOMq0JKeooNxWojDzTQ7gsWSh0OozGvZ+BX05ewF9YORfH
         Lo3cai8cARNoYafhRcwrucsiJYCzkBoteCICqqTSox3d2gPLo4Bz6MDNcba4kRH5Rt
         nc9U1Wsp4ngZR+kFqgGy9UVk+dj0B8xR8X4BJFMulaNwK8UHVZKJJ5w5fFl+Xs7R1y
         5jD+q8vQffwFJWenaRRJCrjNMYOjLpWt+2zS/sqO2wa+qEOFR7+8R2Kzo9OlktNHMD
         CM5xXw+cDDfBA==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.61])
        by mailhost.synopsys.com (Postfix) with ESMTP id 30375A0076;
        Tue, 15 Oct 2019 19:19:29 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 2/5] asm-generic/tlb: stub out pud_free_tlb() if nopud ...
Date:   Tue, 15 Oct 2019 12:19:23 -0700
Message-Id: <20191015191926.9281-3-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015191926.9281-1-vgupta@synopsys.com>
References: <20191015191926.9281-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

... independent of __ARCH_HAS_4LEVEL_HACK

This came up when removing __ARCH_HAS_5LEVEL_HACK for ARC as code bloat
from this routine which is not required in a 2-level paging setup

Note: The primary change is alternate defines for pud_free_tlb() but
while here removed empty stubs for __pud_free_tlb as, which is only called
from pud_free_tlb(), being conditionalized already

| bloat-o-meter2 vmlinux-B-elide-ARCH_USE_5LEVEL_HACK vmlinux-C-elide-pud_free_tlb
| add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-104 (-104)
| function                                     old     new   delta
| free_pgd_range                               656     552    -104
| Total: Before=4137276, After=4137172, chg -1.000000%

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/4level-fixup.h  | 1 -
 include/asm-generic/pgtable-nopud.h | 2 +-
 include/asm-generic/tlb.h           | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/asm-generic/4level-fixup.h b/include/asm-generic/4level-fixup.h
index e3667c9a33a5..c86cf7cb4bba 100644
--- a/include/asm-generic/4level-fixup.h
+++ b/include/asm-generic/4level-fixup.h
@@ -30,7 +30,6 @@
 #undef pud_free_tlb
 #define pud_free_tlb(tlb, x, addr)	do { } while (0)
 #define pud_free(mm, x)			do { } while (0)
-#define __pud_free_tlb(tlb, x, addr)	do { } while (0)
 
 #undef  pud_addr_end
 #define pud_addr_end(addr, end)		(end)
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index c77a1d301155..d3776cb494c0 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -59,7 +59,7 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
  */
 #define pud_alloc_one(mm, address)		NULL
 #define pud_free(mm, x)				do { } while (0)
-#define __pud_free_tlb(tlb, x, a)		do { } while (0)
+#define pud_free_tlb(tlb, x, a)		        do { } while (0)
 
 #undef  pud_addr_end
 #define pud_addr_end(addr, end)			(end)
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 04c0644006fd..5e0c2d01e656 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -584,7 +584,6 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 	} while (0)
 #endif
 
-#ifndef __ARCH_HAS_4LEVEL_HACK
 #ifndef pud_free_tlb
 #define pud_free_tlb(tlb, pudp, address)			\
 	do {							\
@@ -594,7 +593,6 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 		__pud_free_tlb(tlb, pudp, address);		\
 	} while (0)
 #endif
-#endif
 
 #ifndef __ARCH_HAS_5LEVEL_HACK
 #ifndef p4d_free_tlb
-- 
2.20.1

