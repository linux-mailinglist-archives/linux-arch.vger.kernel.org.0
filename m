Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E099624CCE3
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 06:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgHUEop (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 00:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgHUEom (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 00:44:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915ECC061385;
        Thu, 20 Aug 2020 21:44:42 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p37so430092pgl.3;
        Thu, 20 Aug 2020 21:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wqRNPVVkxxZAVOe5cjf4OdJxPseOUgKHXYAzqLL+cs=;
        b=JswMtJ4GRdG0XC7MN25+zcAR+FDhPMWqW0gS8oiXOKwZi451vgTtEaLszHOpU0HB4J
         9H9u538gKqdzyBxKTJmAWqN56+57QcsEN5HPK6SZCW1ti6UBNMjVN/iA4y9FHpljJT+u
         wy1/OngEQwe/K6gcPyALLZYd8Pc6Jx4XOcGr79jiTCpIjIKsPQbCvWqEB+1Lhxj0lP3d
         Nqeoeik+DX2xY7QRyAS+whQzQTubpZrt+U5lvQHBCqNMtNjIG4Wx9uG1i4B0keKVkoLr
         sclYucLHw3o+bXw826g+zsIfsgQDnhblCrJQpV4HiqD2SqSebtf0UwG34fg8oRLgfCw6
         rcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wqRNPVVkxxZAVOe5cjf4OdJxPseOUgKHXYAzqLL+cs=;
        b=AEIyNLVHKEQcdQ2gmamgzO8H8aEPnBLfSotiPcXxT+2Aga/kBcJeCXRYP0ij2e5Ks/
         LTZ9xrr9Iaz3XS34O4bkC1ON9s+n/MHsWontVtDQapRyGHPK6aoW+hsPNUym9wzBhjlC
         90vAX8qR6GyDGMleWgDuG5JtF2jVUqiFhnLN0Q7rHTj66vKkyMFdVdGEEMw356pufOr6
         PDE8xM3KAo1KEGERgpExGZTvnrmx4nCqr5paEzzZEewd4Y7cwkF/w6tRyc0GOMjyG2e/
         /oJzykAoKx4bZfppbJb4aSorCiRLDv74qNlDUptnYhOLmN8BBWtFRnWbPsFYQRdWKwvP
         rRBQ==
X-Gm-Message-State: AOAM5306LP4pnwSK3YG2jhYPfx7/GleRY6bJdRuhJlc99WzvBjVrnro2
        EdmxLuuPJ7PRDubVXhBNHyI=
X-Google-Smtp-Source: ABdhPJyMB3FHce5MTh/dSOT0zrOsoCyzxRf35b8HaRFN1ex/qAd5m4QLLGdfd8b6PLmPj7hs7h1Xvw==
X-Received: by 2002:a62:8f4b:: with SMTP id n72mr1007665pfd.5.1597985082100;
        Thu, 20 Aug 2020 21:44:42 -0700 (PDT)
Received: from bobo.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id l9sm683374pgg.29.2020.08.20.21.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 21:44:41 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v5 1/8] mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
Date:   Fri, 21 Aug 2020 14:44:20 +1000
Message-Id: <20200821044427.736424-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200821044427.736424-1-npiggin@gmail.com>
References: <20200821044427.736424-1-npiggin@gmail.com>
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
index b482d240f9a2..49f225b0f855 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -38,6 +38,7 @@
 #include <linux/overflow.h>
 
 #include <linux/uaccess.h>
+#include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
 
@@ -343,7 +344,9 @@ int is_vmalloc_or_module_addr(const void *x)
 }
 
 /*
- * Walk a vmap address to the struct page it maps.
+ * Walk a vmap address to the struct page it maps. Huge vmap mappings will
+ * return the tail page that corresponds to the base page address, which
+ * matches small vmap mappings.
  */
 struct page *vmalloc_to_page(const void *vmalloc_addr)
 {
@@ -363,25 +366,33 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 
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
@@ -389,6 +400,7 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 	if (pte_present(pte))
 		page = pte_page(pte);
 	pte_unmap(ptep);
+
 	return page;
 }
 EXPORT_SYMBOL(vmalloc_to_page);
-- 
2.23.0

