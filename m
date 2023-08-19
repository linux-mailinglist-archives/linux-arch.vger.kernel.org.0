Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F333E781B98
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 02:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjHTAR7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Aug 2023 20:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjHTAR5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 20:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1523488CE9;
        Sat, 19 Aug 2023 16:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A929661A5C;
        Sat, 19 Aug 2023 23:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0238DC433CA;
        Sat, 19 Aug 2023 23:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692488041;
        bh=JFhA8y871vv+gRtTcPjd9V7hXE56sCKpW0Vj8S1748E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKO9KLcyBESyHV5iuYqMVkQhzDHq8YAPi1uEoCKavq2tdIxRG1lOlcpEZty1plKYK
         cvjDXVhm0Q+9efwybvbdTRJa9sSR+t7W6jT4CulLPJcuEOJezK0zQvjmrmk9zJmDdE
         OIThQhaGtDa9lmsMo7ciFoLBZvkYzr7cdsKMx6rrs1b+Hr+VelhUQpANV4/jILNd8K
         SetHh7xHsayX62uCNaSnZ9o/rZ/IhwvYqOwLU+U9SCfvCP6x3pftrHIZNbamnCHb68
         YDbY3BFle/2KkzG8Ubxd/Xf4TiKa9yPBoN0Y29dlW5IAUZmJeb27euy7QXuEYzd5ZG
         XcFEV2p3pWgzA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] ia64: replace #include <asm/export.h> with #include <linux/export.h>
Date:   Sun, 20 Aug 2023 08:33:50 +0900
Message-Id: <20230819233353.3683813-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819233353.3683813-1-masahiroy@kernel.org>
References: <20230819233353.3683813-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
deprecated <asm/export.h>, which is now a wrapper of <linux/export.h>.

Replace #include <asm/export.h> with #include <linux/export.h>.

After all the <asm/export.h> lines are converted, <asm/export.h> and
<asm-generic/export.h> will be removed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/ia64/kernel/entry.S          | 3 +--
 arch/ia64/kernel/esi_stub.S       | 2 +-
 arch/ia64/kernel/head.S           | 3 +--
 arch/ia64/kernel/ivt.S            | 3 +--
 arch/ia64/kernel/pal.S            | 2 +-
 arch/ia64/lib/clear_page.S        | 2 +-
 arch/ia64/lib/clear_user.S        | 2 +-
 arch/ia64/lib/copy_page.S         | 2 +-
 arch/ia64/lib/copy_page_mck.S     | 2 +-
 arch/ia64/lib/copy_user.S         | 2 +-
 arch/ia64/lib/flush.S             | 3 +--
 arch/ia64/lib/idiv32.S            | 2 +-
 arch/ia64/lib/idiv64.S            | 2 +-
 arch/ia64/lib/ip_fast_csum.S      | 2 +-
 arch/ia64/lib/memcpy.S            | 2 +-
 arch/ia64/lib/memcpy_mck.S        | 2 +-
 arch/ia64/lib/memset.S            | 2 +-
 arch/ia64/lib/strlen.S            | 2 +-
 arch/ia64/lib/strncpy_from_user.S | 2 +-
 arch/ia64/lib/strnlen_user.S      | 2 +-
 arch/ia64/lib/xor.S               | 2 +-
 21 files changed, 21 insertions(+), 25 deletions(-)

diff --git a/arch/ia64/kernel/entry.S b/arch/ia64/kernel/entry.S
index 5eba3fb2e311..ac06d44b9b27 100644
--- a/arch/ia64/kernel/entry.S
+++ b/arch/ia64/kernel/entry.S
@@ -37,7 +37,7 @@
  *	pNonSys:	!pSys
  */
 
-
+#include <linux/export.h>
 #include <linux/pgtable.h>
 #include <asm/asmmacro.h>
 #include <asm/cache.h>
@@ -49,7 +49,6 @@
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
 #include <asm/ftrace.h>
-#include <asm/export.h>
 
 #include "minstate.h"
 
diff --git a/arch/ia64/kernel/esi_stub.S b/arch/ia64/kernel/esi_stub.S
index 821e68d10598..9928c5b2957c 100644
--- a/arch/ia64/kernel/esi_stub.S
+++ b/arch/ia64/kernel/esi_stub.S
@@ -34,9 +34,9 @@
 #define PSR_BITS_TO_SET							\
 	(IA64_PSR_BN)
 
+#include <linux/export.h>
 #include <asm/processor.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 
 /*
  * Inputs:
diff --git a/arch/ia64/kernel/head.S b/arch/ia64/kernel/head.S
index c096500590e9..85c8a57da402 100644
--- a/arch/ia64/kernel/head.S
+++ b/arch/ia64/kernel/head.S
@@ -20,7 +20,7 @@
  *   Support for CPU Hotplug
  */
 
