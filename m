Return-Path: <linux-arch+bounces-8227-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2979A098E
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 14:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C901C23C3F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8ED208972;
	Wed, 16 Oct 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzTuwFXN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B25720821C;
	Wed, 16 Oct 2024 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081575; cv=none; b=VaJsBOck2tkx9cOvTnEgKsKvgAl9vQW1Wgoaw6zPFNSdHpWemm06Dmt8gFytp2Faj5UYCxC9JOG/1OSZ3luTxWxQyR0ptxM1qiehr4mGS2Gk9mZdcf9TfClpUS+siScYB7nBMMaIbbE6/WPIDZbaAKUvigNcbHWnDtM0tqEhEXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081575; c=relaxed/simple;
	bh=xT+C+UkXHo4ksxI6EkkdxgycTwZCmYts1G3brTXvzKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQ7qeVa++ismWsYkXUi8yi75rLXKHOYcKQfCYxHdYEE/tiOB+rAey7phSD54iNNWc7A4Bu3OIzBNkv7vCwmSHDiI6wmy1b/hX/9+3oV0GRaBU1JqFsTNNR6ZKjeNc5vCIKpZ0wtNqq79TibCM4pu0ctxCcyjz1gZC1yxhyNuO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzTuwFXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE8AC4CECF;
	Wed, 16 Oct 2024 12:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729081575;
	bh=xT+C+UkXHo4ksxI6EkkdxgycTwZCmYts1G3brTXvzKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hzTuwFXN3MOizhmxK2LJr8bxptrhqsSvItoln0stLiekCB9E3AQm5mrOjUFv12WnQ
	 gWmDRH8kwTw4ZxNRsb1SD3d2zdcdE4GO2BxoWOXy8K3oJvkLAZhUnk8cvRsioh0jj9
	 kAKDXlMhONinxnTyhfT2Eg+ggtsFtldjPiZ487zMHqQO4/15dIG+nKSrN55O06+fvW
	 5VSA8m/1E9YILnTcawvfokyFt5FrKRbPhjxYmJi7bCB54X1N/vMn+aXHBXohGa5rpJ
	 yV59lX35ZR36emuX3yvzhlrlIwfqXup4/ddTNAup5/3UswY6tUOIJ8SHqYfMfBwT31
	 KIGDxgFuHvDNw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 5/8] arch: introduce set_direct_map_valid_noflush()
Date: Wed, 16 Oct 2024 15:24:21 +0300
Message-ID: <20241016122424.1655560-6-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016122424.1655560-1-rppt@kernel.org>
References: <20241016122424.1655560-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Add an API that will allow updates of the direct/linear map for a set of
physically contiguous pages.

It will be used in the following patches.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/set_memory.h     |  1 +
 arch/arm64/mm/pageattr.c                | 10 ++++++++++
 arch/loongarch/include/asm/set_memory.h |  1 +
 arch/loongarch/mm/pageattr.c            | 19 +++++++++++++++++++
 arch/riscv/include/asm/set_memory.h     |  1 +
 arch/riscv/mm/pageattr.c                | 15 +++++++++++++++
 arch/s390/include/asm/set_memory.h      |  1 +
 arch/s390/mm/pageattr.c                 | 11 +++++++++++
 arch/x86/include/asm/set_memory.h       |  1 +
 arch/x86/mm/pat/set_memory.c            |  8 ++++++++
 include/linux/set_memory.h              |  6 ++++++
 11 files changed, 74 insertions(+)

diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
index 917761feeffd..98088c043606 100644
--- a/arch/arm64/include/asm/set_memory.h
+++ b/arch/arm64/include/asm/set_memory.h
@@ -13,6 +13,7 @@ int set_memory_valid(unsigned long addr, int numpages, int enable);
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
 #endif /* _ASM_ARM64_SET_MEMORY_H */
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 0e270a1c51e6..01225900293a 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -192,6 +192,16 @@ int set_direct_map_default_noflush(struct page *page)
 				   PAGE_SIZE, change_page_range, &data);
 }
 
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+
+	if (!can_set_direct_map())
+		return 0;
+
+	return set_memory_valid(addr, nr, valid);
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
diff --git a/arch/loongarch/include/asm/set_memory.h b/arch/loongarch/include/asm/set_memory.h
index d70505b6676c..55dfaefd02c8 100644
--- a/arch/loongarch/include/asm/set_memory.h
+++ b/arch/loongarch/include/asm/set_memory.h
@@ -17,5 +17,6 @@ int set_memory_rw(unsigned long addr, int numpages);
 bool kernel_page_present(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
 int set_direct_map_invalid_noflush(struct page *page);
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 
 #endif /* _ASM_LOONGARCH_SET_MEMORY_H */
diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
index ffd8d76021d4..bf8678248444 100644
--- a/arch/loongarch/mm/pageattr.c
+++ b/arch/loongarch/mm/pageattr.c
@@ -216,3 +216,22 @@ int set_direct_map_invalid_noflush(struct page *page)
 
 	return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
 }
