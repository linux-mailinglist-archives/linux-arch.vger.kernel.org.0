Return-Path: <linux-arch+bounces-6069-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F1F949B89
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 00:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A111F236B7
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 22:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE941779A4;
	Tue,  6 Aug 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udf26Tm7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33F2176FB4;
	Tue,  6 Aug 2024 22:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984619; cv=none; b=Tli0dmEDQ3dpbFnOvgEwMooe1oaE9ZvLR3F2rZafV4Fm1O1g14QX4qUKEO942KFNaM4FlDoaiaqK/DoSEYQriDFnXWdqVtT5OYmfOkXA0m5c0v4IVSCG1D6J/oAXCuxYS4angkgiYnGdbyhXip2ACPh5UlHbfKDLPQ2rDbw47nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984619; c=relaxed/simple;
	bh=kUpQHDjXUTcIXEW4LUblPgmepAxQU9tsDNhcE63app4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMEdIqgeOjj17wX2/AlLv/W+7f/reZIE4Rkca2My7aP2yLV/5QUX3FFSntdsN8taZv7L2BfJYTOKWomWLVW+bRTzgRTWkCK5LHnuATnHVkv6wTmtLOk3GES4GgOsGGdjPb7TDTVO9cOPDqx10hXEdGyv/Obh4Fwe15xYHmpwfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Udf26Tm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FD4C4AF10;
	Tue,  6 Aug 2024 22:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722984619;
	bh=kUpQHDjXUTcIXEW4LUblPgmepAxQU9tsDNhcE63app4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Udf26Tm7rBKe1LFR1FupsjguWMDeClI8dZtNxzG5xlGDEQyDE2H4VciUMCtxDg60P
	 soZXEMbuROr85oNvgcvg27983KJjpDrSlZRbUlLvBODOqJ0FmiUJFe8/emfSGHo1Xs
	 rTnsF1YKO4nTeY1IzMDGPWQs1jiFlj05d3fmyOD+QeoNqVzflIIAIS55VZKAHLbr9R
	 aoiWYCiNmS8idV0lBIDXMcZHYDMfJOy+Zp6kQvOv0ZafQVD3O8ZKfg5vh5fW6W0hWP
	 ddfWwaQo8/sHInLsTz2BzhlFBYNvBU42R7QCVyjidlD1CLIDJDt3zOUhNbx71mnL4y
	 oKZr2ABVW2dnA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH 06/10] tools/include: Sync uapi/asm-generic/unistd.h with the kernel sources
Date: Tue,  6 Aug 2024 15:50:09 -0700
Message-ID: <20240806225013.126130-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240806225013.126130-1-namhyung@kernel.org>
References: <20240806225013.126130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And arch syscall tables to pick up changes from:

  b1e31c134a8a powerpc: restore some missing spu syscalls
  d3882564a77c syscalls: fix compat_sys_io_pgetevents_time64 usage
  54233a425403 uretprobe: change syscall number, again
  63ded110979b uprobe: Change uretprobe syscall scope and number
  9142be9e6443 x86/syscall: Mark exit[_group] syscall handlers __noreturn
  9aae1baa1c5d x86, arm: Add missing license tag to syscall tables files
  5c28424e9a34 syscalls: Fix to add sys_uretprobe to syscall.tbl
  190fec72df4a uprobe: Wire up uretprobe system call

This should be used to beautify syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
  diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
  diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
  diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl

Please see tools/include/uapi/README for details (it's in the first patch
of this series).

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/arm64/include/uapi/asm/unistd.h    | 24 +------------------
 tools/include/uapi/asm-generic/unistd.h       |  2 +-
 .../arch/powerpc/entry/syscalls/syscall.tbl   |  6 ++++-
 .../perf/arch/s390/entry/syscalls/syscall.tbl |  2 +-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  8 ++++---
 5 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
index 9306726337fe..df36f23876e8 100644
--- a/tools/arch/arm64/include/uapi/asm/unistd.h
+++ b/tools/arch/arm64/include/uapi/asm/unistd.h
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
+#include <asm/unistd_64.h>
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index a00d53d02723..5bf6148cac2b 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -737,7 +737,7 @@ __SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
 #define __NR_ppoll_time64 414
 __SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
 #define __NR_io_pgetevents_time64 416
