Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B9F6F36FF
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 21:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjEAT31 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 15:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbjEAT3U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 15:29:20 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E76A30DC;
        Mon,  1 May 2023 12:28:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-52863157da6so1840003a12.0;
        Mon, 01 May 2023 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682969319; x=1685561319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmbsS8DkaHNij/v9bdafzBlktB7f+f7NAeK2Q02GvbI=;
        b=B4azYqsU+PZdNT5sPYRuRynEP/yG+nnQZzCwWNiJuBYZMp7zK7WPiFNkyYATyiWLs9
         KXu3O4UXjROzHmg5BH+SgHHBIK4HaE73RnqEPc9ZoVRSl4Uh4CCXlTE9MpnCo1Ir9cR5
         1tT0IRumxWPV12suNOkG+VwHWOIH3Na7v0j8RESqGnAScgYPrOMUDDIHfUYdpmcQFIY7
         vF1i0igsbLRBnZPi2HEPlzfFt+R0Rd+c2dVX9RoHx/GLiWbMDfrtbVlk0iN4TeEGJT4d
         1bO8trvKRg+pq0Q4NgCg3JPagFS7MkJj/4qfBc8P2r4TUch12xgUcUg4F69rFfadNKuw
         8vIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682969319; x=1685561319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmbsS8DkaHNij/v9bdafzBlktB7f+f7NAeK2Q02GvbI=;
        b=N/HbOqNEWThNs+g3NXgtcblOtNaGFmHIVcJ3xRixc7db3IS7ul3XgvpCkmINDxI+sT
         U+FvEAX7iGTUMBA9D+sUK6C5A1ENwxuoDcwc3RKXJL2YWDTFPqdziHDKy/izTcxBciLd
         Tf6ZLGwYkpiTXPe85fEKHxqo3booLIPPjB+zGAJ44iVd6u3B9W45GB+l9/uGhjv0/DB1
         WgiwYzNZIg8E/uhsnakM0+A1bTWOuBFamlhnL3Z1+hWxRfw/aUg8IxwqhshUr9uc+u+u
         qc0+DmdGtLLFVeRlkTlmFWdY/SzQR0fjhZ2OrgefjAFmbgO+dnY+bv308B7WaIrU73Uu
         xv4g==
X-Gm-Message-State: AC+VfDx58Jtm1f824Yh3SpPR4HNKFtXGWPUXL+tkx6uq8p3WNC2O6gor
        B0nW20yCx7eUvXFiaUqhzhE=
X-Google-Smtp-Source: ACHHUZ4E/JVh2DFvUW/bEZgIHPiMJ+Zfpw7pvXWZYNeWA42FHZxnOhQrWiIO3kxV0xxzCmUatMgqYw==
X-Received: by 2002:a17:902:8c91:b0:1a9:2b7f:a594 with SMTP id t17-20020a1709028c9100b001a92b7fa594mr13894676plo.29.1682969318714;
        Mon, 01 May 2023 12:28:38 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:937f:7f20::9a2c])
        by smtp.googlemail.com with ESMTPSA id u8-20020a170902bf4800b0019c13d032d8sm18175622pls.253.2023.05.01.12.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 12:28:38 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v2 03/34] s390: Use pt_frag_refcount for pagetables
Date:   Mon,  1 May 2023 12:27:58 -0700
Message-Id: <20230501192829.17086-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501192829.17086-1-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

s390 currently uses _refcount to identify fragmented page tables.
The page table struct already has a member pt_frag_refcount used by
powerpc, so have s390 use that instead of the _refcount field as well.
This improves the safety for _refcount and the page table tracking.

This also allows us to simplify the tracking since we can once again use
the lower byte of pt_frag_refcount instead of the upper byte of _refcount.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/s390/mm/pgalloc.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 66ab68db9842..6b99932abc66 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -182,20 +182,17 @@ void page_table_free_pgste(struct page *page)
  * As follows from the above, no unallocated or fully allocated parent
  * pages are contained in mm_context_t::pgtable_list.
  *
- * The upper byte (bits 24-31) of the parent page _refcount is used
+ * The lower byte (bits 0-7) of the parent page pt_frag_refcount is used
  * for tracking contained 2KB-pgtables and has the following format:
  *
  *   PP  AA
- * 01234567    upper byte (bits 24-31) of struct page::_refcount
+ * 01234567    upper byte (bits 0-7) of struct page::pt_frag_refcount
  *   ||  ||
  *   ||  |+--- upper 2KB-pgtable is allocated
  *   ||  +---- lower 2KB-pgtable is allocated
  *   |+------- upper 2KB-pgtable is pending for removal
  *   +-------- lower 2KB-pgtable is pending for removal
  *
