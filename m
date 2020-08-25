Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1ED9251BAA
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgHYO67 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgHYO6y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Aug 2020 10:58:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABFBC0613ED;
        Tue, 25 Aug 2020 07:58:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id z18so1389948pjr.2;
        Tue, 25 Aug 2020 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ik3l57t0FyOClvLjEe+sb/BhE/y0hhY0gnEqux751Uc=;
        b=jFDbXQGWGSUzk7/GJ+Z/Evd9q3iiU/BfiaMC4g83Na9QhLkZaoeFiiSi/FDNx+q0/o
         JzPfzJTgJWm/P9pW+kiyHgiJ3OxnIaNeOA/VQFt0osyMoqtV8dJGZoFOSLHI8ZJp2LQG
         uXQsCruf53J3N+40TqcYQYhQU5JOrltFKObIJtcT8dIGteWrwQ63Li+XqNWXfO/8TIcX
         O5Y3C++e90X5Ov1fyAwEZ0Pw1S8c0WlG2BrKjPLNiDRIjxzpQXbwnzWTA+RXKohUt+G4
         zwS57mS4cvrbf9wiDvxEB6b1vNXZ5voiRSKhtoS77rvCe8CCQIRYn7SJtz8+EOdXbboI
         nZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ik3l57t0FyOClvLjEe+sb/BhE/y0hhY0gnEqux751Uc=;
        b=cO+bMI3d8A/OYjv5+qnWJoTUQBKNyN2Km99P5Vz2PN5FQk8hnjNnQ9W5uoYoZ7Jrhx
         IavzOCbozQpIPP004b35FVdEByEeW3ezn9blBYzTticmatp6ZMbv1EVC8v3xdu/uphRN
         jKV7yUbwKrKXcyN3nHork2dzhsf1cjvzEDfXaGI8p+8gnop0WJotXNyZhWrFKGPocouC
         U4aJmQRJnK3c+nQwXmbn4yj6PJd6y5Ii1ZYq0dzrzyuwkoZ9AW0VKQSHeidO5CJpwXt7
         H39SfDPut0XafippfGHpFsZQzS/GkIVXET2e0rq/3PRIlT4aFTPXvqKpfsgpew77acSx
         FrKw==
X-Gm-Message-State: AOAM531qPyRSTweYVOtcuPhpJLX/4zzi4Z3tvC1Es00claEu39FiaWVx
        AsMT24j1tToW/mvyfRH1MMo=
X-Google-Smtp-Source: ABdhPJzHo6/7MAKEoI/XmiBkadcGmQ+3ea7nzB3CCBEUR/YsmN15UifwlOMYYbga1Z5fsGVrMds0VQ==
X-Received: by 2002:a17:90a:a101:: with SMTP id s1mr1788302pjp.205.1598367533484;
        Tue, 25 Aug 2020 07:58:53 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id e29sm15755956pfj.92.2020.08.25.07.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 07:58:53 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v7 10/12] mm/vmalloc: add vmap_range_noflush variant
Date:   Wed, 26 Aug 2020 00:57:51 +1000
Message-Id: <20200825145753.529284-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200825145753.529284-1-npiggin@gmail.com>
References: <20200825145753.529284-1-npiggin@gmail.com>
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

