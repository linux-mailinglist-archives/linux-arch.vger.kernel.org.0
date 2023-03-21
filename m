Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302D26C31A3
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 13:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCUMZm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 08:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjCUMZh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 08:25:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F59B30CA;
        Tue, 21 Mar 2023 05:25:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39564AD7;
        Tue, 21 Mar 2023 05:26:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D4EAB3F71E;
        Tue, 21 Mar 2023 05:25:31 -0700 (PDT)
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
Subject: [PATCH v2 3/4] arm64: fix __raw_copy_to_user semantics
Date:   Tue, 21 Mar 2023 12:25:13 +0000
Message-Id: <20230321122514.1743889-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230321122514.1743889-1-mark.rutland@arm.com>
References: <20230321122514.1743889-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

For some combinations of sizes and alignments __{arch,raw}_copy_to_user
will copy some bytes between (to + size - N) and (to + size), but will
never modify bytes past (to + size).

This violates the documentation in <linux/uaccess.h>, which states:

> If raw_copy_{to,from}_user(to, from, size) returns N, size - N bytes
> starting at to must become equal to the bytes fetched from the
> corresponding area starting at from.  All data past to + size - N must
> be left unmodified.

This can be demonstrated through testing, e.g.

|     # test_copy_to_user: EXPECTATION FAILED at lib/usercopy_kunit.c:287
| post-destination bytes modified (dst_page[4082]=0x1, offset=4081, size=16, ret=15)
| [FAILED] 16 byte copy

This happens because the __arch_copy_to_user() can make unaligned stores
to the userspace buffer, and the ARM architecture permits (but does not
require) that such unaligned stores write some bytes before raising a
fault (per ARM DDI 0487I.a Section B2.2.1 and Section B2.7.1). The
extable fixup handlers in __arch_copy_to_user() assume that any faulting
store has failed entirely, and so under-report the number of bytes
copied when an unaligned store writes some bytes before faulting.

The only architecturally guaranteed way to avoid this is to only use
aligned stores to write to user memory.	This patch rewrites
__arch_copy_to_user() to only access the user buffer with aligned
stores, such that the bytes written can always be determined reliably.

For correctness, I've tested this exhaustively for sizes 0 to 128
against every possible alignment relative to a leading and trailing page
boundary. I've also boot tested and run a few kernel builds with the new
implementations.

For performance, I've benchmarked this on a variety of CPU
implementations, and across the board this appears at least as good as
(or marginally better than) the current implementation of
copy_to_user(). Timing a kernel build indicates the same, though the
difference is very close to noise.

We do not have a similar bug in __{arch,raw}_copy_from_user(), as faults
taken on loads from user memory do not have side-effects. We do have
similar issues in __arch_clear_user(), which will be addresssed in a
subsequent patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/lib/copy_to_user.S | 202 +++++++++++++++++++++++++++-------
 1 file changed, 161 insertions(+), 41 deletions(-)

diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
index 8022317726085..fa603487e8571 100644
--- a/arch/arm64/lib/copy_to_user.S
+++ b/arch/arm64/lib/copy_to_user.S
@@ -9,6 +9,14 @@
 #include <asm/assembler.h>
 #include <asm/cache.h>
 
+#define USER_OFF(off, x...)	USER(fixup_offset_##off, x)
+
+#define FIXUP_OFFSET(n)							\
+fixup_offset_##n:							\
+	sub	x0, x3, x0;						\
+	sub	x0, x0, n;						\
+	ret
+
 /*
  * Copy to user space from a kernel buffer (alignment handled by the hardware)
  *
@@ -18,56 +26,168 @@
  *	x2 - n
  * Returns:
  *	x0 - bytes not copied
+ *
+ * Unlike a memcpy(), we need to handle faults on user addresses, and we need
+ * to precisely report the number of bytes (not) copied. We must only use
+ * aligned single-copy-atomic stores to write to user memory, as stores which
+ * are not single-copy-atomic (e.g. unaligned stores, STP, ASMID stores) can be
+ * split into separate byte accesses (per ARM DDI 0487I.a, Section B2.2.1) and
+ * some arbitatrary set of those byte accesses might occur prior to a fault
+ * being raised (per per ARM DDI 0487I.a, Section B2.7.1).
+ *
+ * We use STTR to write to user memory, which has 1/2/4/8 byte forms, and the
+ * user address ('to') might have arbitrary alignment, so we must handle
+ * misalignment up to 8 bytes.
  */
