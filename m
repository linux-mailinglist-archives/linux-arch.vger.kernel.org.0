Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE65566390
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 09:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiGEG6t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 02:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiGEG6s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 02:58:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF0E306;
        Mon,  4 Jul 2022 23:58:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFF08B8161C;
        Tue,  5 Jul 2022 06:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8CCC341CA;
        Tue,  5 Jul 2022 06:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657004324;
        bh=ZD6XXF2j2XJv17OqmANB5ez5uWQC8RfCKCRSnrl8T90=;
        h=From:To:Cc:Subject:Date:From;
        b=QmggCmmvcxyDkXhbP7zoNBpPQC3OHQiYcJSCegxXKWIICH+RqXobMGatVZfU/OBoD
         2Gb3BZwJw4sVpP2oathxZVewRO3CSRSecK+LjlxPw58hyANgnUp+EuJlmlPNfjcmZv
         9S26cKPsOS9ENF1sVt+/+HJdYobKMYifO0BFqOryNEVkomOCIIyySQoBRSisY+k7uC
         skoR9r++pVQF6gRZg0YU9t6qs1OP/0V4zuTxj9DjEXNfC5la/3rsvwYVey4wwyHJTg
         7xHDKTgkPXm8IVzCADOXhn9dXaKx/WU1+Y5CjgwpeXZfPgQng3wZHlA6jOteOcPL0L
         3mX0kwSvmnZaQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, deller@gmx.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: Correct position of _stext
Date:   Tue,  5 Jul 2022 02:58:37 -0400
Message-Id: <20220705065837.1172754-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
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

From: Guo Ren <guoren@linux.alibaba.com>

Correct position of _stext to prevent check_kernel_text_object
warning [1].

[1] https://lore.kernel.org/linux-csky/YfLpNkmlvoR8iPcq@ls3530/

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Helge Deller <deller@gmx.de>
---
 arch/csky/include/asm/sections.h | 10 ++++++++++
 arch/csky/kernel/setup.c         |  4 ++--
 arch/csky/kernel/vmlinux.lds.S   |  3 ++-
 3 files changed, 14 insertions(+), 3 deletions(-)
 create mode 100644 arch/csky/include/asm/sections.h

diff --git a/arch/csky/include/asm/sections.h b/arch/csky/include/asm/sections.h
new file mode 100644
index 000000000000..4192cba8445d
--- /dev/null
+++ b/arch/csky/include/asm/sections.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_SECTIONS_H
+#define __ASM_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+extern char _start[];
+
+#endif /* __ASM_SECTIONS_H */
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index c64e7be2045b..106fbf0b6f3b 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -31,7 +31,7 @@ static void __init csky_memblock_init(void)
 	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 	signed long size;
 
-	memblock_reserve(__pa(_stext), _end - _stext);
+	memblock_reserve(__pa(_start), _end - _start);
 
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
@@ -78,7 +78,7 @@ void __init setup_arch(char **cmdline_p)
 	pr_info("Phys. mem: %ldMB\n",
 		(unsigned long) memblock_phys_mem_size()/1024/1024);
 
-	setup_initial_init_mm(_stext, _etext, _edata, _end);
+	setup_initial_init_mm(_start, _etext, _edata, _end);
 
 	parse_early_param();
 
diff --git a/arch/csky/kernel/vmlinux.lds.S b/arch/csky/kernel/vmlinux.lds.S
index e8b1a4a49798..163a8cd8b9a6 100644
--- a/arch/csky/kernel/vmlinux.lds.S
+++ b/arch/csky/kernel/vmlinux.lds.S
@@ -22,7 +22,7 @@ SECTIONS
 {
 	. = PAGE_OFFSET + PHYS_OFFSET_OFFSET;
 
-	_stext = .;
+	_start = .;
 	__init_begin = .;
 	HEAD_TEXT_SECTION
 	INIT_TEXT_SECTION(PAGE_SIZE)
@@ -33,6 +33,7 @@ SECTIONS
 
 	.text : AT(ADDR(.text) - LOAD_OFFSET) {
 		_text = .;
+		_stext = .;
 		VBR_BASE
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
-- 
2.36.1

