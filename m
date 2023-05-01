Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0187B6F3724
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjEATaG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjEAT3n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2794A30E8;
        Mon,  1 May 2023 12:29:12 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-51fcf5d1e44so2423784a12.3;
        Mon, 01 May 2023 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969339; x=1685561339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrqntkjJd8BO8YfASMnosk0HIl+t/0EXXW8sSx0dJVg=;
        b=YynIc3MWOn+7eKGjmZARCn/IjCANfe8gTHKhI/1ubKTs4ZbiubHG1P9aimD9KzNrIR
         eunJCIzqiXfZGl0CCMrWEsO+nwpbu9UTA+2coBncf0PpX1ohouYsG2DEdDJZPuTXi/ir
         yR5oJPT4K2awb6eBfuzacZRfwPXKDUNKWynDv8oNvVCBXhLYj3JhwMiPBRO+Fg6hjdSs
         FM9xgZDHU6Sc+urW7voaFKEt/7m6LjDuxZZp6qL4zZI9dwEcGtT8oaSDqFIY7TNV4Oop
         NDnPsASY2UskW6usELO5k/OqVJv807YApzHQHt4bSD2BLXySmWIPAbRFeQIxlm3YwdkY
         qcpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969339; x=1685561339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrqntkjJd8BO8YfASMnosk0HIl+t/0EXXW8sSx0dJVg=;
        b=YfEWpp+w0zdwl55DaNbB7wXees/OU6DcqhG3K1powRQLivlJB+NJKMAbgHaGgKa2td
         dqZ9aO1W//gGA//DDoz+F9V8mHsRVQ+s26k2AjD5LOIXYUV+q8XkAYv2kSv5BV8OPFeu
         UTKqbcKlGvyKn6GDJDeH+FHfwLLXfIsHS7fXh5J6FjYFcQnizmlObll8m7GfDLEH63Jv
         GUulGM/Os8U8BUHqmZ8FPfhAa0TD8ji1BqJlJboUmWdAgTSJeXOVX8qnHGzfXQG3F+2n
         LxUZSjG9bZ7njfiZ3xDV7nL6DqHlieysSCYiMwARwwrSEgAhPXyDNEGfBd1ZJeHlmtKB
         GYLQ==
X-Gm-Message-State: AC+VfDxd3pIlRRG7pnc5U6vGBukGXsHf9/+WHbDQB7ptBTBKhI+r4Z1b
        5KqGrMmmiQrY1IFlQeqil74=
X-Google-Smtp-Source: ACHHUZ77ujqEA4Fn1OLOb7e5ecCGVNnJtAoTp2B3mAkadiAfSXyelwvqP5mlNEo41vojA+MW1rmqbg==
X-Received: by 2002:a17:902:ce8e:b0:1aa:efad:f2d4 with SMTP id f14-20020a170902ce8e00b001aaefadf2d4mr5633464plg.63.1682969339499;
        Mon, 01 May 2023 12:28:59 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:59 -0700 (PDT)
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
Subject: [PATCH v2 18/34] mm: Remove page table members from struct page
Date:   Mon,  1 May 2023 12:28:13 -0700
Message-Id: <20230501192829.17086-19-vishal.moola@gmail.com>
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
index b067ac10f3dd..90fa73a896db 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1034,10 +1034,7 @@ struct ptdesc {
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
2.39.2

