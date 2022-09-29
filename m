Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB605F008C
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiI2Wfm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiI2We0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:34:26 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE5A1C5C8B;
        Thu, 29 Sep 2022 15:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490690; x=1696026690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=iq8dhkXWm5cP6VIZVGhcIx1cQKd1zCLxnJKDHuiQvpo=;
  b=CF28L9Yo1ynMl3IIQBWiY739l2aFF/6AmzOSLsz8tZrZ/NGowoxxdnh4
   DYk1+jcRiNGiXLmojBnNpvtVSim1P6UBex+YSM9NVfZxMJ1j1FmjDZzty
   CzNXVgS+AuZuN5OQ8dfIjo0htSVLs8ZmqewQw9KPEH1uO/EUaNHXD019f
   DhZ1HmtCSeV3+VoIpcpv5pw37/bZyDvSUyko2zklx8oMd4jJ48auVetXn
   hieWvXRK1cks44oSn7v76HGwRLHvOrvpsN+/pENZJALDXyZjeOBI9aOuj
   gUgR8aJvsPh1CJm7gxKwOu4lVo+hnf+hm8m3R1X1Kdw3e3ZJ2SIPpkox8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182067"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182067"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016324"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016324"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:40 -0700
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v2 26/39] x86/cet/shstk: Introduce routines modifying shstk
Date:   Thu, 29 Sep 2022 15:29:23 -0700
Message-Id: <20220929222936.14584-27-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Shadow stack's are normally written to via CALL/RET or specific CET
instuctions like RSTORSSP/SAVEPREVSSP. However during some Linux
operations the kernel will need to write to directly using the ring-0 only
WRUSS instruction.

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
have this bit set as it is in the kernel range. It is also can't be a
valid restore token.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---

v2:
 - Add data helpers for writing to shadow stack.

v1:
 - Use xsave helpers.

Yu-cheng v30:
 - Update commit log, remove description about signals.
 - Update various comments.
 - Remove variable 'ssp' init and adjust return value accordingly.
 - Check get_user_shstk_addr() return value.
 - Replace 'ia32' with 'proc32'.

Yu-cheng v29:
 - Update comments for the use of get_xsave_addr().

 arch/x86/include/asm/special_insns.h |  13 ++++
 arch/x86/kernel/shstk.c              | 108 +++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 35f709f619fb..f096f52bd059 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -223,6 +223,19 @@ static inline void clwb(volatile void *__p)
 		: [pax] "a" (p));
 }
 
+#ifdef CONFIG_X86_SHADOW_STACK
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
+#endif /* CONFIG_X86_SHADOW_STACK */
+
 #define nop() asm volatile ("nop")
 
 static inline void serialize(void)
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index db4e53f9fdaf..8904aef487bf 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -25,6 +25,8 @@
 #include <asm/fpu/api.h>
 #include <asm/prctl.h>
 
+#define SS_FRAME_SIZE 8
+
 static bool feature_enabled(unsigned long features)
 {
 	return current->thread.features & features;
@@ -40,6 +42,31 @@ static void feature_clr(unsigned long features)
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
+	/* Mark the token 64-bit */
+	ssp |= BIT(0);
+
+	if (write_user_shstk_64((u64 __user *)addr, (u64)ssp))
+		return -EFAULT;
+
+	*token_addr = addr;
+
+	return 0;
+}
+
 static unsigned long alloc_shstk(unsigned long size)
 {
 	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
@@ -158,6 +185,87 @@ int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
 	return 0;
 }
 
+static unsigned long get_user_shstk_addr(void)
+{
+	unsigned long long ssp;
+
+	fpu_lock_and_load();
+
+	rdmsrl(MSR_IA32_PL3_SSP, ssp);
+
+	fpregs_unlock();
+
+	return ssp;
+}
+
+static int put_shstk_data(u64 __user *addr, u64 data)
+{
+	WARN_ON(data & BIT(63));
+
+	/*
+	 * Mark the high bit so that the sigframe can't be processed as a
+	 * return address.
+	 */
+	if (write_user_shstk_64(addr, data | BIT(63)))
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
+	if (!(ldata & BIT(63)))
+		return -EINVAL;
+
+	*data = ldata & ~BIT(63);
+
+	return 0;
+}
+
+/*
+ * Verify the user shadow stack has a valid token on it, and then set
+ * *new_ssp according to the token.
+ */
+static int shstk_check_rstor_token(unsigned long *new_ssp)
+{
+	unsigned long token_addr;
+	unsigned long token;
+
+	token_addr = get_user_shstk_addr();
+	if (!token_addr)
+		return -EINVAL;
+
+	if (get_user(token, (unsigned long __user *)token_addr))
+		return -EFAULT;
+
+	/* Is mode flag correct? */
+	if (!(token & BIT(0)))
+		return -EINVAL;
+
+	/* Is busy flag set? */
+	if (token & BIT(1))
+		return -EINVAL;
+
+	/* Mask out flags */
+	token &= ~3UL;
+
+	/* Restore address aligned? */
+	if (!IS_ALIGNED(token, 8))
+		return -EINVAL;
+
+	/* Token placed properly? */
+	if (((ALIGN_DOWN(token, 8) - 8) != token_addr) || token >= TASK_SIZE_MAX)
+		return -EINVAL;
+
+	*new_ssp = token;
+
+	return 0;
+}
+
 void shstk_free(struct task_struct *tsk)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
-- 
2.17.1

