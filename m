Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF57F2B1A9E
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 13:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKMMEA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 07:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgKMLjg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Nov 2020 06:39:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85916C061A4D;
        Fri, 13 Nov 2020 03:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TbjAEl0VNgxr5FAZ34L9dbraIDKc0iauYUncRRc0dNs=; b=hIBn1ijbK87tkjZTZ6sN4ALaBs
        /BuVNPW+2Ch84dUQbzBbsXhoSzlFETz/3kyYtDXUW07UIKnbW/lGU3CSEgCp03HR9qmVo4uEqb8pc
        blxMH5pjs8m3VCMaPuwnJwkJN8NULegtO6/b6Qf76Y849/SpNnz2SoU12Wer/ZOd12aZtcFVpERWx
        U0CQOodsii5uMDuSaXnFsUIX0SES6+/SbPtkCs5vK9QYSxJmXODqMTe+Hh/Bs2P9CsqEpC3GF2XXp
        wyy6O+G4lPnoimRd+Muc7gPxCx7DEY4f5i7gMb8QD62SaLjfWML7HGK19N1oSnzsK88TYWyrPY/cT
        hni5eehw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdXPK-0001jM-Th; Fri, 13 Nov 2020 11:38:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E5F2307197;
        Fri, 13 Nov 2020 12:38:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 463052BCDBFDC; Fri, 13 Nov 2020 12:38:19 +0100 (CET)
Message-ID: <20201113113426.655116103@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 13 Nov 2020 12:19:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com
Cc:     christophe.leroy@csgroup.eu, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, will@kernel.org,
        willy@infradead.org, aneesh.kumar@linux.ibm.com,
        sparclinux@vger.kernel.org, davem@davemloft.net,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        peterz@infradead.org
Subject: [PATCH 5/5] sparc64/mm: Implement pXX_leaf_size() support
References: <20201113111901.743573013@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Sparc64 has non-pagetable aligned large page support; wire up the
pXX_leaf_size() functions to report the correct TLB page size.

This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate TLB
page sizes.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sparc/include/asm/pgtable_64.h |   13 +++++++++++++
 arch/sparc/mm/hugetlbpage.c         |   19 +++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -1121,6 +1121,19 @@ extern unsigned long cmdline_memory_size
 
 asmlinkage void do_sparc64_fault(struct pt_regs *regs);
 
+#ifdef CONFIG_HUGETLB_PAGE
+
+#define pud_leaf_size pud_leaf_size
+extern unsigned long pud_leaf_size(pud_t pud);
+
+#define pmd_leaf_size pmd_leaf_size
+extern unsigned long pmd_leaf_size(pmd_t pmd);
+
+#define pte_leaf_size pte_leaf_size
+extern unsigned long pte_leaf_size(pte_t pte);
+
+#endif /* CONFIG_HUGETLB_PAGE */
+
 #endif /* !(__ASSEMBLY__) */
 
 #endif /* !(_SPARC64_PGTABLE_H) */
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -247,14 +247,17 @@ static unsigned int sun4u_huge_tte_to_sh
 	return shift;
 }
 
-static unsigned int huge_tte_to_shift(pte_t entry)
+static unsigned long tte_to_shift(pte_t entry)
 {
-	unsigned long shift;
-
 	if (tlb_type == hypervisor)
-		shift = sun4v_huge_tte_to_shift(entry);
-	else
-		shift = sun4u_huge_tte_to_shift(entry);
+		return sun4v_huge_tte_to_shift(entry);
+
+	return sun4u_huge_tte_to_shift(entry);
+}
+
+static unsigned int huge_tte_to_shift(pte_t entry)
+{
+	unsigned long shift = tte_to_shift(entry);
 
 	if (shift == PAGE_SHIFT)
 		WARN_ONCE(1, "tto_to_shift: invalid hugepage tte=0x%lx\n",
@@ -272,6 +275,10 @@ static unsigned long huge_tte_to_size(pt
 	return size;
 }
 
+unsigned long pud_leaf_size(pud_t pud) { return 1UL << tte_to_shift((pte_t)pud); }
+unsigned long pmd_leaf_size(pmd_t pmd) { return 1UL << tte_to_shift((pte_t)pmd); }
+unsigned long pte_leaf_size(pte_t pte) { return 1UL << tte_to_shift((pte_t)pte); }
+
 pte_t *huge_pte_alloc(struct mm_struct *mm,
 			unsigned long addr, unsigned long sz)
 {