- * (See commit 620b4e903179 ("s390: use _refcount for pgtables") on why
- * using _refcount is possible).
- *
  * When 2KB-pgtable is allocated the corresponding AA bit is set to 1.
  * The parent page is either:
  *   - added to mm_context_t::pgtable_list in case the second half of the
@@ -243,11 +240,12 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 		if (!list_empty(&mm->context.pgtable_list)) {
 			page = list_first_entry(&mm->context.pgtable_list,
 						struct page, lru);
-			mask = atomic_read(&page->_refcount) >> 24;
+			mask = atomic_read(&page->pt_frag_refcount);
 			/*
 			 * The pending removal bits must also be checked.
 			 * Failure to do so might lead to an impossible
-			 * value of (i.e 0x13 or 0x23) written to _refcount.
+			 * value of (i.e 0x13 or 0x23) written to
+			 * pt_frag_refcount.
 			 * Such values violate the assumption that pending and
 			 * allocation bits are mutually exclusive, and the rest
 			 * of the code unrails as result. That could lead to
@@ -259,8 +257,8 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 				bit = mask & 1;		/* =1 -> second 2K */
 				if (bit)
 					table += PTRS_PER_PTE;
-				atomic_xor_bits(&page->_refcount,
-							0x01U << (bit + 24));
+				atomic_xor_bits(&page->pt_frag_refcount,
+							0x01U << bit);
 				list_del(&page->lru);
 			}
 		}
@@ -281,12 +279,12 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	table = (unsigned long *) page_to_virt(page);
 	if (mm_alloc_pgste(mm)) {
 		/* Return 4K page table with PGSTEs */
-		atomic_xor_bits(&page->_refcount, 0x03U << 24);
+		atomic_xor_bits(&page->pt_frag_refcount, 0x03U);
 		memset64((u64 *)table, _PAGE_INVALID, PTRS_PER_PTE);
 		memset64((u64 *)table + PTRS_PER_PTE, 0, PTRS_PER_PTE);
 	} else {
 		/* Return the first 2K fragment of the page */
-		atomic_xor_bits(&page->_refcount, 0x01U << 24);
+		atomic_xor_bits(&page->pt_frag_refcount, 0x01U);
 		memset64((u64 *)table, _PAGE_INVALID, 2 * PTRS_PER_PTE);
 		spin_lock_bh(&mm->context.lock);
 		list_add(&page->lru, &mm->context.pgtable_list);
@@ -323,22 +321,19 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
 		 * will happen outside of the critical section from this
 		 * function or from __tlb_remove_table()
 		 */
-		mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
-		mask >>= 24;
+		mask = atomic_xor_bits(&page->pt_frag_refcount, 0x11U << bit);
 		if (mask & 0x03U)
 			list_add(&page->lru, &mm->context.pgtable_list);
 		else
 			list_del(&page->lru);
 		spin_unlock_bh(&mm->context.lock);
-		mask = atomic_xor_bits(&page->_refcount, 0x10U << (bit + 24));
-		mask >>= 24;
+		mask = atomic_xor_bits(&page->pt_frag_refcount, 0x10U << bit);
 		if (mask != 0x00U)
 			return;
 		half = 0x01U << bit;
 	} else {
 		half = 0x03U;
-		mask = atomic_xor_bits(&page->_refcount, 0x03U << 24);
-		mask >>= 24;
+		mask = atomic_xor_bits(&page->pt_frag_refcount, 0x03U);
 	}
 
 	page_table_release_check(page, table, half, mask);
@@ -368,8 +363,7 @@ void page_table_free_rcu(struct mmu_gather *tlb, unsigned long *table,
 	 * outside of the critical section from __tlb_remove_table() or from
 	 * page_table_free()
 	 */
-	mask = atomic_xor_bits(&page->_refcount, 0x11U << (bit + 24));
-	mask >>= 24;
+	mask = atomic_xor_bits(&page->pt_frag_refcount, 0x11U << bit);
 	if (mask & 0x03U)
 		list_add_tail(&page->lru, &mm->context.pgtable_list);
 	else
@@ -391,14 +385,12 @@ void __tlb_remove_table(void *_table)
 		return;
 	case 0x01U:	/* lower 2K of a 4K page table */
 	case 0x02U:	/* higher 2K of a 4K page table */
-		mask = atomic_xor_bits(&page->_refcount, mask << (4 + 24));
-		mask >>= 24;
+		mask = atomic_xor_bits(&page->pt_frag_refcount, mask << 4);
 		if (mask != 0x00U)
 			return;
 		break;
 	case 0x03U:	/* 4K page table with pgstes */
-		mask = atomic_xor_bits(&page->_refcount, 0x03U << 24);
-		mask >>= 24;
+		mask = atomic_xor_bits(&page->pt_frag_refcount, 0x03U);
 		break;
 	}
 
-- 
2.39.2

