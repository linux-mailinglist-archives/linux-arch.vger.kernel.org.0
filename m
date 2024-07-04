Return-Path: <linux-arch+bounces-5259-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1EA9278D6
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8171C23486
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AD11B1204;
	Thu,  4 Jul 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZG8y7JL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407731B29C8;
	Thu,  4 Jul 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103891; cv=none; b=SHEs42EcSUF6wuyYnePRHrmT+85yQ893sOYFHL+IehfiIwDBlLOUhKmUCkdbvbDnRR4cRA8HjDRfiZrNPYx0f4VqGBuyXTlq6j2Hti1lXy5OLNOdblWsXSoub8goPeWl2nEQrk9Pqi8wTqt/zKGovI2+t+kG6n/L/RZK6S9wqKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103891; c=relaxed/simple;
	bh=F6VHs8/vR/gkfT29GR/49ui5Xm5trk2YQxZHzsh3y7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKorf7FCwsjNgN/TQWJ0ZbFObE6+bnTJH2CC4KCk3BnDLRIX6igqa74XWQf758ssznzalHe5mDTH2WnYNo6nrmDFJVwlGpp8PYQMkxInBQjuBRDucMbcngK1u1Ov6CRrn67Efme53/wBVgxGAxwLuzYrt9wlUbo9FoYkDctQTU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZG8y7JL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD5EC4AF0C;
	Thu,  4 Jul 2024 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103891;
	bh=F6VHs8/vR/gkfT29GR/49ui5Xm5trk2YQxZHzsh3y7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZG8y7JLFBgwuDuQbUnDG+sAz0Fy+O09sVQVJaoVv3WAH4BgFyY5s2todTxxhH7cS
	 tSB0vEHm1Kgdl7/cE4DMiEoaMmyIazdnUuscmtR2MXXTFeLgFCsYmxZMlqYFzSvNKV
	 iC3VA+6mofoZCzEgKiMsjeshxko8zlwegeGneY4ClK1/mWaoe0JL+v4BpfboZqZ2tz
	 /Oc4dpZC8Zy0BQORX3cYkyeXfAJFA9p8foYD7WTsCON/AGnnaNl+EfVewoNcn+6Ffk
	 VbKrxUpK48nX1cFpAtsy1zwOMNiYFmKotvfsxqzmf2z744ZkatdlkhT10W8B1LFy/8
	 A3M0XPDZJpTTw==
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
Subject: [PATCH 12/17] csky: convert to generic syscall table
Date: Thu,  4 Jul 2024 16:36:06 +0200
Message-Id: <20240704143611.2979589-13-arnd@kernel.org>
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

csky has two architecture specific system calls, which I add to
the generic table.  The time32, stat64 and rlimit entries in the
syscall_abis_32 line are for system calls that were part of the generic
ABI when arch/csky got added but are no longer enabled by default for
new architectures.

Both the user visible side of asm/unistd.h and the internal syscall
table in the kernel should have the same effective contents after this.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/include/asm/Kbuild        |  2 ++
 arch/csky/include/asm/unistd.h      |  3 +++
 arch/csky/include/uapi/asm/Kbuild   |  2 ++
 arch/csky/include/uapi/asm/unistd.h | 14 ++------------
 arch/csky/kernel/Makefile.syscalls  |  4 ++++
 arch/csky/kernel/syscall_table.c    |  4 +++-
 scripts/syscall.tbl                 |  4 ++++
 7 files changed, 20 insertions(+), 13 deletions(-)
 create mode 100644 arch/csky/kernel/Makefile.syscalls

diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 13ebc5e34360..9a9bc65b57a9 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y := syscall_table_32.h
+
 generic-y += asm-offsets.h
 generic-y += extable.h
 generic-y += kvm_para.h
diff --git a/arch/csky/include/asm/unistd.h b/arch/csky/include/asm/unistd.h
index 9cf97de9a26d..2c2c24de95d8 100644
--- a/arch/csky/include/asm/unistd.h
+++ b/arch/csky/include/asm/unistd.h
@@ -2,4 +2,7 @@
 
 #include <uapi/asm/unistd.h>
 
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_SYS_CLONE
+
 #define NR_syscalls (__NR_syscalls)
diff --git a/arch/csky/include/uapi/asm/Kbuild b/arch/csky/include/uapi/asm/Kbuild
index e78470141932..2501e82a1a0a 100644
--- a/arch/csky/include/uapi/asm/Kbuild
+++ b/arch/csky/include/uapi/asm/Kbuild
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+syscall-y += unistd_32.h
+
 generic-y += ucontext.h
diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
index d529d0432876..794adbc04e48 100644
--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -1,14 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 
-#define __ARCH_WANT_STAT64
-#define __ARCH_WANT_NEW_STAT
-#define __ARCH_WANT_SYS_CLONE
-#define __ARCH_WANT_SET_GET_RLIMIT
-#define __ARCH_WANT_TIME32_SYSCALLS
-#define __ARCH_WANT_SYNC_FILE_RANGE2
-#include <asm-generic/unistd.h>
-
-#define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
-__SYSCALL(__NR_set_thread_area, sys_set_thread_area)
-#define __NR_cacheflush		(__NR_arch_specific_syscall + 1)
-__SYSCALL(__NR_cacheflush, sys_cacheflush)
+#include <asm/unistd_32.h>
+#define __NR_sync_file_range2 __NR_sync_file_range
diff --git a/arch/csky/kernel/Makefile.syscalls b/arch/csky/kernel/Makefile.syscalls
new file mode 100644
index 000000000000..3df3b5822fce
--- /dev/null
+++ b/arch/csky/kernel/Makefile.syscalls
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += csky time32 stat64 rlimit
+
diff --git a/arch/csky/kernel/syscall_table.c b/arch/csky/kernel/syscall_table.c
index a0c238c5377a..a6eb91a0e2f6 100644
--- a/arch/csky/kernel/syscall_table.c
+++ b/arch/csky/kernel/syscall_table.c
@@ -6,9 +6,11 @@
 
 #undef __SYSCALL
 #define __SYSCALL(nr, call)[nr] = (call),
+#define __SYSCALL_WITH_COMPAT(nr, native, compat) __SYSCALL(nr, native)
 
 #define sys_fadvise64_64 sys_csky_fadvise64_64
+#define sys_sync_file_range sys_sync_file_range2
 void * const sys_call_table[__NR_syscalls] __page_aligned_data = {
 	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
-#include <asm/unistd.h>
+#include <asm/syscall_table_32.h>
 };
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 13f4c79ba5c2..ed0ecba8fea4 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -293,6 +293,10 @@
 246	arc	arc_gettls			sys_arc_gettls
 247	arc	sysfs				sys_sysfs
 248	arc	arc_usr_cmpxchg			sys_arc_usr_cmpxchg
+
+244	csky	set_thread_area			sys_set_thread_area
+245	csky	cacheflush			sys_cacheflush
+
 260	time32	wait4				sys_wait4			compat_sys_wait4
 260	64	wait4				sys_wait4
 261	common	prlimit64			sys_prlimit64
-- 
2.39.2


