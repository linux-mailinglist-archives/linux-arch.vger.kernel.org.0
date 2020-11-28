Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF6D2C7259
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbgK1VuT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387453AbgK1TJe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 14:09:34 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF55C02A1BE;
        Sat, 28 Nov 2020 07:27:01 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id f5so4076696plj.13;
        Sat, 28 Nov 2020 07:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxeoavWkBKpHEVfZRK3a60KePQvEOREDyC26QCPQwGc=;
        b=Mp0zn+oBNq23JKWM/VThMMhPZwOv3ULXqyHMSbU+8eq462RFm0HjxEft5FwwThVa2g
         Gdri/pSNwbSjd4GaBz7LMT7YU4sY+pCpvoKDDARY6wTEO1mOWMrZFvNV76XW71W3IYC8
         Sy97jC4i3tcEucGD5CeJs3bSrFigN60xly++kizAtnlCqvYm0U8ZYqb63x5SyfoRlNht
         /01j3f7AfaN6eKgeFj4VDZoJjwecKRpm+EOre9dlnVWQ58a54p8t0zy7dbaS44WgmHkp
         vdbvtn1f0WRrOS2xbTQK2bp2rXfc+KTBnwUK7oaNJ+cHrevFjLn3+MrrSl3LOcd2DFGX
         VUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxeoavWkBKpHEVfZRK3a60KePQvEOREDyC26QCPQwGc=;
        b=CIwfKpEfFZ4jOv8CY+V6vuCsfUEO+Vt5QPb4txUkssPEMnxybYxoNLeEA6Q+3AphdO
         oCaxSTRGjlHpqVvmF2ss6N5vFUnPnEN8T35TPuMek20QJFxtXy+l5nb1I7ual8fu20b/
         /832b8A10sWcfQNsbPrMz8O83Bk1pJE37br9L8TYHIAVk80nZb2rq+NLcWvo17MKbyK0
         Y2/DR7t8emxhgj+55hvPgmsYopGXFNdnrfkaaDbLg+UTCdS/vEhqJMP8cSwqbcQgt0dj
         fEsyUInJJHe/pii7xrGdKqEzFZTYcgoqkoM9ArWAqDtZ1CAm1hDX+sJle/yZ3MpJFzMN
         uh0Q==
X-Gm-Message-State: AOAM531P72RYvzKXlmySduPCLX6DHDFuThmtHF7eU2mdI3FOYk7PePiM
        K2malz9quSWm0SvogkraJdw=
X-Google-Smtp-Source: ABdhPJzuZ3Dhw6J8hTZ/FG/h2c0xFsw7tIsXj/w3J/q6NkcPqqpvR5GqBDTkYAO1QuSMgiGsudTbdg==
X-Received: by 2002:a17:902:bb8b:b029:da:beb:b81e with SMTP id m11-20020a170902bb8bb02900da0bebb81emr11684808pls.44.1606577220717;
        Sat, 28 Nov 2020 07:27:00 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d22sm15500173pjw.11.2020.11.28.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 07:27:00 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v8 10/12] mm/vmalloc: add vmap_range_noflush variant
Date:   Sun, 29 Nov 2020 01:25:57 +1000
Message-Id: <20201128152559.999540-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128152559.999540-1-npiggin@gmail.com>
References: <20201128152559.999540-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As a side-effect, the order of flush_cache_vmap() and
arch_sync_kernel_mappings() calls are switched, but that now matches
the other callers in this file.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 2f236aeeac24..ee9c3bee67f5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -235,7 +235,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	return 0;
 }
 
-int vmap_range(unsigned long addr, unsigned long end,
+static int vmap_range_noflush(unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift)
 {
@@ -257,14 +257,24 @@ int vmap_range(unsigned long addr, unsigned long end,
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

