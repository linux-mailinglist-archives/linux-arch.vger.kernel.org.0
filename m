Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D924D827
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 17:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgHUPNO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgHUPNJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 11:13:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A47C061573;
        Fri, 21 Aug 2020 08:13:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o5so1142710pgb.2;
        Fri, 21 Aug 2020 08:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5XA+NVPhwbbllPG3xUWDGiDWcwCyUaHTGopG9dY3tOQ=;
        b=IqkomYLyWOWMOqPurIrzg99tZuO52VxFInUZTbikhVRxM4PXfxkwGHmlLO+XS0zZSk
         Pr7Jd2rs7vQ185N1QdUaYkoZ4efSqpJzxD94EJrzKx8kIqjycx8mvql3EtLZ04XD3PAv
         +mN7jYy17uEBwVMXBv+3QBaSIDwxz6zgeYjlPRuBkvdkuCiXh+vxSMcls6+ydgc6gluz
         WkRQ9CbCHTwvp0L5Wq+43+aFGNYPR0WtTbRIskVC8QnIMlAQeaDA6mbIgiGQ3bghONDn
         zxSAZVTZqpMLebzKsAXqaVzCJEbINtXsTKreC3UxJIdgVmZfEImtFPVyNKgk8QoG/nxi
         Cnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5XA+NVPhwbbllPG3xUWDGiDWcwCyUaHTGopG9dY3tOQ=;
        b=FGJVSZ3d3lqm46AvE3zH15tij2mjmjf6rgvYHXoy4IKIRzF3rnxZA+Jkzq8dL5LheU
         2Kx/NeMhC+MK5Y1wOtCPQqa4lWv+YVcqMtlKAllpTRB2F3zfuv3bxk9Gebpymxuw67gO
         zMQzPoxF3NfhmBypWLYO0hQlIXLXRzTvkk92q37O3aGGkuTukMRrSmNJ2Nqieh7oHp3u
         oVe13DHTAhq8fMKmEjx5UdCRzkdypTWiMDHPzWPDhz0m8FaIqoQSCXp/bnMmr+fJiE/v
         Q2yPw8HT/E0NRwE77gxc7X2DU2fP3EbkQ/5rbYA+jekHA1wbcZYlR+TwZ/L4pY9eHJzG
         GYUg==
X-Gm-Message-State: AOAM530QmOVJrfbkX9gN4GmpWH4kjcU0850ihM+WHjGR9IVJV4KhnHvp
        ml2cJaalOXI4329vc2PHClA=
X-Google-Smtp-Source: ABdhPJwMltqvuSSQ4qdpsDYl7lU9jXM0/s7ZBmlyh9r6bV9pBXP6Cdk0H0vc9dugPEDfhsI32WoXkg==
X-Received: by 2002:a63:7505:: with SMTP id q5mr2561816pgc.312.1598022788965;
        Fri, 21 Aug 2020 08:13:08 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id s8sm3126985pfc.122.2020.08.21.08.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:13:08 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 07/12] arm64: inline huge vmap supported functions
Date:   Sat, 22 Aug 2020 01:12:11 +1000
Message-Id: <20200821151216.1005117-8-npiggin@gmail.com>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/arm64/include/asm/vmalloc.h | 23 ++++++++++++++++++++---
 arch/arm64/mm/mmu.c              | 26 --------------------------
 2 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
index 597b40405319..fc9a12d6cc1a 100644
--- a/arch/arm64/include/asm/vmalloc.h
+++ b/arch/arm64/include/asm/vmalloc.h
@@ -4,9 +4,26 @@
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
+	/*
+	 * Only 4k granule supports level 1 block mappings.
+	 * SW table walks can't handle removal of intermediate entries.
+	 */
+	return IS_ENABLED(CONFIG_ARM64_4K_PAGES) &&
+	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
+}
+
+static inline bool arch_vmap_pmd_supported(pgprot_t prot)
+{
+	/* See arch_vmap_pud_supported() */
+	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
+}
 #endif
 
 #endif /* _ASM_ARM64_VMALLOC_H */
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 9df7e0058c78..07093e148957 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1304,27 +1304,6 @@ void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
 	return dt_virt;
 }
 
-bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
-
-bool arch_vmap_pud_supported(pgprot_t prot);
-{
-	/*
-	 * Only 4k granule supports level 1 block mappings.
-	 * SW table walks can't handle removal of intermediate entries.
-	 */
-	return IS_ENABLED(CONFIG_ARM64_4K_PAGES) &&
-	       !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
-}
-
-bool arch_vmap_pmd_supported(pgprot_t prot)
-{
-	/* See arch_vmap_pud_supported() */
-	return !IS_ENABLED(CONFIG_PTDUMP_DEBUGFS);
-}
-
 int pud_set_huge(pud_t *pudp, phys_addr_t phys, pgprot_t prot)
 {
 	pud_t new_pud = pfn_pud(__phys_to_pfn(phys), mk_pud_sect_prot(prot));
@@ -1416,11 +1395,6 @@ int pud_free_pmd_page(pud_t *pudp, unsigned long addr)
 	return 1;
 }
 
-int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
-{
-	return 0;	/* Don't attempt a block mapping */
-}
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 {
-- 
2.23.0

