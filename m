Return-Path: <linux-arch+bounces-7146-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AC1970E71
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 08:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F0C280D88
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B441AF4D2;
	Mon,  9 Sep 2024 06:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE5rHksS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEDE1AED55;
	Mon,  9 Sep 2024 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864552; cv=none; b=ExyDWQDejVubaeYfwJPtNMjXAQ5ZxCmLleSRfgH8iYZGAdjFR70rExE4kS0CTvknD/qNlR2dOYMT9bJlVx5lQ/xYrgJSd8Tg2+3UnBz+Me3XyGv5L6p8QY08AzRhw7eZrmTxlK/RjGWF8z9LefKDyTQkKd0cnuoVB8NmouP663U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864552; c=relaxed/simple;
	bh=X9sfhUFgPK5V3fglnGNo5sHB9wMPevyPr+qKgRxwoik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M34AQrNv/+tDhGHiJLQfTO2QZ41+qfQJ6UzADe2ywd4KwUdpqAJUG9czxlfoj8nVGNMJGbUOX4Rdk9jLjwH06w+5zXjDqD+vtkTLkDp6HBWGSiNJ240qwXIJ0Lnwy3qY74B72Ym6ssi63+obVKad19Q753mFgXUHVvIxCerCCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE5rHksS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4244C4CECA;
	Mon,  9 Sep 2024 06:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725864551;
	bh=X9sfhUFgPK5V3fglnGNo5sHB9wMPevyPr+qKgRxwoik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gE5rHksSDO3uZ8d+BpxC3iCqxZ+t+kYtAmK8ij3ReKzOLwADAXD1KPV81Gv59cLJB
	 QeffyMC9I/10+jXBXTc3t+0L43Q/5LUUYAuSWRRkqMF1qUTuLgE0CHJfsn1QJzpnCc
	 vpbE4JzC9jBNebxwgUnNlq4/NCkpYAMAlNBdq0T9QBn3F+30lZRo0AKiT/LUxF50CU
	 ovqI5rDJnLv1Xkn6214K1cbtBxdD6gx3ThLFeZUH9qVKkVoE+XrXj8aDCwlWIX7+qy
	 pjaJ4YltFeHWHyE9MeOm4kT8zBk9Qw94w2NQP5QJetbV7d9rtaQpBgupHNkhqraFay
	 cord90B6KD2bQ==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 5/8] ftrace: Add swap_func to ftrace_process_locs()
Date: Mon,  9 Sep 2024 09:47:27 +0300
Message-ID: <20240909064730.3290724-6-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909064730.3290724-1-rppt@kernel.org>
References: <20240909064730.3290724-1-rppt@kernel.org>
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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/ftrace.h |  2 ++
 kernel/trace/ftrace.c  | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index fd5e84d0ec47..b794dcb7cae8 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1188,4 +1188,6 @@ unsigned long arch_syscall_addr(int nr);
 
 #endif /* CONFIG_FTRACE_SYSCALLS */
 
+void ftrace_swap_func(void *a, void *b, int n);
+
 #endif /* _LINUX_FTRACE_H */
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4c28dd177ca6..95bb9b52ab36 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6989,6 +6989,23 @@ static void test_is_sorted(unsigned long *start, unsigned long count)
 }
 #endif
 
+/*
+ * ftrace_process_locs sorts module mcount, which might be inside RO
+ * memory.
+ * ftrace_swap_func allows architectures to use RO-memory-poke function to
+ * do the sorting.
+ */
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
@@ -7016,7 +7033,7 @@ static int ftrace_process_locs(struct module *mod,
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