-
+#include <linux/export.h>
 #include <linux/pgtable.h>
 #include <asm/asmmacro.h>
 #include <asm/fpu.h>
@@ -33,7 +33,6 @@
 #include <asm/mca_asm.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define SAL_PSR_BITS_TO_SET				\
diff --git a/arch/ia64/kernel/ivt.S b/arch/ia64/kernel/ivt.S
index 7a418e324d30..da90c49df628 100644
--- a/arch/ia64/kernel/ivt.S
+++ b/arch/ia64/kernel/ivt.S
@@ -47,7 +47,7 @@
  * Table is based upon EAS2.6 (Oct 1999)
  */
 
-
+#include <linux/export.h>
 #include <linux/pgtable.h>
 #include <asm/asmmacro.h>
 #include <asm/break.h>
@@ -58,7 +58,6 @@
 #include <asm/thread_info.h>
 #include <asm/unistd.h>
 #include <asm/errno.h>
-#include <asm/export.h>
 
 #if 0
 # define PSR_DEFAULT_BITS	psr.ac
diff --git a/arch/ia64/kernel/pal.S b/arch/ia64/kernel/pal.S
index 06d01a070aae..fb6db6966f70 100644
--- a/arch/ia64/kernel/pal.S
+++ b/arch/ia64/kernel/pal.S
@@ -13,9 +13,9 @@
  * 05/24/2000 eranian Added support for physical mode static calls
  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
 #include <asm/processor.h>
-#include <asm/export.h>
 
 	.data
 pal_entry_point:
diff --git a/arch/ia64/lib/clear_page.S b/arch/ia64/lib/clear_page.S
index 65b75085c8f4..ba0dd2538fa5 100644
--- a/arch/ia64/lib/clear_page.S
+++ b/arch/ia64/lib/clear_page.S
@@ -10,9 +10,9 @@
  * 3/08/02 davidm	Some more tweaking
  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
 #include <asm/page.h>
-#include <asm/export.h>
 
 #ifdef CONFIG_ITANIUM
 # define L3_LINE_SIZE	64	// Itanium L3 line size
diff --git a/arch/ia64/lib/clear_user.S b/arch/ia64/lib/clear_user.S
index a28f39d349eb..1d9e45ccf8e5 100644
--- a/arch/ia64/lib/clear_user.S
+++ b/arch/ia64/lib/clear_user.S
@@ -12,8 +12,8 @@
  *	Stephane Eranian <eranian@hpl.hp.com>
  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 
 //
 // arguments
diff --git a/arch/ia64/lib/copy_page.S b/arch/ia64/lib/copy_page.S
index 176f857c522e..c0a0e6b2af00 100644
--- a/arch/ia64/lib/copy_page.S
+++ b/arch/ia64/lib/copy_page.S
@@ -15,9 +15,9 @@
  *
  * 4/06/01 davidm	Tuned to make it perform well both for cached and uncached copies.
  */
+#include <linux/export.h>
 #include <asm/asmmacro.h>
 #include <asm/page.h>
-#include <asm/export.h>
 
 #define PIPE_DEPTH	3
 #define EPI		p[PIPE_DEPTH-1]
diff --git a/arch/ia64/lib/copy_page_mck.S b/arch/ia64/lib/copy_page_mck.S
index d6fd56e4f1c1..5e8bb4b4b535 100644
--- a/arch/ia64/lib/copy_page_mck.S
+++ b/arch/ia64/lib/copy_page_mck.S
@@ -60,9 +60,9 @@
  *	to fetch the second-half of the L2 cache line into L1, and the tX words are copied in
  *	an order that avoids bank conflicts.
  */
+#include <linux/export.h>
 #include <asm/asmmacro.h>
 #include <asm/page.h>
-#include <asm/export.h>
 
 #define PREFETCH_DIST	8		// McKinley sustains 16 outstanding L2 misses (8 ld, 8 st)
 
diff --git a/arch/ia64/lib/copy_user.S b/arch/ia64/lib/copy_user.S
index f681556c6b86..8daab72cfe77 100644
--- a/arch/ia64/lib/copy_user.S
+++ b/arch/ia64/lib/copy_user.S
@@ -30,8 +30,8 @@
  *	- fix extraneous stop bit introduced by the EX() macro.
  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 
 //
 // Tuneable parameters
diff --git a/arch/ia64/lib/flush.S b/arch/ia64/lib/flush.S
index 8573d59c9ed1..f8e795fe45cb 100644
--- a/arch/ia64/lib/flush.S
+++ b/arch/ia64/lib/flush.S
@@ -8,9 +8,8 @@
  * 05/28/05 Zoltan Menyhart	Dynamic stride size
  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
