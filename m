Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B073CA004
	for <lists+linux-arch@lfdr.de>; Thu, 15 Jul 2021 15:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbhGONvH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Jul 2021 09:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhGONvH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jul 2021 09:51:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F1BC06175F;
        Thu, 15 Jul 2021 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WOLvypKMIjhFPizMST7OeOsTsse8mwCG5b0u88ACeC0=; b=hn4BABqA9+08E5oQGD1ybUF0OQ
        oEipt+lhZBPhGk0KMO3WiqncwArQJJL6220EYvjN6E4zTmpOR/cjaxGVPyc21zEIMsfc74UZQhO//
        guEg5Yo8jFvczS5xweMQBHW8V9/37Zn9MvpxTB1HHrUHGYRyF+eMS8sQQfwJEP76QIcN+avETZdT0
        JOAdrU9RM4z3O0U3dMjA+F/sYbri/3I+5MqGsi3EYycBPRBjdKRzgS9MUVxcLV1qugBKNtX4WUUzh
        NvI+3s9lui3Nt9UPfMNTSFXC/nUm/ZoWQ+NUaUxU+wmB81705gNlJ3eM5rkV41aZeSbOaJZoE3zKP
        z58D/93w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m41hd-003OeO-PS; Thu, 15 Jul 2021 13:47:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm: Rename PMD_ORDER to PMD_TABLE_ORDER
Date:   Thu, 15 Jul 2021 14:46:10 +0100
Message-Id: <20210715134612.809280-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715134612.809280-1-willy@infradead.org>
References: <20210715134612.809280-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the order of the page table allocation, not the order of a PMD.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/arm/kernel/head.S | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 9eb0b4dbcc12..6da39a1d70ba 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -38,10 +38,10 @@
 #ifdef CONFIG_ARM_LPAE
 	/* LPAE requires an additional page for the PGD */
 #define PG_DIR_SIZE	0x5000
-#define PMD_ORDER	3
+#define PMD_TABLE_ORDER	3
 #else
 #define PG_DIR_SIZE	0x4000
-#define PMD_ORDER	2
+#define PMD_TABLE_ORDER	2
 #endif
 
 	.globl	swapper_pg_dir
@@ -237,7 +237,7 @@ __create_page_tables:
 	mov	r6, r6, lsr #SECTION_SHIFT
 
 1:	orr	r3, r7, r5, lsl #SECTION_SHIFT	@ flags + kernel base
-	str	r3, [r4, r5, lsl #PMD_ORDER]	@ identity mapping
+	str	r3, [r4, r5, lsl #PMD_TABLE_ORDER]	@ identity mapping
 	cmp	r5, r6
 	addlo	r5, r5, #1			@ next section
 	blo	1b
@@ -247,13 +247,13 @@ __create_page_tables:
 	 * set two variables to indicate the physical start and end of the
 	 * kernel.
 	 */
-	add	r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_TABLE_ORDER)
 	ldr	r6, =(_end - 1)
 	adr_l	r5, kernel_sec_start		@ _pa(kernel_sec_start)
 	str	r8, [r5]			@ Save physical start of kernel
 	orr	r3, r8, r7			@ Add the MMU flags
-	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
-1:	str	r3, [r0], #1 << PMD_ORDER
+	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_TABLE_ORDER)
+1:	str	r3, [r0], #1 << PMD_TABLE_ORDER
 	add	r3, r3, #1 << SECTION_SHIFT
 	cmp	r0, r6
 	bls	1b
@@ -269,14 +269,14 @@ __create_page_tables:
 	mov	r3, pc
 	mov	r3, r3, lsr #SECTION_SHIFT
 	orr	r3, r7, r3, lsl #SECTION_SHIFT
-	add	r0, r4,  #(XIP_START & 0xff000000) >> (SECTION_SHIFT - PMD_ORDER)
-	str	r3, [r0, #((XIP_START & 0x00f00000) >> SECTION_SHIFT) << PMD_ORDER]!
+	add	r0, r4,  #(XIP_START & 0xff000000) >> (SECTION_SHIFT - PMD_TABLE_ORDER)
+	str	r3, [r0, #((XIP_START & 0x00f00000) >> SECTION_SHIFT) << PMD_TABLE_ORDER]!
 	ldr	r6, =(_edata_loc - 1)
-	add	r0, r0, #1 << PMD_ORDER
-	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
+	add	r0, r0, #1 << PMD_TABLE_ORDER
+	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_TABLE_ORDER)
 1:	cmp	r0, r6
 	add	r3, r3, #1 << SECTION_SHIFT
-	strls	r3, [r0], #1 << PMD_ORDER
+	strls	r3, [r0], #1 << PMD_TABLE_ORDER
 	bls	1b
 #endif
 
@@ -286,10 +286,10 @@ __create_page_tables:
 	 */
 	mov	r0, r2, lsr #SECTION_SHIFT
 	cmp	r2, #0
-	ldrne	r3, =FDT_FIXED_BASE >> (SECTION_SHIFT - PMD_ORDER)
+	ldrne	r3, =FDT_FIXED_BASE >> (SECTION_SHIFT - PMD_TABLE_ORDER)
 	addne	r3, r3, r4
 	orrne	r6, r7, r0, lsl #SECTION_SHIFT
-	strne	r6, [r3], #1 << PMD_ORDER
+	strne	r6, [r3], #1 << PMD_TABLE_ORDER
 	addne	r6, r6, #1 << SECTION_SHIFT
 	strne	r6, [r3]
 
@@ -308,7 +308,7 @@ __create_page_tables:
 	addruart r7, r3, r0
 
 	mov	r3, r3, lsr #SECTION_SHIFT
-	mov	r3, r3, lsl #PMD_ORDER
+	mov	r3, r3, lsl #PMD_TABLE_ORDER
 
 	add	r0, r4, r3
 	mov	r3, r7, lsr #SECTION_SHIFT
@@ -338,7 +338,7 @@ __create_page_tables:
 	 * If we're using the NetWinder or CATS, we also need to map
 	 * in the 16550-type serial port for the debug messages
 	 */
-	add	r0, r4, #0xff000000 >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #0xff000000 >> (SECTION_SHIFT - PMD_TABLE_ORDER)
 	orr	r3, r7, #0x7c000000
 	str	r3, [r0]
 #endif
@@ -348,10 +348,10 @@ __create_page_tables:
 	 * Similar reasons here - for debug.  This is
 	 * only for Acorn RiscPC architectures.
 	 */
-	add	r0, r4, #0x02000000 >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #0x02000000 >> (SECTION_SHIFT - PMD_TABLE_ORDER)
 	orr	r3, r7, #0x02000000
 	str	r3, [r0]
-	add	r0, r4, #0xd8000000 >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #0xd8000000 >> (SECTION_SHIFT - PMD_TABLE_ORDER)
 	str	r3, [r0]
 #endif
 #endif
-- 
2.30.2

