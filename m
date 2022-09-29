Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5329B5F00B0
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiI2Wha (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiI2Wg1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:36:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C991F2DB;
        Thu, 29 Sep 2022 15:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490736; x=1696026736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o5EM2h/irvXLoTBpZNMDXHTEc20J7+qtmhCjx0ujYys=;
  b=V4ZkA9poJ2rdWzHCnDi4fickEJWAjWW0e0GWjGM9aGlRXVpWc4M+gHVZ
   BcWoqw21Xv+c14xMIUq3/xlk4Q0FcK39uMtDrhOgKfmwcAfCkZXDAmD8z
   nfHYmHaRG9bEHdT6HnTfNoMwKIpx4QBOyzwb/3MbyvNG4h4wkpIr9bDXL
   Kw2KoXYDUDGLCPFxxBzTHKq2Zdy37J4UVcRYXk0/uODL0GUQARSLxQDZj
   8Npw4bn4NtZmYPdgCn9TpQz4YgVreJ6VNimCOpUqneH9TS8EyNMG+7vac
   Ca4HsvDlbc/+6e8FVTe5irJJWO5QkXzMqb+c/mwK07J1cTkQ2SFN09few
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182181"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182181"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016369"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016369"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:55 -0700
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
Cc:     rick.p.edgecombe@intel.com
Subject: [OPTIONAL/CLEANUP v2 34/39] x86: Separate out x86_regset for 32 and 64 bit
Date:   Thu, 29 Sep 2022 15:29:31 -0700
Message-Id: <20220929222936.14584-35-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In fill_thread_core_info() the ptrace accessible registers are collected
for a core file to be written out as notes. The note array is allocated
from a size calculated by iterating the user regset view, and counting the
regsets that have a non-zero core_note_type. However, this only allows for
there to be non-zero core_note_type at the end of the regset view. If
there are any in the middle, fill_thread_core_info() will overflow the
note allocation, as it iterates over the size of the view and the
allocation would be smaller than that.

To apparently avoid this problem, x86_32_regsets and x86_64_regsets need
to be constructed in a special way. They both draw their indices from a
shared enum x86_regset, but 32 bit and 64 bit don't all support the same
regsets and can be compiled in at the same time in the case of
IA32_EMULATION. So this enum has to be laid out in a special way such that
there are no gaps for both x86_32_regsets and x86_64_regsets. This
involves ordering them just right by creating aliases for enum’s that
are only in one view or the other, or creating multiple versions like
REGSET_IOPERM32/REGSET_IOPERM64.

So the collection of the registers tries to minimize the size of the
allocation, but it doesn’t quite work. Then the x86 ptrace side works
around it by constructing the enum just right to avoid a problem. In the
end there is no functional problem, but it is somewhat strange and
fragile.

It could also be improved like this [1], by better utilizing the smaller
array, but this still wastes space in the regset array’s if they are not
carefully crafted to avoid gaps. Instead, just fully separate out the
enums and give them separate 32 and 64 enum names. Add some bitsize-free
defines for REGSET_GENERAL and REGSET_FP since they are the only two
referred to in bitsize generic code.

This should have no functional change and is only changing how constants
are generated and referred to.

[1] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - New patch

 arch/x86/kernel/ptrace.c | 61 ++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 37c12fb92906..1a4df5fbc5e9 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -44,16 +44,35 @@
 
 #include "tls.h"
 
-enum x86_regset {
-	REGSET_GENERAL,
-	REGSET_FP,
-	REGSET_XFP,
-	REGSET_IOPERM64 = REGSET_XFP,
-	REGSET_XSTATE,
-	REGSET_TLS,
+enum x86_regset_32 {
+	REGSET_GENERAL32,
+	REGSET_FP32,
+	REGSET_XFP32,
+	REGSET_XSTATE32,
+	REGSET_TLS32,
 	REGSET_IOPERM32,
 };
 
+enum x86_regset_64 {
+	REGSET_GENERAL64,
+	REGSET_FP64,
+	REGSET_IOPERM64,
+	REGSET_XSTATE64,
+};
+
+#define REGSET_GENERAL \
+({ \
+	BUILD_BUG_ON((int)REGSET_GENERAL32 != (int)REGSET_GENERAL64); \
+	REGSET_GENERAL32; \
+})
+
+#define REGSET_FP \
+({ \
+	BUILD_BUG_ON((int)REGSET_FP32 != (int)REGSET_FP64); \
+	REGSET_FP32; \
+})
+
+
 struct pt_regs_offset {
 	const char *name;
 	int offset;
@@ -788,13 +807,13 @@ long arch_ptrace(struct task_struct *child, long request,
 #ifdef CONFIG_X86_32
 	case PTRACE_GETFPXREGS:	/* Get the child extended FPU state. */
 		return copy_regset_to_user(child, &user_x86_32_view,
-					   REGSET_XFP,
+					   REGSET_XFP32,
 					   0, sizeof(struct user_fxsr_struct),
 					   datap) ? -EIO : 0;
 
 	case PTRACE_SETFPXREGS:	/* Set the child extended FPU state. */
 		return copy_regset_from_user(child, &user_x86_32_view,
-					     REGSET_XFP,
+					     REGSET_XFP32,
 					     0, sizeof(struct user_fxsr_struct),
 					     datap) ? -EIO : 0;
 #endif
@@ -1086,13 +1105,13 @@ static long ia32_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 	case PTRACE_GETFPXREGS:	/* Get the child extended FPU state. */
 		return copy_regset_to_user(child, &user_x86_32_view,
-					   REGSET_XFP, 0,
+					   REGSET_XFP32, 0,
 					   sizeof(struct user32_fxsr_struct),
 					   datap);
 
 	case PTRACE_SETFPXREGS:	/* Set the child extended FPU state. */
 		return copy_regset_from_user(child, &user_x86_32_view,
-					     REGSET_XFP, 0,
+					     REGSET_XFP32, 0,
 					     sizeof(struct user32_fxsr_struct),
 					     datap);
 
@@ -1215,19 +1234,19 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 #ifdef CONFIG_X86_64
 
 static struct user_regset x86_64_regsets[] __ro_after_init = {
-	[REGSET_GENERAL] = {
+	[REGSET_GENERAL64] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = sizeof(struct user_regs_struct) / sizeof(long),
 		.size = sizeof(long), .align = sizeof(long),
 		.regset_get = genregs_get, .set = genregs_set
 	},
-	[REGSET_FP] = {
+	[REGSET_FP64] = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct fxregs_state) / sizeof(long),
 		.size = sizeof(long), .align = sizeof(long),
 		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
 	},
-	[REGSET_XSTATE] = {
+	[REGSET_XSTATE64] = {
 		.core_note_type = NT_X86_XSTATE,
 		.size = sizeof(u64), .align = sizeof(u64),
 		.active = xstateregs_active, .regset_get = xstateregs_get,
@@ -1256,31 +1275,31 @@ static const struct user_regset_view user_x86_64_view = {
 
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 static struct user_regset x86_32_regsets[] __ro_after_init = {
-	[REGSET_GENERAL] = {
+	[REGSET_GENERAL32] = {
 		.core_note_type = NT_PRSTATUS,
 		.n = sizeof(struct user_regs_struct32) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
 		.regset_get = genregs32_get, .set = genregs32_set
 	},
-	[REGSET_FP] = {
+	[REGSET_FP32] = {
 		.core_note_type = NT_PRFPREG,
 		.n = sizeof(struct user_i387_ia32_struct) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = regset_fpregs_active, .regset_get = fpregs_get, .set = fpregs_set
 	},
-	[REGSET_XFP] = {
+	[REGSET_XFP32] = {
 		.core_note_type = NT_PRXFPREG,
 		.n = sizeof(struct fxregs_state) / sizeof(u32),
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
 	},
-	[REGSET_XSTATE] = {
+	[REGSET_XSTATE32] = {
 		.core_note_type = NT_X86_XSTATE,
 		.size = sizeof(u64), .align = sizeof(u64),
 		.active = xstateregs_active, .regset_get = xstateregs_get,
 		.set = xstateregs_set
 	},
-	[REGSET_TLS] = {
+	[REGSET_TLS32] = {
 		.core_note_type = NT_386_TLS,
 		.n = GDT_ENTRY_TLS_ENTRIES, .bias = GDT_ENTRY_TLS_MIN,
 		.size = sizeof(struct user_desc),
@@ -1311,10 +1330,10 @@ u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
 void __init update_regset_xstate_info(unsigned int size, u64 xstate_mask)
 {
 #ifdef CONFIG_X86_64
-	x86_64_regsets[REGSET_XSTATE].n = size / sizeof(u64);
+	x86_64_regsets[REGSET_XSTATE64].n = size / sizeof(u64);
 #endif
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
-	x86_32_regsets[REGSET_XSTATE].n = size / sizeof(u64);
+	x86_32_regsets[REGSET_XSTATE32].n = size / sizeof(u64);
 #endif
 	xstate_fx_sw_bytes[USER_XSTATE_XCR0_WORD] = xstate_mask;
 }
-- 
2.17.1

