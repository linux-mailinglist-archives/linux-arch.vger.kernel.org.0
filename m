Return-Path: <linux-arch+bounces-5264-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33D49278F8
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567431F21DD8
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AC21B3F3A;
	Thu,  4 Jul 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBziHuEX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CB31B013E;
	Thu,  4 Jul 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103929; cv=none; b=j0gpaXUehvKt49/QqrIlZLpLJc0xPKL3eWXXRGtzMP/7ofcKZDPtEucVU0mz/H1Aq/EgSONeqTFxWuEwmTZi+AJfQNCHpSrBqZrA+UBoMjff/xEYi2GuT0c6Xb/FUzSvEbpq0NrbSNum+KTJaAgK68ikOkEnYf7UVlcVQ5zLDhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103929; c=relaxed/simple;
	bh=6VGcvb+hjNG3OZrSZmKQqWbbNaSc922Mlx+mVwuKLTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3G7vYwIu4oY0SoW63n7tJRDZJosoI59U9ElhDDrZJRIdnU2r+EiCAksXaftM7VNSdbanrsjDIJA+iQhxnpYuu9wxmwggeGLXIUTKTK8Sj9sP7rgfeUymyFEinphWDM5mJSrYWPDZ8rnAmsxjmDlJUDbc0m+nFJ/rYXSrveYOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBziHuEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB7EC32781;
	Thu,  4 Jul 2024 14:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103928;
	bh=6VGcvb+hjNG3OZrSZmKQqWbbNaSc922Mlx+mVwuKLTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBziHuEXIXC8B4bVdX4ubT5QGzvcwhzcBNCEQSHkqRYVfo8HXKbNhxoVk2ZCTRVc4
	 I+BYhyhrFlBUlxjREkLG6DFqHfguVlYCB468eioxgwLrw/u8uo8WiUgkPvNmVRRZc6
	 sVvGStxrImJRElhxow0rbSsp/FrpRY3DQSux78mE/k5Gn+VO59+6vtrqrhc3h9B4Wp
	 trZmyYYbDmFp6+c3SPo57hb8Mz/TFOekcjtQMfbFvrBvhwEesi0h1xkQj6NuYsQquf
	 qBe0ou+Y9rdBo3nAJb3CXBQ7/u0MSnQBUWowBSewq2xtP4yJkdziyq/c6z1dGw15HV
	 anNr9FoyBBZxg==
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
Subject: [PATCH 17/17] riscv: convert to generic syscall table
Date: Thu,  4 Jul 2024 16:36:11 +0200
Message-Id: <20240704143611.2979589-18-arnd@kernel.org>
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

The uapi/asm/unistd_{32,64}.h and asm/syscall_table_{32,64}.h headers can
now be generated from scripts/syscall.tbl, which makes this consistent
with the other architectures that have their own syscall.tbl.

riscv has two extra system call that gets added to scripts/syscall.tbl.

The newstat and rlimit entries in the syscall_abis_64 line are for system
calls that were part of the generic ABI when riscv64 got added but are
no longer enabled by default for new architectures. Both riscv32 and
riscv64 also implement memfd_secret, which is optional for all
architectures.

Unlike all the other 32-bit architectures, the time32 and stat64
sets of syscalls are not enabled on riscv32.

Both the user visible side of asm/unistd.h and the internal syscall
table in the kernel should have the same effective contents after this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/include/asm/Kbuild            |  3 ++
 arch/riscv/include/asm/syscall_table.h   |  7 +++++
 arch/riscv/include/asm/unistd.h          | 13 +++++---
 arch/riscv/include/uapi/asm/Kbuild       |  2 ++
 arch/riscv/include/uapi/asm/unistd.h     | 40 +++---------------------
 arch/riscv/kernel/Makefile.syscalls      |  4 +++
 arch/riscv/kernel/compat_syscall_table.c |  6 ++--
 arch/riscv/kernel/syscall_table.c        |  6 ++--
 scripts/syscall.tbl                      |  3 ++
 9 files changed, 40 insertions(+), 44 deletions(-)
 create mode 100644 arch/riscv/include/asm/syscall_table.h
 create mode 100644 arch/riscv/kernel/Makefile.syscalls

diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 504f8b7e72d4..5c589770f2a8 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += syscall_table_32.h
+syscall-y += syscall_table_64.h
+
 generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
diff --git a/arch/riscv/include/asm/syscall_table.h b/arch/riscv/include/asm/syscall_table.h
new file mode 100644
index 000000000000..0c2d61782813
--- /dev/null
+++ b/arch/riscv/include/asm/syscall_table.h
@@ -0,0 +1,7 @@
+#include <asm/bitsperlong.h>
+
+#if __BITS_PER_LONG == 64
+#include <asm/syscall_table_64.h>
+#else
+#include <asm/syscall_table_32.h>
+#endif
diff --git a/arch/riscv/include/asm/unistd.h b/arch/riscv/include/asm/unistd.h
index 221630bdbd07..e6d904fa67c5 100644
--- a/arch/riscv/include/asm/unistd.h
+++ b/arch/riscv/include/asm/unistd.h
@@ -3,11 +3,6 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
-/*
- * There is explicitly no include guard here because this file is expected to
- * be included multiple times.
- */
-
 #define __ARCH_WANT_SYS_CLONE
 
 #ifdef CONFIG_COMPAT
@@ -21,6 +16,14 @@
 #define __ARCH_WANT_COMPAT_FADVISE64_64
 #endif
 
