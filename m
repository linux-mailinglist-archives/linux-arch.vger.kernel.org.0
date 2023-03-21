Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2536C31A5
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjCUMZm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 08:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjCUMZk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 08:25:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2F4D497E0;
        Tue, 21 Mar 2023 05:25:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E46BC14;
        Tue, 21 Mar 2023 05:26:21 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 060103F71E;
        Tue, 21 Mar 2023 05:25:34 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     agordeev@linux.ibm.com, aou@eecs.berkeley.edu, bp@alien8.de,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        davem@davemloft.net, gor@linux.ibm.com, hca@linux.ibm.com,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robin.murphy@arm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        will@kernel.org
Subject: [PATCH v2 4/4] arm64: fix clear_user() semantics
Date:   Tue, 21 Mar 2023 12:25:14 +0000
Message-Id: <20230321122514.1743889-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230321122514.1743889-1-mark.rutland@arm.com>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Generally, clear_user() is supposed to behave the same way as
raw_copy_{to,from}_user(), which per <linux/uaccess.h> requires:

> If raw_copy_{to,from}_user(to, from, size) returns N, size - N bytes
> starting at to must become equal to the bytes fetched from the
> corresponding area starting at from.  All data past to + size - N must
> be left unmodified.
>
> If copying succeeds, the return value must be 0.  If some data cannot
> be fetched, it is permitted to copy less than had been fetched; the
> only hard requirement is that not storing anything at all (i.e.
> returning size) should happen only when nothing could be copied.  In
> other words, you don't have to squeeze as much as possible - it is
> allowed, but not necessary.

Unfortunately arm64's implementation of clear_user() may fail in cases
where some bytes could be written, which can be demonstrated through
testing, e.g.

|     # test_clear_user: ASSERTION FAILED at lib/usercopy_kunit.c:221
| too few bytes consumed (offset=4095, size=2, ret=2)
| [FAILED] 2 byte(s)

As with __{arch,raw}_copy_to_user() there are also a number of potential
other problems where the use of misaligned accesses could result in
under-reporting the number of bytes zeroed.

This patch fixes these issues by replacing the current implementation of
__arch_clear_user() with one derived from the new __arch_copy_to_user().
This only uses aligned stores to write to user memory, and reliably
reports the number of bytes zeroed.

For correctness, I've tested this exhaustively for sizes 0 to 128
against every possible alignment relative to a leading and trailing page
boundary. I've also boot tested and run a few kernel builds with the new
implementation.

For performenace, I've benchmarked reads form /dev/zero and timed kernel
builds before and after this patch, and this seems to be at least as
good (or marginally better than) the current implementation, though the
difference is very close to noise.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/lib/clear_user.S   | 195 +++++++++++++++++++++++++++-------
 arch/arm64/lib/copy_to_user.S |   1 -
 2 files changed, 157 insertions(+), 39 deletions(-)

diff --git a/arch/arm64/lib/clear_user.S b/arch/arm64/lib/clear_user.S
index a5a5f5b97b175..f422c05d84351 100644
--- a/arch/arm64/lib/clear_user.S
+++ b/arch/arm64/lib/clear_user.S
@@ -4,52 +4,171 @@
  */
 
 #include <linux/linkage.h>
+
 #include <asm/asm-uaccess.h>
+#include <asm/assembler.h>
+
+#define USER_OFF(off, x...)	USER(fixup_offset_##off, x)
 
-	.text
+#define FIXUP_OFFSET(n)							\
+fixup_offset_##n:							\
+	sub	x0, x3, x0;						\
+	sub	x0, x0, n;						\
+	ret
 
