Return-Path: <linux-arch+bounces-3578-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC4D8A1BC2
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB06280792
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 17:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4462013790B;
	Thu, 11 Apr 2024 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWHNNAcI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5D13777C;
	Thu, 11 Apr 2024 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851431; cv=none; b=qyMdM2CJ5ZVrdXkJo9WdSR4sgIx2Gc19ZGsiIwYfUWfxS+bfnvaRJ+ZRSN/S0rjalWMHov1A4f4v5lfGHvC7wmT3J+Mkhlvj7s0mzge/J8vJVb40AERxaH0pp7fzjJG8QcYNZGEVFFaLMbrpIt0Ku9hKce9EJ8OxQ/lD2thLcBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851431; c=relaxed/simple;
	bh=tleyEU1lUC0BC39QIzg11FQLbY7rS2GjqFF25yuhwvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ed8c7Ykp/599FNUW+DeXoXfObA/dOXTqMkCArsD+JwC+j1flZ64zoMxAVdW5aLvNOOizf2veK7KgxwjL8aOTqcjJHOvq9R+afIa/uIjZEk+7r9MddILMYhmPQechUdV/qBNBsMmEOBw0+6x0Jrl8iEi0CLl0L+Finx3wlq+eEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWHNNAcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B264BC072AA;
	Thu, 11 Apr 2024 16:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851430;
	bh=tleyEU1lUC0BC39QIzg11FQLbY7rS2GjqFF25yuhwvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWHNNAcIx/mLULvyCHWFsS1YLjSZIaezlJX+m72pGZE/RNEbdBx5UBl+FwhfwbSxC
	 fdiUBt+vEpaP3R/bm42w8LxmAlAgfVm0TZBD86qoaEKsjkv1HZ/9uJh3DXf39hjl+Z
	 S/10ZwZSzTC3Znq9H07mRCjK8broyIQBbWWLJf3tk8B+pnbnTfmsA14YuXJlRy7DTL
	 I6xnz4e0u5vePgQqBHaVpuuAl5Img7qwFaNWAmNczEjvOPFISuS2S3W3ypFIfEcoS8
	 gbo3+vyOWtGb9NM4v6WJPlqh5O74/8/XHwwwKYKPbAH9YXX8m9nHRw7GlWJhdO6RJ+
	 v5BXTq7XKxO3A==
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
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>,
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
Subject: [PATCH v4 12/15] x86/ftrace: enable dynamic ftrace without CONFIG_MODULES
Date: Thu, 11 Apr 2024 19:00:48 +0300
Message-ID: <20240411160051.2093261-13-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411160051.2093261-1-rppt@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
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
index e87ddbdaaeb2..5100a769ffda 100644
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


