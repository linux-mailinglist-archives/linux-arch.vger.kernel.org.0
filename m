Return-Path: <linux-arch+bounces-4049-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327FF8B5833
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2024 14:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA9F1C214ED
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2024 12:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2721C8060A;
	Mon, 29 Apr 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPgdaeYp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52280039;
	Mon, 29 Apr 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393147; cv=none; b=e60+bYVicJ96lMjj5KA8pIWTi7RBG8euYMqZdy5ztHHPW6+MAPbXzoDrZLQlO2gymaQnRusmHnYz1f0c8DnTb6wv5tgVZQ97aqCTjTQMYYcx15tzgGO2OukUF8CZ/uipzXxwsk4g/lp+fRdE3I6M/YbZNeUUz2CDd6fffwrjwMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393147; c=relaxed/simple;
	bh=IjQRyjekukMjpd5h0+fXfebHcomYxPC0ei8vi/yCB1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dG+8h4HfKcueRjCtTY7bxJdT8PXYLWF65/y0WpKU6TkPllSwS9Ds84pzBgKEsoBi4r9MbIHGoU8klvskqv18okb9pePUKiUIu6Rc3eAkD1rwrYQj2VV8cRqwKzH+0K+Vbhj7rBVEvVZnoJprm52e90wYDj+ANfL5GMN6/123HtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPgdaeYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B74C4AF51;
	Mon, 29 Apr 2024 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714393146;
	bh=IjQRyjekukMjpd5h0+fXfebHcomYxPC0ei8vi/yCB1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPgdaeYpabv0yHFmtuafEHgxX9ZhBEqjRbAHz/5OrYvplh1qL2PD46cmSJh5suetN
	 MkVsDxw/Td7Y1re0PavY5BxsYWOYTVZ0toQRjMjgfi7wJUrE/gCo65MYq9y2mAmpuA
	 dN1l/5M0x7M6kCdxTVfIdYgmZwlVZOFC2YnDZ6ehAMmmVizJWt+EyHyMrGsVUN5Mg2
	 RChPQ3gUYMGrhlVhXxe/Xqs3QcR5pvQ58YzMpD6UiLTiYy1Edv1UnecuUBwzl1Q0EA
	 Pf9ONvjqTVc5Y9+LcfGa4WNrm/awTw0lvt7VBnXpkuN+acRAs394j6dfq2cKDLhnUf
	 vkdtS4dR7I3og==
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
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
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
Subject: [PATCH v7 13/16] x86/ftrace: enable dynamic ftrace without CONFIG_MODULES
Date: Mon, 29 Apr 2024 15:16:17 +0300
Message-ID: <20240429121620.1186447-14-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429121620.1186447-1-rppt@kernel.org>
References: <20240429121620.1186447-1-rppt@kernel.org>
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
index 4474bf32d0a4..f2917ccf4fb4 100644
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


