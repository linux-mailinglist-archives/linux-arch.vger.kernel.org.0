Return-Path: <linux-arch+bounces-3879-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D916B8AC9B2
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679021F21D7A
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 09:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B93C142E70;
	Mon, 22 Apr 2024 09:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqvQCRbS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F613CA90;
	Mon, 22 Apr 2024 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779239; cv=none; b=EAcRb5Q0M+7VpMWkslBOmVM5is7Cj4W1AG730d3YAraCZwq/PTFEmfhZmX56w3lUAzTs9pqEvrmwiVtK8O6cidyrIu7ujDyJz02AO/AM4iLcYV7G/bryOV+5NxmCo5jAu6BD5NjnniUL5lhTPtYmxjy0gXaKp64Dk6nb2+k5MVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779239; c=relaxed/simple;
	bh=lHpN+d0QRuUVXJIB1eReja4FWUfXvpd+hME9aJI8tNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKW378opubK7itpYu763YvYIoJY5k4TeGdqyYQDhyBrSoFyNOB4uH9ETewfsFPFt/Zg8lRx9nx8x8Vd9+o4Le/EwD+wJnn1i7j1xxdDbW8yZ4b1sbfMlNPPeelto/QgpppQzg3pn4oRV8WI9GC/MLp4JIar4rzOvUux7QyBFHj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqvQCRbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C049C4AF07;
	Mon, 22 Apr 2024 09:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713779238;
	bh=lHpN+d0QRuUVXJIB1eReja4FWUfXvpd+hME9aJI8tNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqvQCRbSgOtByDX5V7X7Bw0Q6Xg/6rK2dK+e7xdmVuh3CxXahd5fkRnnV4/E1mgFv
	 MnpJiS6k7qsv4Cv9yrxpVrkgPtBTgXqv6snY5o+VvaMzmB+dgrrgTWs6Fk2xCb4cbk
	 clpfBZgcTEXi+sDhCAuvAiBk/RZJQ1ExQR6SIQ0XaYWNYv8ggZmdP6DnkyauN/SN5i
	 PgKK3IY72GlYAysRAMEAsjNSAyfQ8xL5gQVlm2N6nJvIJ2embrZ+O9iEk9WZVsoBfo
	 Jyo9Tu1EKGZ/sy2vEM8dORmBr0c+/aSvnlpUXttLCMWeOso2IBKsjBwFUVDAnUIytk
	 rvIzl/f//U9QA==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
	Sam Ravnborg <sam@ravnborg.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	netdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v5 12/15] x86/ftrace: enable dynamic ftrace without CONFIG_MODULES
Date: Mon, 22 Apr 2024 12:44:33 +0300
Message-ID: <20240422094436.3625171-13-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422094436.3625171-1-rppt@kernel.org>
References: <20240422094436.3625171-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Dynamic ftrace must allocate memory for code and this was impossible
without CONFIG_MODULES.

With execmem separated from the modules code, execmem_text_alloc() is
available regardless of CONFIG_MODULES.

Remove dependency of dynamic ftrace on CONFIG_MODULES and make
CONFIG_DYNAMIC_FTRACE select CONFIG_EXECMEM in Kconfig.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/x86/Kconfig         |  1 +
 arch/x86/kernel/ftrace.c | 10 ----------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3f5ba72c9480..cd8addb96a0b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -34,6 +34,7 @@ config X86_64
 	select SWIOTLB
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
+	select EXECMEM if DYNAMIC_FTRACE
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index c8ddb7abda7c..8da0e66ca22d 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -261,8 +261,6 @@ void arch_ftrace_update_code(int command)
 /* Currently only x86_64 supports dynamic trampolines */
 #ifdef CONFIG_X86_64
 
-#ifdef CONFIG_MODULES
-/* Module allocation simplifies allocating memory for code */
 static inline void *alloc_tramp(unsigned long size)
 {
 	return execmem_alloc(EXECMEM_FTRACE, size);
@@ -271,14 +269,6 @@ static inline void tramp_free(void *tramp)
 {
 	execmem_free(tramp);
 }
-#else
-/* Trampolines can only be created if modules are supported */
-static inline void *alloc_tramp(unsigned long size)
-{
-	return NULL;
-}
-static inline void tramp_free(void *tramp) { }
-#endif
 
 /* Defined as markers to the end of the ftrace default trampolines */
 extern void ftrace_regs_caller_end(void);
-- 
2.43.0


