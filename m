Return-Path: <linux-arch+bounces-3877-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F918AC99E
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 11:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4995A1C20B6F
	for <lists+linux-arch@lfdr.de>; Mon, 22 Apr 2024 09:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF7813D8BC;
	Mon, 22 Apr 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qf2hni4y"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228F913C9A2;
	Mon, 22 Apr 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779215; cv=none; b=niNzOsxDtt+2p7Ls3lFyGmXM6MhDI0aqp+AGSSxcMTol380p9a3AhjemJlo1N6rkWl6RKx+hPVWji0Z3FyVgEZxn/blqkYeUmPm4vCVgs0HJTDuuoVus4WW8WSsiply9zlB+NoGDUIdwzRn6+YTSOe0vUWjmPv1GcrvsxJxzaKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779215; c=relaxed/simple;
	bh=QWGTfmxM6u4L/G8sJRSYS9LtFcq3UHArwE9pGA7ZHH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvE0Aj1DKSLJKEqM7MRkPdzj1R860rWIb003FIXxaH/LjgXFa16L+vsIousXip6/wi5pHFaE82vF7kAp2vlEcKH7RQHHjY17H6h+qIkI3Lwb9N1BI4QqZm5M4NosSif2rJMfkfHEiNY/uB/6FeeILx+4gaHGQVCDK5F/62vLZ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qf2hni4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40EAC113CC;
	Mon, 22 Apr 2024 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713779215;
	bh=QWGTfmxM6u4L/G8sJRSYS9LtFcq3UHArwE9pGA7ZHH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qf2hni4yU29ZmfimX5Cthr6CT3r7qdoQ7j5VBIxbVBQyvb9mCZ4CBagbjVGA5QCXy
	 drdysa/61Vf21EY8h6kOpDDExnGMALPyCkYtnoLux9i3IFh/BF4WoAv3oQFZJv1+ps
	 2OGjzZqUQiBD2VeZc8eDhrfIta3TxXUsfB1i7t6nj3JTuZNc+1pTkCGyZsBH21rz5D
	 2va/X1F3NvU4RuGx3srP5xXEnrggRK2ya2WdyPUJlsD8ttZ1wcPpIEwJl7KLfSPRt7
	 7PJxaKVzGH/rZKJ5ki0jECLWbefv/dYFhAE99e1HFD/ERBzi5uCuc7+O1NnLtafK2i
	 hp7aF4xoRcz6g==
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
Subject: [PATCH v5 10/15] powerpc: extend execmem_params for kprobes allocations
Date: Mon, 22 Apr 2024 12:44:31 +0300
Message-ID: <20240422094436.3625171-11-rppt@kernel.org>
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

powerpc overrides kprobes::alloc_insn_page() to remove writable
permissions when STRICT_MODULE_RWX is on.

Add definition of EXECMEM_KRPOBES to execmem_params to allow using the
generic kprobes::alloc_insn_page() with the desired permissions.

As powerpc uses breakpoint instructions to inject kprobes, it does not
need to constrain kprobe allocations to the modules area and can use the
entire vmalloc address space.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/powerpc/kernel/kprobes.c | 20 --------------------
 arch/powerpc/kernel/module.c  |  7 +++++++
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 9fcd01bb2ce6..14c5ddec3056 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -126,26 +126,6 @@ kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offse
 	return (kprobe_opcode_t *)(addr + offset);
 }
 
-void *alloc_insn_page(void)
-{
-	void *page;
-
-	page = execmem_alloc(EXECMEM_KPROBES, PAGE_SIZE);
-	if (!page)
-		return NULL;
-
-	if (strict_module_rwx_enabled()) {
-		int err = set_memory_rox((unsigned long)page, 1);
-
-		if (err)
-			goto error;
-	}
-	return page;
-error:
-	execmem_free(page);
-	return NULL;
-}
-
 int arch_prepare_kprobe(struct kprobe *p)
 {
 	int ret = 0;
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index ac80559015a3..2a23cf7e141b 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -94,6 +94,7 @@ static struct execmem_info execmem_info __ro_after_init;
 
 struct execmem_info __init *execmem_arch_setup(void)
 {
+	pgprot_t kprobes_prot = strict_module_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
 	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
 	unsigned long fallback_start = 0, fallback_end = 0;
 	unsigned long start, end;
@@ -132,6 +133,12 @@ struct execmem_info __init *execmem_arch_setup(void)
 				.fallback_start	= fallback_start,
 				.fallback_end	= fallback_end,
 			},
+			[EXECMEM_KPROBES] = {
+				.start	= VMALLOC_START,
+				.end	= VMALLOC_END,
+				.pgprot	= kprobes_prot,
+				.alignment = 1,
+			},
 			[EXECMEM_MODULE_DATA] = {
 				.start	= VMALLOC_START,
 				.end	= VMALLOC_END,
-- 
2.43.0


