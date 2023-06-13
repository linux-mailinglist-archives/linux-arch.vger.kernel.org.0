Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D4172D64A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbjFMASE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239151AbjFMAQ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:16:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F33930F8;
        Mon, 12 Jun 2023 17:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615231; x=1718151231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q/smTC4JyzbSbIdcW3lB/5FNt1IRicAxT9isRFlZelE=;
  b=TynvUVM7+REZHysTsxCjKulPBu1USkfx2Y5M1Ir7sMcLaUVgutwIEnP5
   ff06+l+NsRzlOpUUZ9SFAMRV+2g7WXw2Nwi/LQ6kP53BJc1+G0gjwl8VT
   RxEWcFV34KtKFgsFfrb6YywDrM2JEYjam91XEE69zPwTAHr3Dp60fqrKU
   Kvm79yoLzx2cLNuqQw9RlL771Y/oxOT17emjX2cL9SHCFzJl1seg0OBp7
   9LP0eCN9nYdx85I/rGAxLUCrQW2K2bk20f1GPvCC6PaNgFLKEeLTEmZKK
   JPZLHdbE+iIXZtiAc94fQB3W+UvM9HEcKnGkks2JO0O/Qxk35OTDJBqNe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557464"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557464"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671125"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671125"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:36 -0700
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
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com, Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 34/42] x86/shstk: Introduce map_shadow_stack syscall
Date:   Mon, 12 Jun 2023 17:11:00 -0700
Message-Id: <20230613001108.3040476-35-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When operating with shadow stacks enabled, the kernel will automatically
allocate shadow stacks for new threads, however in some cases userspace
will need additional shadow stacks. The main example of this is the
ucontext family of functions, which require userspace allocating and
pivoting to userspace managed stacks.

Unlike most other user memory permissions, shadow stacks need to be
provisioned with special data in order to be useful. They need to be setup
with a restore token so that userspace can pivot to them via the RSTORSSP
instruction. But, the security design of shadow stacks is that they
should not be written to except in limited circumstances. This presents a
problem for userspace, as to how userspace can provision this special
data, without allowing for the shadow stack to be generally writable.

Previously, a new PROT_SHADOW_STACK was attempted, which could be
mprotect()ed from RW permissions after the data was provisioned. This was
found to not be secure enough, as other threads could write to the
shadow stack during the writable window.

The kernel can use a special instruction, WRUSS, to write directly to
userspace shadow stacks. So the solution can be that memory can be mapped
as shadow stack permissions from the beginning (never generally writable
in userspace), and the kernel itself can write the restore token.

First, a new madvise() flag was explored, which could operate on the
PROT_SHADOW_STACK memory. This had a couple of downsides:
1. Extra checks were needed in mprotect() to prevent writable memory from
   ever becoming PROT_SHADOW_STACK.
2. Extra checks/vma state were needed in the new madvise() to prevent
   restore tokens being written into the middle of pre-used shadow stacks.
   It is ideal to prevent restore tokens being added at arbitrary
   locations, so the check was to make sure the shadow stack had never been
   written to.
3. It stood out from the rest of the madvise flags, as more of direct
   action than a hint at future desired behavior.

So rather than repurpose two existing syscalls (mmap, madvise) that don't
quite fit, just implement a new map_shadow_stack syscall to allow
userspace to map and setup new shadow stacks in one step. While ucontext
is the primary motivator, userspace may have other unforeseen reasons to
setup its own shadow stacks using the WRSS instruction. Towards this
provide a flag so that stacks can be optionally setup securely for the
common case of ucontext without enabling WRSS. Or potentially have the
kernel set up the shadow stack in some new way.

The following example demonstrates how to create a new shadow stack with
map_shadow_stack:
void *shstk = map_shadow_stack(addr, stack_size, SHADOW_STACK_SET_TOKEN);

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 arch/x86/include/uapi/asm/mman.h       |  3 ++
 arch/x86/kernel/shstk.c                | 59 ++++++++++++++++++++++----
 include/linux/syscalls.h               |  1 +
 include/uapi/asm-generic/unistd.h      |  2 +-
 kernel/sys_ni.c                        |  1 +
 6 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..f65c671ce3b1 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	64	map_shadow_stack	sys_map_shadow_stack
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 5a0256e73f1e..8148bdddbd2c 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -13,6 +13,9 @@
 		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
 #endif
 
