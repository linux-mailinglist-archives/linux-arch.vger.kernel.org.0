Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8385B6BFE74
	for <lists+linux-arch@lfdr.de>; Sun, 19 Mar 2023 01:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjCSAWW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Mar 2023 20:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjCSAVa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Mar 2023 20:21:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD3E2B9D1;
        Sat, 18 Mar 2023 17:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679185182; x=1710721182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dBIkMgtPKqQv5kVHDuakiGU5eUx6LQnshjLSaxY9/+4=;
  b=IsdWT5sxlFApwumXL8OAmtxb2UhFWs8+9Z/Jt8IBJcAOJz0eNRdvHiw2
   NJcIdxmOKE6x7TCXY4s9vt8pTdHoyAdwFP6/FM/zcxjW5ZZNEyJm58JaH
   SgIy0oeN9s/O7ETdq/tdcHHKn+bjetTkD1a980J317yu1HYFx1ABsGI+a
   FSBrzDYpQEAEtNPah2/jNnn1C/2qa7YKdWbbmlVL8MEPT8UyBl1ZLJmq3
   L5jUA99zdASzzCm8yzokO0jxV2Ev8DsNO3M8gU5zPGu5sp1NBb0V7zoeW
   SvUqmGRPaxkYGtVdILCIiki0mzQQPHjV08yzwoaD1wJdUl++E+CbwgiUC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="338491420"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="338491420"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10653"; a="749672945"
X-IronPort-AV: E=Sophos;i="5.98,272,1673942400"; 
   d="scan'208";a="749672945"
Received: from bmahatwo-mobl1.gar.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.135.34.5])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 17:16:44 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v8 31/40] x86/shstk: Introduce routines modifying shstk
Date:   Sat, 18 Mar 2023 17:15:26 -0700
Message-Id: <20230319001535.23210-32-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
References: <20230319001535.23210-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Shadow stacks are normally written to via CALL/RET or specific CET
instructions like RSTORSSP/SAVEPREVSSP. However, sometimes the kernel will
need to write to the shadow stack directly using the ring-0 only WRUSS
instruction.

A shadow stack restore token marks a restore point of the shadow stack, and
the address in a token must point directly above the token, which is within
the same shadow stack. This is distinctively different from other pointers
on the shadow stack, since those pointers point to executable code area.

Introduce token setup and verify routines. Also introduce WRUSS, which is
a kernel-mode instruction but writes directly to user shadow stack.

In future patches that enable shadow stack to work with signals, the kernel
will need something to denote the point in the stack where sigreturn may be
called. This will prevent attackers calling sigreturn at arbitrary places
in the stack, in order to help prevent SROP attacks.

To do this, something that can only be written by the kernel needs to be
placed on the shadow stack. This can be accomplished by setting bit 63 in
the frame written to the shadow stack. Userspace return addresses can't
have this bit set as it is in the kernel range. It also can't be a valid
restore token.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
v8:
 - Update commit log verbiage (Boris)
 - Use define instead of magic BIT(63) (Boris)

v5:
 - Fix typo in commit log

v3:
 - Drop shstk_check_rstor_token()
 - Fail put_shstk_data() if bit 63 is set in the data (Kees)
 - Add comment in create_rstor_token() (Kees)
 - Pull in create_rstor_token() changes from future patch (Kees)

v2:
 - Add data helpers for writing to shadow stack.
---
 arch/x86/include/asm/special_insns.h | 13 +++++
 arch/x86/kernel/shstk.c              | 75 ++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index de48d1389936..d6cd9344f6c7 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -202,6 +202,19 @@ static inline void clwb(volatile void *__p)
 		: [pax] "a" (p));
 }
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+static inline int write_user_shstk_64(u64 __user *addr, u64 val)
+{
+	asm_volatile_goto("1: wrussq %[val], (%[addr])\n"
+			  _ASM_EXTABLE(1b, %l[fail])
+			  :: [addr] "r" (addr), [val] "r" (val)
+			  :: fail);
+	return 0;
+fail:
+	return -EFAULT;
+}
+#endif /* CONFIG_X86_USER_SHADOW_STACK */
+
 #define nop() asm volatile ("nop")
 
 static inline void serialize(void)
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index bd9cdc3a7338..e22928c63ffc 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -25,6 +25,8 @@
 #include <asm/fpu/api.h>
 #include <asm/prctl.h>
 
+#define SS_FRAME_SIZE 8
+
 static bool features_enabled(unsigned long features)
 {
 	return current->thread.features & features;
@@ -40,6 +42,35 @@ static void features_clr(unsigned long features)
 	current->thread.features &= ~features;
 }
 
+/*
+ * Create a restore token on the shadow stack.  A token is always 8-byte
+ * and aligned to 8.
+ */
+static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
+{
+	unsigned long addr;
+
+	/* Token must be aligned */
+	if (!IS_ALIGNED(ssp, 8))
+		return -EINVAL;
+
+	addr = ssp - SS_FRAME_SIZE;
+
+	/*
+	 * SSP is aligned, so reserved bits and mode bit are a zero, just mark
+	 * the token 64-bit.
+	 */
+	ssp |= BIT(0);
+
+	if (write_user_shstk_64((u64 __user *)addr, (u64)ssp))
+		return -EFAULT;
+
+	if (token_addr)
+		*token_addr = addr;
+
+	return 0;
+}
+
 static unsigned long alloc_shstk(unsigned long size)
 {
 	int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_ABOVE4G;
@@ -157,6 +188,50 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
 	return addr + size;
 }
 
+static unsigned long get_user_shstk_addr(void)
+{
+	unsigned long long ssp;
+
+	fpregs_lock_and_load();
+
+	rdmsrl(MSR_IA32_PL3_SSP, ssp);
+
+	fpregs_unlock();
+
+	return ssp;
+}
+
+#define SHSTK_DATA_BIT BIT(63)
+
+static int put_shstk_data(u64 __user *addr, u64 data)
+{
+	if (WARN_ON_ONCE(data & SHSTK_DATA_BIT))
+		return -EINVAL;
+
+	/*
+	 * Mark the high bit so that the sigframe can't be processed as a
+	 * return address.
+	 */
+	if (write_user_shstk_64(addr, data | SHSTK_DATA_BIT))
+		return -EFAULT;
+	return 0;
+}
+
+static int get_shstk_data(unsigned long *data, unsigned long __user *addr)
+{
+	unsigned long ldata;
+
+	if (unlikely(get_user(ldata, addr)))
+		return -EFAULT;
+
+	if (!(ldata & SHSTK_DATA_BIT))
+		return -EINVAL;
+
+	*data = ldata & ~SHSTK_DATA_BIT;
+
+	return 0;
+}
+
 void shstk_free(struct task_struct *tsk)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
-- 
2.17.1

