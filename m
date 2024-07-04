Return-Path: <linux-arch+bounces-5262-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4E59278E9
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E51F1C224D4
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA5C1B143B;
	Thu,  4 Jul 2024 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECKoRo/3"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182251B0131;
	Thu,  4 Jul 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103914; cv=none; b=OLKYRcPg3rWfYrfaKfvppc11tQnfuBPRAfUMfxWAYV3bvxdbmE09IjEeccJg2bDlAoSXk463o1KMGxQKgrtPXMEAr4BBeh9MB+xljDCMdRVsaB4ya2Gk3NVM71uc47IH+r1xTf6AMRDtrkGX1jLJ3cqftMUxt9NTCv2WMAgqrDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103914; c=relaxed/simple;
	bh=gbz0GkcJfAKvQmB9AUB8QkGeHZNUpB0PFNris+ZXEUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=njbQFmOKFDmnQfaPQZ7QE1ovCFjBdNTJO7CWdP/H8FGC+TlMRLHTQ8IW6P3CVVGwWTCTMKY0hciSt4ELT81lKbUNi88Nm4K8zMstmBB/GLs+Tb6qSem+5DrYpkIkOE2Yw+Ggkdex6w2ld10X1A70YgjWbz7H2x0f/Eh6gp6E2kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECKoRo/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C402C4AF0B;
	Thu,  4 Jul 2024 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103913;
	bh=gbz0GkcJfAKvQmB9AUB8QkGeHZNUpB0PFNris+ZXEUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECKoRo/35DOX8jLdqLV/LqDH4QDkgwe0uAjiCQHQ6F+CPc0U+M933NW5JUjOq8Wg+
	 PDGHC4SX4H6pLsO/3ghCUjFJKZ5x0qmLjejyoj/XlSnJwPFiby3xHwdfPCoSaBdFgB
	 +2/GufNOjEBQbdi72F79XLK97UCkVcKCJiW6d/r1kT+Wp15qNHreYK+rewhJ92jcuv
	 4ZZQ1x/GEnUN4K+yEUzHm13loND5/cBhY1FExihvzsJM9omw1v0tQdrJNYpdlXZlkd
	 imKmKr6ThzDSp8p3aWzwLlv2fPqMiTP98oPuwWlXzbaEYwOvVKO+0jANTesqAMeEyg
	 HvW5yTRFLaq1w==
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
Subject: [PATCH 15/17] nios2: convert to generic syscall table
Date: Thu,  4 Jul 2024 16:36:09 +0200
Message-Id: <20240704143611.2979589-16-arnd@kernel.org>
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

The uapi/asm/unistd_32.h and asm/syscall_table_32.h headers can now be
generated from scripts/syscall.tbl, which makes this consistent with
the other architectures that have their own syscall.tbl.

nios2 has one extra system call that gets added to scripts/syscall.tbl.

The time32, stat64, and rlimit entries in the syscall_abis_32
line are for system calls that were part of the generic ABI when
arch/nios2 got added but are no longer enabled by default for new
architectures.

Both the user visible side of asm/unistd.h and the internal syscall
table in the kernel should have the same effective contents after this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/nios2/include/asm/Kbuild        |  2 ++
 arch/nios2/include/asm/unistd.h      | 12 ++++++++++++
 arch/nios2/include/uapi/asm/Kbuild   |  2 ++
 arch/nios2/include/uapi/asm/unistd.h | 16 +---------------
 arch/nios2/kernel/Makefile.syscalls  |  3 +++
 arch/nios2/kernel/syscall_table.c    |  6 ++++--
 scripts/syscall.tbl                  |  2 ++
 7 files changed, 26 insertions(+), 17 deletions(-)
 create mode 100644 arch/nios2/include/asm/unistd.h
 create mode 100644 arch/nios2/kernel/Makefile.syscalls

diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 7fe7437555fb..0d09829ed144 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += syscall_table_32.h
+
 generic-y += cmpxchg.h
 generic-y += extable.h
 generic-y += kvm_para.h
diff --git a/arch/nios2/include/asm/unistd.h b/arch/nios2/include/asm/unistd.h
new file mode 100644
index 000000000000..1146e56473c5
--- /dev/null
+++ b/arch/nios2/include/asm/unistd.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_UNISTD_H
+#define __ASM_UNISTD_H
+
+#include <uapi/asm/unistd.h>
+
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SET_GET_RLIMIT
+
+#define __ARCH_BROKEN_SYS_CLONE3
+
+#endif
diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
index e78470141932..2501e82a1a0a 100644
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ b/arch/nios2/include/uapi/asm/Kbuild
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += unistd_32.h
+
 generic-y += ucontext.h
diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
index d2bc5ac975fb..1f0e0f5538d9 100644
--- a/arch/nios2/include/uapi/asm/unistd.h
+++ b/arch/nios2/include/uapi/asm/unistd.h
@@ -16,18 +16,4 @@
  *
  */
 
- #define sys_mmap2 sys_mmap_pgoff
-
-#define __ARCH_WANT_RENAMEAT
-#define __ARCH_WANT_STAT64
-#define __ARCH_WANT_SET_GET_RLIMIT
-#define __ARCH_WANT_TIME32_SYSCALLS
-
-#define __ARCH_BROKEN_SYS_CLONE3
-
-/* Use the standard ABI for syscalls */
-#include <asm-generic/unistd.h>
-
-/* Additional Nios II specific syscalls. */
-#define __NR_cacheflush (__NR_arch_specific_syscall)
-__SYSCALL(__NR_cacheflush, sys_cacheflush)
+#include <asm/unistd_32.h>
diff --git a/arch/nios2/kernel/Makefile.syscalls b/arch/nios2/kernel/Makefile.syscalls
new file mode 100644
index 000000000000..579a9daec272
--- /dev/null
+++ b/arch/nios2/kernel/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += nios2 time32 stat64 renameat rlimit
diff --git a/arch/nios2/kernel/syscall_table.c b/arch/nios2/kernel/syscall_table.c
index c2875a6dd5a4..434694067d8f 100644
--- a/arch/nios2/kernel/syscall_table.c
+++ b/arch/nios2/kernel/syscall_table.c
@@ -9,10 +9,12 @@
 
 #include <asm/syscalls.h>
 
-#undef __SYSCALL
 #define __SYSCALL(nr, call) [nr] = (call),
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)        __SYSCALL(nr, native)
+
+#define sys_mmap2 sys_mmap_pgoff
 
 void *sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls-1] = sys_ni_syscall,
-#include <asm/unistd.h>
+#include <asm/syscall_table_32.h>
 };
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index ed0ecba8fea4..40307011abdb 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -297,6 +297,8 @@
 244	csky	set_thread_area			sys_set_thread_area
 245	csky	cacheflush			sys_cacheflush
 
+244	nios2	cacheflush			sys_cacheflush
+
 260	time32	wait4				sys_wait4			compat_sys_wait4
 260	64	wait4				sys_wait4
 261	common	prlimit64			sys_prlimit64
-- 
2.39.2


