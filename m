Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD63641295
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbiLCAnB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiLCAlg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:41:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44C9FA446;
        Fri,  2 Dec 2022 16:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027902; x=1701563902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=70dcNQFQBMnN3c1Es5lWcCS9Jd/iJ6xPvGDlYE+0Wd8=;
  b=SutbyGyUPv+NagtwGNf+8yHAYfiyUW/V72uLD5j3uIUaDdxWS12d/xoH
   LIZ6efx97ye6gRDJt3oMKSZiRIgfsZAXn6VkCIHvfQTsiJTyq6kpodD6O
   ev2rMWeVPm4Cw4aMo4gM28cx7hRc3o7b9JGEbpJOmgGF/FGw1G3ntfm3g
   GL/MSRELVyvijYutnS0zhdTnkFxP9DvpQv6ysxVGpURURRIM54mz/3gMI
   WcBxpXZ3xIg4TxdW3ygA3PwBQ0NL1RN5LktbijCuz/Ds7WFPH1ur31pa0
   GvMLBhBHBbcAs7oy9yJQXEnlukiacyAuRfsS3znJW+9QA4Ag4h76w3lFi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711414"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711414"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479982"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479982"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:35 -0800
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v4 30/39] x86/shstk: Introduce map_shadow_stack syscall
Date:   Fri,  2 Dec 2022 16:35:57 -0800
Message-Id: <20221203003606.6838-31-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
void *shstk = map_shadow_stack(addr, stack_size, SHADOW_STACK_SET_TOKEN);

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v3:
 - Change syscall common -> 64 (Kees)
 - Use bit shift notation instead of 0x1 for uapi header (Kees)
 - Call do_mmap() with MAP_FIXED_NOREPLACE (Kees)
 - Block unsupported flags (Kees)
 - Require size >= 8 to set token (Kees)

v2:
 - Change syscall to take address like mmap() for CRIU's usage

v1:
 - New patch (replaces PROT_SHADOW_STACK).

 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 arch/x86/include/uapi/asm/mman.h       |  3 ++
 arch/x86/kernel/shstk.c                | 56 ++++++++++++++++++++++----
 include/linux/syscalls.h               |  1 +
 include/uapi/asm-generic/unistd.h      |  2 +-
 kernel/sys_ni.c                        |  1 +
 6 files changed, 55 insertions(+), 9 deletions(-)

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
index 775dbd3aff73..15c5a1c4fc29 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -12,6 +12,9 @@
 		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
 #endif
 
+/* Flags for map_shadow_stack(2) */
+#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
+
 #include <asm-generic/mman.h>
 
 #endif /* _ASM_X86_MMAN_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index e53225a8d39e..8f329c22728a 100644
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
 	int flags = MAP_ANONYMOUS | MAP_PRIVATE;
 	struct mm_struct *mm = current->mm;
-	unsigned long addr, unused;
+	unsigned long mapped_addr, unused;
 
-	mmap_write_lock(mm);
-	addr = do_mmap(NULL, 0, size, PROT_READ, flags,
-		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
+	if (addr)
+		flags |= MAP_FIXED_NOREPLACE;
 
+	mmap_write_lock(mm);
+	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
+			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
 	mmap_write_unlock(mm);
 
-	return addr;
+	if (!set_res_tok || IS_ERR_VALUE(addr))
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
 
@@ -179,7 +192,7 @@ int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
 
 
 	size = adjust_shstk_size(stack_size);
-	addr = alloc_shstk(size);
+	addr = alloc_shstk(0, size, 0, false);
 	if (IS_ERR_VALUE(addr))
 		return PTR_ERR((void *)addr);
 
@@ -373,6 +386,33 @@ static int shstk_disable(void)
 	return 0;
 }
 
+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
+{
+	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
+	unsigned long aligned_size;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return -ENOSYS;
+
+	if (flags & ~SHADOW_STACK_SET_TOKEN)
+		return -EINVAL;
+
+	/* If there isn't space for a token */
+	if (set_tok && size < 8)
+		return -EINVAL;
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
2.17.1

