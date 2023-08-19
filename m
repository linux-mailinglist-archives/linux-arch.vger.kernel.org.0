Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C4C781BC7
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 02:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjHTAdb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Aug 2023 20:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjHTAdF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 20:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A18988CFF;
        Sat, 19 Aug 2023 16:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9674661A60;
        Sat, 19 Aug 2023 23:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F34C433CA;
        Sat, 19 Aug 2023 23:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692488045;
        bh=lt/GC4mCVAMEOFC6vz52R8BufOYglMdi+DS9TWA5anE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GHhf4G+MLlj1i1sG/4zzwM4o990LTC4QdjcP52gvXw82tnRQs2FOApLWMH61HofB4
         GTUdMCz/kIB8p79EfvYQdZaKptzC3nss0d0ixSU4t5I0sP1Hh4H24hoGQE5cqvcSdC
         uP6xvrd2SV+G9VfDTm/UJ1GtjIs0wwnxQ8RTz4HPM3p8zcUPh9ues5jm0hLp0axuPZ
         L+eqDPpBWMbmuy9XJlGjhUmPpAVE8MQ7BJNhInKPgTqrmqmMhU2fxKotlGAc0FvdQN
         S1nSv73ECmoSAzlQRi2irEWt8/n/JNNE8tKspSw8sJ83hfj1JaAu5I6SMO0HxW2iWT
         1t47VyzN+yQUg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] alpha: replace #include <asm/export.h> with #include <linux/export.h>
Date:   Sun, 20 Aug 2023 08:33:52 +0900
Message-Id: <20230819233353.3683813-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819233353.3683813-1-masahiroy@kernel.org>
References: <20230819233353.3683813-1-masahiroy@kernel.org>
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

 arch/alpha/lib/callback_srm.S        | 2 +-
 arch/alpha/lib/clear_page.S          | 2 +-
 arch/alpha/lib/clear_user.S          | 2 +-
 arch/alpha/lib/copy_page.S           | 2 +-
 arch/alpha/lib/copy_user.S           | 2 +-
 arch/alpha/lib/csum_ipv6_magic.S     | 2 +-
 arch/alpha/lib/divide.S              | 2 +-
 arch/alpha/lib/ev6-clear_page.S      | 2 +-
 arch/alpha/lib/ev6-clear_user.S      | 2 +-
 arch/alpha/lib/ev6-copy_page.S       | 2 +-
 arch/alpha/lib/ev6-copy_user.S       | 2 +-
 arch/alpha/lib/ev6-csum_ipv6_magic.S | 2 +-
 arch/alpha/lib/ev6-divide.S          | 2 +-
 arch/alpha/lib/ev6-memchr.S          | 2 +-
 arch/alpha/lib/ev6-memcpy.S          | 2 +-
 arch/alpha/lib/ev6-memset.S          | 2 +-
 arch/alpha/lib/ev67-strcat.S         | 2 +-
 arch/alpha/lib/ev67-strchr.S         | 2 +-
 arch/alpha/lib/ev67-strlen.S         | 2 +-
 arch/alpha/lib/ev67-strncat.S        | 2 +-
 arch/alpha/lib/ev67-strrchr.S        | 2 +-
 arch/alpha/lib/memchr.S              | 2 +-
 arch/alpha/lib/memmove.S             | 2 +-
 arch/alpha/lib/memset.S              | 2 +-
 arch/alpha/lib/strcat.S              | 2 +-
 arch/alpha/lib/strchr.S              | 2 +-
 arch/alpha/lib/strcpy.S              | 2 +-
 arch/alpha/lib/strlen.S              | 2 +-
 arch/alpha/lib/strncat.S             | 2 +-
 arch/alpha/lib/strncpy.S             | 2 +-
 arch/alpha/lib/strrchr.S             | 2 +-
 arch/alpha/lib/udiv-qrnnd.S          | 2 +-
 32 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/alpha/lib/callback_srm.S b/arch/alpha/lib/callback_srm.S
