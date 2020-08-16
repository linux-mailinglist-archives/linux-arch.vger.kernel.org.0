Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232652456F4
	for <lists+linux-arch@lfdr.de>; Sun, 16 Aug 2020 11:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgHPJJr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Aug 2020 05:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgHPJJk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Aug 2020 05:09:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94481C061756;
        Sun, 16 Aug 2020 02:09:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m71so6682175pfd.1;
        Sun, 16 Aug 2020 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgciMtrhUFyjwGUVG4/y+NlOfAX4ULiG8JBMTv5iRYk=;
        b=Sx4pg6cbpRc7TLtLsYf6QS9/V3eSzJw243m7oVuutLFfRoykNyppQoVF+KP8ckVRZI
         wfQE8vKHCtcxI6nu1EvkQH9aabReq7AOvteeKC4uYRn0ImOcz1tXyHIQGdJqzz3fqqFd
         8WS2qRtCkI35FPj0Q8b6xqwc+dEQGCLoAb1zJGeAQS/YvJ8twi2P2VGEUDW2FAxa+TFV
         fUCtPV+VGosZf9ILnCMdzVlKauYa05gMYcc/5RJ62/Bd9xnriIdTcFEanDwSZKAj7//V
         C2G4WPqjN+6gu3/NQvy0GD7A0xIQhAPEEF43yQ7Xw9+LwYYDETkpaG84bxIMCb0WJbUE
         LBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgciMtrhUFyjwGUVG4/y+NlOfAX4ULiG8JBMTv5iRYk=;
        b=dUroTLATcimHRKLqWovYw3SaYiOxWHXSnTOlh8Y0Qan1Us5MajqXJ+Tjc3SyQ0U61f
         jtEOf97Httjpi4BKlVBCSa1gJ9vBRAI3j6HF93PTMbrBcrwh4731lm4E7wAoSMqoHNy+
         ECia26DnITXD11K3I92JfARlIZ0LyQtl42oxZL2nkWWIyyCaDv+AofuIvJSbZkLRlQ1y
         vhYcWPzmRBpfhdW/72rt0iqpMyF447/g58XDYMRMRq7iXiIIAv4jEKBBZ3C7QLjshPa9
         cVMDuabkFIOUggRD4ct7xYkxNDQQwRU2S1odWEG/w4RLf7TOR1icsMngC8nRM2/2TzpW
         NTig==
X-Gm-Message-State: AOAM533cF7jz3B0XNTlgorhp3r7Sk5gyffrDOkviMA3gnBFYDO9QUWXd
        5wO1wjbfHE3OJvQCztcwPOk=
X-Google-Smtp-Source: ABdhPJzKawRgG36izl7nSxDOZkM0Of2POzBfKZla6VMvJ5K5Q5uX/ljQ/tfcoEX+aTZsibK3iGuCtQ==
X-Received: by 2002:a63:8f1c:: with SMTP id n28mr3822208pgd.330.1597568980154;
        Sun, 16 Aug 2020 02:09:40 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id o19sm12768369pjs.8.2020.08.16.02.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 02:09:39 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v4 4/8] lib/ioremap: rename ioremap_*_range to vmap_*_range
Date:   Sun, 16 Aug 2020 19:09:00 +1000
Message-Id: <20200816090904.83947-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200816090904.83947-1-npiggin@gmail.com>
References: <20200816090904.83947-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This will be moved to mm/ and used as a generic kernel virtual mapping
function, so re-name it in preparation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/ioremap.c | 55 ++++++++++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/mm/ioremap.c b/mm/ioremap.c
index 5fa1ab41d152..6016ae3227ad 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -61,9 +61,8 @@ static inline int ioremap_pud_enabled(void) { return 0; }
 static inline int ioremap_pmd_enabled(void) { return 0; }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
 
