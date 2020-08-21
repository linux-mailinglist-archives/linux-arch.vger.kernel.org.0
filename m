Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFDB24D839
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgHUPM6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgHUPMp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 11:12:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6759C061573;
        Fri, 21 Aug 2020 08:12:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y206so1193981pfb.10;
        Fri, 21 Aug 2020 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sv/9eriXs4YMtuUqEg5bncZ0rlcJBEbL+hLm5+QBb40=;
        b=GSNKWe4sKvin/No7SBzCc6TLryWUHXwgfTbEx2FE6v6Qty5pCQrFFPx5gnqy/TMrZ0
         FhhPfnO1bjKpB4mpbA2Zbxb9SnDJDwQaEqzIh/veS4HnSfjR3rbv9N9XL2owb+is8FBp
         U8tWqJVuLXxEfds8/KLwA4IOscmZGRMKdB06OQO7XdHheYKQrpMNaMFkXftauA9SdKrT
         lW1CdeEv5KN8HhDLkiTqMOuJxGW/FRMC5XelBXGxC4PtVgAegGzDna0egFgASOCs/cMD
         9ZO6lXh6LIZdusjsisbkJtFSMIfznqn5HCpt0SnfiGnceZS3t5zZrhGdIB1XZ3XVbxe3
         86KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sv/9eriXs4YMtuUqEg5bncZ0rlcJBEbL+hLm5+QBb40=;
        b=KssuQuKiSATNxvEiXxzg3R+Vje+et5IJQ5wdhaLOKfRYHTGI8rSG0TnjhiNgDUihjs
         eUbkt+HWnqpOCGenNhsKmHY1GS106dVSJb/Jx9AtGoxCPYDDlbQh9dF8MPqVFGGLX8QY
         XD9wA1g/h+AepqPnsuraNHBDfuFF0hjI7NYnXJvsvYN1zrwI65Bj0oVy3y9n+K7TzjRB
         913WsjFZ9Qk2qKExVG3+B/B8XoWiZgCuEy/mmLkC7W2zO0/PRMjDNYzSU/JBJCdkc3hA
         MsgBlzw2vBEvJ8SCPv3huuzBJ5GAUpfQt/L7GfYkxoEpCIqQNIztcTPvIc7djnpXfrXh
         PoOQ==
X-Gm-Message-State: AOAM530ipfe8ZCtKdKIAlx8qLMy4WhNou31Epfzoi0fG0A0cK4ydNmm/
        zNAdGJbwQRPilsN2dPYs+rw=
X-Google-Smtp-Source: ABdhPJyVcrLzuP+hh//+EDBR3EBQ4EbV3sHIVDVex2GP8JpaDxXcsB6PkbGOFarFI53/CgzL2OUHFA==
X-Received: by 2002:a63:af51:: with SMTP id s17mr2699253pgo.286.1598022764313;
        Fri, 21 Aug 2020 08:12:44 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id s8sm3126985pfc.122.2020.08.21.08.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:12:43 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v6 03/12] mm/vmalloc: rename vmap_*_range vmap_pages_*_range
Date:   Sat, 22 Aug 2020 01:12:07 +1000
Message-Id: <20200821151216.1005117-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200821151216.1005117-1-npiggin@gmail.com>
References: <20200821151216.1005117-1-npiggin@gmail.com>
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
 mm/vmalloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4e9b21adc73d..45cd80ec7eeb 100644
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

