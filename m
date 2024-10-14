Return-Path: <linux-arch+bounces-8072-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7803999C7DA
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 12:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAB08B23E64
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 10:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADED119B3FF;
	Mon, 14 Oct 2024 10:59:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13262198827;
	Mon, 14 Oct 2024 10:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903574; cv=none; b=jCCv3IPKzV5z6t2FHl6OJTzbOPLJQG2ZtAI7OjciaTx7Q+OPAWAzKRV32oKdFWppxBuf7rqxDoQJo+FxOUNQYYBV5HlXqCmChXvNW+hjQcJVI2WD5OA1Zoj8lCERQVkiT9OYMCmcHiIAW+yYVxQI+oF1FohcihhS6ZzZy0tYLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903574; c=relaxed/simple;
	bh=3DkgtkFIP3BhugDVvT+2CAxdbZG/PGV3YvMZrCTMKHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7a818ATRQXQdGymZmpEfVkrtrEdkCQY7PKZTEtfTvb7AqMKcf6UzcIilW5w+5okvOKOyKoEf/caowtCl7w2yMLXBjVAWGoV5ng/TldaOwmpxaE0iciXtmd+SL8Q4FZl4mB2MB/1VaNTakRJNdVuCd71FMk2WegFdgFMlg8XYZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 443921684;
	Mon, 14 Oct 2024 04:00:02 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E5CD3F51B;
	Mon, 14 Oct 2024 03:59:29 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Lameter <cl@linux.com>,
	David Hildenbrand <david@redhat.com>,
	Dennis Zhou <dennis@kernel.org>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Tejun Heo <tj@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 02/57] vmlinux: Align to PAGE_SIZE_MAX
Date: Mon, 14 Oct 2024 11:58:09 +0100
Message-ID: <20241014105912.3207374-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase alignment of structures requiring at least PAGE_SIZE alignment
to PAGE_SIZE_MAX. For compile-time PAGE_SIZE, PAGE_SIZE_MAX == PAGE_SIZE
so there is no change. For boot-time PAGE_SIZE, PAGE_SIZE_MAX is the
largest selectable page size.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 include/asm-generic/vmlinux.lds.h | 32 +++++++++++++++----------------
 include/linux/linkage.h           |  4 ++--
 include/linux/percpu-defs.h       |  4 ++--
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1ae44793132a8..5727f883001bb 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -13,7 +13,7 @@
  *	. = START;
  *	__init_begin = .;
  *	HEAD_TEXT_SECTION
- *	INIT_TEXT_SECTION(PAGE_SIZE)
+ *	INIT_TEXT_SECTION(PAGE_SIZE_MAX)
  *	INIT_DATA_SECTION(...)
  *	PERCPU_SECTION(CACHELINE_SIZE)
  *	__init_end = .;
@@ -23,7 +23,7 @@
  *	_etext = .;
  *
  *      _sdata = .;
- *	RO_DATA(PAGE_SIZE)
+ *	RO_DATA(PAGE_SIZE_MAX)
  *	RW_DATA(...)
  *	_edata = .;
  *
@@ -371,10 +371,10 @@
  * Data section helpers
  */
 #define NOSAVE_DATA							\
-	. = ALIGN(PAGE_SIZE);						\
+	. = ALIGN(PAGE_SIZE_MAX);					\
 	__nosave_begin = .;						\
 	*(.data..nosave)						\
-	. = ALIGN(PAGE_SIZE);						\
+	. = ALIGN(PAGE_SIZE_MAX);					\
 	__nosave_end = .;
 
 #define PAGE_ALIGNED_DATA(page_align)					\
