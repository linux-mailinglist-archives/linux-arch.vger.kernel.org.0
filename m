Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C7D24CCF0
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 06:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHUEpH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 00:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgHUEpG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 00:45:06 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD55C061386;
        Thu, 20 Aug 2020 21:45:06 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so428851pgb.4;
        Thu, 20 Aug 2020 21:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8C8wdRPXIlS04tUD/986mX054vDuu2PdIQ/xTcAZZAA=;
        b=J4ddgUzasDXInj6ZCF2fxwiLsaEtScdGAOu8lOPhDFaYakCO3NrGk1LBxDUoJ2mXDg
         Cl7ESjYKzCuQKNbvsXKKZvD2eOHZhUqWcZF5TMNmPbRLGU4MsaPYfq+QCQcLA8q9W26z
         hs0tBFGG6129YBPGD1vMB9R7gD0+37YOzqN4rBxndaMqpt0WgDpXD19Gspzzq2JQo3gA
         mqxkfxRpdKad9bmkpLvHnAPblr3MCauTS/S9XUd5dMBBYpocjBbgU1hNHm7zJBi6Okwm
         3b89yZyODzFGBBBHGRL6KzHhFuU/alVEYGDYpKF20JifG2kUrdfIClwhUGnoMUoqi0ys
         PZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8C8wdRPXIlS04tUD/986mX054vDuu2PdIQ/xTcAZZAA=;
        b=tTpo3PaxFqPqwsNT7F/bnCMbTnZ1S0tS7irn072RbTibsjivETAEKBV6CpPSfvfwpp
         0wNvR/9o8gmhmR5x4eos5BwSdPoEzhvrnhGjJxPLCGw3djOG/jltj7dHbD3eYTwLrA3y
         BDj3NWNVfXQgKKCotGQc7Sj1kvDKiDy8pmQ4sZu1a+XDMsSqYrb3y6/7gtUVv2LZg28C
         3tNu3uf7RVIPEIQ2ERuljZZ8TbgETEOSxpvQcliJjUSLCPaeT+u8bRx+JDIlhkFYqYoa
         ZH6Yz4S4+pzGIptTvRvTf6ek06YTTI+UCrguxBKp4NBaeoGD7LKJIqV/b872I3mnfhDe
         2EmA==
X-Gm-Message-State: AOAM531Y6/Mq0r2+R5S7BB/FYPeLja1Z4hGOtG1PKxsJBUik+GCUEGE4
        wRDcKFsZ6iUnfDvLsBGhnTY=
X-Google-Smtp-Source: ABdhPJy7zCMoLaQ0q66stfVNfIyt+ykygBNPJfPuPBH8S4/UD8Lo5p19sMJZjysKorBqq4yJjZdPbQ==
X-Received: by 2002:a63:b24b:: with SMTP id t11mr1038962pgo.233.1597985106002;
        Thu, 20 Aug 2020 21:45:06 -0700 (PDT)
Received: from bobo.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id l9sm683374pgg.29.2020.08.20.21.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 21:45:05 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v5 7/8] mm/vmalloc: add vmap_range_noflush variant
Date:   Fri, 21 Aug 2020 14:44:26 +1000
Message-Id: <20200821044427.736424-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200821044427.736424-1-npiggin@gmail.com>
References: <20200821044427.736424-1-npiggin@gmail.com>
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
 mm/vmalloc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 129f10545bb1..4e5cb7c7f780 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -234,8 +234,8 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
 	return 0;
 }
 
-int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
-			unsigned int max_page_shift)
+static int vmap_range_noflush(unsigned long addr, unsigned long end, phys_addr_t phys_addr,
+			pgprot_t prot, unsigned int max_page_shift)
 {
 	pgd_t *pgd;
 	unsigned long start;
@@ -255,14 +255,23 @@ int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgp
 			break;
 	} while (pgd++, phys_addr += (next - addr), addr = next, addr != end);
 
-	flush_cache_vmap(start, end);
-
 	if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
 		arch_sync_kernel_mappings(start, end);
 
 	return err;
 }
 
+int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
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

