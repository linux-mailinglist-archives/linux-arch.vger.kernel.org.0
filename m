Return-Path: <linux-arch+bounces-5257-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE79278C8
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC92228BF80
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59D91B140A;
	Thu,  4 Jul 2024 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVXxYUaM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92D1B11F9;
	Thu,  4 Jul 2024 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103876; cv=none; b=NQpco+XzQJ82uiHaM4Th4QBg7/T00xjKTKi36v+I5hZmBHyfxLXYjbmxhe45W+mwa1xniPKDV+XUS7MtjnCM2zbF9sUNpD5ZNJwBCzswsQ1ZBIVWEDSi2yWsajHQpuhC58EO3WK1Hy2YORJml1Z0ZozQlLH8+yfrhuUxOdcl3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103876; c=relaxed/simple;
	bh=nZGoGsld/DUw3AVg7vD7mXB59Rr8GgAXxGVkFPOubWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9XFN/27Ihq6JvkpNLRWTD9xoor2WcJdrbKNRIUMI3E40QWiicbo4s/ogNOt3H7MxDTYBO2DYkXn+cfb/ZrABE/FqdwJoKzFLpb6Ia1puvHPGeUtZTte2xlyjt34G7kt4WNK1KBznRNch7ain9ozTZhiMiRZ0+9LY3ShKIhUoNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVXxYUaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ABAC3277B;
	Thu,  4 Jul 2024 14:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103876;
	bh=nZGoGsld/DUw3AVg7vD7mXB59Rr8GgAXxGVkFPOubWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JVXxYUaMIFExsZ9KH6GofYN627sH7sWihH7abVtu0seuRwuE69WyU26iNHsLQWNzH
	 gzk110N8UMZqijpiSwrKOVNZWsyMIstyUjjvbUDTP6vZIofa00veXipVpbCZNL5wl+
	 gd7WfktcSKVOL8+/lD3cDEvYsTln9WifVFedFGSZneD3d2bBY0RqvxvI62xTVsk2W2
	 qY6aV7Aije9aa4nle+LZbf6H3Y5g9UloFGsWUZP51T1ZbIyMophz0iAajit+vYbDV9
	 uBk4zCuyK6SvyimShQ+RGwcsuJwsYImjosHwqAsxyvVPR8NLF/LGEPo3No4vU7PTUD
	 KtdN0wKnc4Nhw==
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
Subject: [PATCH 10/17] arm64: generate 64-bit syscall.tbl
Date: Thu,  4 Jul 2024 16:36:04 +0200
Message-Id: <20240704143611.2979589-11-arnd@kernel.org>
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

Change the asm/unistd.h header for arm64 to no longer include
asm-generic/unistd.h itself, but instead generate both the asm/unistd.h
contents and the list of entry points using the syscall.tbl scripts that
we use on most other architectures.

Once his is done for the remaining architectures, the generic unistd.h
header can be removed and the generated tbl file put in its place.

The Makefile changes are more complex than they should be, I need
a little help to improve those. Ideally this should be done in an
architecture-independent way as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/Kbuild        |  1 +
 arch/arm64/include/asm/seccomp.h     |  1 +
 arch/arm64/include/asm/unistd.h      |  5 ++---
 arch/arm64/include/uapi/asm/Kbuild   |  1 +
 arch/arm64/include/uapi/asm/unistd.h | 24 +-----------------------
 arch/arm64/kernel/Makefile.syscalls  |  1 +
 arch/arm64/kernel/sys.c              |  6 ++++--
 arch/arm64/tools/Makefile            |  6 +++++-
 arch/arm64/tools/syscall_64.tbl      |  1 +
 9 files changed, 17 insertions(+), 29 deletions(-)
 create mode 120000 arch/arm64/tools/syscall_64.tbl

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 3fc45ef32e85..7d7d97ad3cd5 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 syscall-y += syscall_table_32.h
+syscall-y += syscall_table_64.h
 
 # arm32 syscall table used by lib/compat_audit.c:
 syscall-y += unistd_32.h
diff --git a/arch/arm64/include/asm/seccomp.h b/arch/arm64/include/asm/seccomp.h
index d56164d3cac5..c83ca2c8b936 100644
--- a/arch/arm64/include/asm/seccomp.h
+++ b/arch/arm64/include/asm/seccomp.h
@@ -23,6 +23,7 @@
 #define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
 #define SECCOMP_ARCH_NATIVE_NAME	"aarch64"
 #ifdef CONFIG_COMPAT
