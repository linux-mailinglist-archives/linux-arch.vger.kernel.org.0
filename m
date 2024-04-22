Return-Path: <linux-arch+bounces-3862-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE618AC7ED
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 10:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEFE3283463
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 08:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DA358213;
	Mon, 22 Apr 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sO4wTbB+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6351C4D;
	Mon, 22 Apr 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775873; cv=none; b=P95LeNE1bonDF7fIlUhdVvNiotN/iq1OgA40MYkP/rDvRz7qlw4Pbyt9G7srHkEZ74gwd8pBKxYzhMilH7IRB0CJN1zstB+pDbfdX0gJ9q6xfZD7hX4MeBgume9B7GwRwFF2+skQuxsMM3D6HS8HCTDkEHTxOrAhnY2yj6vOdeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775873; c=relaxed/simple;
	bh=lHpN+d0QRuUVXJIB1eReja4FWUfXvpd+hME9aJI8tNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCQ4QGTPQWIe2Jx3k2aK2/vJX9Im2855mKdu/2RKkXfmArgMVPdR2tdHOzery1FOA5y4Hr8IMklwEmO8gu5GF0R4UyOaMq+7TYZzVXBlTtvUpxaRurq4mfRT1448zS8D+lIikq39lDn6NsInse578GBd+UTdyGD0Z2QNQgXmqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sO4wTbB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54B0C113CC;
	Mon, 22 Apr 2024 08:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713775873;
	bh=lHpN+d0QRuUVXJIB1eReja4FWUfXvpd+hME9aJI8tNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sO4wTbB+Milo3xS+lLBG3XWGzAtuQNj9vPNus4JsUmgfbe8gEP4GhjKuaPghll8ad
	 AIL4PHWve7PCKN2gpwuzIrT1A0qMYLaMmX9Mbk5GP1i+0ImBflhvG/HDKJ89MJLS7C
	 NSegGqr+fYAhlsYGHPsTd4qCsBTID69/OIaM+hwcwpdK/vdai/Cmc3WZQUIwFKMf2l
	 sH+rF9Y+jCRKBnnUGS6fxPjHVdYE9oR4TuuD1NzcbrL1Uo008iZkwtxC47vH1y20ws
	 N/AdwVXRGgfWFdYdBbqVwJ9sHu6lojECBJYUuES8MHpkRwaKf/ofhZDClHBd2mup1e
	 zf4ynpfxlW1VA==
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
Date: Mon, 22 Apr 2024 11:50:25 +0300
Message-ID: <20240422085028.3602777-3-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422085028.3602777-1-rppt@kernel.org>
References: <20240422085028.3602777-1-rppt@kernel.org>
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


