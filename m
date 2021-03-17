Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B7333E9B2
	for <lists+linux-arch@lfdr.de>; Wed, 17 Mar 2021 07:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhCQG0D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 02:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhCQGZo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 02:25:44 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423C8C06175F;
        Tue, 16 Mar 2021 23:25:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id h3so407343pfr.12;
        Tue, 16 Mar 2021 23:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xD9CZCqfp6oOH0TENXfs67JbMzL04aaTtGQqYYdMF/Y=;
        b=ABPFYdpLbjkf6zwF7B72Zaoi9pvfhFCoeGzDoVnTUKtm1yxN+kjAmc19B52QXi3lvF
         wyZ8mEa7+Z+XStechgQYeu68Oxg3e6YrtrwlsgauDrOgV9/dLSYi6EFh0iLlvJi+xK1c
         kemMMu3Tm1xpoSPk3gB/phos27rP+OAcxHQ7tcFYNsjL2aTUapJFt6H4vDw+e4jgSoVh
         P1wUghjc6pah1T5/sOy26izKRVqvDKRh/l814l9hBzcXarn1BgQaL9gXxk9vF27KrvXd
         mAk8GKmMdZJbjov4CW8U/FxCgsvHMrxt70JhlVODRNo20Owg2NoTAnmKZfgZjc9cIdVf
         axog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xD9CZCqfp6oOH0TENXfs67JbMzL04aaTtGQqYYdMF/Y=;
        b=eEQMzNS5PPBxaZl0KFkJlO5pznZw+tnRPo3u9a8IVadJB9uz5PMo+vu3VatWgdv+5R
         czpr923ySFkXu4UZUvbnRuNxL3AeNqlnnNxn62Vf+P4g8+QNLCNxo/LCO//RPnQLcaJ0
         e/QuXGLZudyVLcKIMcOnoTrnsWnZAyMe71reUl6+eTWY9Sgk+JNR0TPvlEzr28a0WwEH
         0WSFAT1QtRz5ITvdCaMdwKOokrB8iAp+udg0/sHzFKwIwd3SES5Vt4m7wddrzopImGvp
         0YoASsIRQBP5QgU6mVnxjnW/GIVhBa2NxQuD4LcCiBczDFtRVHo4zCY/Xsz1SCJlMBnQ
         cw1Q==
X-Gm-Message-State: AOAM533Y5FaNhueXcyDXw/hm2Y4J+hoNwBOYJT7g/+dkYK2rI/ffAOTf
        G9x0ah374a7I62t/vHJRTAk=
X-Google-Smtp-Source: ABdhPJwLFoYHkHHTweADUvQkyZeGoreDRgE78Md0c3eS25/BwdXU+gAdtbvWckprWOjaLchflfPI+A==
X-Received: by 2002:aa7:991a:0:b029:201:b736:c556 with SMTP id z26-20020aa7991a0000b0290201b736c556mr2961901pff.8.1615962343854;
        Tue, 16 Mar 2021 23:25:43 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (58-6-239-121.tpgi.com.au. [58.6.239.121])
        by smtp.gmail.com with ESMTPSA id s19sm17959620pfh.168.2021.03.16.23.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:25:43 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v13 12/14] mm/vmalloc: add vmap_range_noflush variant
Date:   Wed, 17 Mar 2021 16:24:00 +1000
Message-Id: <20210317062402.533919-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210317062402.533919-1-npiggin@gmail.com>
References: <20210317062402.533919-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As a side-effect, the order of flush_cache_vmap() and
arch_sync_kernel_mappings() calls are switched, but that now matches
the other callers in this file.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 53414959845d..9455dba58b0e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -240,7 +240,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	return 0;
 }
 
-int vmap_range(unsigned long addr, unsigned long end,
+static int vmap_range_noflush(unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift)
 {
@@ -263,14 +263,24 @@ int vmap_range(unsigned long addr, unsigned long end,
 			break;
 	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
 
-	flush_cache_vmap(start, end);
-
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
 	return err;
 }
 
+int vmap_range(unsigned long addr, unsigned long end,
+			phys_addr_t phys_addr, pgprot_t prot,
+			unsigned int max_page_shift)
+{
+	int err;
+
+	err = vmap_range_noflush(addr, end, phys_addr, prot, max_page_shift);
+	flush_cache_vmap(addr, end);
+
+	return err;
+}
+
 static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 			     pgtbl_mod_mask *mask)
 {
-- 
2.23.0

