Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0732E61A4B9
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiKDWpi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiKDWpO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:45:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAF6748E8;
        Fri,  4 Nov 2022 15:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601651; x=1699137651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1SbH7KoNxvEwp9S5kMeICfV9WFkC+yJHuL5TGX2hAx8=;
  b=hI+057rc4rP/YkRP6tRz9ZXkpPjLrxDP8DqPTZ/OY6p8cwh4YXNOVKgG
   UXX1giMy7bBK35+1SiojyiMkFOKfVUKrFdWoE4SCQS4N+oumZGYLSEo8S
   rrZGrIruO1ssOmZBfEoByiWyThyBNxVh3OjN/lTqpO1uyTY20NC6iQwPa
   qcXPpA01NuRawkjN3ZCavViewbtsguG2jVmRjSbraHBc28mWn5f+3oCpO
   yF+8xgQsj/bkNLObPBEvqqPgs1YodyCHRsNYq+wk45b7hT0zzOaNBP8cW
   wyeW0Fl1RTC2k3cvAp981ES9T2GIc3d9K9/99H/T83Zb3fnroIPDUUkvt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840627"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840627"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:54 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514171"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514171"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:53 -0700
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
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v3 35/37] x86/cet: Add PTRACE interface for CET
Date:   Fri,  4 Nov 2022 15:36:02 -0700
Message-Id: <20221104223604.29615-36-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Some applications (like GDB and CRIU) would like to tweak CET state via
ptrace. This allows for existing functionality to continue to work for
seized CET applications. Provide an interface based on the xsave buffer
format of CET, but filter unneeded states to make the kernel’s job
easier.

There is already ptrace functionality for accessing xstate, but this
does not include supervisor xfeatures. So there is not a completely
clear place for where to put the CET state. Adding it to the user
xfeatures regset would complicate that code, as it currently shares
logic with signals which should not have supervisor features.

Don’t add a general supervisor xfeature regset like the user one,
because it is better to maintain flexibility for other supervisor
xfeatures to define their own interface. For example, an xfeature may
decide not to expose all of it’s state to userspace. A lot of enum
values remain to be used, so just put it in dedicated CET regset.

The only downside to not having a generic supervisor xfeature regset,
is that apps need to be enlightened of any new supervisor xfeature
exposed this way (i.e. they can’t try to have generic save/restore
logic). But maybe that is a good thing, because they have to think
through each new xfeature instead of encountering issues when new a new
supervisor xfeature was added.

By adding a CET regset, it also has the effect of including the CET state
in a core dump, which could be useful for debugging.

Inside the setter CET regset, filter out invalid state. Today this
includes states disallowed by the HW and states involving Indirect Branch
Tracking which the kernel does not currently support for usersapce.

So this leaves three pieces of data that can be set, shadow stack
enablement, WRSS enablement and the shadow stack pointer. It is worth
noting that this is separate than enabling shadow stack via the
arch_prctl()s. Enabling shadow stack involves more than just flipping the
bit. The kernel is made aware that it has to do extra things when cloning
or handling signals. That logic is triggered off of separate feature
enablement state kept in the task struct. So the flipping on HW shadow
stack enforcement without notifying the kernel to change its behavior
would severely limit what an application could do without crashing. Since
there is likely no use for this, only allow the CET registers to be set
if shadow stack is already enabled via the arch_prctl()s. This will let
apps like GDB toggle shadow stack enforcement for apps that already have
shadow stack enabled, and minimize scenarios the kernel has to worry
about.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

---

v3:
 - Drop dependence on thread.shstk.size, and use thread.features bits
 - Drop 32 bit support

v2:
 - Check alignment on ssp.
 - Block IBT bits.
 - Handle init states instead of returning error.
 - Add verbose commit log justifying the design.

Yu-Cheng v12:
 - Return -ENODEV when CET registers are in INIT state.
 - Check reserved/non-support bits from user input.

 arch/x86/include/asm/fpu/regset.h |  7 +--
 arch/x86/include/asm/msr-index.h  |  5 ++
 arch/x86/kernel/fpu/regset.c      | 90 +++++++++++++++++++++++++++++++
 arch/x86/kernel/ptrace.c          | 20 +++++++
 include/uapi/linux/elf.h          |  1 +
 5 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/regset.h b/arch/x86/include/asm/fpu/regset.h
index 4f928d6a367b..8622184d87f5 100644
--- a/arch/x86/include/asm/fpu/regset.h
+++ b/arch/x86/include/asm/fpu/regset.h
@@ -7,11 +7,12 @@
 
 #include <linux/regset.h>
 
-extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active;
+extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active,
+				cetregs_active;
 extern user_regset_get2_fn fpregs_get, xfpregs_get, fpregs_soft_get,
-				 xstateregs_get;
+				 xstateregs_get, cetregs_get;
 extern user_regset_set_fn fpregs_set, xfpregs_set, fpregs_soft_set,
-				 xstateregs_set;
+				 xstateregs_set, cetregs_set;
 
 /*
  * xstateregs_active == regset_fpregs_active. Please refer to the comment
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 10ac52705892..674c508798ee 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -437,6 +437,11 @@
 #define CET_RESERVED			(BIT_ULL(6) | BIT_ULL(7) | BIT_ULL(8) | BIT_ULL(9))
 #define CET_SUPPRESS			BIT_ULL(10)
 #define CET_WAIT_ENDBR			BIT_ULL(11)
+#define CET_EG_LEG_BITMAP_BASE_MASK	GENMASK_ULL(63, 13)
+
+#define CET_U_IBT_MASK			(CET_ENDBR_EN | CET_LEG_IW_EN | CET_NO_TRACK_EN | \
+					 CET_NO_TRACK_EN | CET_SUPPRESS_DISABLE | CET_SUPPRESS | \
+					 CET_WAIT_ENDBR | CET_EG_LEG_BITMAP_BASE_MASK)
 
 #define MSR_IA32_PL0_SSP		0x000006a4 /* ring-0 shadow stack pointer */
 #define MSR_IA32_PL1_SSP		0x000006a5 /* ring-1 shadow stack pointer */
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 75ffaef8c299..21225b994b2d 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -8,6 +8,7 @@
 #include <asm/fpu/api.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
