Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D7E73F160
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjF0DPj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjF0DPZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:15:25 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDFF1BEE;
        Mon, 26 Jun 2023 20:15:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5700401acbeso42701907b3.0;
        Mon, 26 Jun 2023 20:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835718; x=1690427718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MMx6i8bJUxARp5QNqsq1CJUY3hOxlwkAEMcUNtK7dI=;
        b=MeM3v1KjtFoJ68g67QFEF1NyVxMiMYgvdlNUvONCKTcddCTBLfXbCvjdDQ2rkMkntp
         NglXMwE26fCvz5F9nMSZMUxoetH1ZAcsVpi0efOXfEwN4DA6ftYlLFo1JApHI/tubC37
         33sHqn+NMB2tr9HBuBdSW/hwIa8uL6U/SOUDWuLzyTAiHAPzWUOM8CjVLD+EbbHd/5kR
         FnMJGohaY21AmJl4Lrba1v1FCtiqCThvY8//FgKgMI5nMolrkjqa5ElszWe7So6X4/NA
         29o+uMEWd5I0Ihfj0/TIUUwfyyspThDiVrfoH9mpbEwmREVQeVNhmFuIVnTUiZMir9ah
         1F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835718; x=1690427718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MMx6i8bJUxARp5QNqsq1CJUY3hOxlwkAEMcUNtK7dI=;
        b=T5w2MLSMGZY9W53oMaNekVXk8oj2K2MYZWq1xr//bmz3O3dBcGG3i4t2Z8c/yk++QJ
         SvOU1sI/RidDftIdQfbKUMh7VKSQ4qwEoH9FNY6E5FAz4mOe4V6/ab4uy/perb0oMrsB
         gKu80Rib7pt7jYG3VOBJyvSTPHVqNWSLyZIwlrrsRsArk/qKEIPDBhn8zt36LY0er+yF
         hIX/BLWhqb48vUYvaiVh2HlbQjihWRyxnDmOid6lkEk32Hjgs8hCbTv+zju7UGSv9BHY
         uBuCdQ7jnWgIGNmnQxeIaQBytHLkSjQBwAhv7yLZU85omoKKZV5os8DpsE8GjbWASGlG
         T5Yw==
X-Gm-Message-State: AC+VfDzaOlKqSEL1hoR5qQjOQ2yAzLPirvXK3n7UKeLxGoKkiiinxgbO
        CNTdG0k5J3q56rVAINGdITU=
X-Google-Smtp-Source: ACHHUZ7jG3JdEOLXHoTlHZs7iMneXhbSi5TTL08hXZ/YgCW6ZXi6BK/DGPcEgnHcQP1gwkgg+JH2AQ==
X-Received: by 2002:a0d:c506:0:b0:56f:e627:8545 with SMTP id h6-20020a0dc506000000b0056fe6278545mr30778532ywd.39.1687835718493;
        Mon, 26 Jun 2023 20:15:18 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:17 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v6 05/33] mm: Convert pmd_pgtable_page() to pmd_ptdesc()
Date:   Mon, 26 Jun 2023 20:14:03 -0700
Message-Id: <20230627031431.29653-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230627031431.29653-1-vishal.moola@gmail.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Converts pmd_pgtable_page() to pmd_ptdesc() and all its callers. This
removes some direct accesses to struct page, working towards splitting
out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 14d95d494958..1511faf0263c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2915,15 +2915,15 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 
 #if USE_SPLIT_PMD_PTLOCKS
 
-static inline struct page *pmd_pgtable_page(pmd_t *pmd)
+static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
 {
 	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
-	return virt_to_page((void *)((unsigned long) pmd & mask));
+	return virt_to_ptdesc((void *)((unsigned long) pmd & mask));
 }
 
 static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 {
-	return ptlock_ptr(pmd_pgtable_page(pmd));
+	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
 }
 
 static inline bool pmd_ptlock_init(struct page *page)
@@ -2942,7 +2942,7 @@ static inline void pmd_ptlock_free(struct page *page)
 	ptlock_free(page);
 }
 
-#define pmd_huge_pte(mm, pmd) (pmd_pgtable_page(pmd)->pmd_huge_pte)
+#define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
 
 #else
 
-- 
2.40.1

