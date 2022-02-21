Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532DD4BD68A
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 07:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345265AbiBUGjP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 01:39:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbiBUGjM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 01:39:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4E501AF33;
        Sun, 20 Feb 2022 22:38:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6967F1396;
        Sun, 20 Feb 2022 22:38:49 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.49.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2757C3F70D;
        Sun, 20 Feb 2022 22:38:46 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH V2 01/30] mm/debug_vm_pgtable: Drop protection_map[] usage
Date:   Mon, 21 Feb 2022 12:08:10 +0530
Message-Id: <1645425519-9034-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
References: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Although protection_map[] contains the platform defined page protection map
for a given vm_flags combination, vm_get_page_prot() is the right interface
to use. This will also reduce dependency on protection_map[] which is going
to be dropped off completely later on.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/debug_vm_pgtable.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index db2abd9e415b..30fd11a2ed32 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -93,7 +93,7 @@ struct pgtable_debug_args {
 
 static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
 {
-	pgprot_t prot = protection_map[idx];
+	pgprot_t prot = vm_get_page_prot(idx);
 	pte_t pte = pfn_pte(args->fixed_pte_pfn, prot);
 	unsigned long val = idx, *ptr = &val;
 
@@ -101,7 +101,7 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
 
 	/*
 	 * This test needs to be executed after the given page table entry
-	 * is created with pfn_pte() to make sure that protection_map[idx]
+	 * is created with pfn_pte() to make sure that vm_get_page_prot(idx)
 	 * does not have the dirty bit enabled from the beginning. This is
 	 * important for platforms like arm64 where (!PTE_RDONLY) indicate
 	 * dirty bit being set.
@@ -190,7 +190,7 @@ static void __init pte_savedwrite_tests(struct pgtable_debug_args *args)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 {
-	pgprot_t prot = protection_map[idx];
+	pgprot_t prot = vm_get_page_prot(idx);
 	unsigned long val = idx, *ptr = &val;
 	pmd_t pmd;
 
@@ -202,7 +202,7 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
 
 	/*
 	 * This test needs to be executed after the given page table entry
-	 * is created with pfn_pmd() to make sure that protection_map[idx]
+	 * is created with pfn_pmd() to make sure that vm_get_page_prot(idx)
 	 * does not have the dirty bit enabled from the beginning. This is
 	 * important for platforms like arm64 where (!PTE_RDONLY) indicate
 	 * dirty bit being set.
@@ -325,7 +325,7 @@ static void __init pmd_savedwrite_tests(struct pgtable_debug_args *args)
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx)
 {
-	pgprot_t prot = protection_map[idx];
+	pgprot_t prot = vm_get_page_prot(idx);
 	unsigned long val = idx, *ptr = &val;
 	pud_t pud;
 
@@ -337,7 +337,7 @@ static void __init pud_basic_tests(struct pgtable_debug_args *args, int idx)
 
 	/*
 	 * This test needs to be executed after the given page table entry
-	 * is created with pfn_pud() to make sure that protection_map[idx]
+	 * is created with pfn_pud() to make sure that vm_get_page_prot(idx)
 	 * does not have the dirty bit enabled from the beginning. This is
 	 * important for platforms like arm64 where (!PTE_RDONLY) indicate
 	 * dirty bit being set.
@@ -1106,14 +1106,14 @@ static int __init init_args(struct pgtable_debug_args *args)
 	/*
 	 * Initialize the debugging data.
 	 *
-	 * protection_map[0] (or even protection_map[8]) will help create
-	 * page table entries with PROT_NONE permission as required for
-	 * pxx_protnone_tests().
+	 * vm_get_page_prot(VM_NONE) or vm_get_page_prot(VM_SHARED|VM_NONE)
+	 * will help create page table entries with PROT_NONE permission as
+	 * required for pxx_protnone_tests().
 	 */
 	memset(args, 0, sizeof(*args));
 	args->vaddr              = get_random_vaddr();
 	args->page_prot          = vm_get_page_prot(VMFLAGS);
-	args->page_prot_none     = protection_map[0];
+	args->page_prot_none     = vm_get_page_prot(VM_NONE);
 	args->is_contiguous_page = false;
 	args->pud_pfn            = ULONG_MAX;
 	args->pmd_pfn            = ULONG_MAX;
@@ -1248,12 +1248,19 @@ static int __init debug_vm_pgtable(void)
 		return ret;
 
 	/*
-	 * Iterate over the protection_map[] to make sure that all
+	 * Iterate over each possible vm_flags to make sure that all
 	 * the basic page table transformation validations just hold
 	 * true irrespective of the starting protection value for a
 	 * given page table entry.
+	 *
+	 * Protection based vm_flags combinatins are always linear
+	 * and increasing i.e starting from VM_NONE and going upto
+	 * (VM_SHARED | READ | WRITE | EXEC).
 	 */
-	for (idx = 0; idx < ARRAY_SIZE(protection_map); idx++) {
+#define VM_FLAGS_START	(VM_NONE)
+#define VM_FLAGS_END	(VM_SHARED | VM_EXEC | VM_WRITE | VM_READ)
+
+	for (idx = VM_FLAGS_START; idx <= VM_FLAGS_END; idx++) {
 		pte_basic_tests(&args, idx);
 		pmd_basic_tests(&args, idx);
 		pud_basic_tests(&args, idx);
-- 
2.25.1

