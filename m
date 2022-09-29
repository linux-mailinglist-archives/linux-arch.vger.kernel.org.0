Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F7A5F0094
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiI2WgG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiI2WfM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:35:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE381D88FF;
        Thu, 29 Sep 2022 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490702; x=1696026702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XGWOQlXbeszNuJyd3LIBQE35j+5JhmUKmTsmVq3Ln7w=;
  b=C/sr4FJbaHTnD4D09d8/phdxMNze8Zz7u+EkCyEMDBSKHnOjKrIh/bEx
   AeITiDSRefLt9hCdJ7Q591NRGSuf4YIJVxgoEiqn1W5OjoWQ1TxwNcley
   PxdyzijWaLLCZ9TP8ZC0hW7MPkZxEFmNTYH7R+LICB3le1+D/OHCMoKeo
   b4rcGAmz4B3cVk8/6+ay4eegq5/PWRc7v+fAHlSJq3StFAkSLOcl0f85S
   nPDTePY0kScZK1MqLS8vO1dcU1UzCLMDYZvbrLxaNtSshyskPIHNQpx+S
   9E/LQtvI+45+FGDVYueTjfv0KkDZiQnJQAoJydgyGeVszn1KwLIKsTOoD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182098"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182098"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016335"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016335"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:44 -0700
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
Subject: [PATCH v2 28/39] x86/cet/shstk: Introduce map_shadow_stack syscall
Date:   Thu, 29 Sep 2022 15:29:25 -0700
Message-Id: <20220929222936.14584-29-rick.p.edgecombe@intel.com>
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
void *shstk = map_shadow_stack(adrr, stack_size, SHADOW_STACK_SET_TOKEN);

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v2:
 - Change syscall to take address like mmap() for CRIU's usage

v1:
 - New patch (replaces PROT_SHADOW_STACK).

 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 arch/x86/include/uapi/asm/mman.h       |  2 ++
 arch/x86/kernel/shstk.c                | 48 +++++++++++++++++++++-----
 include/linux/syscalls.h               |  1 +
 include/uapi/asm-generic/unistd.h      |  2 +-
 kernel/sys_ni.c                        |  1 +
 6 files changed, 46 insertions(+), 9 deletions(-)

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
index 775dbd3aff73..c9fc57c88fcc 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -12,6 +12,8 @@
 		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
 #endif
 
+#define SHADOW_STACK_SET_TOKEN	0x1	/* Set up a restore token in the shadow stack */
+
 #include <asm-generic/mman.h>
 
 #endif /* _ASM_X86_MMAN_H */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 04442134aadd..873830d63adc 100644
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
@@ -62,24 +63,34 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
 	if (write_user_shstk_64((u64 __user *)addr, (u64)ssp))
 		return -EFAULT;
 
-	*token_addr = addr;
+	if (token_addr)
+		*token_addr = addr;
 
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
 
 	mmap_write_lock(mm);
-	addr = do_mmap(NULL, addr, size, PROT_READ, flags,
-		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
-
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
 
 static void unmap_shadow_stack(u64 base, u64 size)
@@ -122,7 +133,7 @@ int shstk_setup(void)
 		return -EOPNOTSUPP;
 
 	size = PAGE_ALIGN(min_t(unsigned long long, rlimit(RLIMIT_STACK), SZ_4G));
-	addr = alloc_shstk(size);
+	addr = alloc_shstk(0, size, size, false);
 	if (IS_ERR_VALUE(addr))
 		return PTR_ERR((void *)addr);
 
@@ -174,6 +185,7 @@ int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
 
 
 	stack_size = PAGE_ALIGN(stack_size);
+	addr = alloc_shstk(0, stack_size, 0, false);
 	if (IS_ERR_VALUE(addr))
 		return PTR_ERR((void *)addr);
 
@@ -395,6 +407,26 @@ int shstk_disable(void)
 	return 0;
 }
 
+
+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
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
+	return alloc_shstk(addr, aligned_size, size, flags & SHADOW_STACK_SET_TOKEN);
+}
+
 long cet_prctl(struct task_struct *task, int option, unsigned long features)
 {
 	if (option == ARCH_CET_LOCK) {
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..3ae05cbdea5b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1056,6 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
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