-__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+__SC_COMP(__NR_io_pgetevents_time64, sys_io_pgetevents, compat_sys_io_pgetevents_time64)
 #define __NR_recvmmsg_time64 417
 __SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
 #define __NR_mq_timedsend_time64 418
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 3656f1ca7a21..ebae8415dfbb 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -230,8 +230,10 @@
 178	nospu 	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
 179	32	pread64				sys_ppc_pread64			compat_sys_ppc_pread64
 179	64	pread64				sys_pread64
+179	spu	pread64				sys_pread64
 180	32	pwrite64			sys_ppc_pwrite64		compat_sys_ppc_pwrite64
 180	64	pwrite64			sys_pwrite64
+180	spu	pwrite64			sys_pwrite64
 181	common	chown				sys_chown
 182	common	getcwd				sys_getcwd
 183	common	capget				sys_capget
@@ -246,6 +248,7 @@
 190	common	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
 191	32	readahead			sys_ppc_readahead		compat_sys_ppc_readahead
 191	64	readahead			sys_readahead
+191	spu	readahead			sys_readahead
 192	32	mmap2				sys_mmap2			compat_sys_mmap2
 193	32	truncate64			sys_ppc_truncate64		compat_sys_ppc_truncate64
 194	32	ftruncate64			sys_ppc_ftruncate64		compat_sys_ppc_ftruncate64
@@ -293,6 +296,7 @@
 232	nospu	set_tid_address			sys_set_tid_address
 233	32	fadvise64			sys_ppc32_fadvise64		compat_sys_ppc32_fadvise64
 233	64	fadvise64			sys_fadvise64
+233	spu	fadvise64			sys_fadvise64
 234	nospu	exit_group			sys_exit_group
 235	nospu	lookup_dcookie			sys_ni_syscall
 236	common	epoll_create			sys_epoll_create
@@ -502,7 +506,7 @@
 412	32	utimensat_time64		sys_utimensat			sys_utimensat
 413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
 414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
-416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
 419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index bd0fee24ad10..01071182763e 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -418,7 +418,7 @@
 412	32	utimensat_time64	-				sys_utimensat
 413	32	pselect6_time64		-				compat_sys_pselect6_time64
 414	32	ppoll_time64		-				compat_sys_ppoll_time64
-416	32	io_pgetevents_time64	-				sys_io_pgetevents
+416	32	io_pgetevents_time64	-				compat_sys_io_pgetevents_time64
 417	32	recvmmsg_time64		-				compat_sys_recvmmsg_time64
 418	32	mq_timedsend_time64	-				sys_mq_timedsend
 419	32	mq_timedreceive_time64	-				sys_mq_timedreceive
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index a396f6e6ab5b..7093ee21c0d1 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -1,8 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
 #
 # 64-bit system call numbers and entry vectors
 #
 # The format is:
-# <number> <abi> <name> <entry point>
+# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
 #
 # The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
 #
@@ -68,7 +69,7 @@
 57	common	fork			sys_fork
 58	common	vfork			sys_vfork
 59	64	execve			sys_execve
-60	common	exit			sys_exit
+60	common	exit			sys_exit			-			noreturn
 61	common	wait4			sys_wait4
 62	common	kill			sys_kill
 63	common	uname			sys_newuname
@@ -239,7 +240,7 @@
 228	common	clock_gettime		sys_clock_gettime
 229	common	clock_getres		sys_clock_getres
 230	common	clock_nanosleep		sys_clock_nanosleep
-231	common	exit_group		sys_exit_group
+231	common	exit_group		sys_exit_group			-			noreturn
 232	common	epoll_wait		sys_epoll_wait
 233	common	epoll_ctl		sys_epoll_ctl
 234	common	tgkill			sys_tgkill
@@ -343,6 +344,7 @@
 332	common	statx			sys_statx
 333	common	io_pgetevents		sys_io_pgetevents
 334	common	rseq			sys_rseq
+335	common	uretprobe		sys_uretprobe
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
 424	common	pidfd_send_signal	sys_pidfd_send_signal
-- 
2.46.0.rc2.264.g509ed76dc8-goog


