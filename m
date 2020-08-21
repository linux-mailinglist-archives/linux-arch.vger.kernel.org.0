Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400C724D837
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgHUPOU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 11:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgHUPNG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 11:13:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DF6C061573;
        Fri, 21 Aug 2020 08:13:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ds1so946249pjb.1;
        Fri, 21 Aug 2020 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mshGO+fS8Fvu8aEJg35ArnuOW0kj8WJXDS3j67fcQcE=;
        b=Dxuzt8Gq7VFN+A3EE1DxMPxeR9USeuD5Ig74qLhRJfNfR1CmVPxrcgV8gPhNHj2A8P
         quPQ5BBpTYZyqfVksB15bO0M5UDQGUg2/RLxDTyK+Jo40A3mOU5yASraaNxMTRw9S0OZ
         JN/wNNkHe44ywg52mENRYGVDjuigU4bPuvrNsGcn/ef5dP1I5n/TKYfxM9lVuHicwz6s
         Zw/5/ic/iqoZQf//idHiVEb0OpRo1LT4zDCNXeQ+gcZ8ESpEwAwKL9N6H+yqcJSx8YM0
         URv+AuGrWbPWMx5M1EKzJeHJmDN2ARnD48B0zdNvmgnYzHz2Jn8n6nsRPZQUsqV4Q4nK
         axrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mshGO+fS8Fvu8aEJg35ArnuOW0kj8WJXDS3j67fcQcE=;
        b=CetdOjLLioar06av/nlVp3MNEjezf0eWj48cFNX71iF/K8KUSDJgWGzFEeAUBnVzJE
         0kXD7G3Mb2mR0z8Y9+mF81TSL/s6z8p1KYqCcmoIVp3y9gmBeVYiV15AMjqCiHyXusjG
         YPrCEDvgN5iH2xeJq0HmrFnvDeJXTXLlAHNa1aW1yVrVq9G43+uh9+/umAkFJCu626Fr
         4FCOP/2AcXTEI3GIqMy7x1Psa/j6BFaPkVk3ifVts0pIcxnSdNkB8fFgQ+zulcMbyZyn
         h9+QPqVGAoUgXiHpo6XjOyIRpxl3UU0Lf7UoJGIEpdQgdvyVUrw/CiU5NAqxnl9pCLFd
         6VyQ==
X-Gm-Message-State: AOAM5322JfWivpC06z0PZnsrAvkLU4DsX8KTLEUMEtSHBkFGPCgyqnP/
        TASOlWmopINdGidFDisO/0k=
X-Google-Smtp-Source: ABdhPJyI4dN8FzkV0FOxrBa1THMuB+8nPxJGWft+AXElncM0Z7aiq7OcjvvT8WAe06i2OCzHEasr8Q==
X-Received: by 2002:a17:90a:cb0b:: with SMTP id z11mr2882310pjt.77.1598022783284;
        Fri, 21 Aug 2020 08:13:03 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id s8sm3126985pfc.122.2020.08.21.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:13:02 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v6 06/12] powerpc: inline huge vmap supported functions
Date:   Sat, 22 Aug 2020 01:12:10 +1000
Message-Id: <20200821151216.1005117-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200821151216.1005117-1-npiggin@gmail.com>
References: <20200821151216.1005117-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This allows unsupported levels to be constant folded away, and so
p4d_free_pud_page can be removed because it's no longer linked to.

Cc: linuxppc-dev@lists.ozlabs.org
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
index eca83a50bf2e..27f5837cf145 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1134,22 +1134,6 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
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
@@ -1233,8 +1217,3 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 	return 1;
 }
-
-bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
-- 
2.23.0