+/* Flags for map_shadow_stack(2) */
+#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
+
 #include <asm-generic/mman.h>
 
 #endif /* _ASM_X86_MMAN_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 50733a510446..04c37b33a625 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -17,6 +17,7 @@
 #include <linux/compat.h>
 #include <linux/sizes.h>
 #include <linux/user.h>
+#include <linux/syscalls.h>
 #include <asm/msr.h>
 #include <asm/fpu/xstate.h>
 #include <asm/fpu/types.h>
@@ -71,19 +72,31 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
 	return 0;
 }
 
-static unsigned long alloc_shstk(unsigned long size)
+static unsigned long alloc_shstk(unsigned long addr, unsigned long size,
+				 unsigned long token_offset, bool set_res_tok)
 {
 	int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_ABOVE4G;
 	struct mm_struct *mm = current->mm;
-	unsigned long addr, unused;
+	unsigned long mapped_addr, unused;
+
+	if (addr)
+		flags |= MAP_FIXED_NOREPLACE;
 
 	mmap_write_lock(mm);
-	addr = do_mmap(NULL, 0, size, PROT_READ, flags,
-		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
-
+	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
+			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
 	mmap_write_unlock(mm);
 
-	return addr;
+	if (!set_res_tok || IS_ERR_VALUE(mapped_addr))
+		goto out;
+
+	if (create_rstor_token(mapped_addr + token_offset, NULL)) {
+		vm_munmap(mapped_addr, size);
+		return -EINVAL;
+	}
+
+out:
+	return mapped_addr;
 }
 
 static unsigned long adjust_shstk_size(unsigned long size)
@@ -134,7 +147,7 @@ static int shstk_setup(void)
 		return -EOPNOTSUPP;
 
 	size = adjust_shstk_size(0);
-	addr = alloc_shstk(size);
+	addr = alloc_shstk(0, size, 0, false);
 	if (IS_ERR_VALUE(addr))
 		return PTR_ERR((void *)addr);
 
@@ -178,7 +191,7 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long cl
 		return 0;
 
 	size = adjust_shstk_size(stack_size);
-	addr = alloc_shstk(size);
+	addr = alloc_shstk(0, size, 0, false);
 	if (IS_ERR_VALUE(addr))
 		return addr;
 
@@ -398,6 +411,36 @@ static int shstk_disable(void)
 	return 0;
 }
 
+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
+{
+	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
+	unsigned long aligned_size;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return -EOPNOTSUPP;
+
+	if (flags & ~SHADOW_STACK_SET_TOKEN)
+		return -EINVAL;
+
+	/* If there isn't space for a token */
+	if (set_tok && size < 8)
+		return -ENOSPC;
+
+	if (addr && addr < SZ_4G)
+		return -ERANGE;
+
+	/*
+	 * An overflow would result in attempting to write the restore token
+	 * to the wrong location. Not catastrophic, but just return the right
+	 * error code and block it.
+	 */
+	aligned_size = PAGE_ALIGN(size);
+	if (aligned_size < size)
+		return -EOVERFLOW;
+
+	return alloc_shstk(addr, aligned_size, size, set_tok);
+}
+
 long shstk_prctl(struct task_struct *task, int option, unsigned long features)
 {
 	if (option == ARCH_SHSTK_LOCK) {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 33a0ee3bcb2e..392dc11e3556 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1058,6 +1058,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 45fa180cc56a..b12940ec5926 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -887,7 +887,7 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
 __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 
 #undef __NR_syscalls
-#define __NR_syscalls 451
+#define __NR_syscalls 452
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 860b2dcf3ac4..cb9aebd34646 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -381,6 +381,7 @@ COND_SYSCALL(vm86old);
 COND_SYSCALL(modify_ldt);
 COND_SYSCALL(vm86);
 COND_SYSCALL(kexec_file_load);
+COND_SYSCALL(map_shadow_stack);
 
 /* s390 */
 COND_SYSCALL(s390_pci_mmio_read);
-- 
2.34.1