+#if defined(__LP64__) && !defined(__SYSCALL_COMPAT)
+#define __ARCH_WANT_NEW_STAT
+#define __ARCH_WANT_SET_GET_RLIMIT
+#endif /* __LP64__ */
+
+#define __ARCH_WANT_MEMFD_SECRET
+
+
 #include <uapi/asm/unistd.h>
 
 #define NR_syscalls (__NR_syscalls)
diff --git a/arch/riscv/include/uapi/asm/Kbuild b/arch/riscv/include/uapi/asm/Kbuild
index f66554cd5c45..89ac01faa5ae 100644
--- a/arch/riscv/include/uapi/asm/Kbuild
+++ b/arch/riscv/include/uapi/asm/Kbuild
@@ -1 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += unistd_32.h
+syscall-y += unistd_64.h
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 328520defc13..81896bbbf727 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -14,40 +14,10 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <https://www.gnu.org/licenses/>.
  */
+#include <asm/bitsperlong.h>
 
-#if defined(__LP64__) && !defined(__SYSCALL_COMPAT)
-#define __ARCH_WANT_NEW_STAT
-#define __ARCH_WANT_SET_GET_RLIMIT
-#endif /* __LP64__ */
-
-#define __ARCH_WANT_MEMFD_SECRET
-
-#include <asm-generic/unistd.h>
-
-/*
- * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
- * having a direct 'fence.i' instruction available to userspace (which we
- * can't trap!), that's not actually viable when running on Linux because the
- * kernel might schedule a process on another hart.  There is no way for
- * userspace to handle this without invoking the kernel (as it doesn't know the
- * thread->hart mappings), so we've defined a RISC-V specific system call to
- * flush the instruction cache.
- *
- * __NR_riscv_flush_icache is defined to flush the instruction cache over an
- * address range, with the flush applying to either all threads or just the
- * caller.  We don't currently do anything with the address range, that's just
- * in there for forwards compatibility.
- */
-#ifndef __NR_riscv_flush_icache
-#define __NR_riscv_flush_icache (__NR_arch_specific_syscall + 15)
-#endif
-__SYSCALL(__NR_riscv_flush_icache, sys_riscv_flush_icache)
-
-/*
- * Allows userspace to query the kernel for CPU architecture and
- * microarchitecture details across a given set of CPUs.
- */
-#ifndef __NR_riscv_hwprobe
-#define __NR_riscv_hwprobe (__NR_arch_specific_syscall + 14)
+#if __BITS_PER_LONG == 64
+#include <asm/unistd_64.h>
+#else
+#include <asm/unistd_32.h>
 #endif
-__SYSCALL(__NR_riscv_hwprobe, sys_riscv_hwprobe)
diff --git a/arch/riscv/kernel/Makefile.syscalls b/arch/riscv/kernel/Makefile.syscalls
new file mode 100644
index 000000000000..52087a023b3d
--- /dev/null
+++ b/arch/riscv/kernel/Makefile.syscalls
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += riscv memfd_secret
+syscall_abis_64 += riscv newstat rlimit memfd_secret
diff --git a/arch/riscv/kernel/compat_syscall_table.c b/arch/riscv/kernel/compat_syscall_table.c
index ad7f2d712f5f..e884c069e88f 100644
--- a/arch/riscv/kernel/compat_syscall_table.c
+++ b/arch/riscv/kernel/compat_syscall_table.c
@@ -8,9 +8,11 @@
 #include <asm-generic/syscalls.h>
 #include <asm/syscall.h>
 
+#define __SYSCALL_WITH_COMPAT(nr, native, compat) __SYSCALL(nr, compat)
+
 #undef __SYSCALL
 #define __SYSCALL(nr, call)	asmlinkage long __riscv_##call(const struct pt_regs *);
-#include <asm/unistd.h>
+#include <asm/syscall_table_32.h>
 
 #undef __SYSCALL
 #define __SYSCALL(nr, call)      [nr] = __riscv_##call,
@@ -19,5 +21,5 @@ asmlinkage long compat_sys_rt_sigreturn(void);
 
 void * const compat_sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls - 1] = __riscv_sys_ni_syscall,
-#include <asm/unistd.h>
+#include <asm/syscall_table_32.h>
 };
diff --git a/arch/riscv/kernel/syscall_table.c b/arch/riscv/kernel/syscall_table.c
index dda913764903..6f1a36cb0f3f 100644
--- a/arch/riscv/kernel/syscall_table.c
+++ b/arch/riscv/kernel/syscall_table.c
@@ -9,14 +9,16 @@
 #include <asm-generic/syscalls.h>
 #include <asm/syscall.h>
 
+#define __SYSCALL_WITH_COMPAT(nr, native, compat) __SYSCALL(nr, native)
+
 #undef __SYSCALL
 #define __SYSCALL(nr, call)	asmlinkage long __riscv_##call(const struct pt_regs *);
-#include <asm/unistd.h>
+#include <asm/syscall_table.h>
 
 #undef __SYSCALL
 #define __SYSCALL(nr, call)	[nr] = __riscv_##call,
 
 void * const sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls - 1] = __riscv_sys_ni_syscall,
-#include <asm/unistd.h>
+#include <asm/syscall_table.h>
 };
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 28329c00bf68..797e20ea99a2 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -301,6 +301,9 @@
 
 244	or1k	or1k_atomic			sys_or1k_atomic
 
+258	riscv	riscv_hwprobe			sys_riscv_hwprobe
+259	riscv	riscv_flush_icache		sys_riscv_flush_icache
+
 260	time32	wait4				sys_wait4			compat_sys_wait4
 260	64	wait4				sys_wait4
 261	common	prlimit64			sys_prlimit64
-- 
2.39.2


