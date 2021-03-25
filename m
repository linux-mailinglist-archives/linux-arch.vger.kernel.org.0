Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D5D348ADE
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 08:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhCYH5W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 03:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhCYH5E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 03:57:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3DFD61A1A;
        Thu, 25 Mar 2021 07:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616659023;
        bh=u9RL4LzT+WLWRXBJ9z//sx5hDHBEN+tPj2LL+JYE+O8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W0l/baDjx+xRV6jqmt0HGL2qQ6hcpoA/SSXCSx3D4FnpBEkUri0ZkT7Iyq9Irmh15
         8eIHcYW4l4aI8bp9zKxEiIKdk8JHnWbWx6+RNBSBc/j5aedp4Nv+2UwAHnCduaegbt
         PxbwwlrVHooRalO9w8wEK2aG7kBMI3xlcxP3UrUZL9sGYCPHzwnzvvgY2EaY2+TH01
         dUQ103wTcmTl2esthu0Mdi+6kEefGxuDUOzFmGTy6VReb43zL4b8scOP1OiqUtdnLc
         q3vCxF2ujaegsaYsgFXE4E1G8KnYNZrt7iswaR7vyycfqVj3CXKGR62D78494AA0/Z
         Qk1MNxMJrGltg==
From:   guoren@kernel.org
To:     guoren@kernel.org, Anup.Patel@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        tech-unixplatformspec@lists.riscv.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v3 3/4] riscv: cmpxchg.h: Implement xchg for short
Date:   Thu, 25 Mar 2021 07:55:36 +0000
Message-Id: <1616658937-82063-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616658937-82063-1-git-send-email-guoren@kernel.org>
References: <1616658937-82063-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

riscv only support lr.wd/s(c).w(d) with word(double word) size &
align access. There are not lr.h/sc.h instructions. But qspinlock.c
need xchg with short type variable:

xchg_tail -> xchg_releaxed(&lock->tail, ...

typedef struct qspinlock {
        union {
		atomic_t val;

		/*
		 * By using the whole 2nd least significant byte for the
		 * pending bit, we can allow better optimization of the lock
		 * acquisition for the pending bit holder.
		 */
		struct {
			u8	locked;
			u8	pending;
		};
		struct {
			u16	locked_pending;
			u16	tail; /* half word*/
		};
	};
} arch_spinlock_t;

So we add short emulation in xchg with word length and it only
solve qspinlock's requirement.

Michael has sent another implementation, see the Link below.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-developed-by: Michael Clark <michaeljclark@mac.com>
Tested-by: Guo Ren <guoren@linux.alibaba.com>
Link: https://lore.kernel.org/linux-riscv/20190211043829.30096-2-michaeljclark@mac.com/
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Anup Patel <anup@brainfault.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/cmpxchg.h | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 50513b95411d..5ca41152cf4b 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -22,7 +22,43 @@
 	__typeof__(ptr) __ptr = (ptr);					\
 	__typeof__(new) __new = (new);					\
 	__typeof__(*(ptr)) __ret;					\
+	register unsigned long __rc, tmp, align, addr;			\
 	switch (size) {							\
+	case 2:								\
+		align = ((unsigned long) __ptr & 0x3);			\
+		addr = ((unsigned long) __ptr & ~0x3);			\
+		if (align) {						\
+			__asm__ __volatile__ (				\
+			"0:	lr.w	%0, (%4)	\n"		\
+			"	mv	%1, %0		\n"		\
+			"	slliw	%1, %1, 16	\n"		\
+			"	srliw	%1, %1, 16	\n"		\
+			"	mv	%2, %3		\n"		\
+			"	slliw	%2, %2, 16	\n"		\
+			"	or	%1, %2, %1	\n"		\
+			"	sc.w	%2, %1, (%4)	\n"		\
+			"	bnez	%2, 0b		\n"		\
+			"	srliw	%0, %0, 16	\n"		\
+			: "=&r" (__ret), "=&r" (tmp), "=&r" (__rc)	\
+			: "r" (__new), "r"(addr)			\
+			: "memory");					\
+		} else {						\
+			__asm__ __volatile__ (				\
+			"0:	lr.w	%0, (%4)	\n"		\
+			"	mv	%1, %0		\n"		\
+			"	srliw	%1, %1, 16	\n"		\
+			"	slliw	%1, %1, 16	\n"		\
+			"	mv	%2, %3		\n"		\
+			"	or	%1, %2, %1	\n"		\
+			"	sc.w	%2, %1, 0(%4)	\n"		\
+			"	bnez	%2, 0b		\n"		\
+			"	slliw	%0, %0, 16	\n"		\
+			"	srliw	%0, %0, 16	\n"		\
+			: "=&r" (__ret), "=&r" (tmp), "=&r" (__rc)	\
+			: "r" (__new), "r"(addr)			\
+			: "memory");					\
+		}							\
+		break;							\
 	case 4:								\
 		__asm__ __volatile__ (					\
 			"	amoswap.w %0, %2, %1\n"			\
-- 
2.17.1

