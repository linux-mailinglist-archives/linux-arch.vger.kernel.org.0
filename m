Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E203B2456F2
	for <lists+linux-arch@lfdr.de>; Sun, 16 Aug 2020 11:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgHPJJi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Aug 2020 05:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgHPJJe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Aug 2020 05:09:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D759C061786;
        Sun, 16 Aug 2020 02:09:34 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q19so6046726pll.0;
        Sun, 16 Aug 2020 02:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xoa50mjKdO+6rEo7JFgsM1iktECeAufQruBypQNx5uU=;
        b=a9eH2Qud8eaxaDEyJ6Ox3nV2dEQGPtlOBvhHiUtqVX8FJWPdpCeQ/7Z+MH3ABFUlzY
         hGmX62DEx+PK4neClmvN49t6HjShSviRro/UAGDtJPSR6V3MbsPNXrDz8S4WZTYDrlfr
         bCc4QjNnpMrwwl0bn98+LNDPdIcDqScjmU09UuXnxnCUFPo1/sZPQWzrH75XUEL2HCmT
         7zVlApSM3TvG4rV6nJQRTMHPF7VgTZL/WOdO4pwkBBtsA41oUEymfx9+I+gV7FC0GiBD
         FRtkqpWRR3h3zLZqRnoL0QTqf6iqBTeliFHIGWSiG4+f+zGXSw2HK5l/O3HF53m4tE+M
         HQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xoa50mjKdO+6rEo7JFgsM1iktECeAufQruBypQNx5uU=;
        b=sBFfFm5JWow9pXIn3Vjb9WnpDBEul5ty9Rve9tnw3Ltw3KpRZ6iSNxEkCuuopv49Y1
         EUhZ3lUynMee5gSTxTPpRCk3yXw4YTi8zrDB90aGxCYnKPTlfvbpz8mnWDhY+NS4Qybq
         khe/n0mlZ5YwHLlMcfbGGMuP0nKWhP1wOO9mdgZ2YU2ElEcmzTymvm1mn2cUZImyGo/1
         ICt2ciLLecZeIFA2TvYSH7J54GUjcGKOog2MZJVFBPwQhxlHW+ZrmR8vAlB4CDWyZVRf
         2XjQjXhitjEW7uwNZsvYLpBiIW5gWSslLZn8RX3WVOgST8fkZaS7wRKP7qLf3gqL6Cnm
         4AyA==
X-Gm-Message-State: AOAM531xN5CiuKaZA/A6Njb9/DQHB2G5F6w4XYoOzZKV7ZhNToLYC7V3
        7kingxa2DW55cSOtuNDp108=
X-Google-Smtp-Source: ABdhPJxjxbOaxbaEbI6j9pxumC5wRGiGlNLcDB22u2QtqVpRvdt2rZbK1BklnxLXaykWubkHnlaE0Q==
X-Received: by 2002:a17:902:cb0f:: with SMTP id c15mr7427207ply.85.1597568974143;
        Sun, 16 Aug 2020 02:09:34 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id o19sm12768369pjs.8.2020.08.16.02.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 02:09:33 -0700 (PDT)
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
Subject: [PATCH v4 3/8] mm/vmalloc: rename vmap_*_range vmap_pages_*_range
Date:   Sun, 16 Aug 2020 19:08:59 +1000
Message-Id: <20200816090904.83947-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200816090904.83947-1-npiggin@gmail.com>
References: <20200816090904.83947-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The vmalloc mapper operates on a struct page * array rather than a
linear physical address, re-name it to make this distinction clear.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 49f225b0f855..3a1e45fd1626 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -190,9 +190,8 @@ void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
 		arch_sync_kernel_mappings(start, end);
 }
 
-static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)
 {
 	pte_t *pte;
 
@@ -218,9 +217,8 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int vmap_pmd_range(pud_t *pud, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -230,15 +228,14 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (vmap_pte_range(pmd, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -248,15 +245,14 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (vmap_pmd_range(pud, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
-static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -266,7 +262,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		if (vmap_pud_range(p4d, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
@@ -307,7 +303,7 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 		next = pgd_addr_end(addr, end);
 		if (pgd_bad(*pgd))
 			mask |= PGTBL_PGD_MODIFIED;
-		err = vmap_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
+		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
 		if (err)
 			return err;
 	} while (pgd++, addr = next, addr != end);
-- 
2.23.0

