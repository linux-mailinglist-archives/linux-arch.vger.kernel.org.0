Return-Path: <linux-arch+bounces-5254-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69DA9278B7
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188F1B2463E
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD311B142A;
	Thu,  4 Jul 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTw+tspY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AC51AE87B;
	Thu,  4 Jul 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103853; cv=none; b=F1LNtwKqcG28V7bEhksXzUbTuy8ypXADXfQSrqbutc6OtG9fKl8syBDCrH1WeYj3bIDCB0Gxd2tpc4sCvZm/K7Rppsgo7bBWesCCEyTAmSDsmThetQRZqM/I9tFTljrl1GbPTxmtx0VUflE0dFaaIYlgnhgRsi53ylex35foDZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103853; c=relaxed/simple;
	bh=8YqzVKjGqPU8eMC5rrrvE2DOMKh6wTqlyzNzCHRls08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lVtxJZ/M8Ixq4ATz1vNQJUYh8x0khatULRcVLlW2QSdqnL6r17fQkEsSsq5PKKJGaCyyLHi5SmHLP7VFp3Fc1P/E1xV4m8R7QLymTjTXK8iWZ2iCVCP/ArtsdNWfExfRKKsitFao+w92suEA5pmGTfVtbEpM3cE+Ouu3Pr51yVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTw+tspY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBA3C4AF0D;
	Thu,  4 Jul 2024 14:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103853;
	bh=8YqzVKjGqPU8eMC5rrrvE2DOMKh6wTqlyzNzCHRls08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTw+tspYBohxH5QJ/CLTT2arVJ0NVsg8ksF9Pylqm1uHdgW2lN6oPF3KHtbKlqN2Z
	 Q5XnUfpu5KK6tsQXO18FMkO5wosa7ZaEals8jcZNtC27tsUakT7egAZEIcO3fNHOTk
	 hvYO0VPrrxN26rg6GUAkQJOR8NZ5ywGc2QGelSIncjpJ1jtDL1jBqSCmZR4T0knh8l
	 i651/ueitK9DRILdN3mEc8Nz8FDtj1y+ksMCMb+flrfsKgQ3ueqYrkJHc7O133icGT
	 HCGEdjCqvmnY/7rWHAWJHXWlMEyLHN3fNEONXMnHOdM9z51ov9sf/u6ok+WGAnC1rL
	 +cgtq2gduFhZA==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 07/17] clone3: drop __ARCH_WANT_SYS_CLONE3 macro
Date: Thu,  4 Jul 2024 16:36:01 +0200
Message-Id: <20240704143611.2979589-8-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704143611.2979589-1-arnd@kernel.org>
References: <20240704143611.2979589-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When clone3() was introduced, it was not obvious how each architecture
deals with setting up the stack and keeping the register contents in
a fork()-like system call, so this was left for the architecture
maintainers to implement, with __ARCH_WANT_SYS_CLONE3 defined by those
that already implement it.

Five years later, we still have a few architectures left that are missing
clone3(), and the macro keeps getting in the way as it's fundamentally
different from all the other __ARCH_WANT_SYS_* macros that are meant
to provide backwards-compatibility with applications using older
syscalls that are no longer provided by default.

Address this by reversing the polarity of the macro, adding an
__ARCH_BROKEN_SYS_CLONE3 macro to all architectures that don't
already provide the syscall, and remove __ARCH_WANT_SYS_CLONE3
from all the other ones.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arc/include/uapi/asm/unistd.h             | 1 -
 arch/arm/include/asm/unistd.h                  | 1 -
 arch/arm64/include/uapi/asm/unistd.h           | 1 -
 arch/csky/include/uapi/asm/unistd.h            | 1 -
 arch/hexagon/include/uapi/asm/unistd.h         | 2 ++
 arch/loongarch/include/uapi/asm/unistd.h       | 1 -
 arch/m68k/include/asm/unistd.h                 | 1 -
 arch/mips/include/asm/unistd.h                 | 1 -
 arch/nios2/include/uapi/asm/unistd.h           | 2 ++
 arch/openrisc/include/uapi/asm/unistd.h        | 1 -
 arch/parisc/include/asm/unistd.h               | 1 -
 arch/powerpc/include/asm/unistd.h              | 1 -
 arch/riscv/include/uapi/asm/unistd.h           | 1 -
 arch/s390/include/asm/unistd.h                 | 1 -
 arch/sh/include/asm/unistd.h                   | 2 ++
 arch/sparc/include/asm/unistd.h                | 2 ++
 arch/x86/include/asm/unistd.h                  | 1 -
 arch/xtensa/include/asm/unistd.h               | 1 -
 include/uapi/asm-generic/unistd.h              | 4 ----
 kernel/fork.c                                  | 8 +++++---
 kernel/sys_ni.c                                | 2 --
 tools/arch/arm64/include/uapi/asm/unistd.h     | 1 -
 tools/arch/loongarch/include/uapi/asm/unistd.h | 1 -
 tools/include/uapi/asm-generic/unistd.h        | 4 ----
 24 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/arch/arc/include/uapi/asm/unistd.h b/arch/arc/include/uapi/asm/unistd.h