index b13c4a231f1b..36b63f295170 100644
--- a/arch/alpha/lib/callback_srm.S
+++ b/arch/alpha/lib/callback_srm.S
@@ -3,8 +3,8 @@
  *	arch/alpha/lib/callback_srm.S
  */
 
+#include <linux/export.h>
 #include <asm/console.h>
-#include <asm/export.h>
 
 .text
 #define HWRPB_CRB_OFFSET 0xc0
diff --git a/arch/alpha/lib/clear_page.S b/arch/alpha/lib/clear_page.S
index ce02de7b0493..af70ee309a33 100644
--- a/arch/alpha/lib/clear_page.S
+++ b/arch/alpha/lib/clear_page.S
@@ -4,7 +4,7 @@
  *
  * Zero an entire page.
  */
-#include <asm/export.h>
+#include <linux/export.h>
 	.text
 	.align 4
 	.global clear_page
diff --git a/arch/alpha/lib/clear_user.S b/arch/alpha/lib/clear_user.S
index db6c6ca45896..848eb60a0010 100644
--- a/arch/alpha/lib/clear_user.S
+++ b/arch/alpha/lib/clear_user.S
@@ -10,7 +10,7 @@
  * a successful copy).  There is also some rather minor exception setup
  * stuff.
  */
-#include <asm/export.h>
+#include <linux/export.h>
 
 /* Allow an exception for an insn; exit if we get one.  */
 #define EX(x,y...)			\
diff --git a/arch/alpha/lib/copy_page.S b/arch/alpha/lib/copy_page.S
index 5439a30c77d0..1c444fdad9a5 100644
--- a/arch/alpha/lib/copy_page.S
+++ b/arch/alpha/lib/copy_page.S
@@ -4,7 +4,7 @@
  *
  * Copy an entire page.
  */
-#include <asm/export.h>
+#include <linux/export.h>
 	.text
 	.align 4
 	.global copy_page
diff --git a/arch/alpha/lib/copy_user.S b/arch/alpha/lib/copy_user.S
index 32ab0344b185..ef18faafcad6 100644
--- a/arch/alpha/lib/copy_user.S
+++ b/arch/alpha/lib/copy_user.S
@@ -12,7 +12,7 @@
  * exception setup stuff..
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 
 /* Allow an exception for an insn; exit if we get one.  */
 #define EXI(x,y...)			\
diff --git a/arch/alpha/lib/csum_ipv6_magic.S b/arch/alpha/lib/csum_ipv6_magic.S
index c7b213ab01ab..273c426c3859 100644
--- a/arch/alpha/lib/csum_ipv6_magic.S
+++ b/arch/alpha/lib/csum_ipv6_magic.S
@@ -13,7 +13,7 @@
  * added by Ivan Kokshaysky <ink@jurassic.park.msu.ru>
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 	.globl csum_ipv6_magic
 	.align 4
 	.ent csum_ipv6_magic
diff --git a/arch/alpha/lib/divide.S b/arch/alpha/lib/divide.S
index 2b60eb45e50b..db01840d76ec 100644
--- a/arch/alpha/lib/divide.S
+++ b/arch/alpha/lib/divide.S
@@ -46,7 +46,7 @@
  *	$28 - compare status
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 #define halt .long 0
 
 /*
diff --git a/arch/alpha/lib/ev6-clear_page.S b/arch/alpha/lib/ev6-clear_page.S
index 325864c81586..a534d9ff7161 100644
--- a/arch/alpha/lib/ev6-clear_page.S
+++ b/arch/alpha/lib/ev6-clear_page.S
@@ -4,7 +4,7 @@
  *
  * Zero an entire page.
  */
-#include <asm/export.h>
+#include <linux/export.h>
         .text
         .align 4
         .global clear_page
diff --git a/arch/alpha/lib/ev6-clear_user.S b/arch/alpha/lib/ev6-clear_user.S
index 7e644f83cdf2..af776cc45f91 100644
--- a/arch/alpha/lib/ev6-clear_user.S
+++ b/arch/alpha/lib/ev6-clear_user.S
@@ -29,7 +29,7 @@
  *	want to leave a hole (and we also want to avoid repeating lots of work)
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 /* Allow an exception for an insn; exit if we get one.  */
 #define EX(x,y...)			\
 	99: x,##y;			\
