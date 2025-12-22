Return-Path: <linux-arch+bounces-15532-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E053CCD7644
	for <lists+linux-arch@lfdr.de>; Mon, 22 Dec 2025 23:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA6FA3022D39
	for <lists+linux-arch@lfdr.de>; Mon, 22 Dec 2025 22:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5E0347FC8;
	Mon, 22 Dec 2025 22:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwWP75d0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03B2BEC43;
	Mon, 22 Dec 2025 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766444246; cv=none; b=pzcRghlhhsqp5KdCk5WjcGxpehFD/T/1Glzpc8lD7BgEKfi81/1dn37oBij+xeHIQCko9VbfyXWqMW4fNnCy162PvMMQv70vJsAvdrPrFHplYdMnU8kde1u/O5PJ9iQFK1oMo+ebgElzHcG4YDTqiK5XwOkVDWFfy7vr/F2wbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766444246; c=relaxed/simple;
	bh=7E5Dybc75IESRAl+k3QA51khMYlSIHC9JyGLQOU/HYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofnl228MnkZ0VqGER0BThhXKgWN/0Rf+Rc4VhcttlaFYso/woNQUh3j/1vCQEeUW/i2vnIpfkmwonbbRiWYV6MZOGg4/3bzXV7vpc3HOwzcJJksUDmezI9aHuHIIFcryKJU5OpAQM1vf1Vcr6I8j0lmKGYujjhlIobL5rpY+MgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwWP75d0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1A9C19421;
	Mon, 22 Dec 2025 22:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766444245;
	bh=7E5Dybc75IESRAl+k3QA51khMYlSIHC9JyGLQOU/HYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwWP75d0yMaok+rW7kDqDKrllYdg3hFOZVJdkOJXB9XiLWf7BeUY45hOWOg7En3/T
	 FCM3HzlXTEhGTP5e8s3RVFxWqbNgnN7DKtbh3/Jca1hMH3jQOCD+Bo0k7ATEpVn52x
	 9ec10vtMK9+IajQ2K0aNCgCoHPfHAWgfdtcWDFu5PNxY8GxKctWD1FiCIxTSiN9p7U
	 +nqqn+gH95M3HD0yDqbqvruENlaYzKnVXynplpaMUFMQbpFrDzot+w0HYjiBl/6goW
	 1hXLvWBxY/d3WxcFNi9rYVrLAEzwKZ2PWbTfacpTzH+h7o8T+N+W/4UFKs1IB6YZaL
	 EI10QvhW/6d1Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 11/11] tools headers: Sync syscall table with kernel sources
Date: Mon, 22 Dec 2025 14:57:16 -0800
Message-ID: <20251222225716.3565649-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To: <20251222225716.3565649-1-namhyung@kernel.org>
References: <20251222225716.3565649-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  b36d4b6aa88ef039 ("arch: hookup listns() system call")

This should be used to beautify the syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
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

Please see tools/include/README.kernel-copies.

Note that s390 syscall table is still out of sync as it switches to use the
generic table.  But I'd like to minimize the change in this commit.

Cc: linux-arch@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/asm-generic/unistd.h             | 4 +++-
 tools/perf/arch/arm/entry/syscalls/syscall.tbl      | 1 +
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 1 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl       | 1 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl    | 1 +
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl   | 1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 1 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl   | 1 +
 tools/scripts/syscall.tbl                           | 1 +
 11 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 04e0077fb4c97a4d..942370b3f5d25230 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -857,9 +857,11 @@ __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
 __SYSCALL(__NR_file_getattr, sys_file_getattr)
 #define __NR_file_setattr 469
 __SYSCALL(__NR_file_setattr, sys_file_setattr)
+#define __NR_listns 470
+__SYSCALL(__NR_listns, sys_listns)
 
 #undef __NR_syscalls
-#define __NR_syscalls 470
+#define __NR_syscalls 471
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/arm/entry/syscalls/syscall.tbl b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
index b07e699aaa3c2840..fd09afae72a24255 100644
--- a/tools/perf/arch/arm/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
@@ -484,3 +484,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 7a7049c2c307885f..9b92bddf06b572d0 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -384,3 +384,4 @@
 467	n64	open_tree_attr			sys_open_tree_attr
 468	n64	file_getattr			sys_file_getattr
 469	n64	file_setattr			sys_file_setattr
+470	n64	listns				sys_listns
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index b453e80dfc003796..ec4458cdb97b69a6 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -560,3 +560,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 8a6744d658db3986..5863787ab03633a4 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -472,3 +472,4 @@
 467  common	open_tree_attr		sys_open_tree_attr		sys_open_tree_attr
 468  common	file_getattr		sys_file_getattr		sys_file_getattr
 469  common	file_setattr		sys_file_setattr		sys_file_setattr
+470  common	listns			sys_listns			sys_listns
diff --git a/tools/perf/arch/sh/entry/syscalls/syscall.tbl b/tools/perf/arch/sh/entry/syscalls/syscall.tbl
index 5e9c9eff5539e241..969c11325adeb24e 100644
--- a/tools/perf/arch/sh/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sh/entry/syscalls/syscall.tbl
@@ -473,3 +473,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
index ebb7d06d1044fa9b..39aa26b6a50be7e0 100644
--- a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
@@ -515,3 +515,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
index 4877e16da69a50f2..e979a3eac7a355de 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
@@ -475,3 +475,4 @@
 467	i386	open_tree_attr		sys_open_tree_attr
 468	i386	file_getattr		sys_file_getattr
 469	i386	file_setattr		sys_file_setattr
+470	i386	listns			sys_listns
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index ced2a1deecd7ce08..8a4ac4841be6e542 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -394,6 +394,7 @@
 467	common	open_tree_attr		sys_open_tree_attr
 468	common	file_getattr		sys_file_getattr
 469	common	file_setattr		sys_file_setattr
+470	common	listns			sys_listns
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl b/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
index 374e4cb788d8a6d4..438a3b1704022b39 100644
--- a/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
@@ -440,3 +440,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
diff --git a/tools/scripts/syscall.tbl b/tools/scripts/syscall.tbl
index d1ae5e92c615b58e..e74868be513cfb04 100644
--- a/tools/scripts/syscall.tbl
+++ b/tools/scripts/syscall.tbl
@@ -410,3 +410,4 @@
 467	common	open_tree_attr			sys_open_tree_attr
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
+470	common	listns				sys_listns
-- 
2.52.0.351.gbe84eed79e-goog


