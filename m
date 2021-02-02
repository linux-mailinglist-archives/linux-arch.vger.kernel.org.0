Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2795F30BCA1
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 12:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBBLHe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 06:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhBBLHQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 06:07:16 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1547C0613ED;
        Tue,  2 Feb 2021 03:06:35 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d13so12282517plg.0;
        Tue, 02 Feb 2021 03:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hrndBY8R68kIi1pHIRutw3ucH/2Px5UWTBnGPJp9HrY=;
        b=Q54VSUyxFjq2LjEeAJPNCU+WR/2kVaNjZk0Za03INShYBYMhttc3N1NUHL8847fVRe
         VSV5Rei6EI7nFdF3pwZ2uOgu9iQwSWdeE0Dw7rB+pYopphuQUNVaSqCCTMbZhsQU4u2K
         0NgsEQRVnBDvlh8VkwnQPzb4LWG7wrbTmw39IukkODmXHpxSu6gMxhNJBvOAdnC24OqL
         rzjtQckiW5DLg38VK2eDDwKAxn8b69a/UBiF3QjrhShfJZ9eXz9qJCD8f/bEyqyHF+1t
         gKKEfDyAghVhHxbs8rpruo8U7ouDGssyNUMrKY0CYNQvacFpXZog2qGClmKyim4Hief8
         pIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hrndBY8R68kIi1pHIRutw3ucH/2Px5UWTBnGPJp9HrY=;
        b=sPXUjPnl3mVEyhzqPHjK1nVKfWzNL4grYaVR6ggjfPzJRCwWae1cHsompyKTZgeISF
         l9qKSgYqlNbllZAXhJBX5eyrpGjmxoCqPUXuAL3uwUycJAbLDJ/O3AV8fj7oppgB3ZcM
         a6nVH3nK4gtUGqAQPLRVkCHzDhLR4NdXho70iM+M2CCdbt545rC0js/GCeue/D2t8db9
         0iJ0pbQhWDNSZS6+N9GYLY17c/HSx2ixq6nU3HFc7Byt9m+kH9JoHs8TwW9JcUxvvLcc
         JJl9AzFJifd4plH62NLxv0tMqmQybg7195X4nEiBUCImO4NemGlEQ/PM2YbC0OulZ3xD
         m6gg==
X-Gm-Message-State: AOAM533C10M6jB/MC/RVn0Enrum5+VoLCw2USpMenRIYAkOuhX6bYRK1
        Ou8PuUxP/BpvEFNA9nU+gHc=
X-Google-Smtp-Source: ABdhPJxRTy9eWr3BNvH4OMX3zh1FH14Nb6sVUmv6Fk/NPAKR8HOPVuT+15Bqzg23KyJaTsRYWg71Vw==
X-Received: by 2002:a17:902:e783:b029:e1:24a9:a5c6 with SMTP id cp3-20020a170902e783b02900e124a9a5c6mr18981686plb.43.1612263995617;
        Tue, 02 Feb 2021 03:06:35 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 03:06:35 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v12 12/14] mm/vmalloc: add vmap_range_noflush variant
Date:   Tue,  2 Feb 2021 21:05:13 +1000
Message-Id: <20210202110515.3575274-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210202110515.3575274-1-npiggin@gmail.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As a side-effect, the order of flush_cache_vmap() and
arch_sync_kernel_mappings() calls are switched, but that now matches
the other callers in this file.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f043386bb51d..47ab4338cfff 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -240,7 +240,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	return 0;
 }
 
-int vmap_range(unsigned long addr, unsigned long end,
+static int vmap_range_noflush(unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift)
 {
@@ -263,14 +263,24 @@ int vmap_range(unsigned long addr, unsigned long end,
 			break;
 	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
 
-	flush_cache_vmap(start, end);
-
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
 	return err;
 }
 
+int vmap_range(unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
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

