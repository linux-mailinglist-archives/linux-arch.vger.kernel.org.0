Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2CC251BA9
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 16:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHYO6n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 10:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgHYO6d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Aug 2020 10:58:33 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8905BC061755;
        Tue, 25 Aug 2020 07:58:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so7013560pgf.0;
        Tue, 25 Aug 2020 07:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l67Z2dzho9T2ly5R7eUcCIHpsBNVy2xJSWIdCCUuaqc=;
        b=uDNHH8KhZtI7x0oo3/DGvUVgj15j0EFWeWkpDYBKCLJKsOMtuQ1xtfIlg3G2AhdBIn
         CYJgB2BvAfJMB4LL/pc1kFgvcDgNgqiXBYeStk8noBxkFGfXHwcn8jVawe4QiICKcdN1
         T4XRPdl431VQo65ffcLocq0P2XPLAjeYshZGsAuExgdni/73Sg156xvcwRekGlVWJE2o
         AznQRe/Gzv5OMNjMBjT2abU3ehYKwFcnsxjKAURf/zpJ51iHpE+VyEuioFKDyhFwybyk
         ICUmDfnanBvbNsP5GjLLst5UsdUPbiQXprIPBIH4QHAFO1CzLtHvj7cNT80JD+I/PVED
         g5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l67Z2dzho9T2ly5R7eUcCIHpsBNVy2xJSWIdCCUuaqc=;
        b=B96JckNSXk3jpJAa1yxTOQ/XCSmR77fsCFi9iEmVxmMKsWsjkbfnQhKw/nlJhDjPVo
         2xEN9J2eMu2k3h2BcYtyUsPQeupGOoJDbpGjpIC/RFez5pfVzeThV9X5+un6YmGGPMd/
         7MFXlTYhVRItJjxo07/IK/gikSN9dSRdvAmcwDgXb8B/kCKZXuie+d10up1129eS2DlP
         sDBDyY9s5DWovAFgAn9Svwh+m0+xloVcWc9avTSPy+MpHraa2hCEF6PN7UuXEHOZq9st
         kWkS8qNMpTPy2iQPMOWymQIYIQkXpziHO+nfs/KoEfpJvHeLsHSze35CyRnuh1HyPZiG
         Xcig==
X-Gm-Message-State: AOAM533gN9huvnVBt6jqAfKrCfl1eN5RwYDoTDhapQZZ0hHMeBTMZboP
        ZQVbsJni/8HyRBo3q7/4hJE+y+HLTvE=
X-Google-Smtp-Source: ABdhPJzLMJzy9eSMALAieo2xYeCw4xNiaeoXz3Fa/uIpayqK5UpBelchAC7yK+azH4/CJat9OKGjQg==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr8173396ple.167.1598367513105;
        Tue, 25 Aug 2020 07:58:33 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id e29sm15755956pfj.92.2020.08.25.07.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 07:58:32 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v7 06/12] powerpc: inline huge vmap supported functions
Date:   Wed, 26 Aug 2020 00:57:47 +1000
Message-Id: <20200825145753.529284-7-npiggin@gmail.com>
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

Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

Ack or objection if this goes via the -mm tree? 

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

