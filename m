Return-Path: <linux-arch+bounces-11366-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D30A834F9
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 02:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53391B66903
	for <lists+linux-arch@lfdr.de>; Thu, 10 Apr 2025 00:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6367E792;
	Thu, 10 Apr 2025 00:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZzWpx3m"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA878C9C;
	Thu, 10 Apr 2025 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243890; cv=none; b=n9PZOsztv9KrNtkXHPj56sbmb5pMc+tmGmIODLpIPzX5JI68XMTBDY0VDGTCDL14eRO0eaPoU1PZ8nQmvEaxHfq09Nd5K9KeJoTj+hxS9rbK3L85vab/KJlCcNX1tMGIT/ydkfxEVKJjlHmIJik5nW3uZoX1JKMcBWr8LPFa2d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243890; c=relaxed/simple;
	bh=XVfIzcWBmb3+tcEi8kIGcHgr+gNwCp0bATQ8ueGkbgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJGjeOB/IDhf1SF2nBcjX8HpA7ewNDeBXu0YBqHaoGLDqyFUyQSnylY4zkFaErAaqbCRfk0ncvz7osAuHQMDQ5ZBxcBq1iSpXh+RJGH0k+wasvdHiKeK8HMbukAwqArzxU6w6c4ir+BVNZ0mhkqZFnfqEoJdUdiquMxilAd9AZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZzWpx3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764D7C4CEED;
	Thu, 10 Apr 2025 00:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243889;
	bh=XVfIzcWBmb3+tcEi8kIGcHgr+gNwCp0bATQ8ueGkbgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZzWpx3mI+GEcuNANEpJ0eFdjtYno+pcsXm0OoDdFVjRpcNLDKY5r8M6O/U7LbV4A
	 GbEztuP0EMHnoE6EAz+PlFVW9cuukHEr2iA+HFHEFjwdPnTeqX+90BkR6hH+GZwzCj
	 X2G1xJkj8+xXluetdda/95b7p+d5g8I6hJkGfbd2eZb5HPqh0UincYYRwkR5Gkog3y
	 1o9vfQiAPwJESG9R4+7hlEJKj2qhUMtskbMSKskH/1pIKcETY0ocP5UbK0EfwEFKlX
	 oPkhnbqgcnO5xX+gcgT9Py3/0JUKvMz65l7AWwiTyIbRg6qezp11U9Tyr0+mIGtDEV
	 pUgcjrtfUcTlA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 05/10] tools headers: Update the syscall table with the kernel sources
Date: Wed,  9 Apr 2025 17:11:20 -0700
Message-ID: <20250410001125.391820-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250410001125.391820-1-namhyung@kernel.org>
References: <20250410001125.391820-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in:

  c4a16820d9019940 fs: add open_tree_attr()
  2df1ad0d25803399 x86/arch_prctl: Simplify sys_arch_prctl()
  e632bca07c8eef1d arm64: generate 64-bit syscall.tbl

This is basically to support the new open_tree_attr syscall.  But it
also needs to update asm-generic unistd.h header to get the new syscall
number.  And arm64 unistd.h header was converted to use the generic
64-bit header.

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/scripts/syscall.tbl scripts/syscall.tbl
    diff -u tools/perf/arch/x86/entry/syscalls/syscall_32.tbl arch/x86/entry/syscalls/syscall_32.tbl
    diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
    diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl
    diff -u tools/perf/arch/arm/entry/syscalls/syscall.tbl arch/arm/tools/syscall.tbl
    diff -u tools/perf/arch/sh/entry/syscalls/syscall.tbl arch/sh/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/sparc/entry/syscalls/syscall.tbl arch/sparc/kernel/syscalls/syscall.tbl
    diff -u tools/perf/arch/xtensa/entry/syscalls/syscall.tbl arch/xtensa/kernel/syscalls/syscall.tbl
    diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h
    diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h

Please see tools/include/uapi/README for further details.

