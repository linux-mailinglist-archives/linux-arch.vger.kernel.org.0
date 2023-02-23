Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C5A69FFD5
	for <lists+linux-arch@lfdr.de>; Thu, 23 Feb 2023 01:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBWADr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Feb 2023 19:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBWADq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2023 19:03:46 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD611A949
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2023 16:03:44 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e9so5854661plh.2
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2023 16:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpOSkngFbo1xRTtoo3V6Dq6jqJDOtZ7GvHNIgSzFJq8=;
        b=ZKI7PQElxLxanzxiQq3N1uJcH1n8ZFh6ppeN7hE+ChQ4sv6CQ3Qh3LgGBVp/whvm/i
         litvp4kdKds0n0UcUo2eZwfFUOh5fLUeBJ9LxDNSkbtZk1XLrha3MouFDHEol1PM+Wtg
         557hDziGFrLozJJTrTJ249E9d9d+CuJXHrA2D/FHQn4MhX5JFLLV0cvXCIelLZujupEa
         Ac3MFbzLFYgKzEv1DEvnO/JLM1zH7q5gRSHUn5/kdkRJNyxGrw7MHSImO29UG2Xwiu8S
         8C4133Zavh8fFtxCSA2kKSt6kvl79cL1cBWyRIyR5b/GlPdsZnriIwpmno8ZrFmrVQB/
         O30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpOSkngFbo1xRTtoo3V6Dq6jqJDOtZ7GvHNIgSzFJq8=;
        b=1Umt7aV1hbD6dwaxJ76GYtDSG4vC6TG4SrPG9cWvvolpFuDttqw+zayRsNpU2+d/S/
         xyV0seOiKXPOJ3LeYdeRgRNe/18XpPMoSIiZv6OduTt5DU5hm09E156H3VfX4HlG6rei
         /LtAKkwm8jLImVOMTFbvElOmzXq0bb2hMZGxIpvH/EBbK22s1M8whrtN+3b91+w9z6ny
         3WbBByXSmVyE42zJ3MKUKP3jtQ0Etx1LUk8PpB/+1xR6TtDyRuLhb15k4vIzRSuWgI2P
         B9ci5qSEXu57vwbAi0R9VKDB6YGHQ6t9oOKOgHWLzjp/iE67PLRJQqJFx5txof66jNO2
         e6IA==
X-Gm-Message-State: AO0yUKUdetwidQbV7AV4RWmFC/k7rxQ06dHQN4fOHq5xHjm6yyTdJMvv
        WHVt2Xao/aYGruP885zckucYJQ==
X-Google-Smtp-Source: AK7set/6RZ1DrFP2FUeDUcZNGqTq38f856K4vOcIejvzUHF7MDUzNiKVUoHQ8fpiCBpy46ChYarefg==
X-Received: by 2002:a17:902:f547:b0:19a:c65d:f93 with SMTP id h7-20020a170902f54700b0019ac65d0f93mr7915812plf.53.1677110624068;
        Wed, 22 Feb 2023 16:03:44 -0800 (PST)
Received: from debug.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902c38c00b0019c90f8c831sm4054817plg.242.2023.02.22.16.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 16:03:43 -0800 (PST)
Date:   Wed, 22 Feb 2023 16:03:40 -0800
From:   Deepak Gupta <debug@rivosinc.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        david@redhat.com
Subject: Re: [PATCH v6 33/41] x86/shstk: Introduce map_shadow_stack syscall
Message-ID: <20230223000340.GB945966@debug.ba.rivosinc.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-34-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230218211433.26859-34-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 18, 2023 at 01:14:25PM -0800, Rick Edgecombe wrote:
>When operating with shadow stacks enabled, the kernel will automatically
>allocate shadow stacks for new threads, however in some cases userspace
>will need additional shadow stacks. The main example of this is the
>ucontext family of functions, which require userspace allocating and
>pivoting to userspace managed stacks.
>
>Unlike most other user memory permissions, shadow stacks need to be
>provisioned with special data in order to be useful. They need to be setup
>with a restore token so that userspace can pivot to them via the RSTORSSP
>instruction. But, the security design of shadow stack's is that they
>should not be written to except in limited circumstances. This presents a
>problem for userspace, as to how userspace can provision this special
>data, without allowing for the shadow stack to be generally writable.
>
>Previously, a new PROT_SHADOW_STACK was attempted, which could be
>mprotect()ed from RW permissions after the data was provisioned. This was
>found to not be secure enough, as other thread's could write to the
>shadow stack during the writable window.
>
>The kernel can use a special instruction, WRUSS, to write directly to
>userspace shadow stacks. So the solution can be that memory can be mapped
>as shadow stack permissions from the beginning (never generally writable
>in userspace), and the kernel itself can write the restore token.
>
>First, a new madvise() flag was explored, which could operate on the
>PROT_SHADOW_STACK memory. This had a couple downsides:
>1. Extra checks were needed in mprotect() to prevent writable memory from
>   ever becoming PROT_SHADOW_STACK.
>2. Extra checks/vma state were needed in the new madvise() to prevent
>   restore tokens being written into the middle of pre-used shadow stacks.
>   It is ideal to prevent restore tokens being added at arbitrary
>   locations, so the check was to make sure the shadow stack had never been
>   written to.
>3. It stood out from the rest of the madvise flags, as more of direct
>   action than a hint at future desired behavior.
>
>So rather than repurpose two existing syscalls (mmap, madvise) that don't
>quite fit, just implement a new map_shadow_stack syscall to allow
>userspace to map and setup new shadow stacks in one step. While ucontext
>is the primary motivator, userspace may have other unforeseen reasons to
>setup it's own shadow stacks using the WRSS instruction. Towards this
>provide a flag so that stacks can be optionally setup securely for the
>common case of ucontext without enabling WRSS. Or potentially have the
>kernel set up the shadow stack in some new way.

