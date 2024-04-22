Return-Path: <linux-arch+bounces-3853-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6778AC778
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 10:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E16AB2121C
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CD054666;
	Mon, 22 Apr 2024 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqjGhLma"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604353E25;
	Mon, 22 Apr 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775681; cv=none; b=pEzWm1ZhfJieNt8aRZ/5v5EcjrVeoe5WMdWEVzO4bvTQ3YZQGKtIim59cpKkr0dpJM2wXVvMfzlgA9UtoJ+Uujm7jnQ6GaLoXZ+as94wSRM3Hajumq1g4w+yIVJTJ6RU9120upUfIyj0T3QsYe3DKkN8nHK7NIg3x0USbx/U6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775681; c=relaxed/simple;
	bh=Q5aCDGAMhe9LWjmBOe0KfqvsLthVcLCeaQ3ItO7ykso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1oJ20lrFKl4/eubuGm8T5VMiwoP+DFK2im2XZCrbxX7+JHxEoCwbNI4V3FO1Jtsy/JH/SQtFc2l/SqO3NDl04b+TWTsc4C4+9D7nmrT7whc6tw7Ex15nO/WwLK9/87W+Svv0GgsYQwsu5a67CbOQOwcm1av2d+QZOwezMFn1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqjGhLma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFB7C113CC;
	Mon, 22 Apr 2024 08:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713775680;
	bh=Q5aCDGAMhe9LWjmBOe0KfqvsLthVcLCeaQ3ItO7ykso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tqjGhLmakj38qK7RgDjyBqXPIqmgUHctAJPuYLPYWfWlTQVzsz3Yv8bD9x5dI6Hnl
	 zH4N1rZua3kKmp5Z9FTzzOnBDCkE6NkLQqo4SEXw8+hGJksLAPX+KPiTIYWYFcJ7aC
	 NPF5rVfWqZE6OIc3RPkBGBu5CGvszUuUXO+9b2gFLqXc+3J3h1lSPne2TIenVv8BPH
	 BhGnGacMV/GoI70AjaFFGfEWSKb3U7DqMgHV8L7lS8SLOZ7WSffFwUvy94mkdeCGPR
	 0yrZJ28u6aSN34J0ggfPqpKCgrNlu3cA3W008IMoUdJlKQ3f8tdajrnX4H1n0K2SKJ
	 BnX44JYZzOV+w==
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
Subject: [PATCH v5 03/15] nios2: define virtual address space for modules
Date: Mon, 22 Apr 2024 11:47:11 +0300
Message-ID: <20240422084717.3602332-3-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422084717.3602332-1-rppt@kernel.org>
References: <20240422084717.3602332-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

nios2 uses kmalloc() to implement module_alloc() because CALL26/PCREL26
cannot reach all of vmalloc address space.

Define module space as 32MiB below the kernel base and switch nios2 to
use vmalloc for module allocations.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/nios2/include/asm/pgtable.h |  5 ++++-
 arch/nios2/kernel/module.c       | 19 ++++---------------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
index d052dfcbe8d3..eab87c6beacb 100644
--- a/arch/nios2/include/asm/pgtable.h
+++ b/arch/nios2/include/asm/pgtable.h
@@ -25,7 +25,10 @@
 #include <asm-generic/pgtable-nopmd.h>
 
 #define VMALLOC_START		CONFIG_NIOS2_KERNEL_MMU_REGION_BASE
-#define VMALLOC_END		(CONFIG_NIOS2_KERNEL_REGION_BASE - 1)
+#define VMALLOC_END		(CONFIG_NIOS2_KERNEL_REGION_BASE - SZ_32M - 1)
+
+#define MODULES_VADDR		(CONFIG_NIOS2_KERNEL_REGION_BASE - SZ_32M)
+#define MODULES_END		(CONFIG_NIOS2_KERNEL_REGION_BASE - 1)
 
 struct mm_struct;
 
diff --git a/arch/nios2/kernel/module.c b/arch/nios2/kernel/module.c
index 76e0a42d6e36..9c97b7513853 100644
--- a/arch/nios2/kernel/module.c
+++ b/arch/nios2/kernel/module.c
@@ -21,23 +21,12 @@
 
 #include <asm/cacheflush.h>
 
-/*
- * Modules should NOT be allocated with kmalloc for (obvious) reasons.
- * But we do it for now to avoid relocation issues. CALL26/PCREL26 cannot reach
- * from 0x80000000 (vmalloc area) to 0xc00000000 (kernel) (kmalloc returns
- * addresses in 0xc0000000)
- */
 void *module_alloc(unsigned long size)
 {
-	if (size == 0)
-		return NULL;
-	return kmalloc(size, GFP_KERNEL);
-}
-
-/* Free memory returned from module_alloc */
-void module_memfree(void *module_region)
-{
-	kfree(module_region);
+	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
+				    GFP_KERNEL, PAGE_KERNEL_EXEC,
+				    VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
+				    __builtin_return_address(0));
 }
 
 int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
-- 
2.43.0


