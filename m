Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C4524CCE5
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 06:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgHUEot (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 00:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgHUEoq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 00:44:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580ECC061385;
        Thu, 20 Aug 2020 21:44:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h12so422787pgm.7;
        Thu, 20 Aug 2020 21:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r93I4AuViyvI3WFmm3zsFVOEd/ZSp6PAmt6HmvThDqM=;
        b=pCPdkWR+/c3zGQZvbI+yxPmJYiJKpXbInrdYKkqIhWmlE9TYC6j5Mf11xaW0biltIw
         OpEeh+fCH9qvFzH6jX5Lv3RtfHciH9iJpqSE5g2ZeBEhuEqYyTLS1C33+HGi7/0UHE3e
         XRi13Mvm7jZFBeh7aoSMNJgBAAR//QM0MiuA0mJUwYqzKpKXxvSVOg5RGBmfC53y0ZmG
         O8Mj2Wa7adwTYJ+v8cuTZwIbAVljHSCvjsq2/l6Iz3h9e0jeVS4gFdtofpkMYPzIOwSe
         QBzadfNfLEd+vu9GWevuLRVwbiTvNZO2gQ1OuXxvFaJ2bjkrLNyu8oi/X7lcwoXY0FUG
         aT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r93I4AuViyvI3WFmm3zsFVOEd/ZSp6PAmt6HmvThDqM=;
        b=OeAqghL9ZRnjOs6+ADp/TFmXxA+6yo7K8BD95dHzedulxAqKVqmXVcCqquj6xpJPrJ
         LQUP1UVwJs4X5+9HGh6XTyJPIIE1cWmhjMLsmJcUtZtGLs2RZVNrdKl58Sx5KlarE6l/
         exY2mwewWOpGx37E8ybeDmaJrz61p+Qnz0TS7V+uNkL4Px/J4CIPRNmsQ1Q9/CFCPf1W
         QdN+oYLXZwNZOxxH3Is7xwC2u0isAActtoXCA5tu1ClCGHkE4nk1J2HP+zDYOqg/LsGh
         FSajph2+i8XYVqGPOHw/ywGJcMtxu6htgBwKWkvm1JfktNwTXmfjIOlrFbx8lxMHtF7Y
         UT/w==
X-Gm-Message-State: AOAM5339+FsfZnNGxgQKrHPMJcLb6XotA56YEE53cRRTa1CaQ4uh0nxj
        qfYKDwmirQHpWP0Wi3diuKI=
X-Google-Smtp-Source: ABdhPJxcErdb6DHl7wNZg2CJKi37fhm5Y8ORf9S2133r96TOuyrJSJsmNCzKB7cRJeog1G9Yvb/4EQ==
X-Received: by 2002:a62:9254:: with SMTP id o81mr988198pfd.73.1597985085951;
        Thu, 20 Aug 2020 21:44:45 -0700 (PDT)
Received: from bobo.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id l9sm683374pgg.29.2020.08.20.21.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 21:44:45 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v5 2/8] mm: apply_to_pte_range warn and fail if a large pte is encountered
Date:   Fri, 21 Aug 2020 14:44:21 +1000
Message-Id: <20200821044427.736424-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200821044427.736424-1-npiggin@gmail.com>
References: <20200821044427.736424-1-npiggin@gmail.com>
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
index f95edbb77326..19986af291e0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2261,13 +2261,20 @@ static int apply_to_pmd_range(struct mm_struct *mm, pud_t *pud,
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
 
@@ -2288,13 +2295,20 @@ static int apply_to_pud_range(struct mm_struct *mm, p4d_t *p4d,
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
 
@@ -2315,13 +2329,20 @@ static int apply_to_p4d_range(struct mm_struct *mm, pgd_t *pgd,
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
 
@@ -2340,8 +2361,15 @@ static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
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

