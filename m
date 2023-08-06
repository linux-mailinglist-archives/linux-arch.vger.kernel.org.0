Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6827715B5
	for <lists+linux-arch@lfdr.de>; Sun,  6 Aug 2023 17:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjHFPAX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Aug 2023 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjHFPAW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Aug 2023 11:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE95E4B;
        Sun,  6 Aug 2023 08:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4660C6119B;
        Sun,  6 Aug 2023 15:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF0FC433C9;
        Sun,  6 Aug 2023 15:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691334019;
        bh=gHd+SIWcCh6tp6EkPVo9vT4terx63+SBy0E1he1cvgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rnciOujcleDsSDjs9oQ3zjOjRY39apdxCshTMkGoTSxyEJFpy5WtXlpgfAOupG6R3
         3aBJZTTEmHhCJ42GAsR5oxiNxuqIPECkVk5gK2V+j/KzHnq7O0d/2NluMjNmdE7zLA
         nQOmWLLLr+J01DNpr9dKbsf946GGFrSk4w2zoPKFrBvVaxLBePOP8Fyi+CV4wOGPuQ
         xynztGGkDSFtxUAkGgs/2d7Flf8PSgEHCpBuUDntCIh9Vc+OhMTOY694wvoyciA+tF
         spHb65rDsvi4gGTSFFYwerBqo0xjtBQhgJzRwavXM2TOxPkl/yuXkUFdRfPuhoficD
         xMjEXM+KpXGTw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/3] x86: replace #include <asm/export.h> with #include <linux/export.h>
Date:   Sun,  6 Aug 2023 23:59:56 +0900
Message-Id: <20230806145958.380314-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230806145958.380314-1-masahiroy@kernel.org>
References: <20230806145958.380314-1-masahiroy@kernel.org>
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

Use <linux/export.h> in *.S as well as in *.c files.

