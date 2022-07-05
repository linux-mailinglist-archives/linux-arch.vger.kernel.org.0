Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554AE567361
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 17:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiGEPun (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiGEPuI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 11:50:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B112A1EC4D;
        Tue,  5 Jul 2022 08:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2541F61B4A;
        Tue,  5 Jul 2022 15:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4EEC341CB;
        Tue,  5 Jul 2022 15:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657036136;
        bh=0MRT2mp6jbXkb/N3zPVWAzD1HZ6bXCAgcxDNmnhtrWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=miZdIT7JsRLdt69tvlva3KuD2lKZHxDqGlzFubQD1U1n/zlhLYFv79wIBEOz/P25E
         2KWYOUg8w6jNPPD+/0pU8kSPuOsLc4kC1NAhXPmqIhk4XABAqGB4aOGwRSwEzuIts0
         liGjUl7mf0AWvM5W1nfuAw6HJDV4stig/zlXb2guDJBiCwsSMztLh6N9PDqPpCha0Q
         pGHMf4eIYITQkIGVAVDkUWl9exktSvQEPzwaG1dnwi0a6HmOj9BsiXP3AyWYYURC/f
         zswHWUByWbBVy0mDbMX2629JNzw3t6BsoXQW+91hyrG/QQxd7TGdEZ2072aatpiStj
         U5toLbi4fFKYA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        loongarch@lists.linux.dev,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH v2 15/15] ARM: head.S: rename PMD_ORDER to PMD_ENTRY_ORDER
Date:   Tue,  5 Jul 2022 18:47:08 +0300
Message-Id: <20220705154708.181258-16-rppt@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220705154708.181258-1-rppt@kernel.org>
References: <20220705154708.181258-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

PMD_ORDER denotes order of magnitude for a PMD entry, i.e PMD entry
size is 2 ^ PMD_ORDER.

Rename PMD_ORDER to PMD_ENTRY_ORDER to allow a generic definition of
PMD_ORDER as order of a PMD allocation: (PMD_SHIFT - PAGE_SHIFT).

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/head.S | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 500612d3da2e..29e2900178a1 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -38,10 +38,10 @@
 #ifdef CONFIG_ARM_LPAE
 	/* LPAE requires an additional page for the PGD */
 #define PG_DIR_SIZE	0x5000
-#define PMD_ORDER	3
+#define PMD_ENTRY_ORDER	3	/* PMD entry size is 2^PMD_ENTRY_ORDER */
 #else
 #define PG_DIR_SIZE	0x4000
-#define PMD_ORDER	2
+#define PMD_ENTRY_ORDER	2
 #endif
 
 	.globl	swapper_pg_dir
@@ -240,7 +240,7 @@ __create_page_tables:
 	mov	r6, r6, lsr #SECTION_SHIFT
 
 1:	orr	r3, r7, r5, lsl #SECTION_SHIFT	@ flags + kernel base
-	str	r3, [r4, r5, lsl #PMD_ORDER]	@ identity mapping
+	str	r3, [r4, r5, lsl #PMD_ENTRY_ORDER]	@ identity mapping
 	cmp	r5, r6
 	addlo	r5, r5, #1			@ next section
 	blo	1b
@@ -250,7 +250,7 @@ __create_page_tables:
 	 * set two variables to indicate the physical start and end of the
 	 * kernel.
 	 */
-	add	r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
 	ldr	r6, =(_end - 1)
 	adr_l	r5, kernel_sec_start		@ _pa(kernel_sec_start)
 #if defined CONFIG_CPU_ENDIAN_BE8 || defined CONFIG_CPU_ENDIAN_BE32
@@ -259,8 +259,8 @@ __create_page_tables:
 	str	r8, [r5]			@ Save physical start of kernel (LE)
 #endif
 	orr	r3, r8, r7			@ Add the MMU flags
-	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
-1:	str	r3, [r0], #1 << PMD_ORDER
+	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ENTRY_ORDER)
+1:	str	r3, [r0], #1 << PMD_ENTRY_ORDER
 	add	r3, r3, #1 << SECTION_SHIFT
 	cmp	r0, r6
 	bls	1b
@@ -280,14 +280,14 @@ __create_page_tables:
 	mov	r3, pc
 	mov	r3, r3, lsr #SECTION_SHIFT
 	orr	r3, r7, r3, lsl #SECTION_SHIFT
-	add	r0, r4,  #(XIP_START & 0xff000000) >> (SECTION_SHIFT - PMD_ORDER)
-	str	r3, [r0, #((XIP_START & 0x00f00000) >> SECTION_SHIFT) << PMD_ORDER]!
+	add	r0, r4,  #(XIP_START & 0xff000000) >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
+	str	r3, [r0, #((XIP_START & 0x00f00000) >> SECTION_SHIFT) << PMD_ENTRY_ORDER]!
 	ldr	r6, =(_edata_loc - 1)
-	add	r0, r0, #1 << PMD_ORDER
-	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
+	add	r0, r0, #1 << PMD_ENTRY_ORDER
+	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ENTRY_ORDER)
 1:	cmp	r0, r6
 	add	r3, r3, #1 << SECTION_SHIFT
-	strls	r3, [r0], #1 << PMD_ORDER
+	strls	r3, [r0], #1 << PMD_ENTRY_ORDER
 	bls	1b
 #endif
 
@@ -297,10 +297,10 @@ __create_page_tables:
 	 */
 	mov	r0, r2, lsr #SECTION_SHIFT
 	cmp	r2, #0
-	ldrne	r3, =FDT_FIXED_BASE >> (SECTION_SHIFT - PMD_ORDER)
+	ldrne	r3, =FDT_FIXED_BASE >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
 	addne	r3, r3, r4
 	orrne	r6, r7, r0, lsl #SECTION_SHIFT
-	strne	r6, [r3], #1 << PMD_ORDER
+	strne	r6, [r3], #1 << PMD_ENTRY_ORDER
 	addne	r6, r6, #1 << SECTION_SHIFT
 	strne	r6, [r3]
 
@@ -319,7 +319,7 @@ __create_page_tables:
 	addruart r7, r3, r0
 
 	mov	r3, r3, lsr #SECTION_SHIFT
-	mov	r3, r3, lsl #PMD_ORDER
+	mov	r3, r3, lsl #PMD_ENTRY_ORDER
 
 	add	r0, r4, r3
 	mov	r3, r7, lsr #SECTION_SHIFT
@@ -349,7 +349,7 @@ __create_page_tables:
 	 * If we're using the NetWinder or CATS, we also need to map
 	 * in the 16550-type serial port for the debug messages
 	 */
-	add	r0, r4, #0xff000000 >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #0xff000000 >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
 	orr	r3, r7, #0x7c000000
 	str	r3, [r0]
 #endif
@@ -359,10 +359,10 @@ __create_page_tables:
 	 * Similar reasons here - for debug.  This is
 	 * only for Acorn RiscPC architectures.
 	 */
-	add	r0, r4, #0x02000000 >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #0x02000000 >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
 	orr	r3, r7, #0x02000000
 	str	r3, [r0]
-	add	r0, r4, #0xd8000000 >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #0xd8000000 >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
 	str	r3, [r0]
 #endif
 #endif
-- 
2.34.1

