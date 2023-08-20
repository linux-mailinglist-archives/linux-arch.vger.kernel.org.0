Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6CA781BCA
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 02:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjHTAda (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Aug 2023 20:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjHTAdD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 20:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA21488CDC;
        Sat, 19 Aug 2023 16:33:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A1B060B55;
        Sat, 19 Aug 2023 23:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAB1C433C7;
        Sat, 19 Aug 2023 23:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692488037;
        bh=6UEK89bt2PFewknJ9lYROsEb+cpA3UQvuifqeSZY2fY=;
        h=From:To:Cc:Subject:Date:From;
        b=SKWTfiUhTky20tOqgoLoCtRTwhje2c8FDvSmmRDLHMmCcuaUprbq65nE2h6zs7nWG
         cyROFkHr20F/x8uD6f2CYoVHudT2sGuWv/xi+PjRVplKRW301Jm1MBzHKJiU1hIhSG
         OMYSvxTuJX1miSqWxybYrz0xd9Ui7lYP3oaiXRTL+gejNpDgiDVqFw5O274eEe7ARY
         ojYMaj9HhqR9fEOcxMpoS6zs/EPfjhZsiUxc5by7/HOBrusyreU7OznJ/+nuys2zq6
         4kb5+KWo/eouaGfWMbczHZTdKkdW6cKOsVRwe1+QBmg6BxkOfcW7pXISIg+RV4LtsG
         Ugf1z+S7IXaQg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH 1/6] sparc: replace #include <asm/export.h> with #include <linux/export.h>
Date:   Sun, 20 Aug 2023 08:33:48 +0900
Message-Id: <20230819233353.3683813-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

 arch/sparc/kernel/entry.S     | 2 +-
 arch/sparc/kernel/head_32.S   | 2 +-
 arch/sparc/kernel/head_64.S   | 2 +-
 arch/sparc/lib/U1memcpy.S     | 2 +-
 arch/sparc/lib/VISsave.S      | 2 +-
 arch/sparc/lib/ashldi3.S      | 2 +-
 arch/sparc/lib/ashrdi3.S      | 2 +-
 arch/sparc/lib/atomic_64.S    | 2 +-
 arch/sparc/lib/bitops.S       | 2 +-
 arch/sparc/lib/blockops.S     | 2 +-
 arch/sparc/lib/bzero.S        | 2 +-
 arch/sparc/lib/checksum_32.S  | 2 +-
 arch/sparc/lib/checksum_64.S  | 2 +-
 arch/sparc/lib/clear_page.S   | 2 +-
 arch/sparc/lib/copy_in_user.S | 2 +-
 arch/sparc/lib/copy_page.S    | 2 +-
 arch/sparc/lib/copy_user.S    | 2 +-
 arch/sparc/lib/csum_copy.S    | 2 +-
 arch/sparc/lib/divdi3.S       | 2 +-
 arch/sparc/lib/ffs.S          | 2 +-
 arch/sparc/lib/fls.S          | 2 +-
 arch/sparc/lib/fls64.S        | 2 +-
 arch/sparc/lib/hweight.S      | 2 +-
 arch/sparc/lib/ipcsum.S       | 2 +-
 arch/sparc/lib/locks.S        | 2 +-
 arch/sparc/lib/lshrdi3.S      | 2 +-
 arch/sparc/lib/mcount.S       | 2 +-
 arch/sparc/lib/memcmp.S       | 2 +-
 arch/sparc/lib/memcpy.S       | 3 ++-
 arch/sparc/lib/memmove.S      | 2 +-
 arch/sparc/lib/memscan_32.S   | 2 +-
 arch/sparc/lib/memscan_64.S   | 2 +-
 arch/sparc/lib/memset.S       | 2 +-
 arch/sparc/lib/muldi3.S       | 2 +-
 arch/sparc/lib/multi3.S       | 2 +-
 arch/sparc/lib/strlen.S       | 2 +-
 arch/sparc/lib/strncmp_32.S   | 2 +-
 arch/sparc/lib/strncmp_64.S   | 2 +-
 arch/sparc/lib/xor.S          | 2 +-
 39 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index a269ad2fe6df..a3fdee4cd6fa 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -8,6 +8,7 @@
  * Copyright (C) 1997 Anton Blanchard (anton@progsoc.uts.edu.au)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <linux/errno.h>
 #include <linux/pgtable.h>
@@ -30,7 +31,6 @@
 #include <asm/unistd.h>
 
 #include <asm/asmmacro.h>
-#include <asm/export.h>
 
 #define curptr      g6
 
diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 6044b82b9767..964c61b5cd03 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -11,6 +11,7 @@
  * CompactPCI platform by Eric Brower, 1999.
  */
 
+#include <linux/export.h>
 #include <linux/version.h>
 #include <linux/init.h>
 
@@ -25,7 +26,6 @@
 #include <asm/thread_info.h>	/* TI_UWINMASK */
 #include <asm/errno.h>
 #include <asm/pgtable.h>	/* PGDIR_SHIFT */
-#include <asm/export.h>
 
 	.data
 /* The following are used with the prom_vector node-ops to figure out
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 72a5bdc833ea..cf0549134234 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -9,6 +9,7 @@
 
 #include <linux/version.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/threads.h>
 #include <linux/init.h>
 #include <linux/linkage.h>
@@ -33,7 +34,6 @@
 #include <asm/estate.h>
 #include <asm/sfafsr.h>
 #include <asm/unistd.h>
-#include <asm/export.h>
 
 /* This section from from _start to sparc64_boot_end should fit into
  * 0x0000000000404000 to 0x0000000000408000.
diff --git a/arch/sparc/lib/U1memcpy.S b/arch/sparc/lib/U1memcpy.S
index a6f4ee391897..635398ec7540 100644
--- a/arch/sparc/lib/U1memcpy.S
+++ b/arch/sparc/lib/U1memcpy.S
@@ -6,10 +6,10 @@
  */
 
 #ifdef __KERNEL__
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/visasm.h>
 #include <asm/asi.h>
-#include <asm/export.h>
 #define GLOBAL_SPARE	g7
 #else
 #define GLOBAL_SPARE	g5
diff --git a/arch/sparc/lib/VISsave.S b/arch/sparc/lib/VISsave.S
index 9c8eb2017d5b..31a0c336c185 100644
--- a/arch/sparc/lib/VISsave.S
+++ b/arch/sparc/lib/VISsave.S
@@ -7,6 +7,7 @@
  * Copyright (C) 1998 Jakub Jelinek (jj@ultra.linux.cz)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 
 #include <asm/asi.h>
@@ -14,7 +15,6 @@
 #include <asm/ptrace.h>
 #include <asm/visasm.h>
 #include <asm/thread_info.h>
-#include <asm/export.h>
 
 	/* On entry: %o5=current FPRS value, %g7 is callers address */
 	/* May clobber %o5, %g1, %g2, %g3, %g7, %icc, %xcc */
diff --git a/arch/sparc/lib/ashldi3.S b/arch/sparc/lib/ashldi3.S
index 2d72de88af90..2a9e7c4fb260 100644
--- a/arch/sparc/lib/ashldi3.S
+++ b/arch/sparc/lib/ashldi3.S
@@ -6,8 +6,8 @@
  * Copyright (C) 1999 David S. Miller (davem@redhat.com)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 	.text
 ENTRY(__ashldi3)
diff --git a/arch/sparc/lib/ashrdi3.S b/arch/sparc/lib/ashrdi3.S
index 05dfda9f5005..8fd0b311722f 100644
--- a/arch/sparc/lib/ashrdi3.S
+++ b/arch/sparc/lib/ashrdi3.S
@@ -6,8 +6,8 @@
  * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 	.text
 ENTRY(__ashrdi3)
diff --git a/arch/sparc/lib/atomic_64.S b/arch/sparc/lib/atomic_64.S
index 8245d4a97301..4f8cab2fb9cd 100644
--- a/arch/sparc/lib/atomic_64.S
+++ b/arch/sparc/lib/atomic_64.S
@@ -4,10 +4,10 @@
  * Copyright (C) 1999, 2007 2012 David S. Miller (davem@davemloft.net)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/asi.h>
 #include <asm/backoff.h>
-#include <asm/export.h>
 
 	.text
 
diff --git a/arch/sparc/lib/bitops.S b/arch/sparc/lib/bitops.S
index 9d647f977618..9c91cbb310e7 100644
--- a/arch/sparc/lib/bitops.S
+++ b/arch/sparc/lib/bitops.S
@@ -4,10 +4,10 @@
  * Copyright (C) 2000, 2007 David S. Miller (davem@davemloft.net)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/asi.h>
 #include <asm/backoff.h>
-#include <asm/export.h>
 
 	.text
 
