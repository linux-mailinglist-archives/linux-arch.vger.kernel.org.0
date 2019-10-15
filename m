Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D25AD7FE4
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2019 21:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbfJOTTi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Oct 2019 15:19:38 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:39774 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389573AbfJOTTb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Oct 2019 15:19:31 -0400
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E20F5C0C5D;
        Tue, 15 Oct 2019 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571167171; bh=TWgIAs403uWUV0wYIkngd1fRYFF87Lk2XfM7j9v1Avg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZLSPKlF3qsHIMHjNHX42zIg6rv8COLc9ZMJr/pGptVwfRJeIM+xBDW23wXMHCEVNa
         MdVqy65PrxiOrKXzvojFPr+6dSgi7PY8JlLojB2pZn2bFOb6oCxhtEbQUVqF255oJA
         LyUfQHIS/UX534EhoNu01ZjN18aS4TmWn5li0jWye2T8VA4ZwTJlRROsxbQfDb9s58
         hEWVJ8J8flWGQEjC8bofa3jNnhZqJGTIgoWyod5l+i8d9VOTPKoCldNKBcDxvfvY5Z
         CKF2IMWPRfD+aRsAVJimGOKOR9SW11l0ER/m6tKSlMXtJQ0gkbkAfkwR6G79h/qHjg
         Eht8vPO+SeINQ==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.61])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4C1A7A007D;
        Tue, 15 Oct 2019 19:19:29 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 4/5] asm-generic/tlb: stub out pmd_free_tlb() if nopmd
Date:   Tue, 15 Oct 2019 12:19:25 -0700
Message-Id: <20191015191926.9281-5-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015191926.9281-1-vgupta@synopsys.com>
References: <20191015191926.9281-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Note that pmd routine folding can be tricky as even in 2-level setup
(where pmd is folded) most pmd routines refer to upper levels.
This one can surely be elided however.

| bloat-o-meter2 vmlinux-E-elide-p?d_clear_bad vmlinux-F-elide-pmd_free_tlb
| add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-112 (-112)
| function                                     old     new   delta
| free_pgd_range                               422     310    -112
| Total: Before=4137042, After=4136930, chg -1.000000%

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 include/asm-generic/pgtable-nopmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index b85b8271a73d..0d9b28cba16d 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -60,7 +60,7 @@ static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 }
-#define __pmd_free_tlb(tlb, x, a)		do { } while (0)
+#define pmd_free_tlb(tlb, x, a)		do { } while (0)
 
 #undef  pmd_addr_end
 #define pmd_addr_end(addr, end)			(end)
-- 
2.20.1