index fa2713ae6bea..5eafa1115162 100644
--- a/arch/arc/include/uapi/asm/unistd.h
+++ b/arch/arc/include/uapi/asm/unistd.h
@@ -21,7 +21,6 @@
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_EXECVE
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_TIME32_SYSCALLS
diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 3676e82cf95c..9fb00973c608 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -37,7 +37,6 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 
 /*
  * Unimplemented (or alternatively implemented) syscalls
diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index ce2ee8f1e361..9306726337fe 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -19,7 +19,6 @@
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
-#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_MEMFD_SECRET
 
 #include <asm-generic/unistd.h>
diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
index e0594b6370a6..d529d0432876 100644
--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -3,7 +3,6 @@
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
 #define __ARCH_WANT_SYNC_FILE_RANGE2
diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/include/uapi/asm/unistd.h
index 21ae22306b5d..4bea7428e747 100644
--- a/arch/hexagon/include/uapi/asm/unistd.h
+++ b/arch/hexagon/include/uapi/asm/unistd.h
@@ -38,4 +38,6 @@
 #define __ARCH_WANT_TIME32_SYSCALLS
 #define __ARCH_WANT_SYNC_FILE_RANGE2
 
+#define __ARCH_BROKEN_SYS_CLONE3
+
 #include <asm-generic/unistd.h>
diff --git a/arch/loongarch/include/uapi/asm/unistd.h b/arch/loongarch/include/uapi/asm/unistd.h
index fcb668984f03..191614b9b207 100644
--- a/arch/loongarch/include/uapi/asm/unistd.h
+++ b/arch/loongarch/include/uapi/asm/unistd.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 
 #include <asm-generic/unistd.h>
diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 4ae52414cd9d..2e0047cf86f8 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -30,6 +30,5 @@
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
-#define __ARCH_WANT_SYS_CLONE3
 
 #endif /* _ASM_M68K_UNISTD_H_ */
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index 25a5253db7f4..ba83d3fb0a84 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -58,7 +58,6 @@
 # endif
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 
 /* whitelists for checksyscalls */
 #define __IGNORE_fadvise64_64
diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
index 0b4bb1d41b28..d2bc5ac975fb 100644
--- a/arch/nios2/include/uapi/asm/unistd.h
+++ b/arch/nios2/include/uapi/asm/unistd.h
@@ -23,6 +23,8 @@
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
 
+#define __ARCH_BROKEN_SYS_CLONE3
+
 /* Use the standard ABI for syscalls */
 #include <asm-generic/unistd.h>
 
diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
index fae34c60fa88..566f8c4f8047 100644
--- a/arch/openrisc/include/uapi/asm/unistd.h
+++ b/arch/openrisc/include/uapi/asm/unistd.h
@@ -24,7 +24,6 @@
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_TIME32_SYSCALLS
 
 #include <asm-generic/unistd.h>
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index e38f9a90ac15..98851ff7699a 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -160,7 +160,6 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #define __ARCH_WANT_COMPAT_STAT
 
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 659a996c75aa..027ef94a12fb 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -51,7 +51,6 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 
 #endif		/* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_UNISTD_H_ */
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 950ab3fd4409..328520defc13 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -20,7 +20,6 @@
 #define __ARCH_WANT_SET_GET_RLIMIT
 #endif /* __LP64__ */
 
-#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_MEMFD_SECRET
 
 #include <asm-generic/unistd.h>
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 4260bc5ce7f8..70fc671397da 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -35,6 +35,5 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 
 #endif /* _ASM_S390_UNISTD_H_ */
diff --git a/arch/sh/include/asm/unistd.h b/arch/sh/include/asm/unistd.h
index d6e126250136..3d7f35650a13 100644
--- a/arch/sh/include/asm/unistd.h
+++ b/arch/sh/include/asm/unistd.h
@@ -28,4 +28,6 @@
 # define __ARCH_WANT_SYS_VFORK
 # define __ARCH_WANT_SYS_CLONE
 