-
 
 	/*
 	 * flush_icache_range(start,end)
diff --git a/arch/ia64/lib/idiv32.S b/arch/ia64/lib/idiv32.S
index def92b708e6e..83586fbc51ff 100644
--- a/arch/ia64/lib/idiv32.S
+++ b/arch/ia64/lib/idiv32.S
@@ -15,8 +15,8 @@
  * (http://www.goodreads.com/book/show/2019887.Ia_64_and_Elementary_Functions)
  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 
 #ifdef MODULO
 # define OP	mod
diff --git a/arch/ia64/lib/idiv64.S b/arch/ia64/lib/idiv64.S
index a8ba3bd3d4d8..5c9113691f72 100644
--- a/arch/ia64/lib/idiv64.S
+++ b/arch/ia64/lib/idiv64.S
@@ -15,8 +15,8 @@
  * (http://www.goodreads.com/book/show/2019887.Ia_64_and_Elementary_Functions)
  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 
 #ifdef MODULO
 # define OP	mod
diff --git a/arch/ia64/lib/ip_fast_csum.S b/arch/ia64/lib/ip_fast_csum.S
index dc9e6e6fe876..fcc0b812ce2e 100644
--- a/arch/ia64/lib/ip_fast_csum.S
+++ b/arch/ia64/lib/ip_fast_csum.S
@@ -13,8 +13,8 @@
  * Copyright (C) 2002, 2006 Ken Chen <kenneth.w.chen@intel.com>
  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 
 /*
  * Since we know that most likely this function is called with buf aligned
diff --git a/arch/ia64/lib/memcpy.S b/arch/ia64/lib/memcpy.S
index 91a625fddbf0..35c9069a8345 100644
--- a/arch/ia64/lib/memcpy.S
+++ b/arch/ia64/lib/memcpy.S
@@ -14,8 +14,8 @@
  *	Stephane Eranian <eranian@hpl.hp.com>
  *	David Mosberger-Tang <davidm@hpl.hp.com>
  */
+#include <linux/export.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 
 GLOBAL_ENTRY(memcpy)
 
diff --git a/arch/ia64/lib/memcpy_mck.S b/arch/ia64/lib/memcpy_mck.S
index cc4e6ac914b6..c0d4362217ae 100644
--- a/arch/ia64/lib/memcpy_mck.S
+++ b/arch/ia64/lib/memcpy_mck.S
@@ -14,9 +14,9 @@
  * Copyright (C) 2002 Intel Corp.
  * Copyright (C) 2002 Ken Chen <kenneth.w.chen@intel.com>
  */
+#include <linux/export.h>
 #include <asm/asmmacro.h>
 #include <asm/page.h>
-#include <asm/export.h>
 
 #define EK(y...) EX(y)
 
diff --git a/arch/ia64/lib/memset.S b/arch/ia64/lib/memset.S
index 07a8b92c6496..552c5c7e4d06 100644
--- a/arch/ia64/lib/memset.S
+++ b/arch/ia64/lib/memset.S
@@ -18,8 +18,8 @@
    Since a stf.spill f0 can store 16B in one go, we use this instruction
    to get peak speed when value = 0.  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 #undef ret
 
 #define dest		in0
diff --git a/arch/ia64/lib/strlen.S b/arch/ia64/lib/strlen.S
index d66de5966974..1f4a46c15127 100644
--- a/arch/ia64/lib/strlen.S
+++ b/arch/ia64/lib/strlen.S
@@ -17,8 +17,8 @@
  * 09/24/99 S.Eranian add speculation recovery code
  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 
 //
 //
diff --git a/arch/ia64/lib/strncpy_from_user.S b/arch/ia64/lib/strncpy_from_user.S
index 49eb81b69cd2..a287169bd953 100644
--- a/arch/ia64/lib/strncpy_from_user.S
+++ b/arch/ia64/lib/strncpy_from_user.S
@@ -17,8 +17,8 @@
  *			 by Andreas Schwab <schwab@suse.de>).
  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 
 GLOBAL_ENTRY(__strncpy_from_user)
 	alloc r2=ar.pfs,3,0,0,0
diff --git a/arch/ia64/lib/strnlen_user.S b/arch/ia64/lib/strnlen_user.S
index 4b684d4da106..a7eb56e840a9 100644
--- a/arch/ia64/lib/strnlen_user.S
+++ b/arch/ia64/lib/strnlen_user.S
@@ -13,8 +13,8 @@
  * Copyright (C) 1999, 2001 David Mosberger-Tang <davidm@hpl.hp.com>
  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 
 GLOBAL_ENTRY(__strnlen_user)
 	.prologue
diff --git a/arch/ia64/lib/xor.S b/arch/ia64/lib/xor.S
index 5413dafe6b2e..6e2a69662c06 100644
--- a/arch/ia64/lib/xor.S
+++ b/arch/ia64/lib/xor.S
@@ -5,8 +5,8 @@
  * Optimized RAID-5 checksumming functions for IA-64.
  */
 
+#include <linux/export.h>
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 
 GLOBAL_ENTRY(xor_ia64_2)
 	.prologue
-- 
2.39.2

