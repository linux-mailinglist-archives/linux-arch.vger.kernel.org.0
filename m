Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9BA73F19D
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjF0DQF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjF0DPf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:15:35 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B581991;
        Mon, 26 Jun 2023 20:15:29 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-56ff9cc91b4so44754577b3.0;
        Mon, 26 Jun 2023 20:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687835729; x=1690427729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSwuU7fg/k+TT5PagWIdYLap7GxOydHG9fnVI01D6B4=;
        b=Lg2sjw4Fq7Jsh/1bPb8/Bz5bb4WbWygT3r2OYZVXGMBEwfozbqxm0/F6bIElAKjdHD
         k9tw765etUmPaJavNHOgRAh4TrN9WtYkyFJDXO4e8zB0CLQ7CKYG2S6Z4giPdak3TlLV
         dBQDIQS2mzx3Rkho31FJSGH9B3yVhFoSm33zMOn6yvA7Um5yH03kqWlR3ymYgVkxmZrE
         IJEFqdSDC0V+0/+0zxMFLR8Zuzl0eiDJ5KrxbBEu73g+J0vEbUyjW5NugtcJ2jWIZ/MO
         3IUWIpYlYW1hiX8BTPI8estSfzK1mYASEDhKfgKz4greHIhYdQhx0bK/LpN/7ezGhpY+
         FpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687835729; x=1690427729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSwuU7fg/k+TT5PagWIdYLap7GxOydHG9fnVI01D6B4=;
        b=Y0bnOZH0Y5ZUOybzPSYzNSWX7/2r82zd8F1+/3jMIWiF2+u2AvPTo4eqccpfAQfp/N
         2BXHci41BdkY2pFsGD/vZLmwkMontsC1MyiMfsqMXwj1sQ9tGej533fPtG4X9OeVooDP
         wS8zeeK0X1qKJPnGglFOHMuLboWVjgbeyRhqj15GvuvZoozGaJ02Wo4M16vdByy4ta1x
         hV2eHHgdLGGexKE6ANRMPNpzc5Pr351jZsXVzV8MmFjXifBkV3UAbJZJ+cwoyK2SLnaH
         KGDWorxR/h1TbyB/jL1L9Z++fFG+rOoYlM22suJfH0GC21VnkMyaCWqEmW/5uTVZvhNI
         OFXA==
X-Gm-Message-State: AC+VfDw7yomyTMnF5XRm2kzQKiMTw8dfj5WIyIxROKsRCBXgw7tNBf7f
        9a/V0HoPNKkoUXXkRbA7KU8=
X-Google-Smtp-Source: ACHHUZ46AY3BqwTWqQUYpGbmhIWT6fwcR58AoQIOUKYPJMkYvs0jOnx1fxcN7fC61p35DP7uAiDexw==
X-Received: by 2002:a81:6887:0:b0:565:cf47:7331 with SMTP id d129-20020a816887000000b00565cf477331mr37299896ywc.2.1687835728818;
        Mon, 26 Jun 2023 20:15:28 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id s4-20020a0dd004000000b0057399b3bd26sm1614798ywd.33.2023.06.26.20.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:15:28 -0700 (PDT)
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
Subject: [PATCH v6 10/33] mm: Convert pmd_ptlock_free() to use ptdescs
Date:   Mon, 26 Jun 2023 20:14:08 -0700
Message-Id: <20230627031431.29653-11-vishal.moola@gmail.com>
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4af424e4015a..0221675e4dc5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2934,12 +2934,12 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
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
@@ -2952,7 +2952,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 
 static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void pmd_ptlock_free(struct page *page) {}
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
 
@@ -2976,7 +2976,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page);
+	pmd_ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
-- 
2.40.1