+#include <asm/unistd_compat_32.h>
 # define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_ARM
 # define SECCOMP_ARCH_COMPAT_NR		__NR_compat32_syscalls
 # define SECCOMP_ARCH_COMPAT_NAME	"arm"
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 55ac26355be4..fdd16052f9bc 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -41,9 +41,8 @@
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_NEW_STAT
 
-#ifndef __COMPAT_SYSCALL_NR
-#include <uapi/asm/unistd.h>
-#endif
+#include <asm/unistd_64.h>
 
 #define NR_syscalls (__NR_syscalls)
diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index 602d137932dc..c6d141d7b7d7 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += unistd_64.h
 
 generic-y += kvm_para.h
diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
index 9306726337fe..038dddf8f554 100644
--- a/arch/arm64/include/uapi/asm/unistd.h
+++ b/arch/arm64/include/uapi/asm/unistd.h
@@ -1,24 +1,2 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#define __ARCH_WANT_RENAMEAT
-#define __ARCH_WANT_NEW_STAT
-#define __ARCH_WANT_SET_GET_RLIMIT
-#define __ARCH_WANT_TIME32_SYSCALLS
-#define __ARCH_WANT_MEMFD_SECRET
-
-#include <asm-generic/unistd.h>
+#include <unistd_64.h>
diff --git a/arch/arm64/kernel/Makefile.syscalls b/arch/arm64/kernel/Makefile.syscalls
index 1e14effb3921..3cfafd003b2d 100644
--- a/arch/arm64/kernel/Makefile.syscalls
+++ b/arch/arm64/kernel/Makefile.syscalls
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 syscall_abis_32 +=
+syscall_abis_64 += renameat newstat rlimit memfd_secret
 
 syscalltbl = arch/arm64/tools/syscall_%.tbl
diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
index d5ffaaab31a7..f08408b6e826 100644
--- a/arch/arm64/kernel/sys.c
+++ b/arch/arm64/kernel/sys.c
@@ -48,14 +48,16 @@ asmlinkage long __arm64_sys_ni_syscall(const struct pt_regs *__unused)
  */
 #define __arm64_sys_personality		__arm64_sys_arm64_personality
 
+#define __SYSCALL_WITH_COMPAT(nr, native, compat)  __SYSCALL(nr, native)
+
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	asmlinkage long __arm64_##sym(const struct pt_regs *);
-#include <asm/unistd.h>
+#include <asm/syscall_table_64.h>
 
 #undef __SYSCALL
 #define __SYSCALL(nr, sym)	[nr] = __arm64_##sym,
 
 const syscall_fn_t sys_call_table[__NR_syscalls] = {
 	[0 ... __NR_syscalls - 1] = __arm64_sys_ni_syscall,
-#include <asm/unistd.h>
+#include <asm/syscall_table_64.h>
 };
diff --git a/arch/arm64/tools/Makefile b/arch/arm64/tools/Makefile
index fa2251d9762d..c2b34e761006 100644
--- a/arch/arm64/tools/Makefile
+++ b/arch/arm64/tools/Makefile
@@ -3,12 +3,16 @@
 gen := arch/$(ARCH)/include/generated
 kapi := $(gen)/asm
 
-kapi-hdrs-y := $(kapi)/cpucap-defs.h $(kapi)/sysreg-defs.h
+kapisyshdr-y := cpucap-defs.h sysreg-defs.h
+
+kapi-hdrs-y := $(addprefix $(kapi)/, $(kapisyshdr-y))
 
 targets += $(addprefix ../../../, $(kapi-hdrs-y))
 
 PHONY += kapi
 
+all: $(syscall64) kapi
+
 kapi:   $(kapi-hdrs-y)
 
 quiet_cmd_gen_cpucaps = GEN     $@
diff --git a/arch/arm64/tools/syscall_64.tbl b/arch/arm64/tools/syscall_64.tbl
new file mode 120000
index 000000000000..63135cf34b65
--- /dev/null
+++ b/arch/arm64/tools/syscall_64.tbl
@@ -0,0 +1 @@
+../../../scripts/syscall.tbl
\ No newline at end of file
-- 
2.39.2


