Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F50E2456F0
	for <lists+linux-arch@lfdr.de>; Sun, 16 Aug 2020 11:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgHPJJf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Aug 2020 05:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgHPJJ2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Aug 2020 05:09:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC25DC061756;
        Sun, 16 Aug 2020 02:09:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x25so6680818pff.4;
        Sun, 16 Aug 2020 02:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxm/C2mC0786WMQTE10aJFvTg/Tw0xwUgIx5I5X+hjE=;
        b=b9r2FrUb9Vyhol+l3W9WoRcRqwuEhJjICuC8voZ71tdHvf9AxDjiBeHUPoJzDXz918
         GfC0Lqqv1aLzAMXtaXVGWxJ6//psWOIy2I4sji++lJ4BdiP0PWs10DaVhUxrs/zwIvhB
         kwIE3+NTA1aXJvKR4AsAcVvlRBup95ZJs0o8J9ggH+EDr5FqvguEbk6SCdoc6r18RYLb
         qMc3ECitpN/FuWjc9PL9bKG4zy+91aFxbDPlqpmB6w4xTa9WdDDN2iuZL1gIDQqtr6Ak
         fX7yiUhYUaJ841lhLFcKD1xkRiYDVw4mI1xoWm//U3az5Xq+hLgWbkAGx8JSu9AnOfQ7
         JqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxm/C2mC0786WMQTE10aJFvTg/Tw0xwUgIx5I5X+hjE=;
        b=SxQBrTh2IyjGN76IWSGPlSBd1GPM8si69wTrhxHw4x74rm71qjURWOChfcS8lRr6CP
         tMXpT5YnOH/MmVDfVFiqAgRigfNuBSfpLBz52d/UUzv2JQwsEvhNQO1Wj/NTtxokvnaV
         tvpVA5AYcX2C7b9ib4B9DODcXp3rdSpTIl62Iz3AOmguVQw1JHe8PQPg55PgMR8Xuwlc
         58y5sORtEdKjMaER7k5GjGZAQPLvdGXH2FhcvmBildD5shOdctHP66c+HsZ12adJ+vsp
         1qDyDsvnTrxgURKFLicBva/2esO8vwKaTnxGqr4UbFYpPoXW3/0Zw7xJ+lPnKHnvGeR2
         3SzA==
X-Gm-Message-State: AOAM530RcGuBC+KC5IrJ/VL0QKGRJ4ODn9mTfPdW0wysXcJLlSMCAzkm
        ib8G3rYAy5NyRLNLv9v+YZQ=
X-Google-Smtp-Source: ABdhPJwxOvFbG/ZjwUp2j/jXOU/b9ImNMZIMN5ReacxCD9gMRBxoKCQ/eh7ex/628GY5c5MYbRsgNg==
X-Received: by 2002:aa7:9a1c:: with SMTP id w28mr4426784pfj.116.1597568968280;
        Sun, 16 Aug 2020 02:09:28 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (193-116-193-175.tpgi.com.au. [193.116.193.175])
        by smtp.gmail.com with ESMTPSA id o19sm12768369pjs.8.2020.08.16.02.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 02:09:27 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v4 2/8] mm: apply_to_pte_range warn and fail if a large pte is encountered
Date:   Sun, 16 Aug 2020 19:08:58 +1000
Message-Id: <20200816090904.83947-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200816090904.83947-1-npiggin@gmail.com>
References: <20200816090904.83947-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/memory.c | 60 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c39a13b09602..1d5f3093c249 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2260,13 +2260,20 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
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
 
@@ -2287,13 +2294,20 @@ static int apply_to_pud_range(struct mm_struct *mm, p4d_t *p4d,
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
 
@@ -2314,13 +2328,20 @@ static int apply_to_p4d_range(struct mm_struct *mm, pgd_t *pgd,
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
 
@@ -2339,8 +2360,15 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
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