+#define __ARCH_BROKEN_SYS_CLONE3
+
 #include <uapi/asm/unistd.h>
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index d6bc76706a7a..3380411a4537 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -49,6 +49,8 @@
 #define __ARCH_WANT_COMPAT_STAT
 #endif
 
+#define __ARCH_BROKEN_SYS_CLONE3
+
 #ifdef __32bit_syscall_numbers__
 /* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
  * it never had the plain ones and there is no value to adding those
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 761173ccc33c..6c9e5bdd3916 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -56,6 +56,5 @@
 # define __ARCH_WANT_SYS_FORK
 # define __ARCH_WANT_SYS_VFORK
 # define __ARCH_WANT_SYS_CLONE
-# define __ARCH_WANT_SYS_CLONE3
 
 #endif /* _ASM_X86_UNISTD_H */
diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index b52236245e51..30af4dc3ce7b 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -3,7 +3,6 @@
 #define _XTENSA_UNISTD_H
 
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 #include <uapi/asm/unistd.h>
 
 #define __ARCH_WANT_NEW_STAT
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index d4cc26932ff4..5bf6148cac2b 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -776,12 +776,8 @@ __SYSCALL(__NR_fsmount, sys_fsmount)
 __SYSCALL(__NR_fspick, sys_fspick)
 #define __NR_pidfd_open 434
 __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
-
-#ifdef __ARCH_WANT_SYS_CLONE3
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
-#endif
-
 #define __NR_close_range 436
 __SYSCALL(__NR_close_range, sys_close_range)
 #define __NR_openat2 437
diff --git a/kernel/fork.c b/kernel/fork.c
index 99076dbe27d8..02f322424c49 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2941,8 +2941,6 @@ SYSCALL_DEFINE5(clone, unsigned long, clone_flags, unsigned long, newsp,
 }
 #endif
 
-#ifdef __ARCH_WANT_SYS_CLONE3
-
 noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 					      struct clone_args __user *uargs,
 					      size_t usize)
@@ -3086,6 +3084,11 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
 	struct kernel_clone_args kargs;
 	pid_t set_tid[MAX_PID_NS_LEVEL];
 
+#ifdef __ARCH_BROKEN_SYS_CLONE3
+#warning clone3() entry point is missing, please fix
+	return -ENOSYS;
+#endif
+
 	kargs.set_tid = set_tid;
 
 	err = copy_clone_args_from_user(&kargs, uargs, size);
@@ -3097,7 +3100,6 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
 
 	return kernel_clone(&kargs);
 }
-#endif
 
 void walk_process_tree(struct task_struct *top, proc_visitor visitor, void *data)
 {
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index b696b85ac63e..2ef820a2d067 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -76,8 +76,6 @@ COND_SYSCALL(timerfd_gettime32);
 COND_SYSCALL(acct);
 COND_SYSCALL(capget);
 COND_SYSCALL(capset);
-/* __ARCH_WANT_SYS_CLONE3 */
-COND_SYSCALL(clone3);
 COND_SYSCALL(futex);
 COND_SYSCALL(futex_time32);
 COND_SYSCALL(set_robust_list);
diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
index ce2ee8f1e361..9306726337fe 100644
--- a/tools/arch/arm64/include/uapi/asm/unistd.h
+++ b/tools/arch/arm64/include/uapi/asm/unistd.h
@@ -19,7 +19,6 @@
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
-#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_MEMFD_SECRET
 
 #include <asm-generic/unistd.h>
diff --git a/tools/arch/loongarch/include/uapi/asm/unistd.h b/tools/arch/loongarch/include/uapi/asm/unistd.h
index 0c743344e92d..8eeaac0087c3 100644
--- a/tools/arch/loongarch/include/uapi/asm/unistd.h
+++ b/tools/arch/loongarch/include/uapi/asm/unistd.h
@@ -4,6 +4,5 @@
  */
 
 #define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SYS_CLONE3
 
 #include <asm-generic/unistd.h>
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index d983c48a3b6a..a00d53d02723 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -776,12 +776,8 @@ __SYSCALL(__NR_fsmount, sys_fsmount)
 __SYSCALL(__NR_fspick, sys_fspick)
 #define __NR_pidfd_open 434
 __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
-
-#ifdef __ARCH_WANT_SYS_CLONE3
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
-#endif
-
 #define __NR_close_range 436
 __SYSCALL(__NR_close_range, sys_close_range)
 #define __NR_openat2 437
-- 
2.39.2