diff --git a/arch/alpha/lib/ev6-copy_page.S b/arch/alpha/lib/ev6-copy_page.S
index fd7212c8dcf1..36be5113b7b7 100644
--- a/arch/alpha/lib/ev6-copy_page.S
+++ b/arch/alpha/lib/ev6-copy_page.S
@@ -57,7 +57,7 @@
    destination pages are in the dcache, but it is my guess that this is
    less important than the dcache miss case.  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 	.text
 	.align 4
 	.global copy_page
diff --git a/arch/alpha/lib/ev6-copy_user.S b/arch/alpha/lib/ev6-copy_user.S
index f3e433754397..b9b19710c364 100644
--- a/arch/alpha/lib/ev6-copy_user.S
+++ b/arch/alpha/lib/ev6-copy_user.S
@@ -23,7 +23,7 @@
  *	L	- lower subcluster; L0 - subcluster L0; L1 - subcluster L1
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 /* Allow an exception for an insn; exit if we get one.  */
 #define EXI(x,y...)			\
 	99: x,##y;			\
diff --git a/arch/alpha/lib/ev6-csum_ipv6_magic.S b/arch/alpha/lib/ev6-csum_ipv6_magic.S
index 9a73f90700a1..2ee548be98e3 100644
--- a/arch/alpha/lib/ev6-csum_ipv6_magic.S
+++ b/arch/alpha/lib/ev6-csum_ipv6_magic.S
@@ -53,7 +53,7 @@
  * may cause additional delay in rare cases (load-load replay traps).
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 	.globl csum_ipv6_magic
 	.align 4
 	.ent csum_ipv6_magic
diff --git a/arch/alpha/lib/ev6-divide.S b/arch/alpha/lib/ev6-divide.S
index 137ff1a07356..b73a6d26362e 100644
--- a/arch/alpha/lib/ev6-divide.S
+++ b/arch/alpha/lib/ev6-divide.S
@@ -56,7 +56,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 #define halt .long 0
 
 /*
diff --git a/arch/alpha/lib/ev6-memchr.S b/arch/alpha/lib/ev6-memchr.S
index 56bf9e14eeee..f75ba43e61e3 100644
--- a/arch/alpha/lib/ev6-memchr.S
+++ b/arch/alpha/lib/ev6-memchr.S
@@ -28,7 +28,7 @@
  *	L	- lower subcluster; L0 - subcluster L0; L1 - subcluster L1
  * Try not to change the actual algorithm if possible for consistency.
  */
-#include <asm/export.h>
+#include <linux/export.h>
         .set noreorder
         .set noat
 
diff --git a/arch/alpha/lib/ev6-memcpy.S b/arch/alpha/lib/ev6-memcpy.S
index ffbd056b6eb2..3ef43c26c8af 100644
--- a/arch/alpha/lib/ev6-memcpy.S
+++ b/arch/alpha/lib/ev6-memcpy.S
@@ -20,7 +20,7 @@
  * Temp usage notes:
  *	$1,$2,		- scratch
  */
-#include <asm/export.h>
+#include <linux/export.h>
 	.set noreorder
 	.set noat
 
diff --git a/arch/alpha/lib/ev6-memset.S b/arch/alpha/lib/ev6-memset.S
index 1cfcfbbea6f0..89d7809da4cc 100644
--- a/arch/alpha/lib/ev6-memset.S
+++ b/arch/alpha/lib/ev6-memset.S
@@ -27,7 +27,7 @@
  * as fixes will need to be made in multiple places.  The performance gain
  * is worth it.
  */
-#include <asm/export.h>
+#include <linux/export.h>
 	.set noat
 	.set noreorder
 .text
diff --git a/arch/alpha/lib/ev67-strcat.S b/arch/alpha/lib/ev67-strcat.S
index ec3096a9e8d4..f8c7305b11d6 100644
--- a/arch/alpha/lib/ev67-strcat.S
+++ b/arch/alpha/lib/ev67-strcat.S
@@ -20,7 +20,7 @@
  * string once.
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 	.text
 
 	.align 4