diff --git a/arch/sparc/lib/blockops.S b/arch/sparc/lib/blockops.S
index 76ddd1ff6833..5b92959a4d48 100644
--- a/arch/sparc/lib/blockops.S
+++ b/arch/sparc/lib/blockops.S
@@ -5,9 +5,9 @@
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/page.h>
-#include <asm/export.h>
 
 	/* Zero out 64 bytes of memory at (buf + offset).
 	 * Assumes %g1 contains zero.
diff --git a/arch/sparc/lib/bzero.S b/arch/sparc/lib/bzero.S
index 87fec4cbe10c..2bfa44a6b25e 100644
--- a/arch/sparc/lib/bzero.S
+++ b/arch/sparc/lib/bzero.S
@@ -5,8 +5,8 @@
  * Copyright (C) 2005 David S. Miller <davem@davemloft.net>
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 	.text
 
diff --git a/arch/sparc/lib/checksum_32.S b/arch/sparc/lib/checksum_32.S
index 781e39b3c009..84ad709cbecb 100644
--- a/arch/sparc/lib/checksum_32.S
+++ b/arch/sparc/lib/checksum_32.S
@@ -14,8 +14,8 @@
  *	BSD4.4 portable checksum routine
  */
 
+#include <linux/export.h>
 #include <asm/errno.h>
-#include <asm/export.h>
 
 #define CSUM_BIGCHUNK(buf, offset, sum, t0, t1, t2, t3, t4, t5)	\
 	ldd	[buf + offset + 0x00], t0;			\
diff --git a/arch/sparc/lib/checksum_64.S b/arch/sparc/lib/checksum_64.S
index 9700ef1730df..32b626f3fe4d 100644
--- a/arch/sparc/lib/checksum_64.S
+++ b/arch/sparc/lib/checksum_64.S
@@ -14,7 +14,7 @@
  *	BSD4.4 portable checksum routine
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 	.text
 
 csum_partial_fix_alignment:
diff --git a/arch/sparc/lib/clear_page.S b/arch/sparc/lib/clear_page.S
index 302d3454a994..e63458194f5a 100644
--- a/arch/sparc/lib/clear_page.S
+++ b/arch/sparc/lib/clear_page.S
@@ -5,13 +5,13 @@
  * Copyright (C) 1997 Jakub Jelinek (jakub@redhat.com)
  */
 
+#include <linux/export.h>
 #include <linux/pgtable.h>
 #include <asm/visasm.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
 #include <asm/spitfire.h>
 #include <asm/head.h>
-#include <asm/export.h>
 
 	/* What we used to do was lock a TLB entry into a specific
 	 * TLB slot, clear the page with interrupts disabled, then
diff --git a/arch/sparc/lib/copy_in_user.S b/arch/sparc/lib/copy_in_user.S
index 66e90bf528e2..e23e6a69ff92 100644
--- a/arch/sparc/lib/copy_in_user.S
+++ b/arch/sparc/lib/copy_in_user.S
@@ -4,9 +4,9 @@
  * Copyright (C) 1999, 2000, 2004 David S. Miller (davem@redhat.com)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/asi.h>
-#include <asm/export.h>
 
 #define XCC xcc
 
diff --git a/arch/sparc/lib/copy_page.S b/arch/sparc/lib/copy_page.S
index 5ebcfd479f4f..7a041f3ebc58 100644
--- a/arch/sparc/lib/copy_page.S
+++ b/arch/sparc/lib/copy_page.S
@@ -5,13 +5,13 @@
  * Copyright (C) 1997 Jakub Jelinek (jakub@redhat.com)
  */
 
+#include <linux/export.h>
 #include <asm/visasm.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
 #include <linux/pgtable.h>
 #include <asm/spitfire.h>
 #include <asm/head.h>
-#include <asm/export.h>
 
 	/* What we used to do was lock a TLB entry into a specific
 	 * TLB slot, clear the page with interrupts disabled, then
diff --git a/arch/sparc/lib/copy_user.S b/arch/sparc/lib/copy_user.S
index 954572c78539..7bb2ef68881d 100644
--- a/arch/sparc/lib/copy_user.S
+++ b/arch/sparc/lib/copy_user.S
@@ -12,11 +12,11 @@
  * Returns 0 if successful, otherwise count of bytes not copied yet
  */
 
+#include <linux/export.h>
 #include <asm/ptrace.h>
 #include <asm/asmmacro.h>
 #include <asm/page.h>
 #include <asm/thread_info.h>
-#include <asm/export.h>
 
 /* Work around cpp -rob */
 #define ALLOC #alloc
diff --git a/arch/sparc/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
index d839956407a7..f968e83bc93b 100644
--- a/arch/sparc/lib/csum_copy.S
+++ b/arch/sparc/lib/csum_copy.S
@@ -4,7 +4,7 @@
  * Copyright (C) 2005 David S. Miller <davem@davemloft.net>
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 
 #ifdef __KERNEL__
 #define GLOBAL_SPARE	%g7
