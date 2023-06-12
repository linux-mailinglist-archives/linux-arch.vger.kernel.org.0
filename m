Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF64F72D212
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jun 2023 23:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbjFLVIq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 17:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238616AbjFLVIB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 17:08:01 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD8F2950;
        Mon, 12 Jun 2023 14:05:09 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-56d2b7a9465so15630047b3.3;
        Mon, 12 Jun 2023 14:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686603908; x=1689195908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/NReaJdz90gZ2NQIlUYsxuwjuA5PoSk9HvAIR22dRg=;
        b=cJPixJ7fvL8lj4msWoT6T4UdDliAegelx3fhfZFkllamFJSmCzzBfgBkJHvHf5VBH4
         +bFQaX0c9HvMpz3cMr64OoUwpvHF+4NrriYC39tboK0Z4VjLF9J6MmzkevSDnSF+eJ9S
         vsFP6THd62TglAym5r/waWV4KiQYY/X7Hysf9ft4FBrKTw7bicGfQMMhWM2I4CuvKtOv
         cwDTHbNBV8LRmkAEvkAc0kAr+XDxv+lhnXg68dTw4NnjCIip7ummoW4kmN1lP3wtz1t1
         rgvGb1IbL+Qt1u/Y4z+ep/GLJI6yTMWmeJDiLjESMtlIxdtrVlVrtQkxPe5yKm5XHK1M
         0mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603908; x=1689195908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/NReaJdz90gZ2NQIlUYsxuwjuA5PoSk9HvAIR22dRg=;
        b=aepoKjP1xsUQDMauiCnZ6rVGnHYEUeJr3GdZlunKqW1bKzN5hVAMCeZsyVFfKWEkgd
         m3ceIgAPEmhZgOXY4ccnuCylr2IDnAITaRBksCIhPwsDcKE63ouhLzQGZuKTcfI0MnMf
         CfdhQTsg04SPJyX5kllOAbyJIEas/X2vkChdhYN4LMhvs0CxrBlDBwefA91OwXMZ2557
         C4wj4qabvEkYV/XGZHigJEbctm8q9QpM8sW5mwKmwYLfssK+g+uWIcgIw82Nqz6zasu/
         Nvr97j7ZdY+lrI/g+VJ+KKO+Fl8q+2M5QN7oISDo9uxwz5ZfIk+BIM4nWBIQlih275DL
         NXow==
X-Gm-Message-State: AC+VfDztSBOzccz4f3tlCL5cenXCPwbel8LUjI95gdDLM8CYYy/QOs1k
        G8hUXMxVt8QnSDmGwtHYaew=
X-Google-Smtp-Source: ACHHUZ5kijcVYXBTbbFcK1VnPllJL1iB2ONZxmZAAAXhO7jcUSS10Gkxlzbwqmp6U6Z9PG+yvX9PWw==
X-Received: by 2002:a81:9288:0:b0:56c:f916:905 with SMTP id j130-20020a819288000000b0056cf9160905mr7254032ywg.32.1686603908266;
        Mon, 12 Jun 2023 14:05:08 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s125-20020a817783000000b00569eb609458sm2757115ywc.81.2023.06.12.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:05:08 -0700 (PDT)
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
Subject: [PATCH v4 11/34] mm: Convert pmd_ptlock_free() to use ptdescs
Date:   Mon, 12 Jun 2023 14:04:00 -0700
Message-Id: <20230612210423.18611-12-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612210423.18611-1-vishal.moola@gmail.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f48e626d9c98..3b54bb4c9753 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2950,12 +2950,12 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 	return ptlock_init(ptdesc);
 }
 
-static inline void pmd_ptlock_free(struct page *page)
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
+	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
 #endif
-	ptlock_free(page);
+	ptlock_free(ptdesc_page(ptdesc));
 }
 
 #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
@@ -2968,7 +2968,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 
 static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void pmd_ptlock_free(struct page *page) {}
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
 
@@ -2992,7 +2992,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page);
+	pmd_ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
-- 
2.40.1

