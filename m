Return-Path: <linux-arch+bounces-4198-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2518E8BC1E4
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 18:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36AB4B21335
	for <lists+linux-arch@lfdr.de>; Sun,  5 May 2024 16:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCAD3C460;
	Sun,  5 May 2024 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnzdUSuF"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBAC37707;
	Sun,  5 May 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714925256; cv=none; b=EHV4x3dAY7CrzdXZh6UMtvGpoPcTyFT0J/6BNh5w1lLaouDOeIfWwm2LR++GGnqViNT9OqzBfA8ED4fEWXpOztveF+KYCTmo/Df4JNbBE8YHVrZF05ouj9Nv07tUVOm/Kjt3mQ0PZrGP4WWzJ9op+4nYbCf09c9f7t7NBmgSbxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714925256; c=relaxed/simple;
	bh=S2WO9rrdnIu5PceUjVXVwYLrUCttkXy1oVefr4+OvH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzqJ6//sTi+rdXCKzC0UzWVVbtqWxptL7goidwZWa5wKc8IA/9JIeVcn5a2P3wwA09pELUpI62q+zFtPv3vFiLBflrDbHBLXuNXWWfgFzvCnhZNjduzIlhvX3ig+uhIbj3fEmawMfejklDF3fV768A/D0yBEl4jPsWjcGeALOoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnzdUSuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556B2C4DDE6;
	Sun,  5 May 2024 16:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714925255;
	bh=S2WO9rrdnIu5PceUjVXVwYLrUCttkXy1oVefr4+OvH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mnzdUSuFwZFr/+Ip2l7zLEpPo7HXw0QyaxcHIUqM8tYDbmvTYVi7whZRj6QYhAI5c
	 u+OLcnSpi7V7V0jzzVPB9rWa+rJA3dD3nlH+8wp77vvEuH9IEFWLpzyrsWjJPj/jKs
	 BDJmr/0582lWHgGlperk2Rs+BsENvYpmK5JvRFZoFvCPINOMHITRzkh8LcMznIdb8y
	 hOOVaEDM0UZeQGuU9MlrUVaRg389IJ8S7gihJymsFxUbKAYtkt7Avfm7rb5zhV1CaN
	 R6G5Pk6nhS/74iVs2XgCvdWj3a1mXB9GimpVhAzA7uDys6bqCeiKfazaVLcWk7io+d
	 ZIn5pR9SP9ZcA==
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
Subject: [PATCH RESEND v8 04/16] sparc: simplify module_alloc()
Date: Sun,  5 May 2024 19:06:16 +0300
Message-ID: <20240505160628.2323363-5-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240505160628.2323363-1-rppt@kernel.org>
References: <20240505160628.2323363-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Define MODULES_VADDR and MODULES_END as VMALLOC_START and VMALLOC_END
for 32-bit and reduce module_alloc() to

	__vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END, ...)

as with the new defines the allocations becomes identical for both 32
and 64 bits.

While on it, drop unused include of <linux/jump_label.h>

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/pgtable_32.h |  2 ++
 arch/sparc/kernel/module.c          | 25 +------------------------
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 9e85d57ac3f2..62bcafe38b1f 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -432,6 +432,8 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 
 #define VMALLOC_START           _AC(0xfe600000,UL)
 #define VMALLOC_END             _AC(0xffc00000,UL)
+#define MODULES_VADDR           VMALLOC_START
+#define MODULES_END             VMALLOC_END
 
 /* We provide our own get_unmapped_area to cope with VA holes for userland */
 #define HAVE_ARCH_UNMAPPED_AREA
diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
index 66c45a2764bc..d37adb2a0b54 100644
--- a/arch/sparc/kernel/module.c
+++ b/arch/sparc/kernel/module.c
@@ -21,35 +21,12 @@
 
 #include "entry.h"
 
-#ifdef CONFIG_SPARC64
-
-#include <linux/jump_label.h>
-
-static void *module_map(unsigned long size)
+void *module_alloc(unsigned long size)
 {
-	if (PAGE_ALIGN(size) > MODULES_LEN)
-		return NULL;
 	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
 				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
 				__builtin_return_address(0));
 }
-#else
-static void *module_map(unsigned long size)
-{
-	return vmalloc(size);
-}
-#endif /* CONFIG_SPARC64 */
-
-void *module_alloc(unsigned long size)
-{
-	void *ret;
-
-	ret = module_map(size);
-	if (ret)
-		memset(ret, 0, size);
-
-	return ret;
-}
 
 /* Make generic code ignore STT_REGISTER dummy undefined symbols.  */
 int module_frob_arch_sections(Elf_Ehdr *hdr,
-- 
2.43.0


