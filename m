Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508BF6E5298
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjDQUxn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjDQUx0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F327286;
        Mon, 17 Apr 2023 13:53:09 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id s23-20020a17090aba1700b00247a8f0dd50so3410383pjr.1;
        Mon, 17 Apr 2023 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764789; x=1684356789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySUR2NhNYIi45iieMc0XGAHKG7J++HPTQWlVu2Tasao=;
        b=r15/y1KDif+Drf/4AN1jpq4aAvcL2g0C6yBlVejRZjViwAKdx4tN5lVxRrilW72t8W
         lxYrwwZ1V+6OuCBWGNjnVnFHs9fxA0+y+Hq/T2Xun9HaX6uevRtPhFT+6Fyn6rL6cuxl
         Z3/9OHOOCrjsch5rq9oWYEod7RCMO4fFtyd7gUBrmXZG32pCnlsISiWWId2b7LrGrhST
         kpDrkb186Ifgo7UoD/Ti/tLM6Mv74UfKgE7j3u4BhSVZUj1yrtlCsZDlhuTy+CmGW1TT
         t+a+qaRd0Bf5+Wl/CDmlKFz2wUcV2Pe9TbKsnSy3YV2N+zpAWDFA5l3JzNu+kIHHm1Jf
         2puA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764789; x=1684356789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySUR2NhNYIi45iieMc0XGAHKG7J++HPTQWlVu2Tasao=;
        b=RcBvuNfBNrhEroN791ymX7dg6iLG0BijC5EsoWFExuCO/5rOtx/bGdZp9NKmGzLuBy
         mC+A7mBRn5tAwExWbPXrukQh5q7NKlwdYY+oz0LFJ8qQwrkGwo1rFyqrM8aSELC4cO/G
         ArkBpBS10DWhO04QNP1xyMS0MnQmRrYVsKOCQS6FJDoy48SMYKUDo7SmEJE3Tb7DlAUS
         tbp1n/IG+MSQhnom3EPym0yJNpEdtc6g04nqc5/cOWAj79eoUW7SwA1AE0/bswk2qufs
         ooHKMPivC24vb309xtZyIeUwssrus4tGqOc6pN6AWYdTjCWd6RZmZA9TXjUjDQZ2Kxi1
         seAQ==
X-Gm-Message-State: AAQBX9fnkdktYyVT9RKvWnpLYJTZkhG0tLho+JfzU755RHG7QsroQQrL
        skesA5pigqo0e089FHyvEnI=
X-Google-Smtp-Source: AKy350ZVl3PNdJ0+nN/Rb9LpMw5+uyjbe8u9t4N4aIteNFpQkEwBCpgg7+YRGDc+SZWH4x4d964lpw==
X-Received: by 2002:a17:90a:d205:b0:234:409:9752 with SMTP id o5-20020a17090ad20500b0023404099752mr15223725pju.25.1681764789129;
        Mon, 17 Apr 2023 13:53:09 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:53:08 -0700 (PDT)
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
Subject: [PATCH 17/33] mm: Remove page table members from struct page
Date:   Mon, 17 Apr 2023 13:50:32 -0700
Message-Id: <20230417205048.15870-18-vishal.moola@gmail.com>
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

The page table members are now split out into their own ptdesc struct.
Remove them from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm_types.h | 14 --------------
 include/linux/pgtable.h  |  3 ---
 2 files changed, 17 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2616d64c0e8c..4355f95abc5a 100644
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
index 7cd803aa38eb..8cacdf1fc411 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -91,9 +91,6 @@ TABLE_MATCH(flags, __page_flags);
 TABLE_MATCH(compound_head, pt_list);
 TABLE_MATCH(compound_head, _pt_pad_1);
 TABLE_MATCH(mapping, _pt_s390_gaddr);
-TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
-TABLE_MATCH(pt_mm, pt_mm);
-TABLE_MATCH(ptl, ptl);
 #undef TABLE_MATCH
 static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
 
-- 
2.39.2

