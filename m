Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4179D30BC92
	for <lists+linux-arch@lfdr.de>; Tue,  2 Feb 2021 12:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhBBLGd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Feb 2021 06:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhBBLGW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2021 06:06:22 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61502C0613ED;
        Tue,  2 Feb 2021 03:05:41 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o16so14673438pgg.5;
        Tue, 02 Feb 2021 03:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySt43gO6smkJkMCT6Ltah9Oe/TqPH3vOFFL48JryRJY=;
        b=Ski/mw3ycAZzNEp1UFr21+Cp/tNP720PSzUmqurvkfBxoQDFOdHtb4Yi9eWBxNV6x6
         +MRDgMmXeeeNXkN7h69Vv/YGtRQLoU4gu68PmAX+iaTFwRtw9feFBK3kxowjty+NfCGp
         wJjG4o7DoJQQWFnArGBu5VU1V+eurx/xHhFcfkDApot8q70HeCSOc4DXv4SA4HYlkMP5
         aWmudl313UR7gg+iskpcCreNkld6pnmpoNr28vpuMtEdfcl2TZVn0y60J0qqWDltN55q
         XJvGP8M1YI80tvPBQoEmf+W/oHq0c9FiT0+i8Ge9NUcoYfr2KGb3cBm0THh/VuMwAdiU
         kUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySt43gO6smkJkMCT6Ltah9Oe/TqPH3vOFFL48JryRJY=;
        b=YDuwzbBXdbzlfANnJZ1rZmV8gtxrVowKXH+lsilDcMO1xNnUiwAgPFO3KRJrv1BlmP
         q8Gv3nVMVlmtW0dM7/l78R8pSbD4n/76iEsQz+PXuUNH7kWfLBwjc3Vngg16flQfmaEL
         TsESiDaryqBkj0yxPFy2x2Fq/UgEnEudqunhvdnQvYVKSnJ8i1mdF6EHnu8OPa/UGqiG
         /1ME+GNNziUfynminOEKRq4RjiYg4eeU1t4wTpGuF91BUfUBl0mbT6h573mXbze9yEcm
         TW+Xd6NJAA2Gln+OeFU6VmVMXWlP+ts6OVG2bQo5h+F32Fdjkx6yEbgvKP1gyHJxzjKQ
         NYvA==
X-Gm-Message-State: AOAM531V02E+yrOtKQ5kXMIvzSKKpLjJ9FeayXAJ7xFGaby/YMIS4NFt
        VIG1EQ2w3u9u46vfmxUOv4U=
X-Google-Smtp-Source: ABdhPJwEplkRosODeeIhv4PGeJvnvUh/GUzz0oBoKUwaxDzsLdjnBDFwwq84HqP/lXvnmbarkKvPng==
X-Received: by 2002:a63:5705:: with SMTP id l5mr21883663pgb.415.1612263941041;
        Tue, 02 Feb 2021 03:05:41 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id g19sm3188979pfk.113.2021.02.02.03.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 03:05:40 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v12 03/14] mm: apply_to_pte_range warn and fail if a large pte is encountered
Date:   Tue,  2 Feb 2021 21:05:04 +1000
Message-Id: <20210202110515.3575274-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210202110515.3575274-1-npiggin@gmail.com>
References: <20210202110515.3575274-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

apply_to_pte_range might mistake a large pte for bad, or treat it as a
page table, resulting in a crash or corruption. Add a test to warn and
return error if large entries are found.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/memory.c | 66 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index feff48e1465a..672e39a72788 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2440,13 +2440,21 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 	}
 	do {
 		next = pmd_addr_end(addr, end);
-		if (create || !pmd_none_or_clear_bad(pmd)) {
-			err = apply_to_pte_range(mm, pmd, addr, next, fn, data,
-						 create, mask);
-			if (err)
-				break;
+		if (pmd_none(*pmd) && !create)
+			continue;
+		if (WARN_ON_ONCE(pmd_leaf(*pmd)))
+			return -EINVAL;
+		if (!pmd_none(*pmd) && WARN_ON_ONCE(pmd_bad(*pmd))) {
+			if (!create)
+				continue;
+			pmd_clear_bad(pmd);
 		}
+		err = apply_to_pte_range(mm, pmd, addr, next,
+					 fn, data, create, mask);
+		if (err)
+			break;
 	} while (pmd++, addr = next, addr != end);
+
 	return err;
 }
 
@@ -2468,13 +2476,21 @@ static int apply_to_pud_range(struct mm_struct *mm, p4d_t *p4d,
 	}
 	do {
 		next = pud_addr_end(addr, end);
-		if (create || !pud_none_or_clear_bad(pud)) {
-			err = apply_to_pmd_range(mm, pud, addr, next, fn, data,
-						 create, mask);
-			if (err)
-				break;
+		if (pud_none(*pud) && !create)
+			continue;
+		if (WARN_ON_ONCE(pud_leaf(*pud)))
+			return -EINVAL;
+		if (!pud_none(*pud) && WARN_ON_ONCE(pud_bad(*pud))) {
+			if (!create)
+				continue;
+			pud_clear_bad(pud);
 		}
+		err = apply_to_pmd_range(mm, pud, addr, next,
+					 fn, data, create, mask);
+		if (err)
+			break;
 	} while (pud++, addr = next, addr != end);
+
 	return err;
 }
 
@@ -2496,13 +2512,21 @@ static int apply_to_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	}
 	do {
 		next = p4d_addr_end(addr, end);
-		if (create || !p4d_none_or_clear_bad(p4d)) {
-			err = apply_to_pud_range(mm, p4d, addr, next, fn, data,
-						 create, mask);
-			if (err)
-				break;
+		if (p4d_none(*p4d) && !create)
+			continue;
+		if (WARN_ON_ONCE(p4d_leaf(*p4d)))
+			return -EINVAL;
+		if (!p4d_none(*p4d) && WARN_ON_ONCE(p4d_bad(*p4d))) {
+			if (!create)
+				continue;
+			p4d_clear_bad(p4d);
 		}
+		err = apply_to_pud_range(mm, p4d, addr, next,
+					 fn, data, create, mask);
+		if (err)
+			break;
 	} while (p4d++, addr = next, addr != end);
+
 	return err;
 }
 
@@ -2522,9 +2546,17 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 	pgd = pgd_offset(mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		if (!create && pgd_none_or_clear_bad(pgd))
+		if (pgd_none(*pgd) && !create)
 			continue;
-		err = apply_to_p4d_range(mm, pgd, addr, next, fn, data, create, &mask);
+		if (WARN_ON_ONCE(pgd_leaf(*pgd)))
+			return -EINVAL;
+		if (!pgd_none(*pgd) && WARN_ON_ONCE(pgd_bad(*pgd))) {
+			if (!create)
+				continue;
+			pgd_clear_bad(pgd);
+		}
+		err = apply_to_p4d_range(mm, pgd, addr, next,
+					 fn, data, create, &mask);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
-- 
2.23.0

