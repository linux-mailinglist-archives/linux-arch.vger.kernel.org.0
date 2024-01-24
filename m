Return-Path: <linux-arch+bounces-1520-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA1583ABB6
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 15:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA5A1C2216A
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jan 2024 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695817CF36;
	Wed, 24 Jan 2024 14:27:50 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA27CF25
	for <linux-arch@vger.kernel.org>; Wed, 24 Jan 2024 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106470; cv=none; b=X0hsDMASK7hdoOA1viztQ5x46kZJ1RuYiEZDz6SHEnZGOMsCKrnJ2oBh+6IQ42bPvBNeZ9en8rm8ZsSDxqWry2VSGz/Obi1WurMe+sUJO8UbgJGaFeyhrROmjCMzhKC55Si8AVdyIomm9QQ1Vb8Cy4/GkuxcddZKdUO3YzZrGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106470; c=relaxed/simple;
	bh=CfszxU16lZncejKjedsKD1lxYOGoDUS8ZJocL2mNhvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UM/T1CMCHbJ5lyOfopwcdGFIiOOkUaqVSQeXQQsnbGfUczKpoIN/AjXUGzFYptj5M4sCP/y+GXO/NPHC1x8qrMvnN0uWrkOcgj30de+0gPpj5pKoMXSaB55GWNnDb1jcEefxOyFz2HYJlo9fZTj1NC9SG7HfAa8hJre+LGzxi/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:bc9e:fcb8:8aa3:5dc0])
	by xavier.telenet-ops.be with bizsmtp
	id eeTd2B00o58agq201eTdz7; Wed, 24 Jan 2024 15:27:38 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rSeDH-00GQnc-Hq;
	Wed, 24 Jan 2024 15:27:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rSeE5-00FCwG-E2;
	Wed, 24 Jan 2024 15:27:37 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] init: Remove obsolete arch_call_rest_init() wrapper
Date: Wed, 24 Jan 2024 15:27:35 +0100
Message-Id: <aa10868bfb176eef4abb8bb4a710b85330792694.1706106183.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

Since commit 3570ee046c46b5dc ("s390/smp: keep the original lowcore for
CPU 0"), there is no longer any architecture that needs to override
arch_call_rest_init().

Remove the weak wrapper around rest_init(), call rest_init() directly,
and make rest_init() static.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Perhaps rest_init() should lose its noinline tag, or should even be
inlined manually?
---
 include/linux/start_kernel.h | 2 --
 init/main.c                  | 9 ++-------
 tools/objtool/noreturns.h    | 1 -
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/start_kernel.h b/include/linux/start_kernel.h
index a9806a44a605c7d7..09f994ac87df44f1 100644
--- a/include/linux/start_kernel.h
+++ b/include/linux/start_kernel.h
@@ -9,7 +9,5 @@
    up something else. */
 
 extern asmlinkage void __init __noreturn start_kernel(void);
-extern void __init __noreturn arch_call_rest_init(void);
-extern void __ref __noreturn rest_init(void);
 
 #endif /* _LINUX_START_KERNEL_H */
diff --git a/init/main.c b/init/main.c
index e24b0780fdff7a80..521f40770e67dd27 100644
--- a/init/main.c
+++ b/init/main.c
@@ -681,7 +681,7 @@ static void __init setup_command_line(char *command_line)
 
 static __initdata DECLARE_COMPLETION(kthreadd_done);
 
-noinline void __ref __noreturn rest_init(void)
+static noinline void __ref __noreturn rest_init(void)
 {
 	struct task_struct *tsk;
 	int pid;
@@ -822,11 +822,6 @@ static int __init early_randomize_kstack_offset(char *buf)
 early_param("randomize_kstack_offset", early_randomize_kstack_offset);
 #endif
 
-void __init __weak __noreturn arch_call_rest_init(void)
-{
-	rest_init();
-}
-
 static void __init print_unknown_bootoptions(void)
 {
 	char *unknown_options;
@@ -1069,7 +1064,7 @@ void start_kernel(void)
 	kcsan_init();
 
 	/* Do the rest non-__init'ed, we're now alive */
-	arch_call_rest_init();
+	rest_init();
 
 	/*
 	 * Avoid stack canaries in callers of boot_init_stack_canary for gcc-10
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 1685d7ea6a9f7002..7cda577da897cac5 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -12,7 +12,6 @@ NORETURN(__reiserfs_panic)
 NORETURN(__stack_chk_fail)
 NORETURN(__tdx_hypercall_failed)
 NORETURN(__ubsan_handle_builtin_unreachable)
-NORETURN(arch_call_rest_init)
 NORETURN(arch_cpu_idle_dead)
 NORETURN(bch2_trans_in_restart_error)
 NORETURN(bch2_trans_restart_error)
-- 
2.34.1


