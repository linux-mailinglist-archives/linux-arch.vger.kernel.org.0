Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C42301A92
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 09:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbhAXIZP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 03:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbhAXIYx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 03:24:53 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B8C06174A;
        Sun, 24 Jan 2021 00:23:51 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u4so6595300pjn.4;
        Sun, 24 Jan 2021 00:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVhRROVZ7z046qTJ4ejm1G9xGCLJycEigvvpkf2Te7E=;
        b=LD1AJ6Q7eOjSujKmrwu2p/+JbN0Zfr5LtB3ZkyFdzthlHqp5+5bXxUIPms0GZPIEI1
         j8iC6ALOlnNPw7NvBm8g+wvNrzaRNyHGNbry4++c389NU654HOe92r7RSbw9ZyWG84gc
         kp2FgcVZUe9J6ouu30w7uKhA3EG4S+Ee1y+5Cad0k2E5Qg71u/s7n0t0KG/7ghJfui11
         M9VJFibtXnmgzbuQat5H0d9DFSHOp4Kj27NTnsD2LZk65R7tFL3xKYvKblgjj1omjdo8
         0laPVyur/H+mRgYddO4EAAw7KpMtM0p8cACx9kN1MlkXAqWRH/vc/B4wLdXNu0P0Y4t5
         Rsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVhRROVZ7z046qTJ4ejm1G9xGCLJycEigvvpkf2Te7E=;
        b=dKF415yVI94NvJTE2t58hRW2dGAyv+WwUAkYW9aW9hPFQ2y90FzXqJWr7pjfL5yziJ
         mRFcAsDU2wB0sfSIGXibwO0R2QJPjGMiDwFXNOPvblN63I7oYDiRJQSK80XE2TOIsf/t
         AEbqV4t9Z9oov2c3LYLBq+kwGr2rujK4N8SuUIehbEwb+KLLfGjGPp5ADMOSjF2Izi2p
         0BmvWChDsW2Nt6P2+dZTucW+kz3BfeOXugrHd6vSeWm53qy3Y2E194d+/DTAoTTKg87K
         NwKYn3HgrJJiG8DZivT+BFLAjEP2eCJugAl+tQ7bk+TIfNkHWIvOmnOEmnq2LOitkB9J
         lwXQ==
X-Gm-Message-State: AOAM531bltGWGPgIc2oDkf0MFtixUkaAkwn1IB70jAy74pPTV9BGtGpc
        60bEH2hVJU5tdTOQPQlWb08=
X-Google-Smtp-Source: ABdhPJwYhf2C3cY0UzUjCepD6a2ETZbd8HZtvD4C0FN52jeC88VQLzQc0VPtpNQam4pZa9M23WLv4Q==
X-Received: by 2002:a17:902:bb8c:b029:dc:2e5e:2b2 with SMTP id m12-20020a170902bb8cb02900dc2e5e02b2mr13915452pls.10.1611476631232;
        Sun, 24 Jan 2021 00:23:51 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([124.170.13.62])
        by smtp.gmail.com with ESMTPSA id gb12sm11799757pjb.51.2021.01.24.00.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 00:23:50 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: [PATCH v10 10/12] mm/vmalloc: add vmap_range_noflush variant
Date:   Sun, 24 Jan 2021 18:22:28 +1000
Message-Id: <20210124082230.2118861-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210124082230.2118861-1-npiggin@gmail.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

As a side-effect, the order of flush_cache_vmap() and
arch_sync_kernel_mappings() calls are switched, but that now matches
the other callers in this file.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5d79148b7fa7..0377e1d059e5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -235,7 +235,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	return 0;
 }
 
-int vmap_range(unsigned long addr, unsigned long end,
+static int vmap_range_noflush(unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift)
 {
@@ -257,14 +257,24 @@ int vmap_range(unsigned long addr, unsigned long end,
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

