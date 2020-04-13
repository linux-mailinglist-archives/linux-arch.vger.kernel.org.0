Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9A91A669D
	for <lists+linux-arch@lfdr.de>; Mon, 13 Apr 2020 14:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgDMM7p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Apr 2020 08:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbgDMM7n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 13 Apr 2020 08:59:43 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 08:59:42 EDT
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3242C008769;
        Mon, 13 Apr 2020 05:54:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id np9so3790518pjb.4;
        Mon, 13 Apr 2020 05:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k49Z1eeIe8RAePIWxlY/V+bEMZoWrI+Axi8oPgRhVtE=;
        b=L5S1BJRQ9w88zx9XItTQeKB1SWsCw9jN3PuCuTfVxmuOCKWgUewZNKRsVyQjwxHom4
         ryvIxTIOl9WF3LHatElNK8cNsWnR1tE7/N5ODwBzb5+SkQvox0yCH821WVCcfqm495pa
         LK65a2FSueaENFn4ZvlWg3x+AHB5L2wFPRT41i9dbpsLWS2dWFfpccRmZEmhKUWPEymx
         WyI5x9Acu8dyiVuDncUPJrEQb0Sf9Z9Fwppf9ivQJDnmtOAgeNFzkaQYfo3pypCDwIVI
         ITWDYFpdOCKbVXLiHa2pbhcRH0bGRxSg+GfkJc2W005zzgPh63LtWhzwzkFkwciB+nEy
         N5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k49Z1eeIe8RAePIWxlY/V+bEMZoWrI+Axi8oPgRhVtE=;
        b=a41o3EmaxirITjePC+1ZbdQa9IiqRl8yWAmNgcU2V3dQewJDCd2XTTpCfX7jNSv/On
         FhpGY4VuAQ2RSFO1/5m/mKN+TfSfALv2tP9xl1iDU0vOtOPN+YFT/F3eaX7/OAIzTIDd
         1kqdlCLHAtSnvmCKv/7Rl2Gz3hMjXo3bGg53qQTWgvnmbDba28mjcRO8h0ssWD/TM9AU
         TO7s1H6a6TZL60ZZDoXcRnaHN/xz4er0twir6jCKN54yVXwtfWjEH/9cfsApoUApDbEt
         IISkW8r97U9dOE7RoMc3DnqKcydai68hYnEWd5e5oYSMany8/dU1ZAqhlwLsqIiAgxR2
         jO1g==
X-Gm-Message-State: AGi0PuaZ/7bLqa85XLkCEgNiTMxrWnOYtaT3ueyAt3nY9ShmaINxrzCQ
        ucmjgRUnxL+wvUVCRzj+u8U=
X-Google-Smtp-Source: APiQypKN1B5uL3kKzB/lOZ19Pz9DdktaX2dQyGsTq0k0RExJ7gXb2rmJrqHeHeQ2h0CyWmOAFzHcaA==
X-Received: by 2002:a17:90a:368d:: with SMTP id t13mr20937061pjb.175.1586782463462;
        Mon, 13 Apr 2020 05:54:23 -0700 (PDT)
Received: from bobo.ibm.com (60-241-117-97.tpgi.com.au. [60.241.117.97])
        by smtp.gmail.com with ESMTPSA id j24sm9235610pji.20.2020.04.13.05.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 05:54:22 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 1/4] mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
Date:   Mon, 13 Apr 2020 22:53:00 +1000
Message-Id: <20200413125303.423864-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200413125303.423864-1-npiggin@gmail.com>
References: <20200413125303.423864-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

vmalloc_to_page returns NULL for addresses mapped by larger pages[*].
Whether or not a vmap is huge depends on the architecture details,
alignments, boot options, etc., which the caller can not be expected
to know. Therefore HUGE_VMAP is a regression for vmalloc_to_page.

This change teaches vmalloc_to_page about larger pages, and returns
the struct page that corresponds to the offset within the large page.
This makes the API agnostic to mapping implementation details.

[*] As explained by commit 029c54b095995 ("mm/vmalloc.c: huge-vmap:
    fail gracefully on unexpected huge vmap mappings")

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 399f219544f7..1afec7def23f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -36,6 +36,7 @@
 #include <linux/rbtree_augmented.h>
 
 #include <linux/uaccess.h>
+#include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 
@@ -272,7 +273,9 @@ int is_vmalloc_or_module_addr(const void *x)
 }
 
 /*
- * Walk a vmap address to the struct page it maps.
+ * Walk a vmap address to the struct page it maps. Huge vmap mappings will
+ * return the tail page that corresponds to the base page address, which
+ * matches small vmap mappings.
  */
 struct page *vmalloc_to_page(const void *vmalloc_addr)
 {
@@ -292,25 +295,33 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 
 	if (pgd_none(*pgd))
 		return NULL;
+	if (WARN_ON_ONCE(pgd_leaf(*pgd)))
+		return NULL; /* XXX: no allowance for huge pgd */
+	if (WARN_ON_ONCE(pgd_bad(*pgd)))
+		return NULL;
+
 	p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d))
 		return NULL;
-	pud = pud_offset(p4d, addr);
+	if (p4d_leaf(*p4d))
+		return p4d_page(*p4d) + ((addr & ~P4D_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(p4d_bad(*p4d)))
+		return NULL;
 
-	/*
-	 * Don't dereference bad PUD or PMD (below) entries. This will also
-	 * identify huge mappings, which we may encounter on architectures
-	 * that define CONFIG_HAVE_ARCH_HUGE_VMAP=y. Such regions will be
-	 * identified as vmalloc addresses by is_vmalloc_addr(), but are
-	 * not [unambiguously] associated with a struct page, so there is
-	 * no correct value to return for them.
-	 */
-	WARN_ON_ONCE(pud_bad(*pud));
-	if (pud_none(*pud) || pud_bad(*pud))
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return NULL;
+	if (pud_leaf(*pud))
+		return pud_page(*pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(pud_bad(*pud)))
 		return NULL;
+
 	pmd = pmd_offset(pud, addr);
-	WARN_ON_ONCE(pmd_bad(*pmd));
-	if (pmd_none(*pmd) || pmd_bad(*pmd))
+	if (pmd_none(*pmd))
+		return NULL;
+	if (pmd_leaf(*pmd))
+		return pmd_page(*pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
+	if (WARN_ON_ONCE(pmd_bad(*pmd)))
 		return NULL;
 
 	ptep = pte_offset_map(pmd, addr);
@@ -318,6 +329,7 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 	if (pte_present(pte))
 		page = pte_page(pte);
 	pte_unmap(ptep);
+
 	return page;
 }
 EXPORT_SYMBOL(vmalloc_to_page);
-- 
2.23.0

