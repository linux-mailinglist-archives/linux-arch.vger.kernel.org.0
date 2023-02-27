Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BC56A4EB3
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 23:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjB0Whk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 17:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjB0WhC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 17:37:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F29744A5;
        Mon, 27 Feb 2023 14:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677537180; x=1709073180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UFVg3sIbuffnHjOtlNoaz9ZH+gYHjqQgnqMZvI5Wi8Y=;
  b=drugRxHkZJdGeic/6cHhjk6+KlYMQXF2gXbhOBMPIjjyK6+OQYtjXU5d
   MM8+1shDBr/huNBY1vUucotWGlpv1BqfpvOCTtUXOcWFwV8Lcxt7a17ZZ
   HydffeVb7pQ3O9/ULnkbNtMxeS2iwbq8rfolXZN7TiwSTfuOFJ4xO+YA0
   qQK9tK3auv8heduTJ3C0yU3MQGUEbpSj/kHoEMx3lIrUiR6snBx6EhG14
   FIU4Xi38+Uu2TfWRw6IwsB40RNzglgVXfdr6h5nhOH7U2GKb40WJoCb8F
   LQFseyWo33Vr+cgU127TXcBi+47qooOZf94o77y9WTHuYbs7MCaLrdAhC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313657950"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313657950"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="848024813"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="848024813"
Received: from leonqu-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.72.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:36 -0800
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
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v7 39/41] x86: Add PTRACE interface for shadow stack
Date:   Mon, 27 Feb 2023 14:29:55 -0800
Message-Id: <20230227222957.24501-40-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

Some applications (like GDB) would like to tweak shadow stack state via
ptrace. This allows for existing functionality to continue to work for
seized shadow stack applications. Provide an regset interface for
manipulating the shadow stack pointer (SSP).

There is already ptrace functionality for accessing xstate, but this
does not include supervisor xfeatures. So there is not a completely
clear place for where to put the shadow stack state. Adding it to the
user xfeatures regset would complicate that code, as it currently shares
logic with signals which should not have supervisor features.

Don't add a general supervisor xfeature regset like the user one,
because it is better to maintain flexibility for other supervisor
xfeatures to define their own interface. For example, an xfeature may
decide not to expose all of it's state to userspace, as is actually the
case for  shadow stack ptrace functionality. A lot of enum values remain
to be used, so just put it in dedicated shadow stack regset.

The only downside to not having a generic supervisor xfeature regset,
is that apps need to be enlightened of any new supervisor xfeature
exposed this way (i.e. they can't try to have generic save/restore
logic). But maybe that is a good thing, because they have to think
through each new xfeature instead of encountering issues when new a new
supervisor xfeature was added.

By adding a shadow stack regset, it also has the effect of including the
shadow stack state in a core dump, which could be useful for debugging.

The shadow stack specific xstate includes the SSP, and the shadow stack
and WRSS enablement status. Enabling shadow stack or wrss in the kernel
involves more than just flipping the bit. The kernel is made aware that
it has to do extra things when cloning or handling signals. That logic
is triggered off of separate feature enablement state kept in the task
struct. So the flipping on HW shadow stack enforcement without notifying
the kernel to change its behavior would severely limit what an application
could do without crashing, and the results would depend on kernel
internal implementation details. There is also no known use for controlling
this state via prtace today. So only expose the SSP, which is something
that userspace already has indirect control over.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

---
v5:
 - Check shadow stack enablement status for tracee (rppt)
 - Fix typo in comment

v4:
 - Make shadow stack only. Reduce to only supporting SSP register, and
   remove CET references (peterz)
 - Add comment to not use 0x203, because binutils already looks for it in
   coredumps. (Christina Schimpe)

v3:
 - Drop dependence on thread.shstk.size, and use thread.features bits
 - Drop 32 bit support

v2:
 - Check alignment on ssp.
 - Block IBT bits.
 - Handle init states instead of returning error.
 - Add verbose commit log justifying the design.