-/* Prototype: int __arch_clear_user(void *addr, size_t sz)
- * Purpose  : clear some user memory
- * Params   : addr - user memory address to clear
- *          : sz   - number of bytes to clear
- * Returns  : number of bytes NOT cleared
+/*
+ * Write zeroes to a user space buffer
+ *
+ * Parameters:
+ *	x0 - to
+ *	x1 - n
+ * Returns:
+ *	x0 - bytes not copied
  *
- * Alignment fixed up by hardware.
+ * Unlike a memset(to, 0, n), we need to handle faults on user addresses, and
+ * we need to precisely report the number of bytes (not) written. We must only
+ * use aligned single-copy-atomic stores to write to user memory, as stores
+ * which are not single-copy-atomic (e.g. unaligned stores, STP, ASMID stores)
+ * can be split into separate byte accesses (per ARM DDI 0487I.a, Section
+ * B2.2.1) and some arbitatrary set of those byte accesses might occur prior to
+ * a fault being raised (per per ARM DDI 0487I.a, Section B2.7.1).
+ *
+ * We use STTR to write to user memory, which has 1/2/4/8 byte forms, and the
+ * user address ('to') might have arbitrary alignment, so we must handle
+ * misalignment up to 8 bytes.
  */
-
-	.p2align 4
-	// Alignment is for the loop, but since the prologue (including BTI)
-	// is also 16 bytes we can keep any padding outside the function
 SYM_FUNC_START(__arch_clear_user)
