Return-Path: <linux-arch+bounces-4039-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E008B57CC
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2024 14:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1EAF1F220CB
	for <lists+linux-arch@lfdr.de>; Mon, 29 Apr 2024 12:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D744EB42;
	Mon, 29 Apr 2024 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFlLUXKO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563B1B94D;
	Mon, 29 Apr 2024 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393034; cv=none; b=AKw/WMj7xN3oSPvLIgCXwIHu6RUVQZ7jhvODjZTKgSGw1oR8Ikt+fQfDusdZRBEHhpf+XCIt2xj5/to0bNmrkbzHF0d5SYVnFbcj7MMRmZeMG2StlZBxe3sILXwm2xH2UdMF3CNKgLc3wzlhJTT9IqTPS77pxNlyDuhtKemS1nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393034; c=relaxed/simple;
	bh=Q5aCDGAMhe9LWjmBOe0KfqvsLthVcLCeaQ3ItO7ykso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q28ufLTB66owcy58DuNLoyVEvANzTYMhm19RFlUdzDA8v0Ny3uKa3uvhmG0jF9u9PlifXrR/hmhYY7pEZMeRNkGCkiCVh6tJlr9QAxHT63fyuiSYqmpyjZfvdJFRHQr0hND3FUeJ+YRi8i5DKrh9TqvWwrW6q18cAB7xY/d5tx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFlLUXKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE43C4AF1C;
	Mon, 29 Apr 2024 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714393033;
	bh=Q5aCDGAMhe9LWjmBOe0KfqvsLthVcLCeaQ3ItO7ykso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFlLUXKOGW1bA9nT5em+gyu9NCPRcUND9+V0H60SUspwoRFLXFQitEQVYTPWgn1M9
	 z4gEdgmIOodHo5MssVhusRrGON/21XKdAobI8Xl76jIzIjGZ2nuBUJfu7xJYYKxN6v
	 mqSCyhRtiPek7zSthB0V2kCkon2yq5wwYoKlvUuJyYdHWXbatxvOoIjhTRzCeWYglH
	 QCcr2CU57MgnBVNzvmHRWGSC1sILdAjbcoinGJRtM59eQsergOHEcZKSSzUxlIdf1P
	 viEhJNzAUN7etXMkoohraK1IxkhWxZdNrHYfsyJuMrZF0sTHEDTRg7teof836jRKrJ
	 VY3god5uR3bLQ==
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
Subject: [PATCH v7 03/16] nios2: define virtual address space for modules
Date: Mon, 29 Apr 2024 15:16:07 +0300
Message-ID: <20240429121620.1186447-4-rppt@kernel.org>
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