---
 arch/x86/include/asm/fpu/regset.h |  7 +--
 arch/x86/kernel/fpu/regset.c      | 86 +++++++++++++++++++++++++++++++
 arch/x86/kernel/ptrace.c          | 12 +++++
 include/uapi/linux/elf.h          |  2 +
 4 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/regset.h b/arch/x86/include/asm/fpu/regset.h
index 4f928d6a367b..697b77e96025 100644
--- a/arch/x86/include/asm/fpu/regset.h
+++ b/arch/x86/include/asm/fpu/regset.h
@@ -7,11 +7,12 @@
 
 #include <linux/regset.h>
 
-extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active;
+extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active,
+				ssp_active;
 extern user_regset_get2_fn fpregs_get, xfpregs_get, fpregs_soft_get,
-				 xstateregs_get;
+				 xstateregs_get, ssp_get;
 extern user_regset_set_fn fpregs_set, xfpregs_set, fpregs_soft_set,
-				 xstateregs_set;
+				 xstateregs_set, ssp_set;
 
 /*
  * xstateregs_active == regset_fpregs_active. Please refer to the comment
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 6d056b68f4ed..c806952d9496 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -8,6 +8,7 @@
 #include <asm/fpu/api.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
+#include <asm/prctl.h>
 
 #include "context.h"
 #include "internal.h"
@@ -174,6 +175,91 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+int ssp_active(struct task_struct *target, const struct user_regset *regset)
+{
+	if (target->thread.features & ARCH_SHSTK_SHSTK)
+		return regset->n;
+
+	return 0;
+}
+
+int ssp_get(struct task_struct *target, const struct user_regset *regset,
+	    struct membuf to)
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
+		membuf_zero(&to, sizeof(cetregs->user_ssp));
+		return 0;
+	}
+
+	return membuf_write(&to, (unsigned long *)&cetregs->user_ssp,
+			    sizeof(cetregs->user_ssp));
+}
+
+int ssp_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf)
+{
+	struct fpu *fpu = &target->thread.fpu;
+	struct xregs_state *xsave = &fpu->fpstate->regs.xsave;
+	struct cet_user_state *cetregs;
+	unsigned long user_ssp;
+	int r;
+
+	if (!boot_cpu_has(X86_FEATURE_USER_SHSTK) ||
+	    !ssp_active(target, regset))
+		return -ENODEV;
+
+	r = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &user_ssp, 0, -1);
+	if (r)
+		return r;
+
+	/*
+	 * Some kernel instructions (IRET, etc) can cause exceptions in the case
+	 * of disallowed CET register values. Just prevent invalid values.
+	 */
+	if ((user_ssp >= TASK_SIZE_MAX) || !IS_ALIGNED(user_ssp, 8))
+		return -EINVAL;
+
+	fpu_force_restore(fpu);
+
+	/*
+	 * Don't want to init the xfeature until the kernel will definitely
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
+	cetregs->user_ssp = user_ssp;
+	return 0;
+}
+#endif /* CONFIG_X86_USER_SHADOW_STACK */
+
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 
 /*
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index dfaa270a7cc9..095f04bdabdc 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -58,6 +58,7 @@ enum x86_regset_64 {
 	REGSET64_FP,
 	REGSET64_IOPERM,
 	REGSET64_XSTATE,
+	REGSET64_SSP,
 };
 
 #define REGSET_GENERAL \
@@ -1267,6 +1268,17 @@ static struct user_regset x86_64_regsets[] __ro_after_init = {
 		.active		= ioperm_active,
 		.regset_get	= ioperm_get
 	},
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+	[REGSET64_SSP] = {
+		.core_note_type	= NT_X86_SHSTK,
+		.n		= 1,
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= ssp_active,
+		.regset_get	= ssp_get,
+		.set		= ssp_set
+	},
+#endif
 };
 
 static const struct user_regset_view user_x86_64_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 68de6f4c4eee..103a1f2da86e 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -406,6 +406,8 @@ typedef struct elf64_shdr {
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
+/* Old binutils treats 0x203 as a CET state */
+#define NT_X86_SHSTK	0x204		/* x86 SHSTK state */
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
 #define NT_S390_TIMER	0x301		/* s390 timer register */
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
-- 
2.17.1

