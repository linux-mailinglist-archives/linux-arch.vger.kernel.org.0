Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086356E5250
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjDQUxX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjDQUxO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2304C2B;
        Mon, 17 Apr 2023 13:52:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w11so27335099plp.13;
        Mon, 17 Apr 2023 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764772; x=1684356772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPCTGsUKFtNZ0E2E3gxAeEJL+3qovRd//xVc9xUETqc=;
        b=IRDdSAScs3TBGztRzu6QZgH4fMR7/UKueaVS3DDhFsZMLZlJQUDaWkKiPXvov39z8Z
         bssT73UYUy1LP7uOeEalBEo3irDXhaxWlDKHCjJjWa82XbzBt1YrruOwks0GGaa/KE2/
         kcH9ajFlIINgfw2e+eWdEuaQpWFwhb8tF79JjCU2EAC5A/73X/TUfQV/8mop72+F/v41
         nZHSSM2ss9/OewEDYIYb1Iz4F1hF7m8KXVNPHD0iWKxsJnaQ4CmjrVdNW0xNgbwEICJR
         VACO7VFEKZxOIvTtIDcu6wtwdqmMEpSRB4owcroJF6TbGx9VSAN4uiN81drhHklILqhb
         p9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764772; x=1684356772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPCTGsUKFtNZ0E2E3gxAeEJL+3qovRd//xVc9xUETqc=;
        b=Qm+LLh7Wpf0F6qqGYZodIj4Tat/qwDk63MKc+Q9F//6qitUnUgBteUCFLFataBJdjq
         aSIh0ItKlOfAnGZQLmoHIorZUl/gqkKA+tyT+XoTFaLaClHp/xPDE5zk5clbKRX6oIcq
         U9/m1ArDk/AQmMHGE6GW5Q8Y4Er8Hts8Z9LD4gRe3ApbKPLeQOxBdttHnjGTcazgIU7G
         rrt/w65xMkVmT7zv8txUW7P1moq5hmD3ypJmwur9VfFYgEEevNqE+Uk7Dqhel7/vvmV5
         w9D5fK+g/zVNGxEciHv6+CpaSeD/5t0y3t+l1hoMYKKX5JeGTWLC8ri6+SjlhMBiDblm
         zrtQ==
X-Gm-Message-State: AAQBX9e8HbCT0gBcrqEgYpKo2g3gfrfZCRZ24sF4H9XFXx5GhHbHyZo4
        je7Bo0kaX6jdB+HLZ6MfOVY=
X-Google-Smtp-Source: AKy350bms9aSjWgOwaAnzsnpGuFvcEqsOo1myEWAVSaCBXxzFAqV0lCr0DmPVe9wT5EHiIOY8l5jIQ==
X-Received: by 2002:a17:90b:f84:b0:246:fc58:d77b with SMTP id ft4-20020a17090b0f8400b00246fc58d77bmr15834371pjb.44.1681764772342;
        Mon, 17 Apr 2023 13:52:52 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:51 -0700 (PDT)
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
Subject: [PATCH 05/33] mm: Convert pmd_pgtable_page() to pmd_ptdesc()
Date:   Mon, 17 Apr 2023 13:50:20 -0700
Message-Id: <20230417205048.15870-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417205048.15870-1-vishal.moola@gmail.com>
References: <20230417205048.15870-1-vishal.moola@gmail.com>
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
index ec3cbe2fa665..069187e84e35 100644
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

