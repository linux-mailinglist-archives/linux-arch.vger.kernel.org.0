Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B7A773439
	for <lists+linux-arch@lfdr.de>; Tue,  8 Aug 2023 01:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjHGXIh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 19:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjHGXHc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 19:07:32 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D017198D;
        Mon,  7 Aug 2023 16:06:29 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-585ff234cd1so54757857b3.3;
        Mon, 07 Aug 2023 16:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691449578; x=1692054378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yb5+fiX/YSPgeVruPImZCslC+7XzLtSDmAZ+KnCCvCw=;
        b=LURal4KqklmU9AiCOifU5Mxc6WM+IybZMw4f+H9b+ehsvWfF2rdEGUCUpHED/xgeP0
         03+is7BherE6vDUPF9cInwhZZ6O6FVEP73Sri7+CBG0/7jN64G4bgtBq56ZrcLUBIxxT
         uSfx8fFqjmiqF0MtkULVgc1gjFJH4lOvkwRfZt9wzMVRnizjKRrxJwuFQ2mIfEo7cHgy
         UR2ZIO+mIWR9RWU4d+HJedZnPKiZaDv8i4STB2D6+pQaLcMt/pvWXKdhAwPxBTPHyGDc
         YUL8XwwyvOUHrQNxNKfZS8WVqZrgPXs80ZLFz3I7kRgWNiGS07HTyMzLuT9V1dLH0d1v
         g2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449578; x=1692054378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yb5+fiX/YSPgeVruPImZCslC+7XzLtSDmAZ+KnCCvCw=;
        b=W5+LP1+7zjfJ2zqv4JMsmC8EkG8kapuuQIc3Ev1iOr0QqdB/eOMI0pxw9RX4iPzSej
         vI8zGcZHggv2YNUe0aiB9cI5LuqWHkKel/HZsCPjySf7Q3b20hFdDzps6hbjflHIAsIP
         kBiFH+a4OTApK8wTqc35dGm1csXccKLagdB1vQk4EQXp7jGzIuBFNji4E4QyLfT/bZR6
         avBKHvDoLMZzB9cHGQ7ylP6JHXfT8FvTNf6WKRqgOEUWJJ23Sn1LCSKGGG80yDFOIZsr
         neE5fyhinAU3Gq1w6BFs4kd1dGjX6slO3rC0/hR08RbS6DOFqjT2H0ctfNA9g/JPcnnG
         FcDQ==
X-Gm-Message-State: AOJu0YzKImx9dElVEUJPfwlVnVd6QgwY5tbdBSsCiT59z+G0EnxIJfWn
        E82BMgM359sAHdpqGGtOniw=
X-Google-Smtp-Source: AGHT+IHSK0JHQfLZYNqZB3BuP0bNBVURutz2ITpQB4n2EhlNMl4NfRND8wevRJ4hRdMY0+rsbG2z6w==
X-Received: by 2002:a25:ac04:0:b0:d0a:8269:e5d9 with SMTP id w4-20020a25ac04000000b00d0a8269e5d9mr9659872ybi.60.1691449578542;
        Mon, 07 Aug 2023 16:06:18 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::16])
        by smtp.googlemail.com with ESMTPSA id d190-20020a25cdc7000000b00d3596aca5bcsm2545203ybf.34.2023.08.07.16.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 16:06:18 -0700 (PDT)
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
        "David S. Miller" <davem@davemloft.net>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH mm-unstable v9 29/31] sparc: Convert pgtable_pte_page_{ctor, dtor}() to ptdesc equivalents
Date:   Mon,  7 Aug 2023 16:05:11 -0700
Message-Id: <20230807230513.102486-30-vishal.moola@gmail.com>
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

Part of the conversions to replace pgtable pte constructor/destructors with
ptdesc equivalents.

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/sparc/mm/srmmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 13f027afc875..8393faa3e596 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -355,7 +355,8 @@ pgtable_t pte_alloc_one(struct mm_struct *mm)
 		return NULL;
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
-	if (page_ref_inc_return(page) == 2 && !pgtable_pte_page_ctor(page)) {
+	if (page_ref_inc_return(page) == 2 &&
+			!pagetable_pte_ctor(page_ptdesc(page))) {
 		page_ref_dec(page);
 		ptep = NULL;
 	}
@@ -371,7 +372,7 @@ void pte_free(struct mm_struct *mm, pgtable_t ptep)
 	page = pfn_to_page(__nocache_pa((unsigned long)ptep) >> PAGE_SHIFT);
 	spin_lock(&mm->page_table_lock);
 	if (page_ref_dec_return(page) == 1)
-		pgtable_pte_page_dtor(page);
+		pagetable_pte_dtor(page_ptdesc(page));
 	spin_unlock(&mm->page_table_lock);
 
 	srmmu_free_nocache(ptep, SRMMU_PTE_TABLE_SIZE);
-- 
2.40.1

