Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF782456FA
	for <lists+linux-arch@lfdr.de>; Sun, 16 Aug 2020 11:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgHPJKE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Aug 2020 05:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgHPJJ7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Aug 2020 05:09:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F55C061756;
        Sun, 16 Aug 2020 02:09:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c6so6313385pje.1;
        Sun, 16 Aug 2020 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8C8wdRPXIlS04tUD/986mX054vDuu2PdIQ/xTcAZZAA=;
        b=oQlIsW4jf6QdaM41v1DAzwkm/rUCXyiKKAHM7uRLQyLEF7lxXjR7GmEvQPShvtKNQf
         dETlAFV1UwJxM+uJ3hw4p+i6HjdZ1KaUBRDFnyZ1LZfv7LViQGsume3ZFDlou062UCRW
         JERsTRYkRNxB8GTDfdMkpO6z8LDG5x9/cYyiDL0NPA8A8r/rv4NwzlGCwJiFTznJYcLi
         a9+GxQoBiIh/oEFboZbnFS+PIOXYCRnGyGpdqYXeMHtOssz4U0nXw/L2tDv8F5qCy41R
         eQO0EaYIzsJnXoToRJzFrrJ1hrJkMkk9481LETndvWuLQcDVqKpHKM0dWPQNXgse3SQy
         uL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8C8wdRPXIlS04tUD/986mX054vDuu2PdIQ/xTcAZZAA=;
        b=GSZmEaOCjqIY/7bMVPRm24JqcLW2uDwWhOBwfUYQ5gJV+h2gGgStpG+Ci1sNHreLzs
         WoqmeNCpo4ZoBlafljsSTXcs05K9gRern01ZQ3oFOndtQj2Bx/JE9cou6l2nHOlF+FWC
         o3xNiFRQunGgzwdOHRVjEJ48p6mUJcoa867y4zzmnVsGMiut/jRLVb2eeFYuyCDWz7h/
         TQ66Ljpvm1e8cCDrWmD57g3fzcVfrrJs6/zi5CwwgsWr0ngjCrww3HiQQoC+8l8K4bKS
         pCmKMknGTww3raeRCo5SDqLAtU3urvHeAnLCYPF6Vr/9slNQkP1jy+aNr6objITNpoET
         Vt8Q==
X-Gm-Message-State: AOAM531Xg9KxrrgAfnpbTsbu7HzDOoQiXse4lChALrUXvZPkrBPgeHBb
        CWZNcqjmNCy2i2IA475n/7k=
X-Google-Smtp-Source: ABdhPJzRG648jeLeZZ2Z4oujD6qX3vm8KDLEE34yBusy/W9VPlVLdok2Quap0oZrYbchmPfC1Ozb0A==
X-Received: by 2002:a17:90a:f68b:: with SMTP id cl11mr8361244pjb.68.1597568998489;
        Sun, 16 Aug 2020 02:09:58 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id o19sm12768369pjs.8.2020.08.16.02.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 02:09:58 -0700 (PDT)
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
Subject: [PATCH v4 7/8] mm/vmalloc: add vmap_range_noflush variant
Date:   Sun, 16 Aug 2020 19:09:03 +1000
Message-Id: <20200816090904.83947-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200816090904.83947-1-npiggin@gmail.com>
References: <20200816090904.83947-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As a side-effect, the order of flush_cache_vmap() and
arch_sync_kernel_mappings() calls are switched, but that now matches
the other callers in this file.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 129f10545bb1..4e5cb7c7f780 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -234,8 +234,8 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	return 0;
 }
 
-int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift)
+static int vmap_range_noflush(unsigned long addr, unsigned long end, phys_addr_t phys_addr,
+			pgprot_t prot, unsigned int max_page_shift)
 {
 	pgd_t *pgd;
 	unsigned long start;
@@ -255,14 +255,23 @@ int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgp
 			break;
 	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
 
-	flush_cache_vmap(start, end);
-
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
 	return err;
 }
 
+int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	int err;
+
+	err = vmap_range_noflush(addr, end, phys_addr, prot, max_page_shift);
+	flush_cache_vmap(addr, end);
+
+	return err;
+}
+
 static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			     pgtbl_mod_mask *mask)
 {
-- 
2.23.0

