Return-Path: <linux-arch+bounces-3574-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BCE8A1B9D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A77641F21DA5
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 17:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8490131BD3;
	Thu, 11 Apr 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/Pdoybv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11F131BAA;
	Thu, 11 Apr 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851389; cv=none; b=Cb51qyuHAJ4It1Yl37WP7dDtntoOUM8uf7oD/4vFwj3UAzG3gs3S7FUWnbb7U2C8JwuEvmBMPPrctDdnTazIRvqN160/Rskfg60lwVAzSMpCsoFLnQw42ZaWEdEPBP2EJtzAvJL7Ir5N5+UcULDmDm/nGoR78FVIyi7j5/mgzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851389; c=relaxed/simple;
	bh=SKr2KE9uheUItEEdb+3dSNIPv9WQiBLJhcJ7LNHhua4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7qlWYcAhvOwfrFncjPHnNh4ChxpaBTKAX4di+81EcvvqvKdgRp8QoRxF+8j2A0CtD3BBDG7oOXp1VNIq09PudbJCgLryh8uF4jjtPJnOM6ySm21Vk+zgsCubUgSntGTy2n2jNL9dVfpAU3Bx6FzX3G+nJ4jcMcdN73xRBod2BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/Pdoybv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAFAC32786;
	Thu, 11 Apr 2024 16:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851389;
	bh=SKr2KE9uheUItEEdb+3dSNIPv9WQiBLJhcJ7LNHhua4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/PdoybvhERinJCMHC+yQRAsmlncc6oU4utcSyu6AELKgJzyJVfzHf76aaTeaChXL
	 MpldlBly/9Jjz8av31uReShwgA9Wlq2qOfGfuBchPHxdljzoz5ojSKTJpFz36B8Zc1
	 2DsNtXjnq9CfKqqcXehaFdvhsqD42GyFk1ShEVXSbkFTR23dC8pO70bc8xYUW9wBzi
	 rRIEIbV18psznTztZqe/QTtYLOFeXNHkH8OQND+pcN7VGhqgRVfK5LTckwJ9fwgq3g
	 Q7po7BjAwo+Tu8x8tAJ4K4X4LQNucwifMC/HQQYPJ3qGF8eKjk76GPUw4vrFfWned9
	 MeSvQp+0Gx30w==
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
Subject: [PATCH v4 08/15] arm64: extend execmem_info for generated code allocations
Date: Thu, 11 Apr 2024 19:00:44 +0300
Message-ID: <20240411160051.2093261-9-rppt@kernel.org>
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

The memory allocations for kprobes and BPF on arm64 can be placed
anywhere in vmalloc address space and currently this is implemented with
overrides of alloc_insn_page() and bpf_jit_alloc_exec() in arm64.

Define EXECMEM_KPROBES and EXECMEM_BPF ranges in arm64::execmem_info and
drop overrides of alloc_insn_page() and bpf_jit_alloc_exec().

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/module.c         | 14 ++++++++++++++
 arch/arm64/kernel/probes/kprobes.c |  7 -------
 arch/arm64/net/bpf_jit_comp.c      | 11 -----------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index a377a3217cf2..aa9e2b3d7459 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -115,6 +115,12 @@ static struct execmem_info execmem_info __ro_after_init = {
 		[EXECMEM_DEFAULT] = {
 			.alignment = MODULE_ALIGN,
 		},
+		[EXECMEM_KPROBES] = {
+			.alignment = 1,
+		},
+		[EXECMEM_BPF] = {
+			.alignment = 1,
+		},
 	},
 };
 
@@ -143,6 +149,14 @@ struct execmem_info __init *execmem_arch_setup(void)
 		r->end = module_plt_base + SZ_2G;
 	}
 
+	execmem_info.ranges[EXECMEM_KPROBES].pgprot = PAGE_KERNEL_ROX;
+	execmem_info.ranges[EXECMEM_KPROBES].start = VMALLOC_START;
+	execmem_info.ranges[EXECMEM_KPROBES].end = VMALLOC_END;
+
+	execmem_info.ranges[EXECMEM_BPF].pgprot = PAGE_KERNEL;
+	execmem_info.ranges[EXECMEM_BPF].start = VMALLOC_START;
+	execmem_info.ranges[EXECMEM_BPF].end = VMALLOC_END;
+
 	return &execmem_info;
 }
 
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 327855a11df2..4268678d0e86 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -129,13 +129,6 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	return 0;
 }
 
-void *alloc_insn_page(void)
-{
-	return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
-			GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
-			NUMA_NO_NODE, __builtin_return_address(0));
-}
-
 /* arm kprobe: install breakpoint in text */
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 122021f9bdfc..456f5af239fc 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1793,17 +1793,6 @@ u64 bpf_jit_alloc_exec_limit(void)
 	return VMALLOC_END - VMALLOC_START;
 }
 
-void *bpf_jit_alloc_exec(unsigned long size)
-{
-	/* Memory is intended to be executable, reset the pointer tag. */
-	return kasan_reset_tag(vmalloc(size));
-}
-
-void bpf_jit_free_exec(void *addr)
-{
-	return vfree(addr);
-}
-
 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
 bool bpf_jit_supports_subprog_tailcalls(void)
 {
-- 
2.43.0


