Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364EF213B92
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 16:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgGCOMr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 10:12:47 -0400
Received: from ozlabs.org ([203.11.71.1]:57817 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgGCOMl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 10:12:41 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49yxkF6xBTz9sSn; Sat,  4 Jul 2020 00:12:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593785557;
        bh=A/fK4GpD51VpmXThbPYLC3ADd3hoTMsYrDa2vdTUmPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWsC/BfUbN+ubhZqcLXhD29ekXIy5zog04CuA8K8V5tOgjon7eqlrlDNH/6kzMVBS
         tZaE3iGyxzpEljUba9pWGlYaqErxukrwU5I2ZVxj3rSRhFNhUICHV61t5XUXtdBh9C
         iMTmyMGATt5WtnZVS3+I0ANrffouLi5r5BvjPR2rTwUunf5CQexuNYXYJh+dWaYVn3
         CcuFLUblQyNzfc7YoRwpRhUMMpNC9XwB0PSIc+NcRL70ZyWDowJOJ95QHmtxLjpdIZ
         n78GoDZZbyLyFGA3ppdehm8GbmvNJ47U8tflkJAq8Pv6YWtBMcWOlcIgOfz5ZlLsr5
         K9cUUtRzxznnA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        hughd@google.com
Subject: [PATCH 2/5] powerpc: Allow 4096 bytes of stack expansion for the signal frame
Date:   Sat,  4 Jul 2020 00:13:24 +1000
Message-Id: <20200703141327.1732550-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703141327.1732550-1-mpe@ellerman.id.au>
References: <20200703141327.1732550-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We have powerpc specific logic in our page fault handling to decide if
an access to an unmapped address below the stack pointer should expand
the stack VMA.

The code was originally added in 2004 "ported from 2.4". The rough
logic is that the stack is allowed to grow to 1MB with no extra
checking. Over 1MB the access must be within 2048 bytes of the stack
pointer, or be from a user instruction that updates the stack pointer.

The 2048 byte allowance below the stack pointer is there to cover the
288 "red zone" as well as the "about 1.5kB" needed by the signal
delivery code.

Unfortunately since then the signal frame has expanded, and is now
4096 bytes on 64-bit kernels with transactional memory enabled. This
means if a process has consumed more than 1MB of stack, and its stack
pointer lies less than 4096 bytes from the next page boundary, signal
delivery will fault when trying to expand the stack and the process
will see a SEGV.

The 2048 allowance was sufficient until 2008 as the signal frame was:

struct rt_sigframe {
        struct ucontext    uc;                           /*     0  1440 */
        /* --- cacheline 11 boundary (1408 bytes) was 32 bytes ago --- */
        long unsigned int          _unused[2];           /*  1440    16 */
        unsigned int               tramp[6];             /*  1456    24 */
        struct siginfo *           pinfo;                /*  1480     8 */
        void *                     puc;                  /*  1488     8 */
        struct siginfo     info;                         /*  1496   128 */
        /* --- cacheline 12 boundary (1536 bytes) was 88 bytes ago --- */
        char                       abigap[288];          /*  1624   288 */

        /* size: 1920, cachelines: 15, members: 7 */
        /* padding: 8 */
};

Then in commit ce48b2100785 ("powerpc: Add VSX context save/restore,
ptrace and signal support") (Jul 2008) the signal frame expanded to
2176 bytes:

struct rt_sigframe {
        struct ucontext    uc;                           /*     0  1696 */	<--
        /* --- cacheline 13 boundary (1664 bytes) was 32 bytes ago --- */
        long unsigned int          _unused[2];           /*  1696    16 */
        unsigned int               tramp[6];             /*  1712    24 */
        struct siginfo *           pinfo;                /*  1736     8 */
        void *                     puc;                  /*  1744     8 */
        struct siginfo     info;                         /*  1752   128 */
        /* --- cacheline 14 boundary (1792 bytes) was 88 bytes ago --- */
        char                       abigap[288];          /*  1880   288 */

        /* size: 2176, cachelines: 17, members: 7 */
        /* padding: 8 */
};

At this point we should have been exposed to the bug, though as far as
I know it was never reported. I no longer have a system old enough to
easily test on.

Then in 2010 commit 320b2b8de126 ("mm: keep a guard page below a
grow-down stack segment") caused our stack expansion code to never
trigger, as there was always a VMA found for a write up to PAGE_SIZE
below r1.

That meant the bug was hidden as we continued to expand the signal
frame in commit 2b0a576d15e0 ("powerpc: Add new transactional memory
state to the signal context") (Feb 2013):

struct rt_sigframe {
        struct ucontext    uc;                           /*     0  1696 */
        /* --- cacheline 13 boundary (1664 bytes) was 32 bytes ago --- */
        struct ucontext    uc_transact;                  /*  1696  1696 */	<--
        /* --- cacheline 26 boundary (3328 bytes) was 64 bytes ago --- */
        long unsigned int          _unused[2];           /*  3392    16 */
        unsigned int               tramp[6];             /*  3408    24 */
        struct siginfo *           pinfo;                /*  3432     8 */
        void *                     puc;                  /*  3440     8 */
        struct siginfo     info;                         /*  3448   128 */
        /* --- cacheline 27 boundary (3456 bytes) was 120 bytes ago --- */
        char                       abigap[288];          /*  3576   288 */

        /* size: 3872, cachelines: 31, members: 8 */
        /* padding: 8 */
        /* last cacheline: 32 bytes */
};

And commit 573ebfa6601f ("powerpc: Increase stack redzone for 64-bit
userspace to 512 bytes") (Feb 2014):

struct rt_sigframe {
        struct ucontext    uc;                           /*     0  1696 */
        /* --- cacheline 13 boundary (1664 bytes) was 32 bytes ago --- */
        struct ucontext    uc_transact;                  /*  1696  1696 */
        /* --- cacheline 26 boundary (3328 bytes) was 64 bytes ago --- */
        long unsigned int          _unused[2];           /*  3392    16 */
        unsigned int               tramp[6];             /*  3408    24 */
        struct siginfo *           pinfo;                /*  3432     8 */
        void *                     puc;                  /*  3440     8 */
        struct siginfo     info;                         /*  3448   128 */
        /* --- cacheline 27 boundary (3456 bytes) was 120 bytes ago --- */
        char                       abigap[512];          /*  3576   512 */	<--

        /* size: 4096, cachelines: 32, members: 8 */
        /* padding: 8 */
};

Then finally in 2017 commit 1be7107fbe18 ("mm: larger stack guard gap,
between vmas") exposed us to the existing bug, because it changed the
stack VMA to be the correct/real size, meaning our stack expansion
code is now triggered.

Fix it by increasing the allowance to 4096 bytes.

Hard-coding 4096 is obviously unsafe against future expansions of the
signal frame in the same way as the existing code. We can't easily use
sizeof() because the signal frame structure is not in a header. We
will either fix that, or rip out all the custom stack expansion
checking logic entirely.

Reported-by: Tom Lane <tgl@sss.pgh.pa.us>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 641fc5f3d7dd..ed01329dd12b 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -274,7 +274,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
 	/*
 	 * N.B. The POWER/Open ABI allows programs to access up to
 	 * 288 bytes below the stack pointer.
-	 * The kernel signal delivery code writes up to about 1.5kB
+	 * The kernel signal delivery code writes up to 4KB
 	 * below the stack pointer (r1) before decrementing it.
 	 * The exec code can write slightly over 640kB to the stack
 	 * before setting the user r1.  Thus we allow the stack to
@@ -299,7 +299,7 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
 		 * between the last mapped region and the stack will
 		 * expand the stack rather than segfaulting.
 		 */
-		if (address + 2048 >= uregs->gpr[1])
+		if (address + 4096 >= uregs->gpr[1])
 			return false;
 
 		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
-- 
2.25.1

