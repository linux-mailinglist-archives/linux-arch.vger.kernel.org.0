Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A79A304DFB
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 01:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbhAZX3K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 18:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbhAZEqZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jan 2021 23:46:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41027C0613D6;
        Mon, 25 Jan 2021 20:45:39 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s15so9130108plr.9;
        Mon, 25 Jan 2021 20:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5DEowptUwTfPDCMussMIbiVZhaeAlKFwS/BCdRa1CbQ=;
        b=XJK7tG9SvtTGxWs3TOVQ6fHZwRaw5VyqizXAmj67yIEfyHNbc3e9UCyfIF8qPyusjA
         rrC4odf7MiUP9VqOLP2v6acz5sT2GmevGHRV6OiP11IBbKReyvlt0KxzOEz9BkfACiLv
         nTWhm93X0gCoNhFUHbYf7axau6wnKMI82qDpU8OMNlK3zxM7YZ4XAnBBuWEWqKmv1fMH
         J7Ev+wzH5EuiNl17/i3hfjWd0OqOBOLn/TLm/xdsFYktFp6wfP2J1Qvd0/u7C3plfAdq
         1hibv5GoG5/ajjgyjD9i0Q3inKGfesOBEL516Hoxs3sH0uZK9HoMF29D+5Vn7F6lIn8A
         SOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5DEowptUwTfPDCMussMIbiVZhaeAlKFwS/BCdRa1CbQ=;
        b=COZKBZ3ktMU7ovsGYqHKW1EtZbbUTpx54/JMJ+1NrexXd1i12ctmtVlsc4fOdjuUb4
         HFIS+9d9OII0sBDCQZXqZKImoRKzMfW+ZMQSxHx8jp3j8wLG2ekpdSPuT1BCW5Y0a8xH
         F2A6nU+fMNz3+53ICvU35r9yw8rhe66r8lhe7Linjox4pDtJJC8Bm5bkZOaeoUOFsIAu
         6CeqzpahMuAZUQZ5wCkkkWxjXx9NnscsXX+l9I0vn8XaJ6FFQvujrDDWJjCtSe5u2J4M
         gr0TKFpPF4Lm09jV7c7ar+4L5GsLqaaeg5qu16207UVnWOLOrIUoXvQm4WuVu0fAMoRV
         7+qg==
X-Gm-Message-State: AOAM533N3Wd1JzSeEAMrj3HiUBZZUo1Dn5cG1bxiW1foOZ9w5ELWuIOs
        AyT2d0F03cLR36eb2+Quhl4=
X-Google-Smtp-Source: ABdhPJyUK0q6PQk//45Rqh+tNd1BCuCVLTelVDJer0Preys832RKide+3fnd1LhVRvhDXW9RWBXjew==
X-Received: by 2002:a17:90a:77ca:: with SMTP id e10mr4080733pjs.53.1611636338859;
        Mon, 25 Jan 2021 20:45:38 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id 68sm19272293pfg.90.2021.01.25.20.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:45:38 -0800 (PST)
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
Subject: [PATCH v11 03/13] mm/vmalloc: rename vmap_*_range vmap_pages_*_range
Date:   Tue, 26 Jan 2021 14:45:00 +1000
Message-Id: <20210126044510.2491820-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210126044510.2491820-1-npiggin@gmail.com>
References: <20210126044510.2491820-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The vmalloc mapper operates on a struct page * array rather than a
linear physical address, re-name it to make this distinction clear.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 62372f9e0167..7f2f36116980 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -189,7 +189,7 @@ void unmap_kernel_range_noflush(unsigned long start, unsigned long size)
 		arch_sync_kernel_mappings(start, end);
 }
 
-static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
+static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
@@ -217,7 +217,7 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
-static int vmap_pmd_range(pud_t *pud, unsigned long addr,
+static int vmap_pages_pmd_range(pud_t *pud, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
@@ -229,13 +229,13 @@ static int vmap_pmd_range(pud_t *pud, unsigned long addr,
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
+static int vmap_pages_pud_range(p4d_t *p4d, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
@@ -247,13 +247,13 @@ static int vmap_pud_range(p4d_t *p4d, unsigned long addr,
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
+static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
 		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
 		pgtbl_mod_mask *mask)
 {
@@ -265,7 +265,7 @@ static int vmap_p4d_range(pgd_t *pgd, unsigned long addr,
 		return -ENOMEM;
 	do {
 		next = p4d_addr_end(addr, end);
-		if (vmap_pud_range(p4d, addr, next, prot, pages, nr, mask))
+		if (vmap_pages_pud_range(p4d, addr, next, prot, pages, nr, mask))
 			return -ENOMEM;
 	} while (p4d++, addr = next, addr != end);
 	return 0;
@@ -306,7 +306,7 @@ int map_kernel_range_noflush(unsigned long addr, unsigned long size,
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