-	add	x2, x0, x1
-	subs	x1, x1, #8
-	b.mi	2f
-1:
-USER(9f, sttr	xzr, [x0])
-	add	x0, x0, #8
-	subs	x1, x1, #8
-	b.hi	1b
-USER(9f, sttr	xzr, [x2, #-8])
-	mov	x0, #0
-	ret
+		/*
+		 * The end address. Fixup handlers will use this to calculate
+		 * the number of bytes cleared.
+		 */
+		add	x3, x0, x1
 
-2:	tbz	x1, #2, 3f
-USER(9f, sttr	wzr, [x0])
-USER(8f, sttr	wzr, [x2, #-4])
-	mov	x0, #0
-	ret
+		/*
+		 * Tracing of a kernel build indicates that for the vast
+		 * majority of calls to copy_to_user(), 'to' is aligned to 8
+		 * bytes. When this is the case, we want to skip to the bulk
+		 * copy as soon as possible.
+		 */
+		ands	x4, x0, 0x7
+		b.eq	body
 
-3:	tbz	x1, #1, 4f
-USER(9f, sttrh	wzr, [x0])
-4:	tbz	x1, #0, 5f
-USER(7f, sttrb	wzr, [x2, #-1])
-5:	mov	x0, #0
-	ret
+		/*
+		 * For small unaligned copies, it's not worth trying to be
+		 * optimal.
+		 */
+		cmp	x1, #8
+		b.lo	bytewise_loop
 
-	// Exception fixups
-7:	sub	x0, x2, #5	// Adjust for faulting on the final byte...
-8:	add	x0, x0, #4	// ...or the second word of the 4-7 byte case
-9:	sub	x0, x2, x0
-	ret
+		/*
+		 * Calculate the distance to the next 8-byte boundary.
+		 */
+		mov	x5, #8
+		sub	x4, x5, x4
+
+SYM_INNER_LABEL(head_realign_1b, SYM_L_LOCAL)
+		tbz	x4, #0, head_realign_2b
+
+USER_OFF(0,	sttrb	wzr, [x0])
+		add	x0, x0, #1
+
+SYM_INNER_LABEL(head_realign_2b, SYM_L_LOCAL)
+		tbz	x4, #1, head_realign_4b
+
+USER_OFF(0,	sttrh	wzr, [x0])
+		add	x0, x0, #2
+
+SYM_INNER_LABEL(head_realign_4b, SYM_L_LOCAL)
+		tbz	x4, #2, head_realigned
+
+USER_OFF(0,	sttr	wzr, [x0])
+		add	x0, x0, #4
+
+SYM_INNER_LABEL(head_realigned, SYM_L_LOCAL)
+		/*
+		 * Any 1-7 byte misalignment has now been fixed; subtract this
+		 * misalignment from the remaining size.
+		 */
+		sub	x1, x1, x4
+
+SYM_INNER_LABEL(body, SYM_L_LOCAL)
+		cmp	x1, #64
+		b.lo	tail_32b
+
+SYM_INNER_LABEL(body_64b_loop, SYM_L_LOCAL)
+USER_OFF(0,	sttr	xzr, [x0, #0])
+USER_OFF(8,	sttr	xzr, [x0, #8])
+USER_OFF(16,	sttr	xzr, [x0, #16])
+USER_OFF(24,	sttr	xzr, [x0, #24])
+USER_OFF(32,	sttr	xzr, [x0, #32])
+USER_OFF(40,	sttr	xzr, [x0, #40])
+USER_OFF(48,	sttr	xzr, [x0, #48])
+USER_OFF(56,	sttr	xzr, [x0, #56])
+		add	x0, x0, #64
+		sub	x1, x1, #64
+
+		cmp	x1, #64
+		b.hs	body_64b_loop
+
+SYM_INNER_LABEL(tail_32b, SYM_L_LOCAL)
+		tbz	x1, #5, tail_16b
+
+USER_OFF(0,	sttr	xzr, [x0, #0])
+USER_OFF(8,	sttr	xzr, [x0, #8])
+USER_OFF(16,	sttr	xzr, [x0, #16])
+USER_OFF(24,	sttr	xzr, [x0, #24])
+		add	x0, x0, #32
+
+SYM_INNER_LABEL(tail_16b, SYM_L_LOCAL)
+		tbz	x1, #4, tail_8b
+
+USER_OFF(0,	sttr	xzr, [x0, #0])
+USER_OFF(8,	sttr	xzr, [x0, #8])
+		add	x0, x0, #16
+
+SYM_INNER_LABEL(tail_8b, SYM_L_LOCAL)
+		tbz	x1, #3, tail_4b
+
+USER_OFF(0,	sttr	xzr, [x0])
+		add	x0, x0, #8
+
+SYM_INNER_LABEL(tail_4b, SYM_L_LOCAL)
+		tbz	x1, #2, tail_2b
+
+USER_OFF(0,	sttr	wzr, [x0])
+		add	x0, x0, #4
+
+SYM_INNER_LABEL(tail_2b, SYM_L_LOCAL)
+		tbz	x1, #1, tail_1b
+
+USER_OFF(0,	sttrh	wzr, [x0])
+		add	x0, x0, #2
+
+SYM_INNER_LABEL(tail_1b, SYM_L_LOCAL)
+		tbz	x1, #0, done
+
+USER_OFF(0,	sttrb	wzr, [x0])
+
+SYM_INNER_LABEL(done, SYM_L_LOCAL)
+		mov	x0, xzr
+		ret
+
+SYM_INNER_LABEL(bytewise_loop, SYM_L_LOCAL)
+		cbz	x1, done
+
+USER_OFF(0,	sttrb	wzr, [x0])
+		add	x0, x0, #1
+		sub	x1, x1, #1
+
+		b	bytewise_loop
+
+FIXUP_OFFSET(0)
+FIXUP_OFFSET(8)
+FIXUP_OFFSET(16)
+FIXUP_OFFSET(24)
+FIXUP_OFFSET(32)
+FIXUP_OFFSET(40)
+FIXUP_OFFSET(48)
+FIXUP_OFFSET(56)
 SYM_FUNC_END(__arch_clear_user)
 EXPORT_SYMBOL(__arch_clear_user)
diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index fa603487e8571..9eab9ec6c71e9 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -7,7 +7,6 @@
 
 #include <asm/asm-uaccess.h>
 #include <asm/assembler.h>
-#include <asm/cache.h>
 
 #define USER_OFF(off, x...)	USER(fixup_offset_##off, x)
 
-- 
2.30.2

