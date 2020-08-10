Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36A22400D6
	for <lists+linux-arch@lfdr.de>; Mon, 10 Aug 2020 04:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgHJC16 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Aug 2020 22:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgHJC15 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Aug 2020 22:27:57 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FCAC061756;
        Sun,  9 Aug 2020 19:27:57 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f5so78156plr.9;
        Sun, 09 Aug 2020 19:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxm/C2mC0786WMQTE10aJFvTg/Tw0xwUgIx5I5X+hjE=;
        b=WP278OOYLrG+JIYsivHVGAzMTDa1eY0iFpr/M6I+aKWKr6bMnyODBgG4KETvzcgTXd
         ow7Jj2tsasJ8YFFWufeQv277XGisF25VPY5ZRhlBYYgpEWp1+50PYmlf923Gu/QUOITt
         etVT077ynKT7AWNGF/5mQcMdPJjA0gFZC+nLCGBjmku/JKs79bACOlt5k+qdWfrkM+Ui
         7cIyNArYFYHVtz1M3cDImsXm9SmwTNdx2tC09A2Dter3y6Kuu2/oxvSq89h1uNaAGDuh
         zDBy5Pjw69YLMWfuhW7I/ekJKMRZ80wZ+GACMvHlcpOX7TEgC42KFlaiBl9YI8RZowwS
         DNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxm/C2mC0786WMQTE10aJFvTg/Tw0xwUgIx5I5X+hjE=;
        b=P/J9V5QmEOFMrpzHIpJR5XIb7IGRTTMBxTEHJuZs0a9G75AGo5iQuxV2u3RDtiu3Ej
         G2IWCfE0vq+8KRLcSUWRaV5YZ7Zp70D1uYmo6GQ+7U1RX8dGVtotO9J72MZWUR/wxBbd
         oLsdZtwqakFTlx8HjRH6oTxXf6oObouioRI4NQ/Je7924BDitXdkMorLT0VV1jqsm67r
         rj/9AkCoRr02Dfr17tnm6IJcWP2Idcqgk91C+E51UWEhISVoPdGp3Bkm3nSNGGweWgJn
         VLkNwwqWx9DjxQvHXzZZmcOPmWSpN2b2+gz6KGNvo/cefxiBoeczhLhQDPNrCocteyQI
         mMMA==
X-Gm-Message-State: AOAM531GVmebrTkX/xw9MLPOWQ/sITXBTVI6qdQyLa2oAUaEGCd9fn+Q
        N6HGDqjk+VYTVMOwKqhyKb4=
X-Google-Smtp-Source: ABdhPJzQrXlZ5GNgG6uz8L7myrJaEH5zZlbvoa/Z7fFHnyqY5iIPX6x3JpckcdyVbZxn3y4vyTxFlA==
X-Received: by 2002:a17:902:7681:: with SMTP id m1mr9854542pll.62.1597026477066;
        Sun, 09 Aug 2020 19:27:57 -0700 (PDT)
Received: from bobo.ibm.com (193-116-100-32.tpgi.com.au. [193.116.100.32])
        by smtp.gmail.com with ESMTPSA id l17sm21863475pff.126.2020.08.09.19.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 19:27:56 -0700 (PDT)
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
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH v3 2/8] mm: apply_to_pte_range warn and fail if a large pte is encountered
Date:   Mon, 10 Aug 2020 12:27:26 +1000
Message-Id: <20200810022732.1150009-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200810022732.1150009-1-npiggin@gmail.com>
References: <20200810022732.1150009-1-npiggin@gmail.com>
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

