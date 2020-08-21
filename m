Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D4524D81F
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgHUPMl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 11:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgHUPMj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 11:12:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BCFC061573;
        Fri, 21 Aug 2020 08:12:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r11so1191971pfl.11;
        Fri, 21 Aug 2020 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UY3nHiN8pgkQXggDgWgnBUQkjwXub5T9CsJzFX8rSpk=;
        b=VBgyPhP1+Sl/ttwJwVQxq7xmnvzliKnqHCmayEmnyxdcPFsr1octp/TFFnWKIEgvRt
         294S6aSmYr6+teDwU/0oFVzm4wO8+Ym1+jXMpbnFTPBYO+2xzGlknVi7FAcl88wBr/Kn
         jSZkAndm5y1hxR9jtTL3QmJ/7YVnKPSdfMQyRZU97E1JDVGr3HV4RCBEpAOa/BCvA9ew
         PzNoQdId4cgj4lGg/uVYeDkwqO1XRV789Gm96zPIqWeFF2ms2ljOEpvTkeA0JKPRXdMQ
         yE1d22vcwtb7CcTa4Q/ntF/Qt3GIPcHPi4IxgVwof5EEpCPKIlnt9saulwv9E1MnoSxk
         SlGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UY3nHiN8pgkQXggDgWgnBUQkjwXub5T9CsJzFX8rSpk=;
        b=Uh3pvxLm0rbNKE4SU4GC4X/6LzH57nS4/ZoDotFeeab/mkA0btVW037w3gtFbkq0NO
         n5wG1Vx4sJv5iKGCs1EpfTvz9mW31HwryBMK+ji+/IXv+M843np09qOYJQKf9J5JgIB8
         4slaMs49wfZT63CYh2Y6Zlht3lMO3QHk8H4+vTq7THwuPHs5LLty9tKeYoaRFhglaDg9
         j8MCkQJ53MQsFUUzcDbzlbhylk4+sEcsnA/PYSOiDO03GsYLoSxURDwon/2ILir1uN4I
         04wq19/+P1hYMpU8kd+DWFL5lbYLzOb0pXxHP9iVf0n7sNrjnMi0+gWAln7u+5TLDK2y
         BokA==
X-Gm-Message-State: AOAM531J61IUUxVGs91SGcx8HF2DI3oWw3EaiJ64Pi4Jioad1qsQd7/g
        ZSaOz64MCMgGCTKqHH7argU=
X-Google-Smtp-Source: ABdhPJyCXdSqBEAC0kFcsNvD5EqD53KjatKAQFKOQvMLJcOoi8k3fLMlmfj8qhPEMS+C8bwc9rHuyw==
X-Received: by 2002:aa7:9556:: with SMTP id w22mr2775906pfq.245.1598022758914;
        Fri, 21 Aug 2020 08:12:38 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id s8sm3126985pfc.122.2020.08.21.08.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:12:38 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v6 02/12] mm: apply_to_pte_range warn and fail if a large pte is encountered
Date:   Sat, 22 Aug 2020 01:12:06 +1000
Message-Id: <20200821151216.1005117-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200821151216.1005117-1-npiggin@gmail.com>
References: <20200821151216.1005117-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently this might mistake a large pte for bad, or treat it as a
page table, resulting in a crash or corruption.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/memory.c | 60 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 602f4283122f..3a39a47920e2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2262,13 +2262,20 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
 	}
 	do {
 		next = pmd_addr_end(addr, end);
-		if (create || !pmd_none_or_clear_bad(pmd)) {
-			err = apply_to_pte_range(mm, pmd, addr, next, fn, data,
-						 create);
-			if (err)
-				break;
+		if (pmd_none(*pmd) && !create)
+			continue;
+		if (WARN_ON_ONCE(pmd_leaf(*pmd)))
+			return -EINVAL;
+		if (WARN_ON_ONCE(pmd_bad(*pmd))) {
+			if (!create)
+				continue;
+			pmd_clear_bad(pmd);
 		}
+		err = apply_to_pte_range(mm, pmd, addr, next, fn, data, create);
+		if (err)
+			break;
 	} while (pmd++, addr = next, addr != end);
+
 	return err;
 }
 
@@ -2289,13 +2296,20 @@ static int apply_to_pud_range(struct mm_struct *mm, p4d_t *p4d,
 	}
 	do {
 		next = pud_addr_end(addr, end);
-		if (create || !pud_none_or_clear_bad(pud)) {
-			err = apply_to_pmd_range(mm, pud, addr, next, fn, data,
-						 create);
-			if (err)
-				break;
+		if (pud_none(*pud) && !create)
+			continue;
+		if (WARN_ON_ONCE(pud_leaf(*pud)))
+			return -EINVAL;
+		if (WARN_ON_ONCE(pud_bad(*pud))) {
+			if (!create)
+				continue;
+			pud_clear_bad(pud);
 		}
+		err = apply_to_pmd_range(mm, pud, addr, next, fn, data, create);
+		if (err)
+			break;
 	} while (pud++, addr = next, addr != end);
+
 	return err;
 }
 
@@ -2316,13 +2330,20 @@ static int apply_to_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	}
 	do {
 		next = p4d_addr_end(addr, end);
-		if (create || !p4d_none_or_clear_bad(p4d)) {
-			err = apply_to_pud_range(mm, p4d, addr, next, fn, data,
-						 create);
-			if (err)
-				break;
+		if (p4d_none(*p4d) && !create)
+			continue;
+		if (WARN_ON_ONCE(p4d_leaf(*p4d)))
+			return -EINVAL;
+		if (WARN_ON_ONCE(p4d_bad(*p4d))) {
+			if (!create)
+				continue;
+			p4d_clear_bad(p4d);
 		}
+		err = apply_to_pud_range(mm, p4d, addr, next, fn, data, create);
+		if (err)
+			break;
 	} while (p4d++, addr = next, addr != end);
+
 	return err;
 }
 
@@ -2341,8 +2362,15 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
 	pgd = pgd_offset(mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		if (!create && pgd_none_or_clear_bad(pgd))
+		if (pgd_none(*pgd) && !create)
 			continue;
+		if (WARN_ON_ONCE(pgd_leaf(*pgd)))
+			return -EINVAL;
+		if (WARN_ON_ONCE(pgd_bad(*pgd))) {
+			if (!create)
+				continue;
+			pgd_clear_bad(pgd);
+		}
 		err = apply_to_p4d_range(mm, pgd, addr, next, fn, data, create);
 		if (err)
 			break;
-- 
2.23.0

