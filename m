Return-Path: <linux-arch+bounces-3586-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B6B8A1DD2
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 20:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FE6AB29038
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 17:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFE114D702;
	Thu, 11 Apr 2024 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBjNsDOQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE214D43D;
	Thu, 11 Apr 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851578; cv=none; b=dbQa1bvOfgl28SrWyW/TDkwjcql0lZnDZw8lFfR2iYRuE3nkK71+In+t7klcu7W4NeVCC6Loxn2a7C6HHs1LKnOWnTy1zA7wJ64cwYJfhWlzbFSM5J9am8vaU8kTI1EvzAh0mGA90lC1im+TLn77jTyXxd/9wdIvUCSSN8Oprrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851578; c=relaxed/simple;
	bh=btBuaAPySyacvFLoesSF8jmcxuZmKLyhOW9rUao98hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ0f/eQ+DjjMnyzP3vKAF5L+NImgJhYVeMQ2ODI3OiV8/Fv/3Vfr8dHB/eu0jV0tMVHgyTjrxpXTCiHQSbrfKCYZUbfxppgLJl/ZAYp5zTvTerck3jwLpYWigZAI1RtAmlTN4nrUZW872XRMZHQ1KDIQsUrTksXMsvi86Y16uyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBjNsDOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00322C32786;
	Thu, 11 Apr 2024 16:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851577;
	bh=btBuaAPySyacvFLoesSF8jmcxuZmKLyhOW9rUao98hE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBjNsDOQydXb1RIv/QKPd8a/ZcM3ev4iQrlZuWSxB+eUTRlnLJblCgvMoL/gVezXk
	 hMzdbN4z+LzsDiSRE7xfAAHe9xPq1yf5Dp8udLo1xyJoKuxv3AV7HKyl9mucU2ATHY
	 O8GL1DfmSWHVBej34ZHjyiSumP79dUOy5Rmalka7m6BxXWq73PfMbzd7DJkjsvzYrn
	 3bUewkI/ccMeykN+WKxx+bwi2QvOtbdMnYufmjYMSKlLKRLBgJpYiBQsgONqWbK+Tv
	 tyiNgxlRIcvBi+krsFKANi42N4Sy4K8EfIvPGRIPaVUAjxASMQ3Z+Ku76dg641fTiy
	 s268X7J1EAzTg==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Helge Deller <deller@gmx.de>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [RFC PATCH 4/7] ftrace: Add swap_func to ftrace_process_locs()
Date: Thu, 11 Apr 2024 19:05:23 +0300
Message-ID: <20240411160526.2093408-5-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411160526.2093408-1-rppt@kernel.org>
References: <20240411160526.2093408-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Liu <song@kernel.org>

ftrace_process_locs sorts module mcount, which is inside RO memory. Add a
ftrace_swap_func so that archs can use RO-memory-poke function to do the
sorting.

Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/ftrace.h |  2 ++
 kernel/trace/ftrace.c  | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 54d53f345d14..54393ce57f08 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1172,4 +1172,6 @@ unsigned long arch_syscall_addr(int nr);
 
 #endif /* CONFIG_FTRACE_SYSCALLS */
 
+void ftrace_swap_func(void *a, void *b, int n);
+
 #endif /* _LINUX_FTRACE_H */
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698..95f11c8cdc5e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6480,6 +6480,17 @@ static void test_is_sorted(unsigned long *start, unsigned long count)
 }
 #endif
 
+void __weak ftrace_swap_func(void *a, void *b, int n)
+{
+	unsigned long t;
+
+	WARN_ON_ONCE(n != sizeof(t));
+
+	t = *((unsigned long *)a);
+	*(unsigned long *)a = *(unsigned long *)b;
+	*(unsigned long *)b = t;
+}
+
 static int ftrace_process_locs(struct module *mod,
 			       unsigned long *start,
 			       unsigned long *end)
@@ -6507,7 +6518,7 @@ static int ftrace_process_locs(struct module *mod,
 	 */
 	if (!IS_ENABLED(CONFIG_BUILDTIME_MCOUNT_SORT) || mod) {
 		sort(start, count, sizeof(*start),
-		     ftrace_cmp_ips, NULL);
+		     ftrace_cmp_ips, ftrace_swap_func);
 	} else {
 		test_is_sorted(start, count);
 	}
-- 
2.43.0


