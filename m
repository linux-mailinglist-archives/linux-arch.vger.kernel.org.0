Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCC96E52E5
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 22:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDQUyA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 16:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjDQUxV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 16:53:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294E5B90;
        Mon, 17 Apr 2023 13:52:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id la15so4090223plb.11;
        Mon, 17 Apr 2023 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681764779; x=1684356779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3zVXX/N6SOzga9RDJq+tPAqPrrx50X9RMNZ27hRgPo=;
        b=sICUrUNhKpAOA4VRjrqbzI2X/H4tUjO6T2SdOnpuj4Iy+PajhE1DrUSbcJznfffRrX
         L+wg0APu+UnJsiMWo07D8eesoEiJoCPkIf7iFkO3frlAWKtnOneztwNYCGmhOQpiZeuy
         AXohiTFVSZ6j/QYK9dyhVhIaufaLIPexDAAJXmf6qW3dNeCDEUq++V0vxfiKc0g0e7Ab
         Ewxv8L1qYPD4uyzx9cQ6CGY815b+pAM3zpWc0XUF8sLnRhkHRA/O3qjcuWg0cKvRpE4M
         YyoU6OpnuIHEQ4e7n1BxpYaP+3T9kR2hf6Oim0PIubi0gprGsuCOvZCKtVwS9TGYF6kY
         TvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764779; x=1684356779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3zVXX/N6SOzga9RDJq+tPAqPrrx50X9RMNZ27hRgPo=;
        b=jcGd4cdY7Ch+fIG+r2fc4u7HEtxmBRSC5AcLGAPwsin+Pq3IKf5if7v2j1ApQzRNrR
         Ec3fAVs9iIGiUs83RIsdKyf3CQpmH6wJYz5ZcYK/dW9s0JT1yRGSiU0vEpuGuJf0lATb
         YgCQRPbRlKicQ/eb1xIGECk52q+p0S82zdJVrfrjmgU7gK94APEc2mCjZ/qnPR1cstLf
         AmhhS5tyHdOE08e7qC2sHEnWhBXbYUw3M7lVVtxmar0oFgFYI+iCF4NoPLG2zEvwIl/s
         TjbUCxjyxqPwHWC8KLbGP2hnlw4vN4CxptFNXIpsG2p5ux1D9mxHxWDlGMYgABbq/MMX
         sODQ==
X-Gm-Message-State: AAQBX9dwdiktTWl5W2IkprYefu+pOsIRXeszoSQxLgUyO/NBWCsTg3hp
        YFgakSwP+DfV5YCqd9EWAuI=
X-Google-Smtp-Source: AKy350aL1Q/BuQU4b/coHWha7jodau934g5ZfPpWwX1i7O384OcXkkUs5sEaNrPzHDYpgrYCEKrWgg==
X-Received: by 2002:a17:90a:cb8c:b0:233:f393:f6cd with SMTP id a12-20020a17090acb8c00b00233f393f6cdmr15121483pju.5.1681764779380;
        Mon, 17 Apr 2023 13:52:59 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::c139])
        by smtp.googlemail.com with ESMTPSA id h7-20020a17090ac38700b0022335f1dae2sm7609707pjt.22.2023.04.17.13.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:52:59 -0700 (PDT)
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
Subject: [PATCH 10/33] mm: Convert pmd_ptlock_free() to use ptdescs
Date:   Mon, 17 Apr 2023 13:50:25 -0700
Message-Id: <20230417205048.15870-11-vishal.moola@gmail.com>
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
index d2485a110936..2390fc2542aa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2911,12 +2911,12 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
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
@@ -2929,7 +2929,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 
 static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void pmd_ptlock_free(struct page *page) {}
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
 
@@ -2953,7 +2953,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page);
+	pmd_ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
-- 
2.39.2

