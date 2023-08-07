Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0657733C2
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjHGXHK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjHGXG0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:06:26 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7A819AD;
        Mon,  7 Aug 2023 16:06:00 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d4b74a4a6daso2620662276.2;
        Mon, 07 Aug 2023 16:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449536; x=1692054336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dL6AQetgHURU9peF5jMm+1QPkGPdtGd2X/zb9xq5Tzw=;
        b=ipvaU8x/4/BvbPbL1JSP5UKyrvOXFJin5b02qnpk0+g2WqZ4eJ+PO+ktIgA+6wNoSm
         aaVqpEKee+fuDlQKCW2FfgF7SgMBsBqJt3e1nMH+AXWpM2n5M5vJ6ySCVS0SQ6gxdoiI
         D+Vz3KZ0hmlesWiSA/IngK6t1yMsQcmq6H5TLlpCkzZtF+sAfosr9KpkynHtpBKwq7VS
         GLoFH093mbAem14YxFU+jWVsiLanVvmYVX25waYX2eZafZZIUXESTosUd2Oq+mhwT6KE
         DFWO6vdcB84fh2CYUtre/BRV5qGnoLxfl2hREphZC8Q8m4iPBusEVSAtzxRpIAKFC+MO
         xrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449536; x=1692054336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dL6AQetgHURU9peF5jMm+1QPkGPdtGd2X/zb9xq5Tzw=;
        b=KXs1Yv0xKPMqkzM9VMTNw46rhIAhkVIbYQErthhEHsLlHxjWmEwA99rceVOPJwtup+
         6IhXVMn67Mw6sexNw/sI8kv0oEWXBomS0+qzbzP9elpdEwPKtsWpBW3DYzr0UnZ8MLh6
         nH266NZvlHvL6b47h5JKRfRULn3k9vvbmHALeU9yFa2Oe6Pd9rtW5qh/ALs7/dscCJnU
         Li3fokFCkYQRTwBaK4LMQtsw93LgBDKBuEaHusJNHndHqXCriOKG9ThESfyqChb9aI+n
         lV+RlO66qjIgm9P6SNb5HKai3vuBoCdCm1aUmgk8YLZ/zvI0IxDryoqhdFYX/PZ7HXsf
         A5hg==
X-Gm-Message-State: AOJu0Yw8Lma43awVZDl7LQRPBCpdnyuq5wIOMKRPT1N7YOkknw0+r75a
        Ydgou8TBc0fOVUP4eeI9xKI=
X-Google-Smtp-Source: AGHT+IEvxj9+7jMT4q6zEzLr5Igqcb/a7jma6HML30e7U0QAJ8Bd3AhAgHjN0UpvuwRaK7JUtc9G0w==
X-Received: by 2002:a25:738b:0:b0:d09:7f94:6ea3 with SMTP id o133-20020a25738b000000b00d097f946ea3mr11456718ybc.65.1691449536455;
        Mon, 07 Aug 2023 16:05:36 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:05:36 -0700 (PDT)
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
Subject: [PATCH mm-unstable v9 09/31] mm: Convert pmd_ptlock_free() to use ptdescs
Date:   Mon,  7 Aug 2023 16:04:51 -0700
Message-Id: <20230807230513.102486-10-vishal.moola@gmail.com>
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
index 13947b17f25e..aa6f77c71453 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3001,12 +3001,12 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
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
@@ -3019,7 +3019,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 }
 
 static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
-static inline void pmd_ptlock_free(struct page *page) {}
+static inline void pmd_ptlock_free(struct ptdesc *ptdesc) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
 
@@ -3043,7 +3043,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 
 static inline void pgtable_pmd_page_dtor(struct page *page)
 {
-	pmd_ptlock_free(page);
+	pmd_ptlock_free(page_ptdesc(page));
 	__ClearPageTable(page);
 	dec_lruvec_page_state(page, NR_PAGETABLE);
 }
-- 
2.40.1

