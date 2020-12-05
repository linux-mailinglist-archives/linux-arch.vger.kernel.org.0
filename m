Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1E72CFA25
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 08:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387485AbgLEG7T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Dec 2020 01:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbgLEG7T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2020 01:59:19 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04DCC061A51;
        Fri,  4 Dec 2020 22:58:38 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id t3so4928573pgi.11;
        Fri, 04 Dec 2020 22:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxeoavWkBKpHEVfZRK3a60KePQvEOREDyC26QCPQwGc=;
        b=ukqOtiGe7P2XNpwcoCHPv4PLVVLigIR0wfkbWLYHCk03Qwl78XRRc25X9C1RXu0jHe
         71KyORclr783FXhdRwXEwnRYE8V5N9Dlyrpf+r1au98v+1tkhP1N6fl1HslUf7ZQ6F5a
         XTq1ZFQ+e2jvjUGVPu2b86zd+bEI1VIn6WCJ/qjsEj8yxdBoHFWiVg+eMQZWOAY5xRFj
         C11oel1teBnWh8SCk/mPyWyo/bfzkUXfP4dXdfU1VwuAWLs0NLmFg3F0v74OQujpFaki
         9EIdB0FMiyQGzJUoI3N8vq5BLpK4IyZzsPMZT6nSzTsZ26MvND8g+ErfJa8+fsz1pJ2o
         6LkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxeoavWkBKpHEVfZRK3a60KePQvEOREDyC26QCPQwGc=;
        b=GMvY70pr+9C7mTD3zj+lNuLn0/VKKWVaPYQ3+6uBqDyuq9r/IYXUE39jwozmECq6kG
         CTEBCv4q3sYKl4II1oqrroYwvD8gUwNT3pnUF26qRbXoFZBESgCdecd9iiGL+K6FJhUU
         4AbkSEoI7Xb7lYdgGvvsJl4IZvXsrCDbbaKocK6Rzbvz6gPwTk0kWwu3ReXqXPFrfIRw
         1ZpDEgKgB41hT3l867/fcGmZtWWz/Z79+Cy1cb3JQAr/SDc1kKyMbZcRW8F8iIGGwU3F
         zgp18e8+DYdaYZkAr/D3xB/fYxq73mF+huvmr61bkef+DHrKWV+nYwC3bOhFR+hMgEKA
         1mzg==
X-Gm-Message-State: AOAM531Us6nqTyXRzRO3C4LuH10Uf8hbS7UmRQTlIWCuSOTz+YyGi8vd
        lJ5aj//Fd7ij9ekELYOHiBA=
X-Google-Smtp-Source: ABdhPJy4ceoebyQbTqB4fE0S1EBU/ZP1A2fSE/NXY9uIYYRFQfIy2FdDgibtFhuJU5XMFvZqvTYP+Q==
X-Received: by 2002:aa7:8052:0:b029:196:4dbb:99fe with SMTP id y18-20020aa780520000b02901964dbb99femr7374783pfm.11.1607151518507;
        Fri, 04 Dec 2020 22:58:38 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([1.129.145.238])
        by smtp.gmail.com with ESMTPSA id a14sm1110848pfl.141.2020.12.04.22.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 22:58:38 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v9 10/12] mm/vmalloc: add vmap_range_noflush variant
Date:   Sat,  5 Dec 2020 16:57:23 +1000
Message-Id: <20201205065725.1286370-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201205065725.1286370-1-npiggin@gmail.com>
References: <20201205065725.1286370-1-npiggin@gmail.com>
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
index 2f236aeeac24..ee9c3bee67f5 100644
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