Cc: linux-arch@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/arm64/include/uapi/asm/unistd.h    | 24 +------------------
 tools/include/uapi/asm-generic/unistd.h       |  4 +++-
 .../perf/arch/arm/entry/syscalls/syscall.tbl  |  1 +
 .../arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
 .../arch/powerpc/entry/syscalls/syscall.tbl   |  1 +
 .../perf/arch/s390/entry/syscalls/syscall.tbl |  1 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl |  1 +
 .../arch/sparc/entry/syscalls/syscall.tbl     |  1 +
 .../arch/x86/entry/syscalls/syscall_32.tbl    |  3 ++-
 .../arch/x86/entry/syscalls/syscall_64.tbl    |  1 +
 .../arch/xtensa/entry/syscalls/syscall.tbl    |  1 +
 tools/scripts/syscall.tbl                     |  1 +
 12 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
index 9306726337fe005e..df36f23876e863ff 100644
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
index 88dc393c2bca38c0..2892a45023af6d3e 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -849,9 +849,11 @@ __SYSCALL(__NR_getxattrat, sys_getxattrat)
 __SYSCALL(__NR_listxattrat, sys_listxattrat)
 #define __NR_removexattrat 466
 __SYSCALL(__NR_removexattrat, sys_removexattrat)
+#define __NR_open_tree_attr 467
+__SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
 
 #undef __NR_syscalls
-#define __NR_syscalls 467
+#define __NR_syscalls 468
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/arm/entry/syscalls/syscall.tbl b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
index 49eeb2ad8dbd8e07..27c1d5ebcd91c8c2 100644
--- a/tools/perf/arch/arm/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
@@ -481,3 +481,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index c844cd5cda620b28..1e8c44c7b61492ea 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -381,3 +381,4 @@
 464	n64	getxattrat			sys_getxattrat
 465	n64	listxattrat			sys_listxattrat
 466	n64	removexattrat			sys_removexattrat
+467	n64	open_tree_attr			sys_open_tree_attr
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index d8b4ab78bef076bd..9a084bdb892694bc 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -557,3 +557,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index e9115b4d8b635b84..a4569b96ef06c54c 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -469,3 +469,4 @@
 464  common	getxattrat		sys_getxattrat			sys_getxattrat
 465  common	listxattrat		sys_listxattrat			sys_listxattrat
 466  common	removexattrat		sys_removexattrat		sys_removexattrat
+467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
diff --git a/tools/perf/arch/sh/entry/syscalls/syscall.tbl b/tools/perf/arch/sh/entry/syscalls/syscall.tbl
index c8cad33bf250ea11..52a7652fcff6394b 100644
--- a/tools/perf/arch/sh/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sh/entry/syscalls/syscall.tbl
@@ -470,3 +470,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
index 727f99d333b304b3..83e45eb6c095a36b 100644
--- a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
@@ -512,3 +512,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
index 4d0fb2fba7e208ae..ac007ea00979dc28 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
@@ -396,7 +396,7 @@
 381	i386	pkey_alloc		sys_pkey_alloc
 382	i386	pkey_free		sys_pkey_free
 383	i386	statx			sys_statx
-384	i386	arch_prctl		sys_arch_prctl			compat_sys_arch_prctl
+384	i386	arch_prctl		sys_arch_prctl
 385	i386	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
 386	i386	rseq			sys_rseq
 393	i386	semget			sys_semget
@@ -472,3 +472,4 @@
 464	i386	getxattrat		sys_getxattrat
 465	i386	listxattrat		sys_listxattrat
 466	i386	removexattrat		sys_removexattrat
+467	i386	open_tree_attr		sys_open_tree_attr
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 5eb708bff1c791de..cfb5ca41e30de1a4 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -390,6 +390,7 @@
 464	common	getxattrat		sys_getxattrat
 465	common	listxattrat		sys_listxattrat
 466	common	removexattrat		sys_removexattrat
+467	common	open_tree_attr		sys_open_tree_attr
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl b/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
index 37effc1b134eea06..f657a77314f8667f 100644
--- a/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
@@ -437,3 +437,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
diff --git a/tools/scripts/syscall.tbl b/tools/scripts/syscall.tbl
index ebbdb3c42e9f7461..580b4e246aecd5f0 100644
--- a/tools/scripts/syscall.tbl
+++ b/tools/scripts/syscall.tbl
@@ -407,3 +407,4 @@
 464	common	getxattrat			sys_getxattrat
 465	common	listxattrat			sys_listxattrat
 466	common	removexattrat			sys_removexattrat
+467	common	open_tree_attr			sys_open_tree_attr
-- 
2.49.0.504.g3bcea36a83-goog


