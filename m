Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A16E5257
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjDQUx0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjDQUxU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8B055BE;
        Mon, 17 Apr 2023 13:52:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id kh6so25752521plb.0;
        Mon, 17 Apr 2023 13:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764776; x=1684356776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0S9vHWOxLue2VyFd3w8q0WLRZoA25NyvyllT+RcawU=;
        b=XGW0pwJ3AeguS3BSEjZkQda83npB8B7RbJEymTCypauBOGiv3vWjnUTzzYfl8eoJ/G
         l8vpSac3iXyBMdZp/fMD6sum0gW4MOCVqLS502CXgyi0RUYYf3ntgvAGSXGBolZoNn2i
         V+ToiFcIdhtDlP2wctGltXpdu2C91rdsIF1S9oPOQ0O7Jf0vF/Q8QloTMvDXpKn4JpZo
         XwyusDwNIWazvsnj/elh4vmpM936WP8JEzePXhLQ+OdbmLb8t8oYaUiKKrqV8mjQTuNV
         U8/37jTeHtYYWs9KLzMjZZ9An2VnMVkd7CaDSgdHdeupgwKBIBRRGFzwxZa8/Q4lnujL
         ZhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764776; x=1684356776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0S9vHWOxLue2VyFd3w8q0WLRZoA25NyvyllT+RcawU=;
        b=KZlY1HzzKPSbFWRaXF66Ie3cRd13jv758/WiX6vBBBHtCUPeBIToawl9/GyUPtrHbh
         +SfttTRwU1BhgknWdycvDTR06Ly4pgsu3atrbBeWZrBUfo/HB2uZoZ+mRfUXXD0gJy//
         7cWVmOmwpkv1NUMtcWSMG8EkFu15EwgKaKa6t+Au69tjvOG/hYddkSA4Vm6x/eiQfqVJ
         xS7I5WR6Vn0e+qEyCqwcX8DDPVew4wxWbIEzKfh1MsRbQAJCaGfesEutHQgkz70dF1aD
         aintFV+wevjD0bw5O6yabojOwvxY3s8/x4qen6nzN6PhhuI8UP/QfiV5hT+3sboew1Gi
         tX8g==
X-Gm-Message-State: AAQBX9cy99mOk27DLDaiVpCGbBSLhYGTEXNNdrBxWUZH3H9V5Ermsjqr
        A7i8ZLIezsn6s1LWMckq3IM=
X-Google-Smtp-Source: AKy350ZxT8mmBCzqXXqE8vhbMJvpIdAkvQhshhpl/b9NVru4kEOX264b08aZJzrt7Emcu03WoO14SQ==
X-Received: by 2002:a17:90a:3fc8:b0:23d:15d8:1bc3 with SMTP id u8-20020a17090a3fc800b0023d15d81bc3mr16271900pjm.39.1681764776607;
        Mon, 17 Apr 2023 13:52:56 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:56 -0700 (PDT)
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
Subject: [PATCH 08/33] mm: Convert pmd_ptlock_init() to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:23 -0700
Message-Id: <20230417205048.15870-9-vishal.moola@gmail.com>
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ed8dd0464841..7eb562909b2c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2903,12 +2903,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(pmd_ptdesc(pmd));
 }
 
-static inline bool pmd_ptlock_init(struct page *page)
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	page->pmd_huge_pte = NULL;
+	ptdesc->pmd_huge_pte = NULL;
 #endif
-	return ptlock_init(page);
+	return ptlock_init(ptdesc_page(ptdesc));
 }
 
 static inline void pmd_ptlock_free(struct page *page)
@@ -2928,7 +2928,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -2944,7 +2944,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
-	if (!pmd_ptlock_init(page))
+	if (!pmd_ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
-- 
2.39.2

