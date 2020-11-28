Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3AE2C72B3
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389934AbgK1VuQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733209AbgK1TGp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 14:06:45 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA428C02A1B6;
        Sat, 28 Nov 2020 07:26:18 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id m9so6688417pgb.4;
        Sat, 28 Nov 2020 07:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a1tvGnEfaNu1rng4Q1t20sHjkYaWZdSh+BVKU9lSOv4=;
        b=WC6wPXHTMZemAeUyu0JGuClO6wmo82GBportC4Vc1b7ZyXn4R9ou6tkEnwexLfBLMT
         /PKnJPMyQQYEkSDCEN2T6x9O6EcI3hSENdRPYkpmSpdfe310NB0Q31E7zqX3HL75j9wY
         U9eA26iB4gKzoTEaek9y7VNf2SGiYTKhDL5InJX7JVTjqPLlEEn/5Dfe6cYzOa7w9Uwt
         aGOTYadRYHsJx9JAPCTdgdT079frSwMYWYL+t1TuouIW/p/VJ/ODVIlWekmYBoDkUxr9
         9UMgfqqZOitGP3W9j3gjLV95JSJ7rWjY+nbiyevFMNusDZD77lDbQSADv6dcx5PSBBpx
         pMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a1tvGnEfaNu1rng4Q1t20sHjkYaWZdSh+BVKU9lSOv4=;
        b=mSFZItg2SwEHChuEGWqEh7npVzHMWMBStKonVElSP4Q/zvC1Oss/unOgzjuGuAdFOs
         Bss+TGseVWapliz0UwWORIinkjB5Onq/pP+0RpCrMtBWRdcfYl0ePqnxzzvrWUP9TUcg
         4WBYleSe62lGz8zNRrJWLxM8eHlF0MW1AcdtSPL++6GgZSv85Rd4eNykmfiZN5JtlfRj
         kDMwtkQL7HsVpmZQqPMgDCUCgdYIqZARRBFdQnFIvtSBuhQ5pXd/4UtEhyEos2xObGiZ
         cCQ8Vt4/cVBLkIyL8ytBV+eobso8KKUyYTdLXNfy87kvVNg0rSIkMTqxicXOqeG06F6h
         KhHQ==
X-Gm-Message-State: AOAM5339y/aKjgj5cZTd1WNjF5JfwjvfE0mQZg4Vmt3nyYxkQQaVfoBt
        11GTcMTGrf4w2o1lWFkNCKc=
X-Google-Smtp-Source: ABdhPJzwJokMBj7YQcVjw/yvUqBDUzNCrnWHNIeBxJjSVn6cZOaMvc0Xn5fGL4TaXPE/v0i81ElK8g==
X-Received: by 2002:a17:90a:178b:: with SMTP id q11mr16246038pja.132.1606577178587;
        Sat, 28 Nov 2020 07:26:18 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d22sm15500173pjw.11.2020.11.28.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 07:26:18 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v8 02/12] mm: apply_to_pte_range warn and fail if a large pte is encountered
Date:   Sun, 29 Nov 2020 01:25:49 +1000
Message-Id: <20201128152559.999540-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128152559.999540-1-npiggin@gmail.com>
References: <20201128152559.999540-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

apply_to_pte_range might mistake a large pte for bad, or treat it as a
page table, resulting in a crash or corruption. Add a test to warn and
return error if large entries are found.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/memory.c | 66 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c48f8df6e502..3d0f0bc5d573 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2429,13 +2429,21 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
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
 
@@ -2457,13 +2465,21 @@ static int apply_to_pud_range(struct mm_struct *mm, p4d_t *p4d,
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
 
@@ -2485,13 +2501,21 @@ static int apply_to_p4d_range(struct mm_struct *mm, pgd_t *pgd,
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
 
@@ -2511,9 +2535,17 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
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