diff --git a/arch/alpha/lib/ev67-strchr.S b/arch/alpha/lib/ev67-strchr.S
index fbf89e0b6dc3..97a7cb475309 100644
--- a/arch/alpha/lib/ev67-strchr.S
+++ b/arch/alpha/lib/ev67-strchr.S
@@ -16,7 +16,7 @@
  *	L	- lower subcluster; L0 - subcluster L0; L1 - subcluster L1
  * Try not to change the actual algorithm if possible for consistency.
  */
-#include <asm/export.h>
+#include <linux/export.h>
 #include <asm/regdef.h>
 
 	.set noreorder
diff --git a/arch/alpha/lib/ev67-strlen.S b/arch/alpha/lib/ev67-strlen.S
index b73106ffbbc7..3d9078807ab4 100644
--- a/arch/alpha/lib/ev67-strlen.S
+++ b/arch/alpha/lib/ev67-strlen.S
@@ -18,7 +18,7 @@
  *	U	- upper subcluster; U0 - subcluster U0; U1 - subcluster U1
  *	L	- lower subcluster; L0 - subcluster L0; L1 - subcluster L1
  */
-#include <asm/export.h>
+#include <linux/export.h>
 	.set noreorder
 	.set noat
 
diff --git a/arch/alpha/lib/ev67-strncat.S b/arch/alpha/lib/ev67-strncat.S
index ceb0ca528789..8f313233e3a7 100644
--- a/arch/alpha/lib/ev67-strncat.S
+++ b/arch/alpha/lib/ev67-strncat.S
@@ -21,7 +21,7 @@
  * Try not to change the actual algorithm if possible for consistency.
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 	.text
 
 	.align 4
diff --git a/arch/alpha/lib/ev67-strrchr.S b/arch/alpha/lib/ev67-strrchr.S
index 7f80e398530f..ae7355f9ec56 100644
--- a/arch/alpha/lib/ev67-strrchr.S
+++ b/arch/alpha/lib/ev67-strrchr.S
@@ -19,7 +19,7 @@
  *	L	- lower subcluster; L0 - subcluster L0; L1 - subcluster L1
  */
 
-#include <asm/export.h>
+#include <linux/export.h>
 #include <asm/regdef.h>
 
 	.set noreorder
diff --git a/arch/alpha/lib/memchr.S b/arch/alpha/lib/memchr.S
index c13d3eca2e05..45366e32feee 100644
--- a/arch/alpha/lib/memchr.S
+++ b/arch/alpha/lib/memchr.S
@@ -31,7 +31,7 @@ For correctness consider that:
       - only minimum number of quadwords may be accessed
       - the third argument is an unsigned long
 */
-#include <asm/export.h>
+#include <linux/export.h>
         .set noreorder
         .set noat
 
diff --git a/arch/alpha/lib/memmove.S b/arch/alpha/lib/memmove.S
index 42d1922d0edf..3a27689e3390 100644
--- a/arch/alpha/lib/memmove.S
+++ b/arch/alpha/lib/memmove.S
@@ -7,7 +7,7 @@
  * This is hand-massaged output from the original memcpy.c.  We defer to
  * memcpy whenever possible; the backwards copy loops are not unrolled.
  */
-#include <asm/export.h>        
+#include <linux/export.h>
 	.set noat
 	.set noreorder
 	.text
diff --git a/arch/alpha/lib/memset.S b/arch/alpha/lib/memset.S
index 00393e30df25..9075d6918346 100644
--- a/arch/alpha/lib/memset.S
+++ b/arch/alpha/lib/memset.S
@@ -14,7 +14,7 @@
  * The scheduling comments are according to the EV5 documentation (and done by 
  * hand, so they might well be incorrect, please do tell me about it..)
  */
-#include <asm/export.h>
+#include <linux/export.h>
 	.set noat
 	.set noreorder
 .text