+
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	pgprot_t set, clear;
+
+	if (addr < vm_map_base)
+		return 0;
+
+	if (valid) {
+		set = PAGE_KERNEL;
+		clear = __pgprot(0);
+	} else {
+		set = __pgprot(0);
+		clear = __pgprot(_PAGE_PRESENT | _PAGE_VALID);
+	}
+
+	return __set_memory(addr, 1, set, clear);
+}
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index ab92fc84e1fc..ea263d3683ef 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -42,6 +42,7 @@ static inline int set_kernel_memory(char *startp, char *endp,
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 271d01a5ba4d..d815448758a1 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -386,6 +386,21 @@ int set_direct_map_default_noflush(struct page *page)
 			    PAGE_KERNEL, __pgprot(_PAGE_EXEC));
 }
 
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
+{
+	pgprot_t set, clear;
+
+	if (valid) {
+		set = PAGE_KERNEL;
+		clear = __pgprot(_PAGE_EXEC);
+	} else {
+		set = __pgprot(0);
+		clear = __pgprot(_PAGE_PRESENT);
+	}
+
+	return __set_memory((unsigned long)page_address(page), nr, set, clear);
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static int debug_pagealloc_set_page(pte_t *pte, unsigned long addr, void *data)
 {
diff --git a/arch/s390/include/asm/set_memory.h b/arch/s390/include/asm/set_memory.h
index 06fbabe2f66c..240bcfbdcdce 100644
--- a/arch/s390/include/asm/set_memory.h
+++ b/arch/s390/include/asm/set_memory.h
@@ -62,5 +62,6 @@ __SET_MEMORY_FUNC(set_memory_4k, SET_MEMORY_4K)
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 
 #endif
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 5f805ad42d4c..4c7ee74aa130 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -406,6 +406,17 @@ int set_direct_map_default_noflush(struct page *page)
 	return __set_memory((unsigned long)page_to_virt(page), 1, SET_MEMORY_DEF);
 }
 
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
+{
+	unsigned long flags;
+
+	if (valid)
+		flags = SET_MEMORY_DEF;
+	else
+		flags = SET_MEMORY_INV;
+
+	return __set_memory((unsigned long)page_to_virt(page), nr, flags);
+}
 #if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
 
 static void ipte_range(pte_t *pte, unsigned long address, int nr)
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 4b2abce2e3e7..cc62ef70ccc0 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -89,6 +89,7 @@ int set_pages_rw(struct page *page, int numpages);
 
 int set_direct_map_invalid_noflush(struct page *page);
 int set_direct_map_default_noflush(struct page *page);
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid);
 bool kernel_page_present(struct page *page);
 
 extern int kernel_set_to_readonly;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 44f7b2ea6a07..069e421c2247 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2444,6 +2444,14 @@ int set_direct_map_default_noflush(struct page *page)
 	return __set_pages_p(page, 1);
 }
 
+int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
+{
+	if (valid)
+		return __set_pages_p(page, nr);
+
+	return __set_pages_np(page, nr);
+}
+
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)
 {
diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
index e7aec20fb44f..3030d9245f5a 100644
--- a/include/linux/set_memory.h
+++ b/include/linux/set_memory.h
@@ -34,6 +34,12 @@ static inline int set_direct_map_default_noflush(struct page *page)
 	return 0;
 }
 
+static inline int set_direct_map_valid_noflush(struct page *page,
+					       unsigned nr, bool valid)
+{
+	return 0;
+}
+
 static inline bool kernel_page_present(struct page *page)
 {
 	return true;
-- 
2.43.0


