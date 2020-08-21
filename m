Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD924D82A
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 17:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgHUPN2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 11:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgHUPN0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 11:13:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BAEC061573;
        Fri, 21 Aug 2020 08:13:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 17so1200478pfw.9;
        Fri, 21 Aug 2020 08:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ik3l57t0FyOClvLjEe+sb/BhE/y0hhY0gnEqux751Uc=;
        b=u6yhubFcXihID2fWq+QiE0CcG9dvjSoF59E015bcoBinPTWoTc6VB4OCRmb/y5KRsT
         qJkbjXob1gFUX91mcQBSG3U26lx8vo9W5U8g0dpaAxpbW8ExWeJzgZEfBwuwalftHFZn
         0wke4MbGjU2ojD8aQbwZOkVbPO2SYtKoHSz12zM/hQNNjeYeWZF7jE5g2AHPO0aB+DYw
         8C6ylDWaxR7KccTt7GD+eLNOYbuhrkEsjTe/Yv3CvgZ8RSQ10W7DxFdo98xlAAYx2wTT
         XzgU57hcg/H50XvMaweP1v5brBYXdmpavwyQpD5YyHUNi2KfejW5mx/+gd2ao61mGiJ9
         ZR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ik3l57t0FyOClvLjEe+sb/BhE/y0hhY0gnEqux751Uc=;
        b=cWREY1nnVyUs7RlJQkXnq8v7+5GND4hxqmWaMFQ8HLyrmFHMArFCZsdxa+IwRYdthe
         IUMfqtYSYIawuUEt+bRCjYYqRK3ucJsn+nrQCp/YadMWMtVvademYw2YO/p6PE0Et6CK
         i2UVimpUZAaZAo70zqlTySnE3amjtKGtTw5VEFuwuC1ueaayk3gMtiMfb1Pz0SnETfI2
         lcCBjfmr3VvupzlBBBE41ZdgfYgr11ENT78Y43fxgiV7UeFNkYVHw/BSvzTEKqYLAn+g
         3xZWbnT1EIMGmnYRA0Ws6nkcOVvWh2YJ2exl3GdgdzhU3AWtWeQKC4RoGpne2yyldbS7
         TJOQ==
X-Gm-Message-State: AOAM533ErKyjqW9Q6S/VvtpF1DuwdkVCmgP5gTmkckknEjwFDL4qw/9K
        sJMz2dzey1IcGxb4H9Yrl3A=
X-Google-Smtp-Source: ABdhPJzOk8LezUqei41Rt5u2ralsl0Vc1m91oWRQQQjcIB5tNWY2WeZkdOIgpy1cX1Su0SK2t1NhyA==
X-Received: by 2002:a63:5256:: with SMTP id s22mr2774026pgl.325.1598022805468;
        Fri, 21 Aug 2020 08:13:25 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id s8sm3126985pfc.122.2020.08.21.08.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:13:24 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v6 10/12] mm/vmalloc: add vmap_range_noflush variant
Date:   Sat, 22 Aug 2020 01:12:14 +1000
Message-Id: <20200821151216.1005117-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200821151216.1005117-1-npiggin@gmail.com>
References: <20200821151216.1005117-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
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
index 256554d598e6..1d6cad16bda3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -237,7 +237,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	return 0;
 }
 
-int vmap_range(unsigned long addr, unsigned long end,
+static int vmap_range_noflush(unsigned long addr, unsigned long end,
 			phys_addr_t phys_addr, pgprot_t prot,
 			unsigned int max_page_shift)
 {
@@ -259,14 +259,24 @@ int vmap_range(unsigned long addr, unsigned long end,
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