+#include <asm/prctl.h>
 
 #include "context.h"
 #include "internal.h"
@@ -174,6 +175,95 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
+int cetregs_active(struct task_struct *target, const struct user_regset *regset)
+{
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+	if (target->thread.features & CET_SHSTK)
+		return regset->n;
+#endif
+	return 0;
+}
+
+int cetregs_get(struct task_struct *target, const struct user_regset *regset,
+		struct membuf to)
+{
+	struct fpu *fpu = &target->thread.fpu;
+	struct cet_user_state *cetregs;
+
+	if (!boot_cpu_has(X86_FEATURE_USER_SHSTK))
+		return -ENODEV;
+
+	sync_fpstate(fpu);
+	cetregs = get_xsave_addr(&fpu->fpstate->regs.xsave, XFEATURE_CET_USER);
+	if (!cetregs) {
+		/*
+		 * The registers are the in the init state. The init values for
+		 * these regs are zero, so just zero the output buffer.
+		 */
+		membuf_zero(&to, sizeof(struct cet_user_state));
+		return 0;
+	}
+
+	return membuf_write(&to, cetregs, sizeof(struct cet_user_state));
+}
+
+int cetregs_set(struct task_struct *target, const struct user_regset *regset,
+		  unsigned int pos, unsigned int count,
+		  const void *kbuf, const void __user *ubuf)
+{
+	struct fpu *fpu = &target->thread.fpu;
+	struct xregs_state *xsave = &fpu->fpstate->regs.xsave;
+	struct cet_user_state *cetregs, tmp;
+	int r;
+
+	if (!boot_cpu_has(X86_FEATURE_USER_SHSTK) ||
+	    !cetregs_active(target, regset))
+		return -ENODEV;
+
+	r = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &tmp, 0, -1);
+	if (r)
+		return r;
+
+	/*
+	 * Some kernel instructions (IRET, etc) can cause exceptions in the case
+	 * of disallowed CET register values. Just prevent invalid values.
+	 */
+	if ((tmp.user_ssp >= TASK_SIZE_MAX) || !IS_ALIGNED(tmp.user_ssp, 8))
+		return -EINVAL;
+
+	/*
+	 * Don't allow any IBT bits to be set because it is not supported by
+	 * the kernel yet. Also don't allow reserved bits.
+	 */
+	if ((tmp.user_cet & CET_RESERVED) || (tmp.user_cet & CET_U_IBT_MASK))
+		return -EINVAL;
+
+	fpu_force_restore(fpu);
+
+	/*
+	 * Don't want to init the xfeature until the kernel will definetely
+	 * overwrite it, otherwise if it inits and then fails out, it would
+	 * end up initing it to random data.
+	 */
+	if (!xfeature_saved(xsave, XFEATURE_CET_USER) &&
+	    WARN_ON(init_xfeature(xsave, XFEATURE_CET_USER)))
+		return -ENODEV;
+
+	cetregs = get_xsave_addr(xsave, XFEATURE_CET_USER);
+	if (WARN_ON(!cetregs)) {
+		/*
+		 * This shouldn't ever be NULL because it was successfully
+		 * inited above if needed. The only scenario would be if an
+		 * xfeature was somehow saved in a buffer, but not enabled in
+		 * xsave.
+		 */
+		return -ENODEV;
+	}
+
+	memmove(cetregs, &tmp, sizeof(tmp));
+	return 0;
+}
+
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 
 /*
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index eed8a65d335d..f9e6635b69ce 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -51,6 +51,7 @@ enum x86_regset_32 {
 	REGSET_XSTATE32,
 	REGSET_TLS32,
 	REGSET_IOPERM32,
+	REGSET_CET32,
 };
 
 enum x86_regset_64 {
@@ -58,6 +59,7 @@ enum x86_regset_64 {
 	REGSET_FP64,
 	REGSET_IOPERM64,
 	REGSET_XSTATE64,
+	REGSET_CET64,
 };
 
 #define REGSET_GENERAL \
@@ -1267,6 +1269,15 @@ static struct user_regset x86_64_regsets[] __ro_after_init = {
 		.active		= ioperm_active,
 		.regset_get	= ioperm_get
 	},
+	[REGSET_CET64] = {
+		.core_note_type	= NT_X86_CET,
+		.n		= sizeof(struct cet_user_state) / sizeof(u64),
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= cetregs_active,
+		.regset_get	= cetregs_get,
+		.set		= cetregs_set
+	},
 };
 
 static const struct user_regset_view user_x86_64_view = {
@@ -1336,6 +1347,15 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
 		.active		= ioperm_active,
 		.regset_get	= ioperm_get
 	},
+	[REGSET_CET32] = {
+		.core_note_type = NT_X86_CET,
+		.n		= sizeof(struct cet_user_state) / sizeof(u64),
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= cetregs_active,
+		.regset_get	= cetregs_get,
+		.set		= cetregs_set
+	},
 };
 
 static const struct user_regset_view user_x86_32_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index c7b056af9ef0..11089731e2e9 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -406,6 +406,7 @@ typedef struct elf64_shdr {
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
+#define NT_X86_CET	0x203		/* x86 CET state */
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
 #define NT_S390_TIMER	0x301		/* s390 timer register */
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
-- 
2.17.1

