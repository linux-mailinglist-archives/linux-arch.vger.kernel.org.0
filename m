Return-Path: <linux-arch+bounces-4185-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7BE8BC119
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 16:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB70AB20C9B
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E402460BB6;
	Sun,  5 May 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZBNbgqZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81F2D051;
	Sun,  5 May 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714919290; cv=none; b=MDhqRYzjX+0auTdMjgcae6OgqQ8s1Kq179LkKMi0FBO2EggOolNx+ceBUBZurKgteIqe8Vqw/eEFQAY5VCcjqZluLZ1CRAiiycfuSVpOj8aKvRtsh4TbFDZoTWZCY/ZXBdbTUSgLSi8buvQ6vQ176+BxZ6Qbh84Eq5iVdnc3NkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714919290; c=relaxed/simple;
	bh=Rvc7E+HMMA3ADjVUaU2tKv0yhJenjSe9igrLALIYU0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sk/dN/0im+DE4/bLB1CDH8Ndgz38yysqPHIItrweiqoEPQFKjmb+a1stRS8/kg/N4hySFACw4ihnNSEpvN5+9kQX1jLFl/GxURFr9a4CfwbA95cU32r6oZWmh6Mk4CZtTg2UuaW2cRGi4Nq8h7OveqidnWEAerrGisQSKOltjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZBNbgqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C15C4DDE5;
	Sun,  5 May 2024 14:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714919290;
	bh=Rvc7E+HMMA3ADjVUaU2tKv0yhJenjSe9igrLALIYU0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZBNbgqZM8fTpMpBIBBoIMNevcLneOWz+UMMuh5HD7Hvyw9pJcz9NSX7Wij/nV9xL
	 FtyRL9b/dN++XMHIoZNxaO4GQuW0VU6rNLHqyyl84qxvOPYK29X0F47LMEwWU8sF4A
	 x9UZbUS0hTu1I8D3OWYGcsxjD39bntUTvR0tofqfQlPU4AsCyZ62yE+AwEfyfv/P7K
	 45ZZqBubHl+xUs4uvKql4FjTbOwrVDDFHgGPcgdZUNlZaYGaKxY5t9crBYuWtEI0VN
	 thOvqqdmcv3ghDx/TpyAKkcVarp8ljHwhRscC474CnsGiuV5nPh1lZuZ7pduWhc6l8
	 tnGnCtCNfFB9g==
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
	Liviu Dudau <liviu@dudau.co.uk>,
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
Subject: [PATCH v8 09/17] riscv: extend execmem_params for generated code allocations
Date: Sun,  5 May 2024 17:25:52 +0300
Message-ID: <20240505142600.2322517-10-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240505142600.2322517-1-rppt@kernel.org>
References: <20240505142600.2322517-1-rppt@kernel.org>
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

Define MODULES_VADDR and MODULES_END as VMALLOC_START and VMALLOC_END for
32 bit and slightly reorder execmem_params initialization to support both
32 and 64 bit variants, define EXECMEM_KPROBES and EXECMEM_BPF ranges in
riscv::execmem_params and drop overrides of alloc_insn_page() and
bpf_jit_alloc_exec().

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h   |  3 +++
 arch/riscv/kernel/module.c         | 14 +++++++++++++-
 arch/riscv/kernel/probes/kprobes.c | 10 ----------
 arch/riscv/net/bpf_jit_core.c      | 13 -------------
 4 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9f8ea0e33eb1..5f21814e438e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -55,6 +55,9 @@
 #define MODULES_LOWEST_VADDR	(KERNEL_LINK_ADDR - SZ_2G)
 #define MODULES_VADDR		(PFN_ALIGN((unsigned long)&_end) - SZ_2G)
 #define MODULES_END		(PFN_ALIGN((unsigned long)&_start))
+#else
+#define MODULES_VADDR		VMALLOC_START
+#define MODULES_END		VMALLOC_END
 #endif
 
 /*
diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 182904127ba0..0e6415f00fca 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -906,7 +906,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 	return 0;
 }
 
-#if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
+#ifdef CONFIG_MMU
 static struct execmem_info execmem_info __ro_after_init;
 
 struct execmem_info __init *execmem_arch_setup(void)
@@ -919,6 +919,18 @@ struct execmem_info __init *execmem_arch_setup(void)
 				.pgprot	= PAGE_KERNEL,
 				.alignment = 1,
 			},
+			[EXECMEM_KPROBES] = {
+				.start	= VMALLOC_START,
+				.end	= VMALLOC_END,
+				.pgprot	= PAGE_KERNEL_READ_EXEC,
+				.alignment = 1,
+			},
+			[EXECMEM_BPF] = {
+				.start	= BPF_JIT_REGION_START,
+				.end	= BPF_JIT_REGION_END,
+				.pgprot	= PAGE_KERNEL,
+				.alignment = PAGE_SIZE,
+			},
 		},
 	};
 
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


