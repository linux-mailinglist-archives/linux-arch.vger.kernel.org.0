Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982042CFA1B
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 08:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgLEG66 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 01:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgLEG65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 01:58:57 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2E9C061A55;
        Fri,  4 Dec 2020 22:58:13 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id iq13so4433893pjb.3;
        Fri, 04 Dec 2020 22:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HiUfAFVtYQfdJFI+mGar/loPm26LbyhdUt8nmYytWQQ=;
        b=DxmZPA3yAfjPLXLMP04XS6JXFdsWLGTS01CQhH8sB/zsK9XTcQVwrq4kbXx7YdojRK
         yGn64NeViNWYWiFixEYhcMj2muh0L0+uifTZxha4vibt+CbN5dDPstR/oH88Rdx2TXe1
         DPmtfYXy/yZqSoldqCGJe1d5yEgHX5VJZUvx34k38zBxcsWESi3TXgbQCCzU5FCHtmfX
         uvPDEqFMF5e6fcGCiv+1x0NHOXC6ULqNghY5MidMVepomjFC29csup82rx8jeus4x4iP
         AlnMWPJveZxBzAUtYmMKBg+6/Zy8SqNYCYqCD2AW793yFHcIhGjC4ULukG3zt76F5D01
         hmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HiUfAFVtYQfdJFI+mGar/loPm26LbyhdUt8nmYytWQQ=;
        b=pVB3GnZHIzt5mqWH+MjkGt1ep96hOjd8fPmou0OTVn6Y9TArpkuM3o1liMhyx+M7kD
         FyNbjWQYedMoyWAGWrd0YcW53rvBjkEz//FL90ojOYjQde709E68uYQq6Vhps99liNnY
         Zd8Opz1f/Ahso3YWBKL9vbfIDp+1WG08isqfoJ+sQoHd07mLSAGmarhrs11xFz+0x4Dh
         /TbopGymzHOCmDg5jweT6Lr5kzZHjfbdEhKLkuKbYJtV/UoefsMuVwG3kmDkrd+diGIN
         h4ShPTZDxln0lbz9e2qPSWc0gmXYSDuS9XCbIt/00i4XjWTnoRF+McxCV5PuPepSNdHz
         7y4w==
X-Gm-Message-State: AOAM530zc7ZiQRp5QstEC1Yb+G3F6f/z6QwmT2PY6UPKXEWgzvyrhznx
        /E/pWeYKoVK4tEptc70kmak=
X-Google-Smtp-Source: ABdhPJyvHIRuemZhXud4eIE3YEqh2cLPgp8Qkm3Pre2khvi9AhP4Lk22USojlqZWMBSIeZDSMx7xxA==
X-Received: by 2002:a17:90b:253:: with SMTP id fz19mr7455121pjb.195.1607151492973;
        Fri, 04 Dec 2020 22:58:12 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([1.129.145.238])
        by smtp.gmail.com with ESMTPSA id a14sm1110848pfl.141.2020.12.04.22.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 22:58:12 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v9 06/12] powerpc: inline huge vmap supported functions
Date:   Sat,  5 Dec 2020 16:57:19 +1000
Message-Id: <20201205065725.1286370-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201205065725.1286370-1-npiggin@gmail.com>
References: <20201205065725.1286370-1-npiggin@gmail.com>
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
index ab426fc0cd4b..de6b558dc187 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1121,22 +1121,6 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
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
@@ -1220,8 +1204,3 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
 
 	return 1;
 }
-
-bool arch_vmap_p4d_supported(pgprot_t prot)
-{
-	return false;
-}
-- 
2.23.0

