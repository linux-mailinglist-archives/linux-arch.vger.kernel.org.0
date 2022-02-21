Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BE74BD632
	for <lists+linux-arch@lfdr.de>; Mon, 21 Feb 2022 07:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345291AbiBUGj0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Feb 2022 01:39:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345296AbiBUGjR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Feb 2022 01:39:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3467527B3A;
        Sun, 20 Feb 2022 22:38:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03E031476;
        Sun, 20 Feb 2022 22:38:53 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.49.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 077603F70D;
        Sun, 20 Feb 2022 22:38:49 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-arch@vger.kernel.org
Subject: [PATCH V2 02/30] mm/mmap: Clarify protection_map[] indices
Date:   Mon, 21 Feb 2022 12:08:11 +0530
Message-Id: <1645425519-9034-3-git-send-email-anshuman.khandual@arm.com>
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

protection_map[] maps vm_flags access combinations into page protection
value as defined by the platform via __PXXX and __SXXX macros. The array
indices in protection_map[], represents vm_flags access combinations but
it's not very intuitive to derive. This makes it clear and explicit.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/mmap.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1e8fdb0b51ed..670c68f5fbf1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -102,8 +102,22 @@ static void unmap_region(struct mm_struct *mm,
  *								x: (yes) yes
  */
 pgprot_t protection_map[16] __ro_after_init = {
-	__P000, __P001, __P010, __P011, __P100, __P101, __P110, __P111,
-	__S000, __S001, __S010, __S011, __S100, __S101, __S110, __S111
+	[VM_NONE]					= __P000,
+	[VM_READ]					= __P001,
+	[VM_WRITE]					= __P010,
+	[VM_WRITE | VM_READ]				= __P011,
+	[VM_EXEC]					= __P100,
+	[VM_EXEC | VM_READ]				= __P101,
+	[VM_EXEC | VM_WRITE]				= __P110,
+	[VM_EXEC | VM_WRITE | VM_READ]			= __P111,
+	[VM_SHARED]					= __S000,
+	[VM_SHARED | VM_READ]				= __S001,
+	[VM_SHARED | VM_WRITE]				= __S010,
+	[VM_SHARED | VM_WRITE | VM_READ]		= __S011,
+	[VM_SHARED | VM_EXEC]				= __S100,
+	[VM_SHARED | VM_EXEC | VM_READ]			= __S101,
+	[VM_SHARED | VM_EXEC | VM_WRITE]		= __S110,
+	[VM_SHARED | VM_EXEC | VM_WRITE | VM_READ]	= __S111
 };
 
 #ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
-- 
2.25.1

