Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79332718C29
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjEaVbj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjEaVb2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:31:28 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8159F133;
        Wed, 31 May 2023 14:31:22 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-566586b180fso959707b3.0;
        Wed, 31 May 2023 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568681; x=1688160681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQi1r9n8ZvdAYjhQrP0RtpOHDwCF0T3SkT9pOHS3grY=;
        b=I4ZK3ufVe7mv71vTYogtgymswU5NJnWubvNrBVwVZ1xQ0v/p7EI5y5eDyiHJRrHKpG
         azRQJKWH7AViYgdCK9GdEYZ8omA3oIlbOzs852fLZAEvIF+ozvEvZkK1/lCOTaAOLLWg
         oij0mtTKcWvOTyQV92r6jSH492LqXNF3KyTROTbV0zOPwz64hVwHxQg5gRw6g2twpMr+
         Syr51H68T+2e3gvOiE/6C7bywaJcNLAGV+Y3hFA7u25fKQ4NEmZwbyYlQc7gCZ6R/kVr
         pYNZAd+SPL7/3au6VqcXubefeyJmThujQisY5D7sD9GWsMGa+7uty95WSWwZ8guF3AKi
         4svg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568681; x=1688160681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQi1r9n8ZvdAYjhQrP0RtpOHDwCF0T3SkT9pOHS3grY=;
        b=EjVKHFhUivhOPDFPMoOFYbj6OoEiHS6XHkpm6xHkE7J3qgTLlCRw0+HUJMd++kfKkg
         5NkLhIktEzrPHIhJMMokiU4nDRF3I8IVn5epg3amaheoiJAMfA1VO2SE7oPmZcXpxtPB
         66VGQj7nCIj6oZ/OPfnTmQ6RioxXzFwsjYTceXdhVYOchwuDcg2jNDlHfJfO/Kb8/oME
         XW5L9u1JCjk8clr8KNZibDD09lS14qVDdzPZ/3k+qFCR4DYjPHMDXWWRjOk2TT1l21yV
         TjKKZpzQLUr6HpaHy1XvZ9f8/cl0Kbe6akWLxq70GxgE78llpmlAyPHHeHbHJ8Xqb6Ne
         lBqQ==
X-Gm-Message-State: AC+VfDyztjY+AGyEwCNHRDi+ohjwZxcnpIT+iNb7f2OHYA4RDRonNzMS
        FtfwO2YY2YNj/p6I7fpI5KA=
X-Google-Smtp-Source: ACHHUZ4MgiQhTnDT0ikSenPgoz+0X6zm2wOF95JZP/LWMfbyCLY8nB5YKCMBE1n0Fb7UhukNcNCVlw==
X-Received: by 2002:a0d:f5c6:0:b0:561:1c14:b8df with SMTP id e189-20020a0df5c6000000b005611c14b8dfmr6643798ywf.47.1685568681477;
        Wed, 31 May 2023 14:31:21 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:21 -0700 (PDT)
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
Subject: [PATCH v3 06/34] mm: Convert pmd_pgtable_page() to pmd_ptdesc()
Date:   Wed, 31 May 2023 14:30:04 -0700
Message-Id: <20230531213032.25338-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
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
---
 include/linux/mm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 620537e2f94f..3a9c40e90dd7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2912,15 +2912,15 @@ static inline void pgtable_pte_page_dtor(struct page *page)
 
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
@@ -2939,7 +2939,7 @@ static inline void pmd_ptlock_free(struct page *page)
 	ptlock_free(page);
 }
 
-#define pmd_huge_pte(mm, pmd) (pmd_pgtable_page(pmd)->pmd_huge_pte)
+#define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
 
 #else
 
-- 
2.40.1