Was following ever attempted?

void *shstk = mmap(0, size, PROT_SHADOWSTACK, ...);
- limit PROT_SHADOWSTACK protection flag to only mmap (and thus mprotect can't
   convert memory from shadow stack to non-shadow stack type or vice versa)
- limit PROT_SHADOWSTACK protection flag to anonymous memory only.
- top level mmap handler to put a token at the base using WRUSS if prot == PROT_SHADOWSTACK

You essentially would get shadow stack manufacturing with existing (single) syscall.
Acting a bit selfish here, this allows other architectures as well to re-use this and 
do their own implementation of mapping and placing the token at the base.

>
>The following example demonstrates how to create a new shadow stack with
>map_shadow_stack:
>void *shstk = map_shadow_stack(addr, stack_size, SHADOW_STACK_SET_TOKEN);
>
>Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>Tested-by: John Allen <john.allen@amd.com>
>Reviewed-by: Kees Cook <keescook@chromium.org>
>Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>
>---
>v5:
> - Fix addr/mapped_addr (Kees)
> - Switch to EOPNOTSUPP (Kees suggested ENOTSUPP, but checkpatch
>   suggests this)
> - Return error for addresses below 4G
>
>v3:
> - Change syscall common -> 64 (Kees)
> - Use bit shift notation instead of 0x1 for uapi header (Kees)
> - Call do_mmap() with MAP_FIXED_NOREPLACE (Kees)
> - Block unsupported flags (Kees)
> - Require size >= 8 to set token (Kees)
>
>v2:
> - Change syscall to take address like mmap() for CRIU's usage
>
>v1:
> - New patch (replaces PROT_SHADOW_STACK).
>---
> arch/x86/entry/syscalls/syscall_64.tbl |  1 +
> arch/x86/include/uapi/asm/mman.h       |  3 ++
> arch/x86/kernel/shstk.c                | 59 ++++++++++++++++++++++----
> include/linux/syscalls.h               |  1 +
> include/uapi/asm-generic/unistd.h      |  2 +-
> kernel/sys_ni.c                        |  1 +
> 6 files changed, 58 insertions(+), 9 deletions(-)
>
>diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
>index c84d12608cd2..f65c671ce3b1 100644
>--- a/arch/x86/entry/syscalls/syscall_64.tbl
>+++ b/arch/x86/entry/syscalls/syscall_64.tbl
>@@ -372,6 +372,7 @@
> 448	common	process_mrelease	sys_process_mrelease
> 449	common	futex_waitv		sys_futex_waitv
> 450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
>+451	64	map_shadow_stack	sys_map_shadow_stack
>
> #
> # Due to a historical design error, certain syscalls are numbered differently
>diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
>index 5a0256e73f1e..8148bdddbd2c 100644
>--- a/arch/x86/include/uapi/asm/mman.h
>+++ b/arch/x86/include/uapi/asm/mman.h
>@@ -13,6 +13,9 @@
> 		((key) & 0x8 ? VM_PKEY_BIT3 : 0))
> #endif
>
>+/* Flags for map_shadow_stack(2) */
>+#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)	/* Set up a restore token in the shadow stack */
>+
> #include <asm-generic/mman.h>
>
> #endif /* _ASM_X86_MMAN_H */
>diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
>index 40f0a55762a9..0a3decab70ee 100644
>--- a/arch/x86/kernel/shstk.c
>+++ b/arch/x86/kernel/shstk.c
>@@ -17,6 +17,7 @@
> #include <linux/compat.h>
> #include <linux/sizes.h>
> #include <linux/user.h>
>+#include <linux/syscalls.h>
> #include <asm/msr.h>
> #include <asm/fpu/xstate.h>
> #include <asm/fpu/types.h>
>@@ -71,19 +72,31 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
> 	return 0;
> }
>
>-static unsigned long alloc_shstk(unsigned long size)
>+static unsigned long alloc_shstk(unsigned long addr, unsigned long size,
>+				 unsigned long token_offset, bool set_res_tok)
> {
> 	int flags = MAP_ANONYMOUS | MAP_PRIVATE | MAP_ABOVE4G;
> 	struct mm_struct *mm = current->mm;
>-	unsigned long addr, unused;
>+	unsigned long mapped_addr, unused;
>
>-	mmap_write_lock(mm);
>-	addr = do_mmap(NULL, 0, size, PROT_READ, flags,
>-		       VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
>+	if (addr)
>+		flags |= MAP_FIXED_NOREPLACE;
>
>+	mmap_write_lock(mm);
>+	mapped_addr = do_mmap(NULL, addr, size, PROT_READ, flags,
>+			      VM_SHADOW_STACK | VM_WRITE, 0, &unused, NULL);
> 	mmap_write_unlock(mm);
>
>-	return addr;
>+	if (!set_res_tok || IS_ERR_VALUE(mapped_addr))
>+		goto out;
>+
>+	if (create_rstor_token(mapped_addr + token_offset, NULL)) {
>+		vm_munmap(mapped_addr, size);
>+		return -EINVAL;
>+	}
>+
>+out:
>+	return mapped_addr;
> }
>
> static unsigned long adjust_shstk_size(unsigned long size)
>@@ -134,7 +147,7 @@ static int shstk_setup(void)
> 		return -EOPNOTSUPP;
>
> 	size = adjust_shstk_size(0);
>-	addr = alloc_shstk(size);
>+	addr = alloc_shstk(0, size, 0, false);
> 	if (IS_ERR_VALUE(addr))
> 		return PTR_ERR((void *)addr);
>
>@@ -178,7 +191,7 @@ int shstk_alloc_thread_stack(struct task_struct *tsk, unsigned long clone_flags,
> 		return 0;
>
> 	size = adjust_shstk_size(stack_size);
>-	addr = alloc_shstk(size);
>+	addr = alloc_shstk(0, size, 0, false);
> 	if (IS_ERR_VALUE(addr))
> 		return PTR_ERR((void *)addr);
>
>@@ -371,6 +384,36 @@ static int shstk_disable(void)
> 	return 0;
> }
>
>+SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
>+{
>+	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
>+	unsigned long aligned_size;
>+
>+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
>+		return -EOPNOTSUPP;
>+
>+	if (flags & ~SHADOW_STACK_SET_TOKEN)
>+		return -EINVAL;
>+
>+	/* If there isn't space for a token */
>+	if (set_tok && size < 8)
>+		return -EINVAL;
>+
>+	if (addr && addr <= 0xFFFFFFFF)
>+		return -EINVAL;
>+
>+	/*
>+	 * An overflow would result in attempting to write the restore token
>+	 * to the wrong location. Not catastrophic, but just return the right
>+	 * error code and block it.
>+	 */
>+	aligned_size = PAGE_ALIGN(size);
>+	if (aligned_size < size)
>+		return -EOVERFLOW;
>+
>+	return alloc_shstk(addr, aligned_size, size, set_tok);
>+}
>+
> long shstk_prctl(struct task_struct *task, int option, unsigned long features)
> {
> 	if (option == ARCH_SHSTK_LOCK) {
>diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>index 33a0ee3bcb2e..392dc11e3556 100644
>--- a/include/linux/syscalls.h
>+++ b/include/linux/syscalls.h
>@@ -1058,6 +1058,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
> asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
> 					    unsigned long home_node,
> 					    unsigned long flags);
>+asmlinkage long sys_map_shadow_stack(unsigned long addr, unsigned long size, unsigned int flags);
>
> /*
>  * Architecture-specific system calls
>diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
>index 45fa180cc56a..b12940ec5926 100644
>--- a/include/uapi/asm-generic/unistd.h
>+++ b/include/uapi/asm-generic/unistd.h
>@@ -887,7 +887,7 @@ __SYSCALL(__NR_futex_waitv, sys_futex_waitv)
> __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
>
> #undef __NR_syscalls
>-#define __NR_syscalls 451
>+#define __NR_syscalls 452
>
> /*
>  * 32 bit systems traditionally used different
>diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
>index 860b2dcf3ac4..cb9aebd34646 100644
>--- a/kernel/sys_ni.c
>+++ b/kernel/sys_ni.c
>@@ -381,6 +381,7 @@ COND_SYSCALL(vm86old);
> COND_SYSCALL(modify_ldt);
> COND_SYSCALL(vm86);
> COND_SYSCALL(kexec_file_load);
>+COND_SYSCALL(map_shadow_stack);
>
> /* s390 */
> COND_SYSCALL(s390_pci_mmio_read);
>-- 
>2.17.1
>
