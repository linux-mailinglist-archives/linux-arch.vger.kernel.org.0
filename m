Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6EA251BA8
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 16:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHYO6l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 10:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgHYO6j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Aug 2020 10:58:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3BC061756;
        Tue, 25 Aug 2020 07:58:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k15so1083276pfc.12;
        Tue, 25 Aug 2020 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/5eWAbEDQgOkiF6H06FGKZHT/EDb26p/JCBso4Tchw=;
        b=b0AWgWGGUkjUbVDCI2TEdIDTZ4JsxKTUttA8MH4l5sDv3h/rE3ZTwojNnF/PYUM1Mc
         rChp7wjU4B40W63KYGDwvx8DMJuTlmJIWmiOvJ24kwFppMGbxEe7UsbE/BSgegHkfb3j
         LONhu22IlfERWDw8KCGGDDHT35FyWcfSU82h3i6KidDfX79nz7QiE46/WdC5uZ4brzxu
         8hrUEomJ1vnvGYG6UeDro5fRriPjk19sdTPUR0iAB0Omt6kUP5pVWMF3b7oZncCSELwC
         CgmHBgVY75MA6GwJqdeihvCoBXpuhmVIXDzN41XcjOhbeUcHiyD7Ay2fGa3VscHvt8OI
         U6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/5eWAbEDQgOkiF6H06FGKZHT/EDb26p/JCBso4Tchw=;
        b=ttr3r+InaOcFCHFP+4NElmRkWMcnEaZyfXtj6omQPRst62n2ifLMdi5QqiTlaglG5V
         PRhPTFkg4P/bvVLr6wrK07NGdsUXeoCGoOpVa7NyvNwO6GJLZpwFYEzpCBF3buAgaVrI
         gG4YWt1CZ5Jrs6QmMw9ed81Vav5p9HT3bwd77Pj5LOli6R8m1ZaUCIwfWZ5suVdrrRcj
         gcRL6ZjgmkO0pMWu/jw1SMoAkeO2hv7u408mZ/HMLwwkYMw8pyFoC0pv/1ZbdE4jTpsR
         khJCI7X6lX6km4KYV/iYMrMJeOKnu5MZD/qihLW/rahpO4+ftbZGasnVgrFraKB/r7nj
         FWkA==
X-Gm-Message-State: AOAM5307k1k88KfuX266IMvu/4rM7mygA6J1LT8jM2TMcyuI5ICsfG2T
        GLi/MRjoMdlkfkzIpsriuGk=
X-Google-Smtp-Source: ABdhPJyoYG5YDMJT67BmAM16vft0/MgmMdJ09oTXgsuH1MNyBThmKV5NRHMl8mSRkrVyoySYFmRl/A==
X-Received: by 2002:aa7:9f92:: with SMTP id z18mr8222689pfr.260.1598367518404;
        Tue, 25 Aug 2020 07:58:38 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id e29sm15755956pfj.92.2020.08.25.07.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 07:58:38 -0700 (PDT)
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
Subject: [PATCH v7 07/12] arm64: inline huge vmap supported functions
Date:   Wed, 26 Aug 2020 00:57:48 +1000
Message-Id: <20200825145753.529284-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200825145753.529284-1-npiggin@gmail.com>
References: <20200825145753.529284-1-npiggin@gmail.com>
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

Ack or objection if this goes via the -mm tree?

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