-	.macro ldrb1 reg, ptr, val
-	ldrb  \reg, [\ptr], \val
-	.endm
+SYM_FUNC_START(__arch_copy_to_user)
+		/*
+		 * The end address. Fixup handlers will use this to calculate
+		 * the number of bytes copied.
+		 */
+		add	x3, x0, x2
 
-	.macro strb1 reg, ptr, val
-	user_ldst 9998f, sttrb, \reg, \ptr, \val
-	.endm
+		/*
+		 * Tracing of a kernel build indicates that for the vast
+		 * majority of calls to copy_to_user(), 'to' is aligned to 8
+		 * bytes. When this is the case, we want to skip to the bulk
+		 * copy as soon as possible.
+		 */
+		ands	x4, x0, 0x7
+		b.eq	body
 
-	.macro ldrh1 reg, ptr, val
-	ldrh  \reg, [\ptr], \val
-	.endm
+		/*
+		 * For small unaligned copies, it's not worth trying to be
+		 * optimal.
+		 */
+		cmp	x2, #8
+		b.lo	bytewise_loop
 
-	.macro strh1 reg, ptr, val
-	user_ldst 9997f, sttrh, \reg, \ptr, \val
-	.endm
+		/*
+		 * Calculate the distance to the next 8-byte boundary.
+		 */
+		mov	x5, #8
+		sub	x4, x5, x4
 
-	.macro ldr1 reg, ptr, val
-	ldr \reg, [\ptr], \val
-	.endm
+SYM_INNER_LABEL(head_realign_1b, SYM_L_LOCAL)
+		tbz	x4, #0, head_realign_2b
 
-	.macro str1 reg, ptr, val
-	user_ldst 9997f, sttr, \reg, \ptr, \val
-	.endm
+		ldrb	w8, [x1], #1
+USER_OFF(0,	sttrb	w8, [x0])
+		add	x0, x0, #1
 
-	.macro ldp1 reg1, reg2, ptr, val
-	ldp \reg1, \reg2, [\ptr], \val
-	.endm
+SYM_INNER_LABEL(head_realign_2b, SYM_L_LOCAL)
+		tbz	x4, #1, head_realign_4b
 
-	.macro stp1 reg1, reg2, ptr, val
-	user_stp 9997f, \reg1, \reg2, \ptr, \val
-	.endm
+		ldrh	w8, [x1], #2
+USER_OFF(0,	sttrh	w8, [x0])
+		add	x0, x0, #2
 
-end	.req	x5
-srcin	.req	x15
-SYM_FUNC_START(__arch_copy_to_user)
-	add	end, x0, x2
-	mov	srcin, x1
-#include "copy_template.S"
-	mov	x0, #0
-	ret
+SYM_INNER_LABEL(head_realign_4b, SYM_L_LOCAL)
+		tbz	x4, #2, head_realigned
 
