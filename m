Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0EF301A84
	for <lists+linux-arch@lfdr.de>; Sun, 24 Jan 2021 09:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbhAXIYO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 24 Jan 2021 03:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbhAXIXo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jan 2021 03:23:44 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92688C06174A;
        Sun, 24 Jan 2021 00:23:04 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id g15so6616238pjd.2;
        Sun, 24 Jan 2021 00:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/x6cdpjaOH33+ELSrGwY3sQ3qRgzggzyFztG5hnhdsk=;
        b=aO4gEjmWuAuh0gZMGkfqR1QuVFpQRIH3UxpYZqGzPJi9zwsdd163c6MNj6YBKia+ZQ
         xaV2O1fDHJGBjZkyX1Xfps2OADbM1Seeotu2I7jMQkobgb5Dt2hquvM6Uci/8mrklLGi
         E3vNbCOlcObgpoQV0H1VtQUDw0Z9L4hzJPcTQ/g+XwFU5xpQdzmuAu8yuEkwkVfij7Vb
         1v8AQi8CTlNtZZXthdGd+fm3tikUnrkoadMRBh/RdkuULLxDkVQRN3tU2QDzq1ZjegOY
         /Ctv4/l98syX528uaxkOcfQ2sCkUrorQ7xGxJ5LJRFAIenRQfUDOpKe2hOeJ6UUP9r5s
         444w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/x6cdpjaOH33+ELSrGwY3sQ3qRgzggzyFztG5hnhdsk=;
        b=g57O8yihg6xLz6tbjq5b9yN34DwZU6apxg5CePj2lkJqmKlCoNZL0cUuMMTfyHSs+y
         oJ1O/wNriNvrgCmjdoVEhwsYYDZD3sgzIyORSWAAX0b+HDJEmdAdLt3W6pwjP2ayG6Th
         Vogxp/za2h41ypWJMlwWd9AGcdExSs9D/JJdDNY2LqSu1i3gqDxGwXFIV1AQu+ITuGjB
         bh/ZnXjVRd7kqSOPkasfXsgSpWVuA5emogQcH0S/V9A/J34N6kEEqoVWtW9ZuQ3pYrjB
         cxErxWKrzjFfb1WX9ik1X2tV/4JZ7btBbqbV+aj74V5DjSr7ikyePY2CEEnCnhBM/BdN
         KMeQ==
X-Gm-Message-State: AOAM532S5+XQeyXzeI3NGLKNenMty4P5bnneNmm3eTf6R+PgA6DBhi3P
        PClqODWC83Qvgjr5uOWGw08=
X-Google-Smtp-Source: ABdhPJyrsytE/NMqNg0eGkiocOJPB9OIhVhalaGRXuMoTtXPLltyqIr5T+D2zqmrI8yVhUBnUVlz2Q==
X-Received: by 2002:a17:902:e80c:b029:de:a20b:7a9c with SMTP id u12-20020a170902e80cb02900dea20b7a9cmr13712689plg.12.1611476584165;
        Sun, 24 Jan 2021 00:23:04 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([124.170.13.62])
        by smtp.gmail.com with ESMTPSA id gb12sm11799757pjb.51.2021.01.24.00.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 00:23:03 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>
Subject: [PATCH v10 02/12] mm: apply_to_pte_range warn and fail if a large pte is encountered
Date:   Sun, 24 Jan 2021 18:22:20 +1000
Message-Id: <20210124082230.2118861-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210124082230.2118861-1-npiggin@gmail.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
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

