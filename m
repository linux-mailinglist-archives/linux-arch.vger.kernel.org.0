Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9462C725E
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgK1VuS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387434AbgK1THh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 14:07:37 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E84C02A1B5;
        Sat, 28 Nov 2020 07:26:14 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f17so6676957pge.6;
        Sat, 28 Nov 2020 07:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ls4Z+QtszsWeZpzsu5kDe+zUxHoBLiN8enIaEYCRRt8=;
        b=drVEkTTrCOtir36Ci8iG5QpMvuGFOjCL2QXhy+CWnhEn7njj+5Zw0QPewWh4IfL6/+
         lbxroZWD8THwfjPCk6ra/o2YV6dutR258cMBSGPq7aduL0ckag1wVHxasDRLfbOFDdNf
         plsEBOLWNc5/uiB1X3sUug80bnx3paf7jnuLUsYR18D75Yf5QdUXKqxdaFddCf930MSJ
         jDxLcr8uWE5ySnluNkW4W6GijJZ/MxGEY6sieCH4LChrPD1uZrHEWTf6nCwn/50xWzUK
         YKbCGnoyV1lQzxjolDyo9rE5oIN6qCGUtKNSzByxKHKai3HjChXwzIRiGg/akuS+yx4J
         zQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ls4Z+QtszsWeZpzsu5kDe+zUxHoBLiN8enIaEYCRRt8=;
        b=hGoR7LYU2HKgOA+2OpaBuIrLBi0xuylsxsafMmp3SGigUh8TwxG33dlYGGHGFy0jtn
         LnTWe7nyzLIvZ1Hvb1ZXbCOokc0FqjT84rh6w8MkFEkENeMI9AlL1pfjZvzXizePSsSd
         oeLnGCWEALNdr3PrswEP38RWDzKBo+F6FYH5BLHQdnn2IjCpl00+sO9nWiRqjilyyC6J
         RnLINoZv6rzgjL4lVPFjKXTwd9n42q6Sigf0i732CSjy7BcDDserqcB0HHg6YPW3R8u8
         rXXnLWAw4O+JjJuwzsg7micS34TKewjjpjM6xQxBvETl+LIwoXhuHyNTHaYsYPyaYjk9
         51zA==
X-Gm-Message-State: AOAM532xrePqGQ9u+0AMsJsxkK0NOj+rU5nVPyK1yhHaUJLLfX5JgbPu
        Ux0xfRbwIWOaoXpna51LX2k=
X-Google-Smtp-Source: ABdhPJxzVq4dv/2aOv1eLf2qxZsQ5B6wDWqYIt2VFRKLkx2wofPlt9eaOXQEQGLRT5Rf3+zVpMbPBw==
X-Received: by 2002:a62:f809:0:b029:18e:f528:76e6 with SMTP id d9-20020a62f8090000b029018ef52876e6mr11676378pfh.28.1606577174029;
        Sat, 28 Nov 2020 07:26:14 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d22sm15500173pjw.11.2020.11.28.07.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 07:26:13 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v8 01/12] mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
Date:   Sun, 29 Nov 2020 01:25:48 +1000
Message-Id: <20201128152559.999540-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128152559.999540-1-npiggin@gmail.com>
References: <20201128152559.999540-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 mm/vmalloc.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6ae491a8b210..f85124e88bdb 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -34,7 +34,7 @@
 #include <linux/bitops.h>
 #include <linux/rbtree_augmented.h>
 #include <linux/overflow.h>
-
+#include <linux/pgtable.h>
 #include <linux/uaccess.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
@@ -343,7 +343,9 @@ int is_vmalloc_or_module_addr(const void *x)
 }
 
 /*
- * Walk a vmap address to the struct page it maps.
+ * Walk a vmap address to the struct page it maps. Huge vmap mappings will
+ * return the tail page that corresponds to the base page address, which
+ * matches small vmap mappings.
  */
 struct page *vmalloc_to_page(const void *vmalloc_addr)
 {
@@ -363,25 +365,33 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 
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
@@ -389,6 +399,7 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
 	if (pte_present(pte))
 		page = pte_page(pte);
 	pte_unmap(ptep);
+
 	return page;
 }
 EXPORT_SYMBOL(vmalloc_to_page);
-- 
2.23.0

