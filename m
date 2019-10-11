Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD93D4A74
	for <lists+linux-arch@lfdr.de>; Sat, 12 Oct 2019 00:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfJKWrL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 18:47:11 -0400
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:37182 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbfJKWrL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 18:47:11 -0400
X-Greylist: delayed 522 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Oct 2019 18:47:10 EDT
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 80CEFC04A7;
        Fri, 11 Oct 2019 22:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1570833508; bh=E0P1RFAQD2Jf3g/rlBhYfNzwHdOeyXPqBOG/QZTvieM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6IYKky8AdyUQ2QMjcIa2Uj+0XJjLeGbu6SH7JKVYKXMO6VLVywzRybptkCdTakG0
         RDHIGz82Gfiajkpm4OCoDCz9X4UjVucNxnWyUWfz+tlwwNcSs1lfGeqyUqmRKJ3LFS
         tBwLL8Ru9EXyP/LBxMEtY6xAHed0FQeC59VOQqR9UUlgMl+BFNEPVVNI9SqOd5WLg0
         jRQ+NyVOSXkfzBGVDgUyBMjNBT83MBQiNVhn3m6ENnXJdTZM9bDCep+rLXiai1UQkv
         UIYZzv9FSGgroLSDe0WPaDu0yK3CsCcEcUiNmvP+v0zljLl4HIl6q2weZjeDtxqIVu
         zIeuNs1TDq8ZA==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.61])
        by mailhost.synopsys.com (Postfix) with ESMTP id AC1E4A006B;
        Fri, 11 Oct 2019 22:38:21 +0000 (UTC)
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
Subject: [RFC] asm-generic/tlb: stub out pmd_free_tlb() if __PAGETABLE_PMD_FOLDED
Date:   Fri, 11 Oct 2019 15:38:18 -0700
Message-Id: <20191011223818.7238-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191011121951.nxna6hruuskvdxod@box>
References: <20191011121951.nxna6hruuskvdxod@box>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is inine with similar patches for nopud [1] and nop4d [2] cases.

  However I'm not really sure I understand clearly how the nopmd code is
  supposed to work (for a 2 tier paging system) - hence the RFC.
  Consider free_pmd_range() simplified/annotated below

  free_pmd_range
  ...
	pmd = pmd_offset(pud, addr);
	do {
		next = pmd_addr_end(addr, end);
		if (pmd_none_or_clear_bad(pmd)) => *pmd_bad()/pmd_clear_bad() [a]*
			continue;
		free_pte_range(tlb, pmd, addr);
	} while (pmd++, addr = next, addr != end);
   ...
	*pmd_free_tlb(tlb, pmd, start); => [b]*

   For ARC/nopmd case [a] is actually checking pgd and consequently
   pmd_clear_bad() can't be stubbed out for PMD_FOLDED case. However it seems
   case [b] can be stubbed out (hence this patch) along same lines as [1] and [2]

| bloat-o-meter2 vmlinux-E-elide-p?d_clear_bad vmlinux-F-elide-pmd_free_tlb
| add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-112 (-112)
| function                                     old     new   delta
| free_pgd_range                               422     310    -112
| Total: Before=4137002, After=4136890, chg -1.000000%

[1] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006266.html
[2] http://lists.infradead.org/pipermail/linux-snps-arc/2019-October/006265.html

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/tlb.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index f3dad87f4ecc..a1edad7d4170 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -574,6 +574,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 	} while (0)
 #endif
 
+#ifndef __PAGETABLE_PMD_FOLDED
 #ifndef pmd_free_tlb
 #define pmd_free_tlb(tlb, pmdp, address)			\
 	do {							\
@@ -583,6 +584,9 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
 		__pmd_free_tlb(tlb, pmdp, address);		\
 	} while (0)
 #endif
+#else
+#define pmd_free_tlb(tlb, pmdp, address)        do { } while (0)
+#endif
 
 #ifndef __PAGETABLE_PUD_FOLDED
 #ifndef pud_free_tlb
-- 
2.20.1

