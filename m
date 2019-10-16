Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36FA5D972C
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 18:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406214AbfJPQYZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 12:24:25 -0400
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:58544 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406117AbfJPQYH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Oct 2019 12:24:07 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 00485C3006;
        Wed, 16 Oct 2019 16:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571243046; bh=I83LSLyqJ3n0GzQ1+sT02W9/9Z0LbDBtsN2auGtpAaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVnhWYOMOtzVRxSoWjsbiXp8fHrwtS9YMzNXCKPRO/Aetx1ogSf706iRyJKzLeccp
         +kWaDRKzTqHzLJeRMn850VmVRlSFQtADSIHn8DyDbaAwIB6z/as9Lx2sXw4SU9zi05
         7yv7p+QsBHdgUZlRQOKbfeJxZFmZr5BYVWNsobI2at++Vy8lbTYWs5RWMrnTjBWj4Z
         1dNcYUW4+J2m/OA/5lsgEM3MINWYoh24edgnlUEhs47cpyZ7iVEjk282LLd6f/jYF9
         8dJyW1YFv+TH605rIRuhV9FBAdsDMo2ahTxrZiskFJ8UaKYhONh4BTPa+48ErX7W2m
         uL1mSffnxaRrA==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.61])
        by mailhost.synopsys.com (Postfix) with ESMTP id 77CE9A007D;
        Wed, 16 Oct 2019 16:24:04 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-mm@kvack.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v3 3/5] asm-generic/tlb: stub out p4d_free_tlb() if nop4d ...
Date:   Wed, 16 Oct 2019 09:23:58 -0700
Message-Id: <20191016162400.14796-4-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016162400.14796-1-vgupta@synopsys.com>
References: <20191016162400.14796-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

... independent of __ARCH_HAS_5LEVEL_HACK

This came up when removing __ARCH_HAS_5LEVEL_HACK for ARC as code bloat.
With this patch we see the following code reduction

| bloat-o-meter2 vmlinux-C-elide-pud_free_tlb vmlinux-D-elide-p4d_free_tlb
| add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-104 (-104)
| function                                     old     new   delta
| free_pgd_range                               552     422    -130
| Total: Before=4137172, After=4137042, chg -1.000000%

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/5level-fixup.h  | 1 -
 include/asm-generic/pgtable-nop4d.h | 2 +-
 include/asm-generic/tlb.h           | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
index f6947da70d71..4c74b1c1d13b 100644
--- a/include/asm-generic/5level-fixup.h
+++ b/include/asm-generic/5level-fixup.h
@@ -51,7 +51,6 @@ static inline int p4d_present(p4d_t p4d)
 #undef p4d_free_tlb
 #define p4d_free_tlb(tlb, x, addr)	do { } while (0)
 #define p4d_free(mm, x)			do { } while (0)
-#define __p4d_free_tlb(tlb, x, addr)	do { } while (0)
 
 #undef  p4d_addr_end
 #define p4d_addr_end(addr, end)		(end)
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index aebab905e6cd..ce2cbb3c380f 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -50,7 +50,7 @@ static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
  */
 #define p4d_alloc_one(mm, address)		NULL
 #define p4d_free(mm, x)				do { } while (0)
-#define __p4d_free_tlb(tlb, x, a)		do { } while (0)
+#define p4d_free_tlb(tlb, x, a)			do { } while (0)
 
 #undef  p4d_addr_end
 #define p4d_addr_end(addr, end)			(end)
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 5e0c2d01e656..05dddc17522b 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -594,7 +594,6 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 	} while (0)
 #endif
 
-#ifndef __ARCH_HAS_5LEVEL_HACK
 #ifndef p4d_free_tlb
 #define p4d_free_tlb(tlb, pudp, address)			\
 	do {							\
@@ -603,7 +602,6 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 		__p4d_free_tlb(tlb, pudp, address);		\
 	} while (0)
 #endif
-#endif
 
 #endif /* CONFIG_MMU */
 
-- 
2.20.1

