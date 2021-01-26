Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172D93054E2
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 08:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317165AbhAZXdt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 18:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbhAZEsz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2021 23:48:55 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF94C061797;
        Mon, 25 Jan 2021 20:46:26 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e9so1518814pjj.0;
        Mon, 25 Jan 2021 20:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hrndBY8R68kIi1pHIRutw3ucH/2Px5UWTBnGPJp9HrY=;
        b=Kh7bj2IR06EDd1qGZ2t3ulwctmkhxiZs/U4o/vDOkXNuGmRG3EiJDvHyiw26B1KE/Z
         noBts4EDsXI7gbOV9ihyk6VX5ck9GK6f3W3T+PkS4vyUxs/Izt2qYf4wrsTriSkNDYwG
         8K64qbx5re/qJBgvVDx6ImIm0xTaeBPkbVaexUyy4H8+lhfZpXxpTjpmv0ChdfpA8/Io
         NHmwmR26KBOHb/8slnYFAfQDKthfgoKBFsrBMSh+pFZkalrdy1KqFxovgB07EJpTs1F9
         fV674H7DUCRmTRlID/NC6dsv8Uz5aa9E0xd99LlPyoF7PQxZswj7finw26pOve/Kewcd
         KSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hrndBY8R68kIi1pHIRutw3ucH/2Px5UWTBnGPJp9HrY=;
        b=e+MGO6l3fOdx5SLRGHRzNo+2ED+vRFkl4aPT+zmP9i4Ecd0N9rM9jWDTXDXtoaMqCg
         Sj0qaBV0Qk6nwAu7PFMusvSv1VrXtTZ0Goca8F/TLEblyv3zvxVUUuGnu2dWw/FmsUgI
         FlQcUc0JweTn26JiaOcUui+HPm1zb/oqgmlJB5WfVn7biEL7VTHpaLJlgjb3JO8BIsc3
         7r0oeUDfGc/4wUczxc8YeHiBJvJdtWU8KWtzguB3nJhfupi3gCKvAvo0tgRDLwIu//fW
         6wOoM3sElv/Xjat7TVf8OJeVcmA96c01CFI3x9gMxhx4hmBsVUlwGFun0r5PqVZ4GFfI
         dbKw==
X-Gm-Message-State: AOAM531/iAX0MuzPCWr28ESn6C7PdZaAper3HvTQ3LGTipsDDPQzlNgw
        uzwTFile4tam4KOYP58c2zg=
X-Google-Smtp-Source: ABdhPJwxZpxVcs5+yRJ6hGh8RKOyIh9OTe/nY1FORrQk/LwAUAC2vXL/Za9+EjHe6HQoxPwvXVNlgw==
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr3967571pjb.166.1611636385804;
        Mon, 25 Jan 2021 20:46:25 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id 68sm19272293pfg.90.2021.01.25.20.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:46:25 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 11/13] mm/vmalloc: add vmap_range_noflush variant
Date:   Tue, 26 Jan 2021 14:45:08 +1000
Message-Id: <20210126044510.2491820-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210126044510.2491820-1-npiggin@gmail.com>
References: <20210126044510.2491820-1-npiggin@gmail.com>
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
index f043386bb51d..47ab4338cfff 100644
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

