Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CC630BC9A
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 12:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhBBLHH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 06:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhBBLHA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 06:07:00 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E232CC061573;
        Tue,  2 Feb 2021 03:06:06 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a16so639750plh.8;
        Tue, 02 Feb 2021 03:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FRU9caWwWjvnrqszVqRsss5Upxnc33B3OfV8qLPoO8=;
        b=BLtpKFo+BgRlVpQQW3j8ZC4sQb7LUbMNxR9OvdZjYaGP3RrS6ZT9VkH/tfNgwrPXtW
         9rwl2g6E+WtOCQt4/ObVgzVNxX+JaJcrhE+itbc2msKRMNrNHilpd0PU73XKs0V+U665
         3QmQ7blDhtImH6Q9CMppiW4wQHpLr6snoHRrZ60Nlh5mWe4r+7Jyj3qraTpur6KnSx+S
         cSR3FiRUoSyITY3FZ1B/ieQp/GcyFpRs33NQJKPasX5U0hcIswq23D/F49PA1cvS3voZ
         PPjdbU7uFiZS0BOgFJHqfSD0MQ4VxgWB05EQgTr9dfCdKCSpP9Q/2WQYgwSw7WirAe41
         9wkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FRU9caWwWjvnrqszVqRsss5Upxnc33B3OfV8qLPoO8=;
        b=aw/VC43JH9cifNnUx3OkBZuX7A4sf/wbEMV4Z4mh7XpdvgqlrMC1iRHYCXajTHbF9D
         O6TdAL6PcLvjVl75cLTYvH4+7dpcP+eRvqjDk+HDa430Sj3cbJH637IkbcLqTQLQwRo0
         1QK86D/xY/7uAWwb4E8Uw2P3QUGyaRNIMdz6mL1Q+uIsByikwGkcDcuKdziLptHj6s/x
         H6MT+/cZ2gGJ4FXiWRJO01v1/z2Ohd7Aa2OVT0GiO6yJuMUgdu4ghv1Bk02xcizQ3gE8
         ruXPlcbmNc11OSPl7TFLl/oJcFSQUR6ohOCVBPAB4BG+u9KBERZ+qLW51fDVKZLIir/S
         1mKw==
X-Gm-Message-State: AOAM531S79j9p/4fCX1of+H02jnWYroVMekCL0YwpQLqkZf9R0texsjs
        Fl/LqR0v1zJuMMZGzKXc1XA=
X-Google-Smtp-Source: ABdhPJxy5wuhLIGB5shBbmYaQt0JzKzJciEj6N12Zja8o8hEmPFloC9t+TSQo+EwkfIa1vbuWeaUdg==
X-Received: by 2002:a17:90a:6c26:: with SMTP id x35mr3834636pjj.52.1612263966435;
        Tue, 02 Feb 2021 03:06:06 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 03:06:05 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v12 07/14] powerpc: inline huge vmap supported functions
Date:   Tue,  2 Feb 2021 21:05:08 +1000
Message-Id: <20210202110515.3575274-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210202110515.3575274-1-npiggin@gmail.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This allows unsupported levels to be constant folded away, and so
p4d_free_pud_page can be removed because it's no longer linked to.

Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/vmalloc.h       | 19 ++++++++++++++++---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 21 ---------------------
 2 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/vmalloc.h b/arch/powerpc/include/asm/vmalloc.h
index 105abb73f075..3f0c153befb0 100644
--- a/arch/powerpc/include/asm/vmalloc.h
+++ b/arch/powerpc/include/asm/vmalloc.h
@@ -1,12 +1,25 @@
 #ifndef _ASM_POWERPC_VMALLOC_H
 #define _ASM_POWERPC_VMALLOC_H
 
+#include <asm/mmu.h>
 #include <asm/page.h>
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
-bool arch_vmap_p4d_supported(pgprot_t prot);
-bool arch_vmap_pud_supported(pgprot_t prot);
-bool arch_vmap_pmd_supported(pgprot_t prot);
+static inline bool arch_vmap_p4d_supported(pgprot_t prot)
+{
+	return false;
+}
+
+static inline bool arch_vmap_pud_supported(pgprot_t prot)
+{
+	/* HPT does not cope with large pages in the vmalloc area */
+	return radix_enabled();
+}
+
+static inline bool arch_vmap_pmd_supported(pgprot_t prot)
+{
+	return radix_enabled();
+}
 #endif
 
 #endif /* _ASM_POWERPC_VMALLOC_H */
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 743807fc210f..8da62afccee5 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1082,22 +1082,6 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
 	set_pte_at(mm, addr, ptep, pte);
 }
 
-bool arch_vmap_pud_supported(pgprot_t prot)
-{
-	/* HPT does not cope with large pages in the vmalloc area */
-	return radix_enabled();
-}
-
-bool arch_vmap_pmd_supported(pgprot_t prot)
-{
-	return radix_enabled();
-}
-
-int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
-{
-	return 0;
-}
-
 int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 {
 	pte_t *ptep = (pte_t *)pud;
@@ -1181,8 +1165,3 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 	return 1;
 }
-
-bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
-- 
2.23.0