-static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
-		pgtbl_mod_mask *mask)
+static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)
 {
 	pte_t *pte;
 	u64 pfn;
@@ -81,9 +80,8 @@ static int ioremap_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int ioremap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
-				unsigned long end, phys_addr_t phys_addr,
-				pgprot_t prot)
+static int vmap_try_huge_pmd(pmd_t *pmd, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot)
 {
 	if (!ioremap_pmd_enabled())
 		return 0;
@@ -103,9 +101,8 @@ static int ioremap_try_huge_pmd(pmd_t *pmd, unsigned long addr,
 	return pmd_set_huge(pmd, phys_addr, prot);
 }
 
-static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
-		pgtbl_mod_mask *mask)
+static int vmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -116,20 +113,19 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 	do {
 		next = pmd_addr_end(addr, end);
 
-		if (ioremap_try_huge_pmd(pmd, addr, next, phys_addr, prot)) {
+		if (vmap_try_huge_pmd(pmd, addr, next, phys_addr, prot)) {
 			*mask |= PGTBL_PMD_MODIFIED;
 			continue;
 		}
 
-		if (ioremap_pte_range(pmd, addr, next, phys_addr, prot, mask))
+		if (vmap_pte_range(pmd, addr, next, phys_addr, prot, mask))
 			return -ENOMEM;
 	} while (pmd++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
 }
 
-static int ioremap_try_huge_pud(pud_t *pud, unsigned long addr,
-				unsigned long end, phys_addr_t phys_addr,
-				pgprot_t prot)
+static int vmap_try_huge_pud(pud_t *pud, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot)
 {
 	if (!ioremap_pud_enabled())
 		return 0;
@@ -149,9 +145,8 @@ static int ioremap_try_huge_pud(pud_t *pud, unsigned long addr,
 	return pud_set_huge(pud, phys_addr, prot);
 }
 
-static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
-		pgtbl_mod_mask *mask)
+static int vmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -162,20 +157,19 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 	do {
 		next = pud_addr_end(addr, end);
 
-		if (ioremap_try_huge_pud(pud, addr, next, phys_addr, prot)) {
+		if (vmap_try_huge_pud(pud, addr, next, phys_addr, prot)) {
 			*mask |= PGTBL_PUD_MODIFIED;
 			continue;
 		}
 
-		if (ioremap_pmd_range(pud, addr, next, phys_addr, prot, mask))
+		if (vmap_pmd_range(pud, addr, next, phys_addr, prot, mask))
 			return -ENOMEM;
 	} while (pud++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
 }
 
-static int ioremap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
-				unsigned long end, phys_addr_t phys_addr,
-				pgprot_t prot)
+static int vmap_try_huge_p4d(p4d_t *p4d, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot)
 {
 	if (!ioremap_p4d_enabled())
 		return 0;
@@ -195,9 +189,8 @@ static int ioremap_try_huge_p4d(p4d_t *p4d, unsigned long addr,
 	return p4d_set_huge(p4d, phys_addr, prot);
 }
 
-static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
-		unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
-		pgtbl_mod_mask *mask)
+static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot, pgtbl_mod_mask *mask)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -208,19 +201,18 @@ static inline int ioremap_p4d_range(pgd_t *pgd, unsigned long addr,
 	do {
 		next = p4d_addr_end(addr, end);
 
-		if (ioremap_try_huge_p4d(p4d, addr, next, phys_addr, prot)) {
+		if (vmap_try_huge_p4d(p4d, addr, next, phys_addr, prot)) {
 			*mask |= PGTBL_P4D_MODIFIED;
 			continue;
 		}
 
-		if (ioremap_pud_range(p4d, addr, next, phys_addr, prot, mask))
+		if (vmap_pud_range(p4d, addr, next, phys_addr, prot, mask))
 			return -ENOMEM;
 	} while (p4d++, phys_addr += (next - addr), addr = next, addr != end);
 	return 0;
 }
 
-int ioremap_page_range(unsigned long addr,
-		       unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
+int ioremap_page_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
 {
 	pgd_t *pgd;
 	unsigned long start;
@@ -235,8 +227,7 @@ int ioremap_page_range(unsigned long addr,
 	pgd = pgd_offset_k(addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = ioremap_p4d_range(pgd, addr, next, phys_addr, prot,
-					&mask);
+		err = vmap_p4d_range(pgd, addr, next, phys_addr, prot, &mask);
 		if (err)
 			break;
 	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
@@ -272,7 +263,7 @@ void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
 		return NULL;
 	vaddr = (unsigned long)area->addr;
 
-	if (ioremap_page_range(vaddr, vaddr + size, addr, __pgprot(prot))) {
+	if (vmap_page_range(vaddr, vaddr + size, addr, __pgprot(prot))) {
 		free_vm_area(area);
 		return NULL;
 	}
-- 
2.23.0

