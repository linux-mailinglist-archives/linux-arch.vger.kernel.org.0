Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10A5ED907E
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2019 14:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403823AbfJPMMj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Oct 2019 08:12:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49960 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403786AbfJPMMj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 08:12:39 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iKiAK-0007Zv-Hm; Wed, 16 Oct 2019 12:12:32 +0000
Date:   Wed, 16 Oct 2019 13:12:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>, linux-arch@vger.kernel.org
Subject: [RFC] change of calling conventions for arch_futex_atomic_op_inuser()
Message-ID: <20191016121232.GA28742@ZenIV.linux.org.uk>
References: <20191010195504.GI26530@ZenIV.linux.org.uk>
 <CAHk-=wgWRQo0m7TUCK4T_J-3Vqte+p-FWzvT3CB1jJHgX-KctA@mail.gmail.com>
 <20191011001104.GJ26530@ZenIV.linux.org.uk>
 <CAHk-=wgg3jzkk-jObm1FLVYGS8JCTiKppEnA00_QX7Wsm5ieLQ@mail.gmail.com>
 <20191013181333.GK26530@ZenIV.linux.org.uk>
 <CAHk-=wgrWGyACBM8N8KP7Pu_2VopuzM4A12yQz6Eo=X2Jpwzcw@mail.gmail.com>
 <20191013191050.GL26530@ZenIV.linux.org.uk>
 <CAHk-=wjJNE9hOKuatqh6SFf4nd65LG4ZR3gQSgg+rjSpVxe89w@mail.gmail.com>
 <20191013195949.GM26530@ZenIV.linux.org.uk>
 <20191015180846.GA31707@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015180846.GA31707@ZenIV.linux.org.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 15, 2019 at 07:08:46PM +0100, Al Viro wrote:
> [futex folks and linux-arch Cc'd]

> Another question: right now we have
>         if (!access_ok(uaddr, sizeof(u32)))
>                 return -EFAULT;
> 
>         ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
>         if (ret)
>                 return ret;
> in kernel/futex.c.  Would there be any objections to moving access_ok()
> inside the instances and moving pagefault_disable()/pagefault_enable() outside?
> 
> Reasons:
> 	* on x86 that would allow folding access_ok() with STAC into
> user_access_begin().  The same would be doable on other usual suspects
> (arm, arm64, ppc, riscv, s390), bringing access_ok() next to their
> STAC counterparts.
> 	* pagefault_disable()/pagefault_enable() pair is universal on
> all architectures, really meant to by the nature of the beast and
> lifting it into kernel/futex.c would get the same situation as with
> futex_atomic_cmpxchg_inatomic().  Which also does access_ok() inside
> the primitive (also foldable into user_access_begin(), at that).
> 	* access_ok() would be closer to actual memory access (and
> out of the generic code).
> 
> Comments?

FWIW, completely untested patch follows; just the (semimechanical) conversion
of calling conventions, no per-architecture followups included.  Could futex
folks ACK/NAK that in principle?

commit 7babb6ad28cb3e80977fb6bd0405e3f81a943161
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue Oct 15 16:54:41 2019 -0400

    arch_futex_atomic_op_inuser(): move access_ok() in and pagefault_disable() - out
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/alpha/include/asm/futex.h b/arch/alpha/include/asm/futex.h
index bfd3c01038f8..da67afd578fd 100644
--- a/arch/alpha/include/asm/futex.h
+++ b/arch/alpha/include/asm/futex.h
@@ -31,7 +31,8 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -53,8 +54,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/arc/include/asm/futex.h b/arch/arc/include/asm/futex.h
index 9d0d070e6c22..607d1c16d4dd 100644
--- a/arch/arc/include/asm/futex.h
+++ b/arch/arc/include/asm/futex.h
@@ -75,10 +75,12 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
 #ifndef CONFIG_ARC_HAS_LLSC
 	preempt_disable();	/* to guarantee atomic r-m-w of futex op */
 #endif
-	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -101,7 +103,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
 #ifndef CONFIG_ARC_HAS_LLSC
 	preempt_enable();
 #endif
diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 83c391b597d4..e133da303a98 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -134,10 +134,12 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret, tmp;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
 #ifndef CONFIG_SMP
 	preempt_disable();
 #endif
-	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -159,7 +161,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
 #ifndef CONFIG_SMP
 	preempt_enable();
 #endif
diff --git a/arch/arm64/include/asm/futex.h b/arch/arm64/include/asm/futex.h
index 6cc26a127819..97f6a63810ec 100644
--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -48,7 +48,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 	int oldval = 0, ret, tmp;
 	u32 __user *uaddr = __uaccess_mask_ptr(_uaddr);
 
-	pagefault_disable();
+	if (!access_ok(_uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -75,8 +76,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/hexagon/include/asm/futex.h b/arch/hexagon/include/asm/futex.h
index cb635216a732..8693dc5ae9ec 100644
--- a/arch/hexagon/include/asm/futex.h
+++ b/arch/hexagon/include/asm/futex.h
@@ -36,7 +36,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -62,8 +63,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/ia64/include/asm/futex.h b/arch/ia64/include/asm/futex.h
index 2e106d462196..1db26b432d8c 100644
--- a/arch/ia64/include/asm/futex.h
+++ b/arch/ia64/include/asm/futex.h
@@ -50,7 +50,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -74,8 +75,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/microblaze/include/asm/futex.h b/arch/microblaze/include/asm/futex.h
index 8c90357e5983..86131ed84c9a 100644
--- a/arch/microblaze/include/asm/futex.h
+++ b/arch/microblaze/include/asm/futex.h
@@ -34,7 +34,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -56,8 +57,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/mips/include/asm/futex.h b/arch/mips/include/asm/futex.h
index b83b0397462d..86f224548651 100644
--- a/arch/mips/include/asm/futex.h
+++ b/arch/mips/include/asm/futex.h
@@ -88,7 +88,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -115,8 +116,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/nds32/include/asm/futex.h b/arch/nds32/include/asm/futex.h
index 5213c65c2e0b..60b7ab74ed92 100644
--- a/arch/nds32/include/asm/futex.h
+++ b/arch/nds32/include/asm/futex.h
@@ -66,8 +66,9 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
-	pagefault_disable();
 	switch (op) {
 	case FUTEX_OP_SET:
 		__futex_atomic_op("move	%0, %3", ret, oldval, tmp, uaddr,
@@ -93,8 +94,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/openrisc/include/asm/futex.h b/arch/openrisc/include/asm/futex.h
index fe894e6331ae..865e9cd0d97b 100644
--- a/arch/openrisc/include/asm/futex.h
+++ b/arch/openrisc/include/asm/futex.h
@@ -35,7 +35,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -57,8 +58,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/parisc/include/asm/futex.h b/arch/parisc/include/asm/futex.h
index 50662b6cb605..6e2e4d10e3c8 100644
--- a/arch/parisc/include/asm/futex.h
+++ b/arch/parisc/include/asm/futex.h
@@ -40,11 +40,10 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 	u32 tmp;
 
 	_futex_spin_lock_irqsave(uaddr, &flags);
-	pagefault_disable();
 
 	ret = -EFAULT;
 	if (unlikely(get_user(oldval, uaddr) != 0))
-		goto out_pagefault_enable;
+		goto out_unlock;
 
 	ret = 0;
 	tmp = oldval;
@@ -72,8 +71,7 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 	if (ret == 0 && unlikely(put_user(tmp, uaddr) != 0))
 		ret = -EFAULT;
 
-out_pagefault_enable:
-	pagefault_enable();
+out_unlock:
 	_futex_spin_unlock_irqrestore(uaddr, &flags);
 
 	if (!ret)
diff --git a/arch/powerpc/include/asm/futex.h b/arch/powerpc/include/asm/futex.h
index eea28ca679db..d6e32b32f452 100644
--- a/arch/powerpc/include/asm/futex.h
+++ b/arch/powerpc/include/asm/futex.h
@@ -35,8 +35,9 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 	allow_write_to_user(uaddr, sizeof(*uaddr));
-	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -58,8 +59,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	*oval = oldval;
 
 	prevent_write_to_user(uaddr, sizeof(*uaddr));
diff --git a/arch/riscv/include/asm/futex.h b/arch/riscv/include/asm/futex.h
index 4ad6409c4647..84574acfb927 100644
--- a/arch/riscv/include/asm/futex.h
+++ b/arch/riscv/include/asm/futex.h
@@ -40,7 +40,8 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 {
 	int oldval = 0, ret = 0;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -67,8 +68,6 @@ arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *uaddr)
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/s390/include/asm/futex.h b/arch/s390/include/asm/futex.h
index 5e97a4353147..3c18a48baf44 100644
--- a/arch/s390/include/asm/futex.h
+++ b/arch/s390/include/asm/futex.h
@@ -28,8 +28,10 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	int oldval = 0, newval, ret;
 	mm_segment_t old_fs;
 
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
+
 	old_fs = enable_sacf_uaccess();
-	pagefault_disable();
 	switch (op) {
 	case FUTEX_OP_SET:
 		__futex_atomic_op("lr %2,%5\n",
@@ -54,7 +56,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	default:
 		ret = -ENOSYS;
 	}
-	pagefault_enable();
 	disable_sacf_uaccess(old_fs);
 
 	if (!ret)
diff --git a/arch/sh/include/asm/futex.h b/arch/sh/include/asm/futex.h
index 3190ec89df81..b39cda09fb95 100644
--- a/arch/sh/include/asm/futex.h
+++ b/arch/sh/include/asm/futex.h
@@ -34,8 +34,6 @@ static inline int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval,
 	u32 oldval, newval, prev;
 	int ret;
 
-	pagefault_disable();
-
 	do {
 		ret = get_user(oldval, uaddr);
 
@@ -67,8 +65,6 @@ static inline int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval,
 		ret = futex_atomic_cmpxchg_inatomic(&prev, uaddr, oldval, newval);
 	} while (!ret && prev != oldval);
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/sparc/include/asm/futex_64.h b/arch/sparc/include/asm/futex_64.h
index 0865ce77ec00..72de967318d7 100644
--- a/arch/sparc/include/asm/futex_64.h
+++ b/arch/sparc/include/asm/futex_64.h
@@ -38,8 +38,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 	if (unlikely((((unsigned long) uaddr) & 0x3UL)))
 		return -EINVAL;
 
-	pagefault_disable();
-
 	switch (op) {
 	case FUTEX_OP_SET:
 		__futex_cas_op("mov\t%4, %1", ret, oldval, uaddr, oparg);
@@ -60,8 +58,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 13c83fe97988..6bcd1c1486d9 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -47,7 +47,8 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 {
 	int oldval = 0, ret, tem;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -70,8 +71,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/arch/xtensa/include/asm/futex.h b/arch/xtensa/include/asm/futex.h
index 0c4457ca0a85..271cfcf8a841 100644
--- a/arch/xtensa/include/asm/futex.h
+++ b/arch/xtensa/include/asm/futex.h
@@ -72,7 +72,8 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 #if XCHAL_HAVE_S32C1I || XCHAL_HAVE_EXCLUSIVE
 	int oldval = 0, ret;
 
-	pagefault_disable();
+	if (!access_ok(uaddr, sizeof(u32)))
+		return -EFAULT;
 
 	switch (op) {
 	case FUTEX_OP_SET:
@@ -99,8 +100,6 @@ static inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		ret = -ENOSYS;
 	}
 
-	pagefault_enable();
-
 	if (!ret)
 		*oval = oldval;
 
diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 02970b11f71f..f4c3470480c7 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -34,7 +34,6 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 	u32 tmp;
 
 	preempt_disable();
-	pagefault_disable();
 
 	ret = -EFAULT;
 	if (unlikely(get_user(oldval, uaddr) != 0))
@@ -67,7 +66,6 @@ arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 		ret = -EFAULT;
 
 out_pagefault_enable:
-	pagefault_enable();
 	preempt_enable();
 
 	if (ret == 0)
diff --git a/kernel/futex.c b/kernel/futex.c
index bd18f60e4c6c..2cc8a35109da 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1662,10 +1662,9 @@ static int futex_atomic_op_inuser(unsigned int encoded_op, u32 __user *uaddr)
 		oparg = 1 << oparg;
 	}
 
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
-
+	pagefault_disable();
 	ret = arch_futex_atomic_op_inuser(op, oparg, &oldval, uaddr);
+	pagefault_enable();
 	if (ret)
 		return ret;
 
