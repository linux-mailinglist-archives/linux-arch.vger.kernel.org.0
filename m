Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A762251BA1
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 16:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHYO6T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Aug 2020 10:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgHYO6N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Aug 2020 10:58:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBDDC061574;
        Tue, 25 Aug 2020 07:58:13 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g1so3203887pgm.9;
        Tue, 25 Aug 2020 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mSzVBpitc24aVru+Z5sqZmf0BwSZbFvBZc52kq4fALc=;
        b=vQtLeiorPiM+mBnb60jbbLATWdt1MHtxT3cLtj/RriJ8o1jdz7rkP3YQoG8mJWp8io
         LS8Dn6rf+7FDGByZFvEN2Fvj765mPOq6rs5PxtVpnNKAnP+HpRPZEGtxlZ4w7c+4GIgm
         ezgfbHhGIlzBhl9CqOSnbIsXRE5mnjIqpNFVmnXuNc6PzLygdIFXRQ5p2XVvInqQQ0lO
         2yl8BqFp93HPQDWY6blFQJainUjJoxR/yKxm5FkwT715afuzUyduhXOJYRKlwe8TAjes
         P7xVYKEM9pYt5n5N5z4cdA2mKYCcpZb5B8iOuU36TX3QTyiEkX6JW7/V6JZZlxdFBQw7
         8HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSzVBpitc24aVru+Z5sqZmf0BwSZbFvBZc52kq4fALc=;
        b=Ot77zT+HRcIdTyXlFL4T9bw1iKYNuDI1dmTyMuN4wnlbR0P0aVrqD4XexM/3TqlIl0
         xWGw4H/8JDM8gCkSRNpVHuDvbimlhM08+IkjKrPHF3DLLns2OGaloi9o5N2zX8na52MX
         8v+uPVvnvytPnD0VDrk6psgVPJOnAL18jNRwsKrog1LMFED7T6JyIqepdsEL5iB9//P0
         BYCEzWNra2AXoGiwureQMiwFqEPZ7kPfVCCd8gFJUz5tBEbQCQ3vEonWOdW1ViqpHXS6
         RGn2pU+9VIATRjLhdWl+LKLsMPt4jRlrJc8JRKf8Kt4SenORr0630v3oSFb7LcaZjP1p
         yuPA==
X-Gm-Message-State: AOAM533aEhVJAFhmEgwD0gx9kQlbNdvxn/HHdoniX3OV++qwdDIjTFsO
        2aGKXlGIBGIER+dS5ZBgdRc=
X-Google-Smtp-Source: ABdhPJx8/sy89f7MYqPfGwfXfZYI+WaeFxgwudoUWCZ36ogQX+u6vunFQp0u1doW3+kcOJej62M5Pg==
X-Received: by 2002:a17:902:7790:: with SMTP id o16mr7580684pll.299.1598367492650;
        Tue, 25 Aug 2020 07:58:12 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id e29sm15755956pfj.92.2020.08.25.07.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 07:58:12 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v7 02/12] mm: apply_to_pte_range warn and fail if a large pte is encountered
Date:   Wed, 26 Aug 2020 00:57:43 +1000
Message-Id: <20200825145753.529284-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200825145753.529284-1-npiggin@gmail.com>
References: <20200825145753.529284-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

apply_to_pte_range might mistake a large pte for bad, or treat it as a
page table, resulting in a crash or corruption. Add a test to warn and
return error if large entries are found.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/memory.c | 60 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 602f4283122f..995b2e790b79 100644
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
+		if (!pmd_none(*pmd) && WARN_ON_ONCE(pmd_bad(*pmd))) {
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
+		if (!pud_none(*pud) && WARN_ON_ONCE(pud_bad(*pud))) {
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
+		if (!p4d_none(*p4d) && WARN_ON_ONCE(p4d_bad(*p4d))) {
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
+		if (!pgd_none(*pgd) && WARN_ON_ONCE(pgd_bad(*pgd))) {
+			if (!create)
+				continue;
+			pgd_clear_bad(pgd);
+		}
 		err = apply_to_p4d_range(mm, pgd, addr, next, fn, data, create);
 		if (err)
 			break;
-- 
2.23.0

