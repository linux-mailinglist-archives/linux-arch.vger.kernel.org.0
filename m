Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20124A3A4C
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356772AbiA3V0B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:26:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:9053 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356663AbiA3VYW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577862; x=1675113862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=bevQ6N+BuwOL/p8dqWUyPQqjTmNufH5CT0XA5AXO3tQ=;
  b=DyrJ5Itzg/ZF2Rrq4HsilTvmV3tyvlq0T8zwHirwzNtK1tiQXE2xVMLF
   3C5ELARtuVPtqf/YfNH0T6Hhg7RE+6jjoZJB87em84WLLeVgl+kqequnz
   OIUErQjjV9Bkte9jxTTFnkbhRPwZoP8xvabPA1xF2SmcVk9BrR2fHra12
   wtG0SnDhfxZT0ebM7SDGCveMH+hYhCGPGfb0sfN449m1Ch43BcRjlJSxf
   YqTtkR3sRbMIDnvOq1vH0Hkfncb2j1i472rRVDS+fcDt9A431gkEEIIwV
   wD6qVdXCkDZgzj6GP4EaTiSTKTUc9nOW7uWQq2bmK0BLpiFhMT5qP3c8q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="310685831"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="310685831"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856995"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:22:11 -0800
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH 32/35] x86/cet/shstk: Introduce map_shadow_stack syscall
Date:   Sun, 30 Jan 2022 13:18:35 -0800
Message-Id: <20220130211838.8382-33-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
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
instruction. But, the security design of shadow stack's is that they
should not be written to except in limited circumstances. This presents a
problem for userspace, as to how userspace can provision this special
data, without allowing for the shadow stack to be generally writable.

Previously, a new PROT_SHADOW_STACK was attempted, which could be
mprotect()ed from RW permissions after the data was provisioned. This was
found to not be secure enough, as other thread's could write to the
shadow stack during the writable window.

The kernel can use a special instruction, WRUSS, to write directly to
userspace shadow stacks. So the solution can be that memory can be mapped
as shadow stack permissions from the beginning (never generally writable
in userspace), and the kernel itself can write the restore token.

First, a new madvise() flag was explored, which could operate on the
PROT_SHADOW_STACK memory. This had a couple downsides:
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
setup it's own shadow stacks using the WRSS instruction. Towards this
provide a flag so that stacks can be optionally setup securely for the
common case of ucontext without enabling WRSS. Or potentially have the
kernel set up the shadow stack in some new way.

The following example demonstrates how to create a new shadow stack with
map_shadow_stack:
void *shadow_stack = map_shadow_stack(stack_size, SHADOW_STACK_SET_TOKEN);

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v1:
 - New patch (replaces PROT_SHADOW_STACK).

 arch/x86/entry/syscalls/syscall_32.tbl |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 arch/x86/include/uapi/asm/mman.h       |  2 ++
 arch/x86/kernel/shstk.c                | 39 +++++++++++++++++++++++---
 include/linux/syscalls.h               |  1 +
 include/uapi/asm-generic/unistd.h      |  2 +-
 kernel/sys_ni.c                        |  1 +
 7 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 320480a8db4f..68106c12937f 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -455,3 +455,4 @@
 448	i386	process_mrelease	sys_process_mrelease
 449	i386	futex_waitv		sys_futex_waitv
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	i386	map_shadow_stack	sys_map_shadow_stack
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c84d12608cd2..d9639e3e0a33 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -372,6 +372,7 @@
 448	common	process_mrelease	sys_process_mrelease
 449	common	futex_waitv		sys_futex_waitv
 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
+451	common	map_shadow_stack	sys_map_shadow_stack
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 9704e27c4d24..dd4e8405e189 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -26,6 +26,8 @@
 		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
 #endif
 
+#define SHADOW_STACK_SET_TOKEN	0x1	/* Set up a restore token in the shadow stack */
+
 #include <asm-generic/mman.h>
 
 #endif /* _UAPI_ASM_X86_MMAN_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index f330be17e2d1..53be5d5539d4 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -15,6 +15,7 @@
 #include <linux/compat.h>
 #include <linux/sizes.h>
 #include <linux/user.h>
+#include <linux/syscalls.h>
 #include <asm/msr.h>
 #include <asm/fpu/internal.h>
 #include <asm/fpu/xstate.h>
@@ -45,12 +46,14 @@ static int create_rstor_token(bool proc32, unsigned long ssp,
 	if (write_user_shstk_64((u64 __user *)addr, (u64)ssp))
 		return -EFAULT;
 
-	*token_addr = addr;
+	if (token_addr)
+		*token_addr = addr;
 
 	return 0;
 }
 
-static unsigned long alloc_shstk(unsigned long size)
+static unsigned long alloc_shstk(unsigned long size, unsigned long token_offset,
+				 bool set_res_tok)
 {
 	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
 	struct mm_struct *mm = current->mm;
@@ -61,6 +64,15 @@ static unsigned long alloc_shstk(unsigned long size)
 		       &unused, NULL);
 	mmap_write_unlock(mm);
 
+	if (!set_res_tok || IS_ERR_VALUE(addr))
+		goto out;
+
+	if (create_rstor_token(in_ia32_syscall(), addr + token_offset, NULL)) {
+		vm_munmap(addr, size);
+		return -EINVAL;
+	}
+
+out:
 	return addr;
 }
 
@@ -103,7 +115,7 @@ int shstk_setup(void)
 		return 1;
 
 	size = PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
-	addr = alloc_shstk(size);
+	addr = alloc_shstk(size, size, false);
 	if (IS_ERR_VALUE(addr))
 		return 1;
 
@@ -181,7 +193,7 @@ int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
 		return -EINVAL;
 
 	stack_size = PAGE_ALIGN(stack_size);
-	addr = alloc_shstk(stack_size);
+	addr = alloc_shstk(stack_size, stack_size, false);
 	if (IS_ERR_VALUE(addr)) {
 		shstk->base = 0;
 		shstk->size = 0;
@@ -380,3 +392,22 @@ int restore_signal_shadow_stack(void)
 
 	return err;
 }
+
+SYSCALL_DEFINE2(map_shadow_stack, unsigned long, size, unsigned int, flags)
+{
+	unsigned long aligned_size;
+
+	if (!cpu_feature_enabled(X86_FEATURE_SHSTK))
+		return -ENOSYS;
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
+	return alloc_shstk(aligned_size, size, flags & SHADOW_STACK_SET_TOKEN);
+}
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 819c0cb00b6d..11220c40b26a 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1060,6 +1060,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
 asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
 					    unsigned long home_node,
 					    unsigned long flags);
+asmlinkage long sys_map_shadow_stack(unsigned long size, unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1c48b0ae3ba3..41112fdd3b66 100644
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
index a492f159624f..16a6e1a57c2b 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -380,6 +380,7 @@ COND_SYSCALL(vm86old);
 COND_SYSCALL(modify_ldt);
 COND_SYSCALL(vm86);
 COND_SYSCALL(kexec_file_load);
+COND_SYSCALL(map_shadow_stack);
 
 /* s390 */
 COND_SYSCALL(s390_pci_mmio_read);
-- 
2.17.1

