Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9716272D211
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 23:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbjFLVIp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 17:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239064AbjFLVIL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 17:08:11 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9BC3C21;
        Mon, 12 Jun 2023 14:05:23 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-569386b7861so86050987b3.0;
        Mon, 12 Jun 2023 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603923; x=1689195923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BBSMNk3/NV9IPbcmTeXVmuDxVjvV9nk5pHOLLkR9Zc=;
        b=B5eteOvH/q+5UxTkqPiKmSRGXAjb4bZMizLs/WNtLaesb1E0HpRn4up+92FQaO/msD
         wl+HgJ9chyyZgdROsDvWF8ST2c98XDyJ6K5mIkqjJX4+EdwGnn3FI4jGMxc7JXWmf967
         aU1KzzzuV6U5c/qEMroqPTw1zV9aDblRqBawPVlpf/Mlyp6BjBb5H05VxOKBrkeVjlqN
         FunX9lODEGlrIj4hvPqV1OUn4lS2vKzFGXO/PdJAy/LDMA65UwEZCw3NLCYo8+J5kL9P
         iG2KwFG+0fA0Z25/Erx4n5fssjHvgoAeU/1R/dnILNKDOgbuGKGvMNK5K7M37Fiw/tnm
         j5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603923; x=1689195923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9BBSMNk3/NV9IPbcmTeXVmuDxVjvV9nk5pHOLLkR9Zc=;
        b=jjsvebrKfxCC4zaCzBi9vDTLAnf5Jk9CoQumOYlfBKSimpwxtaXyceNOVm66hbvJhB
         cR/KtQTFWIhR6EhqnBt5KwB3JCpIQuO/wb2r2JaHgO0K8/+L37WGMf7a4sA7o+Eg8NGD
         ObOMWYa4eXAMggessohK8YfzvfYvYSZRJJHDeEdnw2ZmfustwTRu3IxvOdqaGl5AyFIg
         hycr7pMRYh+Jn79KiCCEHWEk34BIxaNQQvsdsLOHNbKS6EoX5M8+oXIfF35JVkQiAmUI
         G88nIJz2lqWYqovme5BHnMPGW3w55dQpXcT0ojB5qXBO7tUu4vB0D2+U94ATBAnmLWc5
         wuzQ==
X-Gm-Message-State: AC+VfDwBqINAwgM9ufXjfOyrJcUcCtv7XXhZX0YIYJ1pKJNl7qNDTd0Y
        tFo+xmJ+hOGJD38P4bnf4Io=
X-Google-Smtp-Source: ACHHUZ6Y5hnmbR0E296qiytbEPqdIHR5totNZCgnfGVo00JLi96ohBBFsqGnqpvBKL1saABj0PHBjA==
X-Received: by 2002:a81:8495:0:b0:56d:c8d:be26 with SMTP id u143-20020a818495000000b0056d0c8dbe26mr5358308ywf.26.1686603922720;
        Mon, 12 Jun 2023 14:05:22 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:22 -0700 (PDT)
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
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 18/34] mm: Remove page table members from struct page
Date:   Mon, 12 Jun 2023 14:04:07 -0700
Message-Id: <20230612210423.18611-19-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
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
index c405f74d3875..33cc19d752b3 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1019,10 +1019,7 @@ struct ptdesc {
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