@@ -733,9 +733,9 @@
 	. = ALIGN(bss_align);						\
 	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {				\
 		BSS_FIRST_SECTIONS					\
-		. = ALIGN(PAGE_SIZE);					\
+		. = ALIGN(PAGE_SIZE_MAX);				\
 		*(.bss..page_aligned)					\
-		. = ALIGN(PAGE_SIZE);					\
+		. = ALIGN(PAGE_SIZE_MAX);				\
 		*(.dynbss)						\
 		*(BSS_MAIN)						\
 		*(COMMON)						\
@@ -950,9 +950,9 @@
  */
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 #define PERCPU_DECRYPTED_SECTION					\
-	. = ALIGN(PAGE_SIZE);						\
+	. = ALIGN(PAGE_SIZE_MAX);					\
 	*(.data..percpu..decrypted)					\
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(PAGE_SIZE_MAX);
 #else
 #define PERCPU_DECRYPTED_SECTION
 #endif
@@ -1030,7 +1030,7 @@
 #define PERCPU_INPUT(cacheline)						\
 	__per_cpu_start = .;						\
 	*(.data..percpu..first)						\
-	. = ALIGN(PAGE_SIZE);						\
+	. = ALIGN(PAGE_SIZE_MAX);					\
 	*(.data..percpu..page_aligned)					\
 	. = ALIGN(cacheline);						\
 	*(.data..percpu..read_mostly)					\
@@ -1075,16 +1075,16 @@
  * PERCPU_SECTION - define output section for percpu area, simple version
  * @cacheline: cacheline size
  *
- * Align to PAGE_SIZE and outputs output section for percpu area.  This
+ * Align to PAGE_SIZE_MAX and outputs output section for percpu area.  This
  * macro doesn't manipulate @vaddr or @phdr and __per_cpu_load and
  * __per_cpu_start will be identical.
  *
- * This macro is equivalent to ALIGN(PAGE_SIZE); PERCPU_VADDR(@cacheline,,)
+ * This macro is equivalent to ALIGN(PAGE_SIZE_MAX); PERCPU_VADDR(@cacheline,,)
  * except that __per_cpu_load is defined as a relative symbol against
  * .data..percpu which is required for relocatable x86_32 configuration.
  */
 #define PERCPU_SECTION(cacheline)					\
-	. = ALIGN(PAGE_SIZE);						\
+	. = ALIGN(PAGE_SIZE_MAX);					\
 	.data..percpu	: AT(ADDR(.data..percpu) - LOAD_OFFSET) {	\
 		__per_cpu_load = .;					\
 		PERCPU_INPUT(cacheline)					\
@@ -1102,15 +1102,15 @@
  * All sections are combined in a single .data section.
  * The sections following CONSTRUCTORS are arranged so their
  * typical alignment matches.
- * A cacheline is typical/always less than a PAGE_SIZE so
+ * A cacheline is typical/always less than a PAGE_SIZE_MAX so
  * the sections that has this restriction (or similar)
- * is located before the ones requiring PAGE_SIZE alignment.
- * NOSAVE_DATA starts and ends with a PAGE_SIZE alignment which
+ * is located before the ones requiring PAGE_SIZE_MAX alignment.
+ * NOSAVE_DATA starts and ends with a PAGE_SIZE_MAX alignment which
  * matches the requirement of PAGE_ALIGNED_DATA.
  *
  * use 0 as page_align if page_aligned data is not used */
 #define RW_DATA(cacheline, pagealigned, inittask)			\
-	. = ALIGN(PAGE_SIZE);						\
+	. = ALIGN(PAGE_SIZE_MAX);					\
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {				\
 		INIT_TASK_DATA(inittask)				\
 		NOSAVE_DATA						\
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 5c8865bb59d91..68aa9775fce51 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -36,8 +36,8 @@
 		  __stringify(name))
 #endif
 
-#define __page_aligned_data	__section(".data..page_aligned") __aligned(PAGE_SIZE)
-#define __page_aligned_bss	__section(".bss..page_aligned") __aligned(PAGE_SIZE)
+#define __page_aligned_data	__section(".data..page_aligned") __aligned(PAGE_SIZE_MAX)
+#define __page_aligned_bss	__section(".bss..page_aligned") __aligned(PAGE_SIZE_MAX)
 
 /*
  * For assembly routines.
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 8efce7414fad6..89c7f430015ba 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -156,11 +156,11 @@
  */
 #define DECLARE_PER_CPU_PAGE_ALIGNED(type, name)			\
 	DECLARE_PER_CPU_SECTION(type, name, "..page_aligned")		\
-	__aligned(PAGE_SIZE)
+	__aligned(PAGE_SIZE_MAX)
 
 #define DEFINE_PER_CPU_PAGE_ALIGNED(type, name)				\
 	DEFINE_PER_CPU_SECTION(type, name, "..page_aligned")		\
-	__aligned(PAGE_SIZE)
+	__aligned(PAGE_SIZE_MAX)
 
 /*
  * Declaration/definition used for per-CPU variables that must be read mostly.
-- 
2.43.0


