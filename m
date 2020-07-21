Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C92B2289E0
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 22:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgGUU0c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 16:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730639AbgGUUZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:25:51 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3030C0619DC;
        Tue, 21 Jul 2020 13:25:51 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxypi-00HPoy-0m; Tue, 21 Jul 2020 20:25:50 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 08/18] m68k: get rid of zeroing destination on error in csum_and_copy_from_user()
Date:   Tue, 21 Jul 2020 21:25:39 +0100
Message-Id: <20200721202549.4150745-8-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m68k/lib/checksum.c | 79 +++++++++---------------------------------------
 1 file changed, 15 insertions(+), 64 deletions(-)

diff --git a/arch/m68k/lib/checksum.c b/arch/m68k/lib/checksum.c
index 3aeca261f622..7e6afeae6217 100644
--- a/arch/m68k/lib/checksum.c
+++ b/arch/m68k/lib/checksum.c
@@ -236,82 +236,33 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
 		"clrl %5\n\t"
 		"addxl %5,%0\n\t"	/* add X bit */
 	     "7:\t"
-		"clrl %5\n"		/* no error - clear return value */
-	     "8:\n"
 		".section .fixup,\"ax\"\n"
 		".even\n"
-		/* If any exception occurs zero out the rest.
-		   Similarities with the code above are intentional :-) */
+		/* If any exception occurs, return 0 */
 	     "90:\t"
-		"clrw %3@+\n\t"
-		"movel %1,%4\n\t"
-		"lsrl #5,%1\n\t"
-		"jeq 1f\n\t"
-		"subql #1,%1\n"
-	     "91:\t"
-		"clrl %3@+\n"
-	     "92:\t"
-		"clrl %3@+\n"
-	     "93:\t"
-		"clrl %3@+\n"
-	     "94:\t"
-		"clrl %3@+\n"
-	     "95:\t"
-		"clrl %3@+\n"
-	     "96:\t"
-		"clrl %3@+\n"
-	     "97:\t"
-		"clrl %3@+\n"
-	     "98:\t"
-		"clrl %3@+\n\t"
-		"dbra %1,91b\n\t"
-		"clrw %1\n\t"
-		"subql #1,%1\n\t"
-		"jcc 91b\n"
-	     "1:\t"
-		"movel %4,%1\n\t"
-		"andw #0x1c,%4\n\t"
-		"jeq 1f\n\t"
-		"lsrw #2,%4\n\t"
-		"subqw #1,%4\n"
-	     "99:\t"
-		"clrl %3@+\n\t"
-		"dbra %4,99b\n\t"
-	     "1:\t"
-		"andw #3,%1\n\t"
-		"jeq 9f\n"
-	     "100:\t"
-		"clrw %3@+\n\t"
-		"tstw %1\n\t"
-		"jeq 9f\n"
-	     "101:\t"
-		"clrb %3@+\n"
-	     "9:\t"
-#define STR(X) STR1(X)
-#define STR1(X) #X
-		"moveq #-" STR(EFAULT) ",%5\n\t"
-		"jra 8b\n"
+		"clrl %0\n"
+		"jra 7b\n"
 		".previous\n"
 		".section __ex_table,\"a\"\n"
 		".long 10b,90b\n"
-		".long 11b,91b\n"
-		".long 12b,92b\n"
-		".long 13b,93b\n"
-		".long 14b,94b\n"
-		".long 15b,95b\n"
-		".long 16b,96b\n"
-		".long 17b,97b\n"
-		".long 18b,98b\n"
-		".long 19b,99b\n"
-		".long 20b,100b\n"
-		".long 21b,101b\n"
+		".long 11b,90b\n"
+		".long 12b,90b\n"
+		".long 13b,90b\n"
+		".long 14b,90b\n"
+		".long 15b,90b\n"
+		".long 16b,90b\n"
+		".long 17b,90b\n"
+		".long 18b,90b\n"
+		".long 19b,90b\n"
+		".long 20b,90b\n"
+		".long 21b,90b\n"
 		".previous"
 		: "=d" (sum), "=d" (len), "=a" (src), "=a" (dst),
 		  "=&d" (tmp1), "=d" (tmp2)
 		: "0" (sum), "1" (len), "2" (src), "3" (dst)
 	    );
 
-	return tmp2 ? 0 : sum;
+	return sum;
 }
 
 EXPORT_SYMBOL(csum_and_copy_from_user);
-- 
2.11.0

