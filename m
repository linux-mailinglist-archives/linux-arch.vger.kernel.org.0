Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14336772943
	for <lists+linux-arch@lfdr.de>; Mon,  7 Aug 2023 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjHGPc4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Aug 2023 11:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjHGPcx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Aug 2023 11:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1267FBD;
        Mon,  7 Aug 2023 08:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 744D861E0C;
        Mon,  7 Aug 2023 15:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF98C433C9;
        Mon,  7 Aug 2023 15:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691422370;
        bh=WDVv22MYYfLqjdwf8Gw7PbfPu+30r8uVpIIUVl3UkFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWfaVxKnRv69ooHYPILI0MVK98tkMGMuwWYY76pcQWuyB3YkoQXAAbcnObAI68n1T
         /8zec6weUmLF+gdxCYWPQRhfjzA4aXSnn5iYnn/UAyd3Wwq5AurhQjtrLU5EI8qXGu
         sUk+9jS+zxAGvvk0V9OgRNWHlq4s72VQzjBly9Y6oIZXGdpTakiTgkqWmkedGV+my0
         5N18gSVC76THBVKWtpw1lxjlv5cP6e+srqK+P5QBnFWfp75FIIaDPk6+bNwpa7mEMZ
         sxBpoG+mC1MKrnTuA5yKBmuVDW++FKnYxesqUiaNYPrPLgbwspjG4gJhSQ3sISs+Nf
         XVofTJLalCj5w==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] mips: replace #include <asm/export.h> with #include <linux/export.h>
Date:   Tue,  8 Aug 2023 00:32:42 +0900
Message-Id: <20230807153243.996262-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807153243.996262-1-masahiroy@kernel.org>
References: <20230807153243.996262-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

 arch/mips/cavium-octeon/octeon-memcpy.S | 2 +-
 arch/mips/kernel/mcount.S               | 2 +-
 arch/mips/kernel/r2300_fpu.S            | 2 +-
 arch/mips/kernel/r4k_fpu.S              | 2 +-
 arch/mips/lib/csum_partial.S            | 2 +-
 arch/mips/lib/memcpy.S                  | 2 +-
 arch/mips/lib/memset.S                  | 2 +-
 arch/mips/lib/strncpy_user.S            | 2 +-
 arch/mips/lib/strnlen_user.S            | 2 +-
 arch/mips/mm/page-funcs.S               | 2 +-
 arch/mips/mm/tlb-funcs.S                | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 25860fba6218..fef0c6de3fa1 100644
--- a/arch/mips/cavium-octeon/octeon-memcpy.S
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -13,9 +13,9 @@
  * Mnemonic names for arguments to memcpy/__copy_user
  */
 
+#include <linux/export.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 #define dst a0
diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index cff52b283e03..fcec579f64e9 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -10,7 +10,7 @@
  * Author: Wu Zhangjin <wuzhangjin@gmail.com>
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
 #include <asm/ftrace.h>
diff --git a/arch/mips/kernel/r2300_fpu.S b/arch/mips/kernel/r2300_fpu.S
index 6c745aa9e825..c000b22e3fcd 100644
--- a/arch/mips/kernel/r2300_fpu.S
+++ b/arch/mips/kernel/r2300_fpu.S
@@ -11,10 +11,10 @@
  * Further modifications to make this work:
  * Copyright (c) 1998 Harald Koerfgen
  */
+#include <linux/export.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/errno.h>
-#include <asm/export.h>
 #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
 #include <asm/asm-offsets.h>
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 4e8c98517d9d..4bb97ee89904 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -12,10 +12,10 @@
  * Copyright (C) 2000 MIPS Technologies, Inc.
  * Copyright (C) 1999, 2001 Silicon Graphics, Inc.
  */
+#include <linux/export.h>
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
 #include <asm/errno.h>
-#include <asm/export.h>
 #include <asm/fpregdef.h>
 #include <asm/mipsregs.h>
 #include <asm/asm-offsets.h>
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 7767137c3e49..3d2ff4118d79 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -11,9 +11,9 @@
  * Copyright (C) 2014 Imagination Technologies Ltd.
  */
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 #ifdef CONFIG_64BIT
diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 18a43f2e29c8..a4b4e805ff13 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -32,9 +32,9 @@
 #undef CONFIG_CPU_HAS_PREFETCH
 #endif
 
+#include <linux/export.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 #define dst a0
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 0b342bae9a98..79405c32cc85 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -8,9 +8,9 @@
  * Copyright (C) 2007 by Maciej W. Rozycki
  * Copyright (C) 2011, 2012 MIPS Technologies, Inc.
  */
+#include <linux/export.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 #if LONGSIZE == 4
diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
index 13aaa9927ad1..94f4203563c1 100644
--- a/arch/mips/lib/strncpy_user.S
+++ b/arch/mips/lib/strncpy_user.S
@@ -7,9 +7,9 @@
  * Copyright (C) 2011 MIPS Technologies, Inc.
  */
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 #define EX(insn,reg,addr,handler)			\
diff --git a/arch/mips/lib/strnlen_user.S b/arch/mips/lib/strnlen_user.S
index 6de31b616f9c..c192a6f6cd84 100644
--- a/arch/mips/lib/strnlen_user.S
+++ b/arch/mips/lib/strnlen_user.S
@@ -6,9 +6,9 @@
  * Copyright (c) 1996, 1998, 1999, 2004 by Ralf Baechle
  * Copyright (c) 1999 Silicon Graphics, Inc.
  */
+#include <linux/export.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 #define EX(insn,reg,addr,handler)			\
diff --git a/arch/mips/mm/page-funcs.S b/arch/mips/mm/page-funcs.S
index 43181ac0a1af..42d0516ca18a 100644
--- a/arch/mips/mm/page-funcs.S
+++ b/arch/mips/mm/page-funcs.S
@@ -8,8 +8,8 @@
  * Copyright (C) 2012  MIPS Technologies, Inc.
  * Copyright (C) 2012  Ralf Baechle <ralf@linux-mips.org>
  */
+#include <linux/export.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 #ifdef CONFIG_SIBYTE_DMA_PAGEOPS
diff --git a/arch/mips/mm/tlb-funcs.S b/arch/mips/mm/tlb-funcs.S
index 00fef578c8cd..2705d7dcb33e 100644
--- a/arch/mips/mm/tlb-funcs.S
+++ b/arch/mips/mm/tlb-funcs.S
@@ -11,8 +11,8 @@
  * Copyright (C) 2012  MIPS Technologies, Inc.
  * Copyright (C) 2012  Ralf Baechle <ralf@linux-mips.org>
  */
+#include <linux/export.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 #include <asm/regdef.h>
 
 #define FASTPATH_SIZE	128
-- 
2.39.2

