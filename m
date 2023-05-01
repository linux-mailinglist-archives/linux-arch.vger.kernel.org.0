Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A5E6F374D
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjEAT3o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbjEAT3W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:22 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24B62D48;
        Mon,  1 May 2023 12:28:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aaf91ae451so11829935ad.1;
        Mon, 01 May 2023 12:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969323; x=1685561323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ii9PvRdhTMRqBop+JFdKAWa6G/XpZkmB9p8iHmrwUc=;
        b=lFLswDg0HvrPkF+dtbJhg/asaCBgi3e00w4opfv2mri4GHWG5ahGHxm9sLAnqC4qbq
         cQ+9MPTjwHhlk51h4w8lOE5zFHDICMVPmNnmwWW2l0krumAZ2PDeWC1WEjJOX3LShLcV
         g0uvqMJBbig8RslrcZc6EAJCiGxazADIIfKt9bAt8yGDMo+5nIH4mdhXs+LaHQV1OVik
         U1EjmbMLOLA/7Pwt5TKTUK+w95+W73jVDYdL+HuxsLXipLy8KET4HB50FeUWTlZzXbc3
         qFSctTNSvV8Q7v0NapgoBkUZ/cCAkZoFPz8ver9uL6iYj4+bfmoOnnABcA11qHjnQcrq
         /yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969323; x=1685561323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ii9PvRdhTMRqBop+JFdKAWa6G/XpZkmB9p8iHmrwUc=;
        b=VD6VsC8zrUXmnTbpsta4vwsVUi53+L8++HrRx1S9hGoVHMuMqwfNvs8sTJDqqa0UGM
         OETqkCFH2PCV+wdafmXylL5R2yQTayfM41TLHx0rg+LAtBYRUmbxlXYaX8GKJukcXMqW
         lGnSuS3aBFt5EY1W9FTjcnew6ZPgXywiLcU8Y77qe8Ox8LuJYvwX3gSoc/Y5TxAmllXA
         37LRjAYMl0OCiAFfPuRXuNyoxbNoaOgOCyyAeF5AL7hMoxDSc2cJN+IwbHSNW5dkehcH
         XIRsJi0IuXEtwqzae8pM2AlVzskmzFx3LxidIw6DirkiowBfo2G/u/rhwdZ8G7Orz6/J
         /pZQ==
X-Gm-Message-State: AC+VfDyqqUMckXdHqnGAF+0WTwFFdX7isBc9A6cY+EE9Tnuw8rgtlWmB
        4zQ2Wszhu8iriJsK6pyE0dM=
X-Google-Smtp-Source: ACHHUZ4gWlsAH/48zhDdvicQeallszzZORdrHEFL4BiABQ6zj3x4/LHvqIQGrX0uRjqorCk+ulIxBg==
X-Received: by 2002:a17:902:e805:b0:1aa:f6c3:ba24 with SMTP id u5-20020a170902e80500b001aaf6c3ba24mr5259994plg.4.1682969322807;
        Mon, 01 May 2023 12:28:42 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:42 -0700 (PDT)
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
        kvm@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 06/34] mm: Convert pmd_pgtable_page() to pmd_ptdesc()
Date:   Mon,  1 May 2023 12:28:01 -0700
Message-Id: <20230501192829.17086-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Converts pmd_pgtable_page() to pmd_ptdesc() and all its callers. This
removes some direct accesses to struct page, working towards splitting
out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 258f3b730359..62c1635a9d44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2892,15 +2892,15 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 
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
@@ -2919,7 +2919,7 @@ static inline void pmd_ptlock_free(struct page *page)
 	ptlock_free(page);
 }
 
-#define pmd_huge_pte(mm, pmd) (pmd_pgtable_page(pmd)->pmd_huge_pte)
+#define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
 
 #else
 
-- 
2.39.2