diff --git a/arch/sparc/lib/divdi3.S b/arch/sparc/lib/divdi3.S
index a7389409d9fa..4ba901acd572 100644
--- a/arch/sparc/lib/divdi3.S
+++ b/arch/sparc/lib/divdi3.S
@@ -5,7 +5,7 @@ This file is part of GNU CC.
 
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 	.text
 	.align 4
 	.globl __divdi3
diff --git a/arch/sparc/lib/ffs.S b/arch/sparc/lib/ffs.S
index 5a11d864fa05..3a9ad8ffdfe8 100644
--- a/arch/sparc/lib/ffs.S
+++ b/arch/sparc/lib/ffs.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 	.register	%g2,#scratch
 
diff --git a/arch/sparc/lib/fls.S b/arch/sparc/lib/fls.S
index 06b8d300bcae..ccf97fb7d8cd 100644
--- a/arch/sparc/lib/fls.S
+++ b/arch/sparc/lib/fls.S
@@ -5,8 +5,8 @@
  * and onward.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 	.text
 	.register	%g2, #scratch
diff --git a/arch/sparc/lib/fls64.S b/arch/sparc/lib/fls64.S
index c83e22ae9586..87005b67d378 100644
--- a/arch/sparc/lib/fls64.S
+++ b/arch/sparc/lib/fls64.S
@@ -5,8 +5,8 @@
  * and onward.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 	.text
 	.register	%g2, #scratch
diff --git a/arch/sparc/lib/hweight.S b/arch/sparc/lib/hweight.S
index 0ddbbb031822..eebee59b0655 100644
--- a/arch/sparc/lib/hweight.S
+++ b/arch/sparc/lib/hweight.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 	.text
 	.align	32
diff --git a/arch/sparc/lib/ipcsum.S b/arch/sparc/lib/ipcsum.S
index 531d89c9d5d9..7fa8fd4b795a 100644
--- a/arch/sparc/lib/ipcsum.S
+++ b/arch/sparc/lib/ipcsum.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 	.text
 ENTRY(ip_fast_csum) /* %o0 = iph, %o1 = ihl */
diff --git a/arch/sparc/lib/locks.S b/arch/sparc/lib/locks.S
index 9a1289a3fb28..47a39f4384a2 100644
--- a/arch/sparc/lib/locks.S
+++ b/arch/sparc/lib/locks.S
@@ -7,11 +7,11 @@
  * Copyright (C) 1998 Jakub Jelinek   (jj@ultra.linux.cz)
  */
 
+#include <linux/export.h>
 #include <asm/ptrace.h>
 #include <asm/psr.h>
 #include <asm/smp.h>
 #include <asm/spinlock.h>
-#include <asm/export.h>
 
 	.text
 	.align	4
diff --git a/arch/sparc/lib/lshrdi3.S b/arch/sparc/lib/lshrdi3.S
index 509ca6682da8..09bf581a0ba5 100644
--- a/arch/sparc/lib/lshrdi3.S
+++ b/arch/sparc/lib/lshrdi3.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 ENTRY(__lshrdi3)
 	cmp	%o2, 0
diff --git a/arch/sparc/lib/mcount.S b/arch/sparc/lib/mcount.S
index deba6fa0bc78..f7f7910eb41e 100644
--- a/arch/sparc/lib/mcount.S
+++ b/arch/sparc/lib/mcount.S
@@ -6,8 +6,8 @@
  * This can also be tweaked for kernel stack overflow detection.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 /*
  * This is the main variant and is called by C code.  GCC's -pg option
diff --git a/arch/sparc/lib/memcmp.S b/arch/sparc/lib/memcmp.S
index a18076ef5af1..c87e8000feba 100644
--- a/arch/sparc/lib/memcmp.S
+++ b/arch/sparc/lib/memcmp.S
@@ -5,9 +5,9 @@
  * Copyright (C) 2000, 2008 David S. Miller (davem@davemloft.net)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 
 	.text
 ENTRY(memcmp)
diff --git a/arch/sparc/lib/memcpy.S b/arch/sparc/lib/memcpy.S
index ee823d8c9215..57b1ae0f5924 100644
--- a/arch/sparc/lib/memcpy.S
+++ b/arch/sparc/lib/memcpy.S
@@ -8,7 +8,8 @@
  * Copyright (C) 1996 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
+
 #define FUNC(x) 		\
 	.globl	x;		\
 	.type	x,@function;	\
diff --git a/arch/sparc/lib/memmove.S b/arch/sparc/lib/memmove.S
index 3132b6316144..543dda7b9dac 100644
--- a/arch/sparc/lib/memmove.S
+++ b/arch/sparc/lib/memmove.S
@@ -5,8 +5,8 @@
  * Copyright (C) 1996, 1997, 1998, 1999 Jakub Jelinek (jj@ultra.linux.cz)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 	.text
 ENTRY(memmove) /* o0=dst o1=src o2=len */
