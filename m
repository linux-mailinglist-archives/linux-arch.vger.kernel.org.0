Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE8718C0C
	for <lists+linux-arch@lfdr.de>; Wed, 31 May 2023 23:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjEaVb3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 May 2023 17:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjEaVbX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2023 17:31:23 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0AF180;
        Wed, 31 May 2023 14:31:16 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565cdb77b01so920617b3.0;
        Wed, 31 May 2023 14:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685568676; x=1688160676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5BTNYEJrMvEdgPHE9qghL8qlsXVOst+iBLMKLVFrSI=;
        b=ZOrjRpztCykn5S2UQynBNzBa3MWmWRXtFOidHPb8ljWg9idLGbr9+vMldhGKYgTruN
         1934LTH9c2Wh9xXG+tZ6quTSzUJuhszO9LCf/AYBJsPXuQjHo4TfwO3yqkVoV4JnI7mh
         lK7Zjtt0YSLV9vHzTQP3W+nJ0auBkrTwfRrAwKmblLPqRjLTgj5BxN/zgR0xbn+upf0o
         apfiugG50HJ8VEu2RIDT+46U7OJf8q3uoGBfoRDouzvlyJiG8pcaDr4mVE+vzfndDM01
         /Jv+1rxOJiA9ppMDbAjm8+j8FmFsNys3enhgZaJmy9pp0lvroiQaVp9oa4sPbWaYs1n7
         Zxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685568676; x=1688160676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5BTNYEJrMvEdgPHE9qghL8qlsXVOst+iBLMKLVFrSI=;
        b=Yo1jcEUbaSMM6FK283GWg0EehY84EohOyBlU+YAuitdT+ApvQv3pFZK+IRQA7l8c+H
         qajbC6+jJUi/wkiEU3jLS5SrHM9BKzVP+dZlN8d/atVv/IOUGaRi/2GSy3PjvICDM7M1
         LfMIMuaDqGcIL1SEuahHg/rfuDkQBruWveBZxckQeOmXBWHqJXRaYZzFHBeVVv7NELIn
         PQ1rU+BH9IHqE3S1FO6U+Osel8RmZLXFiKrcJAcMK2B7OM9UyL6ZI7giYMPra0SiJN/W
         dNMj6lI5CgZbUDlCAZUx9q8TeZxOOnbwdlYTWhyaz/5G+7CX5O2Gz33XHRg48tBWc+6n
         nkcw==
X-Gm-Message-State: AC+VfDz2UdtxwGeb18W1wtsKJUajSgKWQl1v0f0kXThlehDMqjsHfmX0
        3JXDCnY4tq41lTMvVQgVlwM=
X-Google-Smtp-Source: ACHHUZ7A4AW0g1EJo54eGQeBH+bfqFv0MB7wzzUtb0w1cODVt+jOCsqaj2lzyysVEFaa+9MnJMXYag==
X-Received: by 2002:a0d:df81:0:b0:561:bd01:9ff with SMTP id i123-20020a0ddf81000000b00561bd0109ffmr7412356ywe.28.1685568675532;
        Wed, 31 May 2023 14:31:15 -0700 (PDT)
Received: from unknowna0e70b2ca394.attlocal.net ([2600:1700:2f7d:1800::46])
        by smtp.googlemail.com with ESMTPSA id t63-20020a0dd142000000b0055aafcef659sm658905ywd.5.2023.05.31.14.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 14:31:15 -0700 (PDT)
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
Subject: [PATCH v3 03/34] s390: Use pt_frag_refcount for pagetables
Date:   Wed, 31 May 2023 14:30:01 -0700
Message-Id: <20230531213032.25338-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531213032.25338-1-vishal.moola@gmail.com>
References: <20230531213032.25338-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.40.1

