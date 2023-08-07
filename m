Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ACB7733EC
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjHGXHd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjHGXG5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:06:57 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E785F1705;
        Mon,  7 Aug 2023 16:06:10 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d479d128596so3766300276.1;
        Mon, 07 Aug 2023 16:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449548; x=1692054348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djDHSA50q7R+UyBiZfR1OlHjGJmDs73q9nwlLjbVi90=;
        b=A70KAiN4sx+tlFlhyX9BkgJstVMLVR3VqHlhU0rx7I/q1gK7xadYJiksKbuvoZ1TCU
         vtYAPdjYMcohI4FUcCDaUSvo3KExkCCd8i4ZAJlLsd7GGEFa35HZ6ueu66zMG9Pjessv
         IfHL3oLMSZbSj2Xq1C5vYTgwWzjwrMyTCzKH7w07IcqqBjGPHvlKkPkr5yx2TrtnD3V5
         vilM5UK235QUkkDj7spFvnAsyD47IB2DFcBmstKvpCiE4ENrGAtmtfggM5j3FhO6Urma
         yNzpPXlABiRMwP18oUglZegWP3XimvmMFaP4ALUxkyZmGiszwVYNBF+f3K+ck5Grr2Wp
         NJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449548; x=1692054348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djDHSA50q7R+UyBiZfR1OlHjGJmDs73q9nwlLjbVi90=;
        b=BNrzF4QxxvEdfX/WMRJQL7FRb9YYYpimsE59T/drqo81PhVKgTbCfm5jzbwfpv2Syc
         Y6WmSYZ7DNlAA0uNxMHE2Pfs8YGZ9qNnPtdB2WloKdmr7Efa7SVK8HOXV+fI72qDq3ad
         BbLv9ubTRm8Zpdoa9tDczB1SRsMytvUjA8cixfoXr7dQOmIplEe9iqAWwbjM0wTiNydu
         77hIjch4M7OdMvGcZB9knH4kvU17kK7UbnrlRyCZOkHV7ebMiA7rTmKXR17X0jHHlP2L
         lDMXVYqAxk+gsLb4kOgM7+3nLoSBNYqRCMt8nYDoHT5s4d1zXmTdzUYcyOkw9dOLeSCn
         uxbg==
X-Gm-Message-State: AOJu0YzfRrzyUS+IbMPOn8pX2SfrXLRMwEEo1qZlRKdFBOLJKjw3bx8C
        G2hOPGkAHQcUqYa74wQX1h8=
X-Google-Smtp-Source: AGHT+IGTzP73V6D5bA3Obfkv2DqAOxUsUVIIigLLB5NQKEC9VyMSvyrKel3HyW7I0Mz7ccDZUXFbIA==
X-Received: by 2002:a25:d8c4:0:b0:d05:2616:3363 with SMTP id p187-20020a25d8c4000000b00d0526163363mr9753736ybg.26.1691449548551;
        Mon, 07 Aug 2023 16:05:48 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:48 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 15/31] mm: remove page table members from struct page
Date:   Mon,  7 Aug 2023 16:04:57 -0700
Message-Id: <20230807230513.102486-16-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230807230513.102486-1-vishal.moola@gmail.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The page table members are now split out into their own ptdesc struct.
Remove them from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm_types.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ea34b22b4cbf..f5ba5b0bc836 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -141,24 +141,6 @@ struct page {
 		struct {	/* Tail pages of compound page */
 			unsigned long compound_head;	/* Bit zero is set */
 		};
-		struct {	/* Page table pages */
-			unsigned long _pt_pad_1;	/* compound_head */
-			pgtable_t pmd_huge_pte; /* protected by page->ptl */
-			/*
-			 * A PTE page table page might be freed by use of
-			 * rcu_head: which overlays those two fields above.
-			 */
-			unsigned long _pt_pad_2;	/* mapping */
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
@@ -454,10 +436,7 @@ struct ptdesc {
 TABLE_MATCH(flags, __page_flags);
 TABLE_MATCH(compound_head, pt_list);
 TABLE_MATCH(compound_head, _pt_pad_1);
-TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
 TABLE_MATCH(mapping, __page_mapping);
-TABLE_MATCH(pt_mm, pt_mm);
-TABLE_MATCH(ptl, ptl);
 TABLE_MATCH(rcu_head, pt_rcu_head);
 TABLE_MATCH(page_type, __page_type);
 TABLE_MATCH(_refcount, _refcount);
-- 
2.40.1