diff --git a/arch/sparc/lib/memscan_32.S b/arch/sparc/lib/memscan_32.S
index c4c2d5b3a2e9..5386a3a20019 100644
--- a/arch/sparc/lib/memscan_32.S
+++ b/arch/sparc/lib/memscan_32.S
@@ -5,7 +5,7 @@
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 
 /* In essence, this is just a fancy strlen. */
 
diff --git a/arch/sparc/lib/memscan_64.S b/arch/sparc/lib/memscan_64.S
index 36dd638905c3..70a4f21057f2 100644
--- a/arch/sparc/lib/memscan_64.S
+++ b/arch/sparc/lib/memscan_64.S
@@ -6,7 +6,7 @@
  * Copyright (C) 1998 David S. Miller (davem@redhat.com)
  */
 
-	#include <asm/export.h>
+#include <linux/export.h>
 
 #define HI_MAGIC	0x8080808080808080
 #define LO_MAGIC	0x0101010101010101
diff --git a/arch/sparc/lib/memset.S b/arch/sparc/lib/memset.S
index eaff68213fdf..a33419dbb464 100644
--- a/arch/sparc/lib/memset.S
+++ b/arch/sparc/lib/memset.S
@@ -9,8 +9,8 @@
  * clear_user.
  */
 
+#include <linux/export.h>
 #include <asm/ptrace.h>
-#include <asm/export.h>
 
 /* Work around cpp -rob */
 #define ALLOC #alloc
diff --git a/arch/sparc/lib/muldi3.S b/arch/sparc/lib/muldi3.S
index 53054dee66d6..7e1e8cd30a22 100644
--- a/arch/sparc/lib/muldi3.S
+++ b/arch/sparc/lib/muldi3.S
@@ -5,7 +5,7 @@ This file is part of GNU CC.
 
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 	.text
 	.align 4
 	.globl __muldi3
diff --git a/arch/sparc/lib/multi3.S b/arch/sparc/lib/multi3.S
index 2f187b299345..5bb4c122a2cf 100644
--- a/arch/sparc/lib/multi3.S
+++ b/arch/sparc/lib/multi3.S
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 	.text
 	.align	4
diff --git a/arch/sparc/lib/strlen.S b/arch/sparc/lib/strlen.S
index dd111bbad5df..27478b3f1647 100644
--- a/arch/sparc/lib/strlen.S
+++ b/arch/sparc/lib/strlen.S
@@ -6,9 +6,9 @@
  * Copyright (C) 1996, 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/asm.h>
-#include <asm/export.h>
 
 #define LO_MAGIC 0x01010101
 #define HI_MAGIC 0x80808080
diff --git a/arch/sparc/lib/strncmp_32.S b/arch/sparc/lib/strncmp_32.S
index 794733f036b6..387bbf621548 100644
--- a/arch/sparc/lib/strncmp_32.S
+++ b/arch/sparc/lib/strncmp_32.S
@@ -4,8 +4,8 @@
  *            generic strncmp routine.
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
-#include <asm/export.h>
 
 	.text
 ENTRY(strncmp)
diff --git a/arch/sparc/lib/strncmp_64.S b/arch/sparc/lib/strncmp_64.S
index 3d37d65f674c..76c1207ecf5a 100644
--- a/arch/sparc/lib/strncmp_64.S
+++ b/arch/sparc/lib/strncmp_64.S
@@ -5,9 +5,9 @@
  * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/asi.h>
-#include <asm/export.h>
 
 	.text
 ENTRY(strncmp)
diff --git a/arch/sparc/lib/xor.S b/arch/sparc/lib/xor.S
index f6af7c7ee6fc..35461e3b2a9b 100644
--- a/arch/sparc/lib/xor.S
+++ b/arch/sparc/lib/xor.S
@@ -9,12 +9,12 @@
  * Copyright (C) 2006 David S. Miller <davem@davemloft.net>
  */
 
+#include <linux/export.h>
 #include <linux/linkage.h>
 #include <asm/visasm.h>
 #include <asm/asi.h>
 #include <asm/dcu.h>
 #include <asm/spitfire.h>
-#include <asm/export.h>
 
 /*
  *	Requirements:
-- 
2.39.2

