Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C872400D4
	for <lists+linux-arch@lfdr.de>; Mon, 10 Aug 2020 04:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgHJC1w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Aug 2020 22:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgHJC1w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Aug 2020 22:27:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0434FC061756;
        Sun,  9 Aug 2020 19:27:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so4083197pgf.0;
        Sun, 09 Aug 2020 19:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wqRNPVVkxxZAVOe5cjf4OdJxPseOUgKHXYAzqLL+cs=;
        b=uzlZkjSm9ZGrRLlsU85yYntg5uUa6TXp4vH+ikn0xWiGnZ80ZZ37DbPaomShZJfPnE
         0oiZoFL0/mDnn+SocvSfP1WMGgn8TgdaPkindydu0o+r6R7Fc+gxEdQxx7JzfznITR1q
         mPWsHHhc4c1dQIfvFKE2oND4B0OzSWyERbhsTrQLzubUjimvhYHoaTsE2Hcrl5Fioz3X
         cjcoEbIvIfuf2WYH6Ug7ZJ+aiS1YTw6ChcwZVpAwjhDuGBDKbaXSxG1MiQCJaeuwTVKI
         R+BAlqiU5oVlpJVYU/bdKo/Pb9s+j72tB6r8z/RoTb4CRa3k/zRgZZC76K5epCbmm40n
         hKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wqRNPVVkxxZAVOe5cjf4OdJxPseOUgKHXYAzqLL+cs=;
        b=YUUr0PGvA9yKhDiwSOOuBY6BumtJ2y6dvWFYYGYMKhHZT3A5Z/vgEoRDv5EZbN/DBs
         oJZgIlBW6No5bpoMT+Odww5n7+gCJ/lKWr71cub6GGFK9c+QzbXLaVueyncL/E7gct2p
         7D2IkVtX3GY84kZV2kuuZ3RLj19nF+XlsxUmmmOcDNFEt5AxKAg4DuN1RK3j3ttWv+3H
         9Gh9rJ3Z9UtbmwwgEl/emFHldmkyAQVQzMO+pmT7I1vI14/SNjYq2frumVd9oWBuS2Bh
         xIAY//XuyeLOBrI9JKxnB1luLSneqxwZkoyRndZbUvUD2ZXBnu9lu8tNIY2CJJvX6L9r
         dAOg==
X-Gm-Message-State: AOAM5305rydH3hmTUdwV9oqTvvYG8Y8RePXUWMtdtxg9AhYHqNdmDlrQ
        8LFZ871ZCDf4SHO7VHwZuCU=
X-Google-Smtp-Source: ABdhPJxJ5wOs61jPiAtdiL9OZRHbgCxw1msWorFzPuXMtNPWII0pHR8QnAVNPZXVV89m8/gFh40qtQ==
X-Received: by 2002:aa7:8b18:: with SMTP id f24mr23487412pfd.301.1597026471393;
        Sun, 09 Aug 2020 19:27:51 -0700 (PDT)
Received: from bobo.ibm.com (193-116-100-32.tpgi.com.au. [193.116.100.32])
        by smtp.gmail.com with ESMTPSA id l17sm21863475pff.126.2020.08.09.19.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 19:27:50 -0700 (PDT)
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
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH v3 1/8] mm/vmalloc: fix vmalloc_to_page for huge vmap mappings
Date:   Mon, 10 Aug 2020 12:27:25 +1000
Message-Id: <20200810022732.1150009-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200810022732.1150009-1-npiggin@gmail.com>
References: <20200810022732.1150009-1-npiggin@gmail.com>
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

