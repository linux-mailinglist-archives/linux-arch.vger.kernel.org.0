Return-Path: <linux-arch+bounces-3575-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390C58A1BA5
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696781C21FF9
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 17:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A41332BE;
	Thu, 11 Apr 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhJUoNdh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9685F13329C;
	Thu, 11 Apr 2024 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851399; cv=none; b=pajju4r+52geYmIGH4n7U8TqevmbyZ3Dj/gZaET+eny9uKBLIFz5yK3UErx3bTgjGcbjPV+AB6nZHJuJ+jaqtJaVPlG19ZfdWbzRuAhke+k3IBs/M4ffnnlrktxjXU2AhJGL40sCz/R0bYlgUKqb8v2UB/LlKQy0x4nk8yAtCqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851399; c=relaxed/simple;
	bh=MDN1WZXA3xhpqzlVolNbN2nPNGabqu/EHQ96vnrSojU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaQtBB3bAIncCS7EIcIPvTca4gC8MJRCi3cRfHk9TjywHqLRpLJTpA1U78N43aop++x7kkRwgomHpfun3gcxgZX61neWnaTG0SvHuq3nml8QaFoHdq+6f8JvCvx5JUaGs5Zq36mSlJmJfU8wViEnn0cz6Ntk7IB74k9sW2QACkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhJUoNdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94880C2BD11;
	Thu, 11 Apr 2024 16:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851399;
	bh=MDN1WZXA3xhpqzlVolNbN2nPNGabqu/EHQ96vnrSojU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LhJUoNdhtV0oZXoRrDXU6eMRqs3zZ5XHBNvrq+6ByzAMbDAa6uq7MBqyMKgbGqZFW
	 HrzUCiC8TYoTAiZJ4eUrIKHEBCy1h9cvybi1lknpDvZxBUbpLxDlWVac4fFQo8y3tl
	 6XYZrA/ZIeDOZnAcush9O5J+oz/E9mCdnu9FG5iSvvfxcbchbVMnbZJ0Ot60g9khR8
	 6hlVhoKuSdfItxauM9IOtBNhB/qhuG+DV//AyfCzDUlFwdosD585kNGC5cwqVdOxlh
	 8Zby1LP7fTPzIayJ9Zh0PVhOV8QUnueDvX81krMeKPRGIRxcKLNazZfZgzVpP34N6W
	 ovAGcgA2RpWQg==
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
Subject: [PATCH v4 09/15] riscv: extend execmem_params for generated code allocations
Date: Thu, 11 Apr 2024 19:00:45 +0300
Message-ID: <20240411160051.2093261-10-rppt@kernel.org>
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

The memory allocations for kprobes and BPF on RISC-V are not placed in
the modules area and these custom allocations are implemented with
overrides of alloc_insn_page() and  bpf_jit_alloc_exec().

Slightly reorder execmem_params initialization to support both 32 and 64
bit variants, define EXECMEM_KPROBES and EXECMEM_BPF ranges in
riscv::execmem_params and drop overrides of alloc_insn_page() and
bpf_jit_alloc_exec().

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/module.c         | 21 ++++++++++++++++++++-
 arch/riscv/kernel/probes/kprobes.c | 10 ----------
 arch/riscv/net/bpf_jit_core.c      | 13 -------------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index ad32e2a8621a..aad158bb2022 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -906,20 +906,39 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
+#ifdef CONFIG_MMU
 static struct execmem_info execmem_info __ro_after_init = {
 	.ranges = {
 		[EXECMEM_DEFAULT] = {
 			.pgprot = PAGE_KERNEL,
 			.alignment = 1,
 		},
+		[EXECMEM_KPROBES] = {
+			.pgprot = PAGE_KERNEL_READ_EXEC,
+			.alignment = 1,
+		},
+		[EXECMEM_BPF] = {
+			.pgprot = PAGE_KERNEL,
+			.alignment = PAGE_SIZE,
+		},
 	},
 };
 
 struct execmem_info __init *execmem_arch_setup(void)
 {
+#ifdef CONFIG_64BIT
 	execmem_info.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
 	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
+#else
+	execmem_info.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
+	execmem_info.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
+#endif
+
+	execmem_info.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
+	execmem_info.ranges[EXECMEM_KPROBES].end = VMALLOC_END;
+
+	execmem_info.ranges[EXECMEM_BPF].start = BPF_JIT_REGION_START;
+	execmem_info.ranges[EXECMEM_BPF].end = BPF_JIT_REGION_END;
 
 	return &execmem_info;
 }
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 2f08c14a933d..e64f2f3064eb 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -104,16 +104,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	return 0;
 }
 
-#ifdef CONFIG_MMU
-void *alloc_insn_page(void)
-{
-	return  __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
-				     GFP_KERNEL, PAGE_KERNEL_READ_EXEC,
-				     VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
-				     __builtin_return_address(0));
-}
-#endif
-
 /* install breakpoint in text */
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 6b3acac30c06..e238fdbd5dbc 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -219,19 +219,6 @@ u64 bpf_jit_alloc_exec_limit(void)
 	return BPF_JIT_REGION_SIZE;
 }
 
-void *bpf_jit_alloc_exec(unsigned long size)
-{
-	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
-				    BPF_JIT_REGION_END, GFP_KERNEL,
-				    PAGE_KERNEL, 0, NUMA_NO_NODE,
-				    __builtin_return_address(0));
-}
-
-void bpf_jit_free_exec(void *addr)
-{
-	return vfree(addr);
-}
-
 void *bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
 	int ret;
-- 
2.43.0


