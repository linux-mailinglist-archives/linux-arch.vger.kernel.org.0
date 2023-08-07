Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E295A7733A4
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjHGXGh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjHGXGY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:06:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6B419A2;
        Mon,  7 Aug 2023 16:05:55 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d43930354bcso2766503276.3;
        Mon, 07 Aug 2023 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449532; x=1692054332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV51lKtiOhMWQgAl7GNvRpOxJtkn3o5Ia4Rm5PKGOL0=;
        b=WW7U9RxJoy+3YY4y3qa+Z9OsxlwmyOU3wMBaX5rDPLFmIEHt/X6v4NdYOpBq8PRkh5
         HGAvbPPuVPcaXp+7bIkcS5zKLOts7aoRAq2rmpfhl809GhQ5Z7qhyD2D1O9jUw02JT8D
         ByQrQ+74LtD1rxejz5iV5Ji3t3biqjBaLILP+cGmcXMABNbKMRqAqcPv+Q5eVbDOwvco
         pnySxrcubM/hR4SWo6309aJr0ghUYXqxorm9LprpxBDG4pKG7rw8FnMSIxuCIl+L3G3f
         pQ7sJFVehZ1e4LudKLyLwUTD+K2Hcr+cYbBqgmDPIUau/hEmU0pgvAzvLPGNFfNzyEIP
         WwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449532; x=1692054332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV51lKtiOhMWQgAl7GNvRpOxJtkn3o5Ia4Rm5PKGOL0=;
        b=N1KiKxhNi+/gyepfJx/lQaxGMIpgl8/zb+LFKAPwYI4MW0kOUnXz7qC06tn81kcbW8
         0SWwehWsaHrekjcnzr62i5j69lCPZYogZ10+PftTxbiTjQ04xAjqBV3sv+M84aavEJss
         mI/mDUwJTNrx7yoEsmOvSOAjkvaBeYI4sSkvGUJus9OYW/X+oX4S0OZPXZK7266KkB43
         QwZjTol+Ft0Gm6rVde6zb8/U8fnblSW5IzpYiDlPZbN6+GgDgqnZPriqC93xe2Rro3pa
         9/9accQDFfKyy/sI1hFfgu2uZZvmmDsPdS4hAzfCZSV5ybyk7cgndEzwsnuZcFBGB/US
         J80Q==
X-Gm-Message-State: AOJu0YwJ4MrRR7nxvOcGTmVt5/Cdew2scjkQ/NE0VrJ3DcOl5BtzdusR
        0kJwVWgtTKrxyB+ADim1H3U=
X-Google-Smtp-Source: AGHT+IEvrDCY+UE05HZYU4gf4n6Ovk9myxbAlbrTcNmkwiJKi0vLSKG9giGoSfLWvI4ILhQ42gUDlQ==
X-Received: by 2002:a25:bd7:0:b0:d14:6e28:69a4 with SMTP id 206-20020a250bd7000000b00d146e2869a4mr9317696ybl.29.1691449532541;
        Mon, 07 Aug 2023 16:05:32 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:32 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 07/31] mm: Convert pmd_ptlock_init() to use ptdescs
Date:   Mon,  7 Aug 2023 16:04:49 -0700
Message-Id: <20230807230513.102486-8-vishal.moola@gmail.com>
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

This removes some direct accesses to struct page, working towards
splitting out struct ptdesc from struct page.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc82a64e5f01..040982fe9063 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2993,12 +2993,12 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
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
@@ -3018,7 +3018,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
@@ -3034,7 +3034,7 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
-	if (!pmd_ptlock_init(page))
+	if (!pmd_ptlock_init(page_ptdesc(page)))
 		return false;
 	__SetPageTable(page);
 	inc_lruvec_page_state(page, NR_PAGETABLE);
-- 
2.40.1