-	// Exception fixups
-9997:	cmp	dst, dstin
-	b.ne	9998f
-	// Before being absolutely sure we couldn't copy anything, try harder
-	ldrb	tmp1w, [srcin]
-USER(9998f, sttrb tmp1w, [dst])
-	add	dst, dst, #1
-9998:	sub	x0, end, dst			// bytes not copied
-	ret
+		ldr	w8, [x1], #4
+USER_OFF(0,	sttr	w8, [x0])
+		add	x0, x0, #4
+
+SYM_INNER_LABEL(head_realigned, SYM_L_LOCAL)
+		/*
+		 * Any 1-7 byte misalignment has now been fixed; subtract this
+		 * misalignment from the remaining size.
+		 */
+		sub	x2, x2, x4
+
+SYM_INNER_LABEL(body, SYM_L_LOCAL)
+		cmp	x2, #64
+		b.lo	tail_32b
+
+SYM_INNER_LABEL(body_64b_loop, SYM_L_LOCAL)
+		ldp	x8,  x9,  [x1, #0]
+		ldp	x10, x11, [x1, #16]
+		ldp	x12, x13, [x1, #32]
+		ldp	x14, x15, [x1, #48]
+USER_OFF(0,	sttr	x8,  [x0, #0])
+USER_OFF(8,	sttr	x9,  [x0, #8])
+USER_OFF(16,	sttr	x10, [x0, #16])
+USER_OFF(24,	sttr	x11, [x0, #24])
+USER_OFF(32,	sttr	x12, [x0, #32])
+USER_OFF(40,	sttr	x13, [x0, #40])
+USER_OFF(48,	sttr	x14, [x0, #48])
+USER_OFF(56,	sttr	x15, [x0, #56])
+		add	x0, x0, #64
+		add	x1, x1, #64
+		sub	x2, x2, #64
+
+		cmp	x2, #64
+		b.hs	body_64b_loop
+
+SYM_INNER_LABEL(tail_32b, SYM_L_LOCAL)
+		tbz	x2, #5, tail_16b
+
+		ldp	x8,  x9,  [x1, #0]
+		ldp	x10, x11, [x1, #16]
+USER_OFF(0,	sttr	x8,  [x0, #0])
+USER_OFF(8,	sttr	x9,  [x0, #8])
+USER_OFF(16,	sttr	x10, [x0, #16])
+USER_OFF(24,	sttr	x11, [x0, #24])
+		add	x0, x0, #32
+		add	x1, x1, #32
+
+SYM_INNER_LABEL(tail_16b, SYM_L_LOCAL)
+		tbz	x2, #4, tail_8b
+
+		ldp	x8,  x9,  [x1], #16
+USER_OFF(0,	sttr	x8, [x0, #0])
+USER_OFF(8,	sttr	x9, [x0, #8])
+		add	x0, x0, #16
+
+SYM_INNER_LABEL(tail_8b, SYM_L_LOCAL)
+		tbz	x2, #3, tail_4b
+
+		ldr	x8, [x1], #8
+USER_OFF(0,	sttr	x8, [x0])
+		add	x0, x0, #8
+
+SYM_INNER_LABEL(tail_4b, SYM_L_LOCAL)
+		tbz	x2, #2, tail_2b
+
+		ldr	w8, [x1], #4
+USER_OFF(0,	sttr	w8, [x0])
+		add	x0, x0, #4
+
+SYM_INNER_LABEL(tail_2b, SYM_L_LOCAL)
+		tbz	x2, #1, tail_1b
+
+		ldrh	w8, [x1], #2
+USER_OFF(0,	sttrh	w8, [x0])
+		add	x0, x0, #2
+
+SYM_INNER_LABEL(tail_1b, SYM_L_LOCAL)
+		tbz	x2, #0, done
+
+		ldrb	w8, [x1]
+USER_OFF(0,	sttrb	w8, [x0])
+
+SYM_INNER_LABEL(done, SYM_L_LOCAL)
+		mov	x0, xzr
+		ret
+
+SYM_INNER_LABEL(bytewise_loop, SYM_L_LOCAL)
+		cbz	x2, done
+
+		ldrb	w8, [x1], #1
+USER_OFF(0,	sttrb	w8, [x0])
+		add	x0, x0, #1
+		sub	x2, x2, #1
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
 SYM_FUNC_END(__arch_copy_to_user)
 EXPORT_SYMBOL(__arch_copy_to_user)
-- 
2.30.2

