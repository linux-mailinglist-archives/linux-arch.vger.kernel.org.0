Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51524CCE7
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 06:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgHUEow (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 00:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgHUEov (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 00:44:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED1DC061385;
        Thu, 20 Aug 2020 21:44:50 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q93so412667pjq.0;
        Thu, 20 Aug 2020 21:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xoa50mjKdO+6rEo7JFgsM1iktECeAufQruBypQNx5uU=;
        b=cfi4mDOu03twyolblqmsiXSKLkWdrtP6DA32thuCHNC6mXen19Y+kwOWy25uSRuyAd
         Qa0bgRVU3+eP/5sefkTIIsZIeICp6AU1QK0DB6FIFGeK5xh2hEnGZU+nYr/VrW2rOUfc
         tV5MSHrfgtsv9vIlRDYAj4TdoEsWMfrh9gSbUHA0xIpWXvKqPDXaYOHOJj2GR400bxdp
         yTbeKz7R+/C0ewTgjav45Loptie3gcboNCy1eomfzJUs8waTkOxkU17vfX8XSv0uSzcC
         rNi2y4c5u7tA/ioI4pvh9ypWxzu1bFTMZ/o1CyfCiOAs420mJoSXUtb6Zc3TecHWn8CH
         sSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xoa50mjKdO+6rEo7JFgsM1iktECeAufQruBypQNx5uU=;
        b=J2EeooHv+hO1JEAwirJSRBEM2ydBfP0O2SpmmTC+0Eb5sB3xBrhyvFWxi0C1oXN5e/
         suqppc208nSOcS5+pwV8M+8NitYEb7VE9YbaVCrGbs47o/r9ozBldbce12sPw2mKRYff
         LhI0ztdEHFn9kqCiClnsBWBu6uVUaTdMWvK8YHxbitezVV2vUbuDIJN5zvaPqZGc0LJs
         vaXh20Abe11UDXPs9wEiCN4rY+5p30xUIc0Vv1kXVykdY9AHFR7l32h80/vYrZyW6j3T
         zroDVrKBpOI/cEBHrygg0f3/i/kQxMFyOQDqUNpwTRex5i92YtsxDFkxqNZNd4eRNaY+
         pHMA==
X-Gm-Message-State: AOAM532fpC119KBi/WWLtRNKV6XJB7orewGIBDzu6zNujONgQsncrzyF
        PJRE6jO4VzJ8JHuJcWBEH1oGCn8Wif0=
X-Google-Smtp-Source: ABdhPJxPggI04ETKTB3DdnitxxNiKgH+fgh1eKljj6tsD8xS6vufzUeeuZNnWtOgyMzr1fIMfPln9g==
X-Received: by 2002:a17:902:8491:: with SMTP id c17mr942848plo.93.1597985089799;
        Thu, 20 Aug 2020 21:44:49 -0700 (PDT)
Received: from bobo.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id l9sm683374pgg.29.2020.08.20.21.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 21:44:49 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v5 3/8] mm/vmalloc: rename vmap_*_range vmap_pages_*_range
Date:   Fri, 21 Aug 2020 14:44:22 +1000
Message-Id: <20200821044427.736424-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200821044427.736424-1-npiggin@gmail.com>
References: <20200821044427.736424-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The vmalloc mapper operates on a struct page * array rather than a
linear physical address, re-name it to make this distinction clear.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 49f225b0f855..3a1e45fd1626 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -190,9 +190,8 @@ void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
 		arch_sync_kernel_mappings(start, end);
 }
 
-static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)
 {
 	pte_t *pte;
 
@@ -218,9 +217,8 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int vmap_pmd_range(pud_t *pud, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)
 {
 	pmd_t *pmd;
 	unsigned long next;
@@ -230,15 +228,14 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = pmd_addr_end(addr, end);
-		if (vmap_pte_range(pmd, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pte_range(pmd, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (pmd++, addr = next, addr != end);
 	return 0;
 }
 
-static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)
 {
 	pud_t *pud;
 	unsigned long next;
@@ -248,15 +245,14 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = pud_addr_end(addr, end);
-		if (vmap_pmd_range(pud, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pmd_range(pud, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (pud++, addr = next, addr != end);
 	return 0;
 }
 
-static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
-		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
-		pgtbl_mod_mask *mask)
+static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
+		pgprot_t prot, struct page **pages, int *nr, pgtbl_mod_mask *mask)
 {
 	p4d_t *p4d;
 	unsigned long next;
@@ -266,7 +262,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		if (vmap_pud_range(p4d, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
@@ -307,7 +303,7 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
 		next = pgd_addr_end(addr, end);
 		if (pgd_bad(*pgd))
 			mask |= PGTBL_PGD_MODIFIED;
-		err = vmap_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
+		err = vmap_pages_p4d_range(pgd, addr, next, prot, pages, &nr, &mask);
 		if (err)
 			return err;
 	} while (pgd++, addr = next, addr != end);
-- 
2.23.0

