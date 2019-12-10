Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F245117F1F
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 05:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfLJErk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Dec 2019 23:47:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34119 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfLJErj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Dec 2019 23:47:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id n13so8414105pff.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Dec 2019 20:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txq3LAFK3wOGlutPVrH/f5MoWKzx5UG/2rHrSgg8Ef0=;
        b=Twub/7dfkfSLtOLxrE276ihuEuvporLf72DEUs3hin3WvhA/s1IXbcI8fgn6bYfEap
         gu6iY9yK9ZBPgRRsp2Dndk9mrhs3BC8P/iXi7D2zWdBwrEIU3AYdLX3FjoTgwxeJb6n1
         dheXIk9ucGRFhy5Zr5/DR0A350BnDT96IS57E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txq3LAFK3wOGlutPVrH/f5MoWKzx5UG/2rHrSgg8Ef0=;
        b=fAw5T69L5BnTPUOp0iXlo2U4ydGYSJqkkWHbugM8u/TrWgf7SyxxNo/qNBSvsia5Ch
         vB27tXFP1kyRq1NVm1i2E96cblw23n/1fApxLYAvXlA/of8qomC8fBlxs6mHuhBlI3sV
         xnk9a4EnMKB8bXpvn4nNYDdvKAZG+K3hPCKtyApLhz7qV4XFvLVL1/OTjjgZ13ivTrQI
         fYV/5A+cm1cORKsE22PnrqmznontmFonYY9+UmXFW84QBcv2tAalBAetkDa7sAFziOc5
         jxS9GCf1nqrVtvf5BcxV6zl1zdmMGecyCb7foDiiYhtfOjoxUsI5xMxvAPkUKCelDEgA
         EiYQ==
X-Gm-Message-State: APjAAAWU2JDuEtqD82M3HidZhQyz68FJt5cMrRd2hPt7lRpZjAwUjLz0
        m+LVrdBBM9O+Q9nAap4Cj9X3ZQ==
X-Google-Smtp-Source: APXvYqwo4BmaQbSIu9CGUWSB47DJ4jc+UUxqneRNCNhT2QgM4Y9U0WXwRELaH6aJYlTs5Hvw2Ghozg==
X-Received: by 2002:aa7:8f16:: with SMTP id x22mr33786940pfr.120.1575953258528;
        Mon, 09 Dec 2019 20:47:38 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-e460-0b66-7007-c654.static.ipv6.internode.on.net. [2001:44b8:1113:6700:e460:b66:7007:c654])
        by smtp.gmail.com with ESMTPSA id c184sm1185254pfa.39.2019.12.09.20.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 20:47:37 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 2/4] kasan: use MAX_PTRS_PER_* for early shadow
Date:   Tue, 10 Dec 2019 15:47:12 +1100
Message-Id: <20191210044714.27265-3-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210044714.27265-1-dja@axtens.net>
References: <20191210044714.27265-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This helps with powerpc support, and should have no effect on
anything else.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 include/linux/kasan.h | 6 +++---
 mm/kasan/init.c       | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index e18fe54969e9..d2f2a4ffcb12 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -15,9 +15,9 @@ struct task_struct;
 #include <asm/pgtable.h>
 
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
-extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
-extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
-extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
+extern pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE];
+extern pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD];
+extern pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD];
 extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 
 int kasan_populate_early_shadow(const void *shadow_start,
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ce45c491ebcd..8b54a96d3b3e 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -46,7 +46,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 3
-pud_t kasan_early_shadow_pud[PTRS_PER_PUD] __page_aligned_bss;
+pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD] __page_aligned_bss;
 static inline bool kasan_pud_table(p4d_t p4d)
 {
 	return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
@@ -58,7 +58,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD] __page_aligned_bss;
+pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD] __page_aligned_bss;
 static inline bool kasan_pmd_table(pud_t pud)
 {
 	return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
@@ -69,7 +69,7 @@ static inline bool kasan_pmd_table(pud_t pud)
 	return false;
 }
 #endif
-pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
+pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE] __page_aligned_bss;
 
 static inline bool kasan_pte_table(pmd_t pmd)
 {
-- 
2.20.1