After all the <asm/export.h> lines are replaced, <asm/export.h> and
<asm-generic/export.h> will be removed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/entry/entry.S               | 2 +-
 arch/x86/entry/entry_64.S            | 2 +-
 arch/x86/entry/thunk_32.S            | 2 +-
 arch/x86/entry/thunk_64.S            | 2 +-
 arch/x86/kernel/ftrace_32.S          | 2 +-
 arch/x86/kernel/ftrace_64.S          | 2 +-
 arch/x86/kernel/head_32.S            | 2 +-
 arch/x86/kernel/head_64.S            | 3 +--
 arch/x86/kernel/irqflags.S           | 2 +-
 arch/x86/lib/checksum_32.S           | 2 +-
 arch/x86/lib/clear_page_64.S         | 2 +-
 arch/x86/lib/cmpxchg8b_emu.S         | 2 +-
 arch/x86/lib/copy_page_64.S          | 2 +-
 arch/x86/lib/copy_user_64.S          | 2 +-
 arch/x86/lib/copy_user_uncached_64.S | 2 +-
 arch/x86/lib/getuser.S               | 2 +-
 arch/x86/lib/hweight.S               | 2 +-
 arch/x86/lib/memcpy_64.S             | 2 +-
 arch/x86/lib/memmove_32.S            | 2 +-
 arch/x86/lib/memmove_64.S            | 2 +-
 arch/x86/lib/memset_64.S             | 2 +-
 arch/x86/lib/putuser.S               | 3 +--
 arch/x86/lib/retpoline.S             | 2 +-
 arch/x86/um/checksum_32.S            | 2 +-
 24 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index bfb7bcb362bc..8c8d38f0cb1d 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -3,8 +3,8 @@
  * Common place for both 32- and 64-bit entry routines.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 #include <asm/msr-index.h>
 
 .pushsection .noinstr.text, "ax"
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 43606de22511..be08efa33e9f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -18,6 +18,7 @@
  * - SYM_FUNC_START/END:Define functions in the symbol table.
  * - idtentry:		Define exception entry points.
  */
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/cache.h>
@@ -34,7 +35,6 @@
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/pgtable_types.h>
-#include <asm/export.h>
 #include <asm/frame.h>
 #include <asm/trapnr.h>
 #include <asm/nospec-branch.h>
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index ff6e7003da97..0103e103a657 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -4,9 +4,9 @@
  * Copyright 2008 by Steven Rostedt, Red Hat, Inc
  *  (inspired by Andi Kleen's thunk_64.S)
  */
+	#include <linux/export.h>
 	#include <linux/linkage.h>
 	#include <asm/asm.h>
-	#include <asm/export.h>
 
 	/* put return address in eax (arg1) */
 	.macro THUNK name, func, put_ret_addr_in_eax=0
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 27b5da2111ac..416b400f39db 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -4,10 +4,10 @@
  * disturbance of register allocation in some inline assembly constructs.
  * Copyright 2001,2002 by Andi Kleen, SuSE Labs.
  */
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include "calling.h"
 #include <asm/asm.h>
-#include <asm/export.h>
 
 	/* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 	.macro THUNK name, func
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 24c1175a47e2..58d9ed50fe61 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -3,10 +3,10 @@
  *  Copyright (C) 2017  Steven Rostedt, VMware Inc.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/page_types.h>
 #include <asm/segment.h>
-#include <asm/export.h>
 #include <asm/ftrace.h>
 #include <asm/nospec-branch.h>
 #include <asm/frame.h>
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 945cfa5f7239..214f30e9f0c0 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -3,12 +3,12 @@
  *  Copyright (C) 2014  Steven Rostedt, Red Hat Inc
  */
 
+#include <linux/export.h>
 #include <linux/cfi_types.h>
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/ftrace.h>
-#include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
 #include <asm/frame.h>
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index c9318993f959..b6554212b7c7 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -8,6 +8,7 @@
  */
 
 .text
+#include <linux/export.h>
 #include <linux/threads.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
@@ -25,7 +26,6 @@
 #include <asm/nops.h>
 #include <asm/nospec-branch.h>
 #include <asm/bootparam.h>
-#include <asm/export.h>
 #include <asm/pgtable_32.h>
 
 /* Physical address */
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c5b9289837dc..3d055bff018e 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -9,7 +9,7 @@
  *  Copyright (C) 2005 Eric Biederman <ebiederm@xmission.com>
  */
 
-
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <linux/threads.h>
 #include <linux/init.h>
@@ -22,7 +22,6 @@
 #include <asm/percpu.h>
 #include <asm/nops.h>
 #include "../entry/calling.h"
-#include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/apicdef.h>
 #include <asm/fixmap.h>
diff --git a/arch/x86/kernel/irqflags.S b/arch/x86/kernel/irqflags.S
index aaf9e776f323..7f542a7799cb 100644
--- a/arch/x86/kernel/irqflags.S
+++ b/arch/x86/kernel/irqflags.S
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #include <asm/asm.h>
-#include <asm/export.h>
+#include <linux/export.h>
 #include <linux/linkage.h>
 
 /*
diff --git a/arch/x86/lib/checksum_32.S b/arch/x86/lib/checksum_32.S
index 23318c338db0..68f7fa3e1322 100644
--- a/arch/x86/lib/checksum_32.S
+++ b/arch/x86/lib/checksum_32.S
@@ -21,10 +21,10 @@
  *                   converted to pure assembler
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/errno.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 #include <asm/nospec-branch.h>
 
 /*
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index f74a3e704a1c..2760a15fbc00 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 
 /*
  * Most CPUs support enhanced REP MOVSB/STOSB instructions. It is
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index 49805257b125..873e4ef23e49 100644
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 #include <asm/percpu.h>
 #include <asm/processor-flags.h>
 
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index 30ea644bf446..d6ae793d08fa 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Written 2003 by Andi Kleen, based on a kernel by Evandro Menezes */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
-#include <asm/export.h>
 
 /*
  * Some CPUs run faster using the string copy instructions (sane microcode).
diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 01c5de4c279b..e7c791de69ae 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -6,11 +6,11 @@
  * Functions to copy from and to user space.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 
 /*
  * rep_movs_alternative - memory copy with exception handling.
diff --git a/arch/x86/lib/copy_user_uncached_64.S b/arch/x86/lib/copy_user_uncached_64.S
index 5c5f38d32672..2918e36eece2 100644
--- a/arch/x86/lib/copy_user_uncached_64.S
+++ b/arch/x86/lib/copy_user_uncached_64.S
@@ -3,9 +3,9 @@
  * Copyright 2023 Linus Torvalds <torvalds@linux-foundation.org>
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 
 /*
  * copy_user_nocache - Uncached memory copy with exception handling
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index 9c63713477bb..20ef350a60fb 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -26,6 +26,7 @@
  * as they get called from within inline assembly.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/page_types.h>
 #include <asm/errno.h>
@@ -33,7 +34,6 @@
 #include <asm/thread_info.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
-#include <asm/export.h>
 
 #define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
 
diff --git a/arch/x86/lib/hweight.S b/arch/x86/lib/hweight.S
index 12c16c6aa44a..5e5e9e3f8fb7 100644
--- a/arch/x86/lib/hweight.S
+++ b/arch/x86/lib/hweight.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 #include <asm/asm.h>
 
diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
index 8f95fb267caa..516121a3a3e6 100644
--- a/arch/x86/lib/memcpy_64.S
+++ b/arch/x86/lib/memcpy_64.S
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* Copyright 2002 Andi Kleen */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <linux/cfi_types.h>
 #include <asm/errno.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
-#include <asm/export.h>
 
 .section .noinstr.text, "ax"
 
diff --git a/arch/x86/lib/memmove_32.S b/arch/x86/lib/memmove_32.S
index 0588b2c0fc95..35010ba3dd6f 100644
--- a/arch/x86/lib/memmove_32.S
+++ b/arch/x86/lib/memmove_32.S
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 SYM_FUNC_START(memmove)
 /*
diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
index 0559b206fb11..7384a5283f05 100644
--- a/arch/x86/lib/memmove_64.S
+++ b/arch/x86/lib/memmove_64.S
@@ -6,10 +6,10 @@
  * This assembly file is re-written from memmove_64.c file.
  *	- Copyright 2011 Fenghua Yu <fenghua.yu@intel.com>
  */
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
-#include <asm/export.h>
 
 #undef memmove
 
diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
index 7c59a704c458..da14a9803348 100644
--- a/arch/x86/lib/memset_64.S
+++ b/arch/x86/lib/memset_64.S
@@ -1,10 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright 2002 Andi Kleen, SuSE Labs */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
-#include <asm/export.h>
 
 .section .noinstr.text, "ax"
 
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index 1451e0c4ae22..6ba118375ec4 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -11,13 +11,12 @@
  * return an error value in addition to the "real"
  * return value.
  */
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/thread_info.h>
 #include <asm/errno.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
-#include <asm/export.h>
-
 
 /*
  * __put_user_X
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 3bea96341d00..0d875c3023ac 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -1,12 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/export.h>
 #include <linux/stringify.h>
 #include <linux/linkage.h>
 #include <asm/dwarf2.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
 #include <asm/asm-offsets.h>
-#include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
 #include <asm/percpu.h>
diff --git a/arch/x86/um/checksum_32.S b/arch/x86/um/checksum_32.S
index aed782ab7721..b39a366d8aba 100644
--- a/arch/x86/um/checksum_32.S
+++ b/arch/x86/um/checksum_32.S
@@ -21,9 +21,9 @@
  *                   converted to pure assembler
  */
 
+#include <linux/export.h>
 #include <asm/errno.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 				
 /*
  * computes a partial checksum, e.g. for TCP/UDP fragments
-- 
2.39.2

