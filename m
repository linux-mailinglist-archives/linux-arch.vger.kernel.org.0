Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59788718C85
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjEaVdX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjEaVcr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:32:47 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CB8184;
        Wed, 31 May 2023 14:31:50 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-565bd368e19so797487b3.1;
        Wed, 31 May 2023 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568705; x=1688160705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9eRM/zDkfdSk+8A/Hewm27be7ojppibpTW/4yMTPrs=;
        b=cEdd+3JqSM8NFS7GIxJNDGEwvf5zLrjyKSP/sMa+M4iyqruEv0NeTXFNM3FuEOve0w
         BIidhyYZPlXr46Gag37ah0Z9lK+/zubpEH8qTvbGBEkRrc++Uy/9vmo7kzodV2wrSQQX
         I30LmfVEDViclfTqhhCm9JCK+j60eB88X4OE4kx5hV9tTa2skQgGrRsYDfbJW0ibMSeL
         XGmJa+8fFqRfTTRXmPxLl8Ng1lVV80Cc71vk49EsIYa6/DzcwK4zi4KQyIaDphcDsbUr
         cdzc/H0c6XAN15Wd27KyDlOf+VJeKUYgNs/w5+avyyLu4TkMCo4jGnCkWr4fOUgF3X5G
         tX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568705; x=1688160705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9eRM/zDkfdSk+8A/Hewm27be7ojppibpTW/4yMTPrs=;
        b=M33+SrGUwnV6vJR/Lr5xHgZVjI4eqxHhWu/RxXEm3tFjOsZRsGuP+Wle0SjTDyx/Z+
         /sUrbZhCdTUbYJJYIfw5dL3HEefeQ9ezx/71wwib9BCmO3jOi4ih/kTrhQMNQpmo6x4L
         JmsG7OCZvoaONPB2yu6CtT6iT5x+0boUz7lWPSBSnwJruMufJS7uG511mW9rabv46Jge
         15UPzHWL6OpKb61qsQRFgwzkXbSsJW3Q2eHyvrTQvsd7cfva6b6AIfAbInvAZsiCgclF
         xJ/kvV8uSvHCpqDl6lb0dwBSU/r1eOk0E8NceAmD35ObCnZ6kzHIUTkFsvvYk1uNbh17
         8yTg==
X-Gm-Message-State: AC+VfDy4O4+JedTCIanAbk0QV4V/yzcs++Budy3uHXTIElIel3SsYhSE
        tIgwYIIkTfU5bwurb93ySq4=
X-Google-Smtp-Source: ACHHUZ6qsHeUoao2+s8uy7ftoyOjIWcEzXHhSNjnyPVGfYnJHG4o2q2q2wEf6DyMGhXFqCryp1fDIQ==
X-Received: by 2002:a81:778b:0:b0:565:ee47:5844 with SMTP id s133-20020a81778b000000b00565ee475844mr7319022ywc.38.1685568704868;
        Wed, 31 May 2023 14:31:44 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:44 -0700 (PDT)
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
Subject: [PATCH v3 18/34] mm: Remove page table members from struct page
Date:   Wed, 31 May 2023 14:30:16 -0700
Message-Id: <20230531213032.25338-19-vishal.moola@gmail.com>
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

The page table members are now split out into their own ptdesc struct.
Remove them from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm_types.h | 14 --------------
 include/linux/pgtable.h  |  3 ---
 2 files changed, 17 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6161fe1ae5b8..31ffa1be21d0 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -141,20 +141,6 @@ struct page {
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
 		};
-		struct {	/* Page table pages */
-			unsigned long _pt_pad_1;	/* compound_head */
-			pgtable_t pmd_huge_pte; /* protected by page->ptl */
-			unsigned long _pt_s390_gaddr;	/* mapping */
-			union {
-				struct mm_struct *pt_mm; /* x86 pgds only */
-				atomic_t pt_frag_refcount; /* powerpc */
-			};
-#if ALLOC_SPLIT_PTLOCKS
-			spinlock_t *ptl;
-#else
-			spinlock_t ptl;
-#endif
-		};
 		struct {	/* ZONE_DEVICE pages */
 			/** @pgmap: Points to the hosting device page map. */
 			struct dev_pagemap *pgmap;
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5f12622d1521..3b89dd028973 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1020,10 +1020,7 @@ struct ptdesc {
 TABLE_MATCH(flags, __page_flags);
 TABLE_MATCH(compound_head, pt_list);
 TABLE_MATCH(compound_head, _pt_pad_1);
-TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
 TABLE_MATCH(mapping, _pt_s390_gaddr);
-TABLE_MATCH(pt_mm, pt_mm);
-TABLE_MATCH(ptl, ptl);
 #undef TABLE_MATCH
 static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
 
-- 
2.40.1