diff --git a/arch/alpha/lib/strcat.S b/arch/alpha/lib/strcat.S
index 055877dccd27..62b90ebbcf44 100644
--- a/arch/alpha/lib/strcat.S
+++ b/arch/alpha/lib/strcat.S
@@ -5,7 +5,7 @@
  *
  * Append a null-terminated string from SRC to DST.
  */
-#include <asm/export.h>
+#include <linux/export.h>
 
 	.text
 
diff --git a/arch/alpha/lib/strchr.S b/arch/alpha/lib/strchr.S
index 17871dd00280..68c54ff50dfe 100644
--- a/arch/alpha/lib/strchr.S
+++ b/arch/alpha/lib/strchr.S
@@ -6,7 +6,7 @@
  * Return the address of a given character within a null-terminated
  * string, or null if it is not found.
  */
-#include <asm/export.h>
+#include <linux/export.h>
 #include <asm/regdef.h>
 
 	.set noreorder
diff --git a/arch/alpha/lib/strcpy.S b/arch/alpha/lib/strcpy.S
index cb74ad23a90d..d8773ba77525 100644
--- a/arch/alpha/lib/strcpy.S
+++ b/arch/alpha/lib/strcpy.S
@@ -6,7 +6,7 @@
  * Copy a null-terminated string from SRC to DST.  Return a pointer
  * to the null-terminator in the source.
  */
-#include <asm/export.h>
+#include <linux/export.h>
 	.text
 
 	.align 3
diff --git a/arch/alpha/lib/strlen.S b/arch/alpha/lib/strlen.S
index dd882fe4d7e3..4fc6a6ff24cd 100644
--- a/arch/alpha/lib/strlen.S
+++ b/arch/alpha/lib/strlen.S
@@ -12,7 +12,7 @@
  *	  do this instead of the 9 instructions that
  *	  binary search needs).
  */
-#include <asm/export.h>
+#include <linux/export.h>
 	.set noreorder
 	.set noat
 
diff --git a/arch/alpha/lib/strncat.S b/arch/alpha/lib/strncat.S
index 522fee3e26ac..a913a7c84a39 100644
--- a/arch/alpha/lib/strncat.S
+++ b/arch/alpha/lib/strncat.S
@@ -10,7 +10,7 @@
  * past count, whereas libc may write to count+1.  This follows the generic
  * implementation in lib/string.c and is, IMHO, more sensible.
  */
-#include <asm/export.h>
+#include <linux/export.h>
 	.text
 
 	.align 3
diff --git a/arch/alpha/lib/strncpy.S b/arch/alpha/lib/strncpy.S
index cc57fad8b7ca..cb90cf022df3 100644
--- a/arch/alpha/lib/strncpy.S
+++ b/arch/alpha/lib/strncpy.S
@@ -11,7 +11,7 @@
  * version has cropped that bit o' nastiness as well as assuming that
  * __stxncpy is in range of a branch.
  */
-#include <asm/export.h>
+#include <linux/export.h>
 	.set noat
 	.set noreorder
 
diff --git a/arch/alpha/lib/strrchr.S b/arch/alpha/lib/strrchr.S
index 7650ba99b7e2..dd8e073b6cf2 100644
--- a/arch/alpha/lib/strrchr.S
+++ b/arch/alpha/lib/strrchr.S
@@ -6,7 +6,7 @@
  * Return the address of the last occurrence of a given character
  * within a null-terminated string, or null if it is not found.
  */
-#include <asm/export.h>
+#include <linux/export.h>
 #include <asm/regdef.h>
 
 	.set noreorder
diff --git a/arch/alpha/lib/udiv-qrnnd.S b/arch/alpha/lib/udiv-qrnnd.S
index b887aa5428e5..96f05918bffe 100644
--- a/arch/alpha/lib/udiv-qrnnd.S
+++ b/arch/alpha/lib/udiv-qrnnd.S
@@ -25,7 +25,7 @@
  # along with GCC; see the file COPYING.  If not, write to the 
  # Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
  # MA 02111-1307, USA.
-#include <asm/export.h>
+#include <linux/export.h>
 
         .set noreorder
         .set noat
-- 
2.39.2

