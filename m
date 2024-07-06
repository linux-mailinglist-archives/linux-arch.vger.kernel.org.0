Return-Path: <linux-arch+bounces-5290-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FC49294AF
	for <lists+linux-arch@lfdr.de>; Sat,  6 Jul 2024 18:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316CB1F22E38
	for <lists+linux-arch@lfdr.de>; Sat,  6 Jul 2024 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A2013B7A3;
	Sat,  6 Jul 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uc35fHa9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5390213B588;
	Sat,  6 Jul 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720281919; cv=none; b=cxBC0Qyp7Z2LdazedndX3DTpeIJqXRvg2ejUPIyV5/USIiQ8RE/rS+z6CMzrrVy+ut6XSuATbvU0KHXDpvjs2UYwoz4lFGv0zf3q8qLmfBkOrF6DwuDqSwgG2IOHdAkMAWvsuM4ej2V8tm3AdHviOabr4kgXJce1wlN3hV/Qz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720281919; c=relaxed/simple;
	bh=pZ0dtsocLozbLF2xzm6/rZVG0e7mWE2G+9WaGMTT4Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlrDTbwx96GKcL0sHgxTXRY9iIgl5+E1VtFDcgBzF0v0aNSuuhDtdiVaganrkSQg/kxg583MChL7J8nkF42i6nbR4JM+LhMwe03X0XabXNP3wMjLX5FSni+Id4/9IdprgxplTtrTw9U32JNbhQdeoQYg96D3IIzA16bwCT1DDwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uc35fHa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC13C4AF0A;
	Sat,  6 Jul 2024 16:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720281918;
	bh=pZ0dtsocLozbLF2xzm6/rZVG0e7mWE2G+9WaGMTT4Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uc35fHa9MraPHnl7RUcaL2X0ooLCoWfWC5h3xyBvDVNMU8NqoWMRr11T/LV5C49rH
	 XA7/VLLeC8Q4LURBlKpCHatbFsso+5wH3budAKDm12Zllg+2LizI7+4wy05kXMDaB8
	 8DTvVWlkTDf1JWOqgr4smubsbY4pcs4rhs5WnW6hEa0xGLp+vMtRHjoRe3zX2Zvr1Q
	 irLkVVshlEc3RiK6ucIlSych+JwCWxd3QZtHEXSua5+8eaMzbX98Yfwe55vumthQAY
	 ACCCqjiIpruXoTS08yUZfFhpQntyrPR5YAj5ETuhDm4Gn4ShMIbbBsXGjDrU+BXQvj
	 vThlnb6Zn/QDQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-arch@vger.kernel.org
Subject: [PATCH 2/2] init/modpost: conditionally check section mismatch to __meminit*
Date: Sun,  7 Jul 2024 01:05:06 +0900
Message-ID: <20240706160511.2331061-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240706160511.2331061-1-masahiroy@kernel.org>
References: <20240706160511.2331061-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit eb8f689046b8 ("Use separate sections for __dev/
_cpu/__mem code/data").

Check section mismatch to __meminit* only when CONFIG_MEMORY_HOTPLUG=y.

With this change, the linker script and modpost become simpler, and we
can get rid of the __ref annotations from the memory hotplug code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/asm-generic/vmlinux.lds.h | 18 ++----------------
 include/linux/init.h              | 14 +++++++++-----
 scripts/mod/modpost.c             | 19 ++++---------------
 3 files changed, 15 insertions(+), 36 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 62b4cb0462e6..c23f7d0645ad 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -141,14 +141,6 @@
  * often happens at runtime)
  */
 
-#if defined(CONFIG_MEMORY_HOTPLUG)
-#define MEM_KEEP(sec)    *(.mem##sec)
-#define MEM_DISCARD(sec)
-#else
-#define MEM_KEEP(sec)
-#define MEM_DISCARD(sec) *(.mem##sec)
-#endif
-
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 #define KEEP_PATCHABLE		KEEP(*(__patchable_function_entries))
 #define PATCHABLE_DISCARDS
@@ -357,7 +349,6 @@
 	*(.data..decrypted)						\
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
-	MEM_KEEP(init.data*)						\
 	*(.data.unlikely)						\
 	__start_once = .;						\
 	*(.data.once)							\
@@ -523,7 +514,6 @@
 	/* __*init sections */						\
 	__init_rodata : AT(ADDR(__init_rodata) - LOAD_OFFSET) {		\
 		*(.ref.rodata)						\
-		MEM_KEEP(init.rodata)					\
 	}								\
 									\
 	/* Built-in module parameters. */				\
@@ -574,8 +564,7 @@
 		*(.text.unknown .text.unknown.*)			\
 		NOINSTR_TEXT						\
 		*(.ref.text)						\
-		*(.text.asan.* .text.tsan.*)				\
-	MEM_KEEP(init.text*)						\
+		*(.text.asan.* .text.tsan.*)
 
 
 /* sched.text is aling to function alignment to secure we have same
@@ -682,7 +671,6 @@
 #define INIT_DATA							\
 	KEEP(*(SORT(___kentry+*)))					\
 	*(.init.data .init.data.*)					\
-	MEM_DISCARD(init.data*)						\
 	KERNEL_CTORS()							\
 	MCOUNT_REC()							\
 	*(.init.rodata .init.rodata.*)					\
@@ -690,7 +678,6 @@
 	TRACE_SYSCALLS()						\
 	KPROBE_BLACKLIST()						\
 	ERROR_INJECT_WHITELIST()					\
-	MEM_DISCARD(init.rodata)					\
 	CLK_OF_TABLES()							\
 	RESERVEDMEM_OF_TABLES()						\
 	TIMER_OF_TABLES()						\
@@ -708,8 +695,7 @@
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
-	*(.text.startup)						\
-	MEM_DISCARD(init.text*)
+	*(.text.startup)
 
 #define EXIT_DATA							\
 	*(.exit.data .exit.data.*)					\
diff --git a/include/linux/init.h b/include/linux/init.h
index b2e9dfff8691..ee1309473bc6 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -84,11 +84,15 @@
 
 #define __exit          __section(".exit.text") __exitused __cold notrace
 
-/* Used for MEMORY_HOTPLUG */
-#define __meminit        __section(".meminit.text") __cold notrace \
-						  __latent_entropy
-#define __meminitdata    __section(".meminit.data")
-#define __meminitconst   __section(".meminit.rodata")
+#ifdef CONFIG_MEMORY_HOTPLUG
+#define __meminit
+#define __meminitdata
+#define __meminitconst
+#else
+#define __meminit	__init
+#define __meminitdata	__initdata
+#define __meminitconst	__initconst
+#endif
 
 /* For assembly routines */
 #define __HEAD		.section	".head.text","ax"
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 3e5313ed6065..8c8ad7485f73 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -776,17 +776,14 @@ static void check_section(const char *modname, struct elf_info *elf,
 
 
 #define ALL_INIT_DATA_SECTIONS \
-	".init.setup", ".init.rodata", ".meminit.rodata", \
-	".init.data", ".meminit.data"
+	".init.setup", ".init.rodata", ".init.data"
 
 #define ALL_PCI_INIT_SECTIONS	\
 	".pci_fixup_early", ".pci_fixup_header", ".pci_fixup_final", \
 	".pci_fixup_enable", ".pci_fixup_resume", \
 	".pci_fixup_resume_early", ".pci_fixup_suspend"
 
-#define ALL_XXXINIT_SECTIONS ".meminit.*"
-
-#define ALL_INIT_SECTIONS INIT_SECTIONS, ALL_XXXINIT_SECTIONS
+#define ALL_INIT_SECTIONS ".init.*"
 #define ALL_EXIT_SECTIONS ".exit.*"
 
 #define DATA_SECTIONS ".data", ".data.rel"
@@ -797,9 +794,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 		".fixup", ".entry.text", ".exception.text", \
 		".coldtext", ".softirqentry.text"
 
-#define INIT_SECTIONS      ".init.*"
-
-#define ALL_TEXT_SECTIONS  ".init.text", ".meminit.text", ".exit.text", \
+#define ALL_TEXT_SECTIONS  ".init.text", ".exit.text", \
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
 
 enum mismatch {
@@ -839,12 +834,6 @@ static const struct sectioncheck sectioncheck[] = {
 	.bad_tosec = { ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS, NULL },
 	.mismatch = TEXTDATA_TO_ANY_INIT_EXIT,
 },
-/* Do not reference init code/data from meminit code/data */
-{
-	.fromsec = { ALL_XXXINIT_SECTIONS, NULL },
-	.bad_tosec = { INIT_SECTIONS, NULL },
-	.mismatch = XXXINIT_TO_SOME_INIT,
-},
 /* Do not use exit code/data from init code */
 {
 	.fromsec = { ALL_INIT_SECTIONS, NULL },
@@ -859,7 +848,7 @@ static const struct sectioncheck sectioncheck[] = {
 },
 {
 	.fromsec = { ALL_PCI_INIT_SECTIONS, NULL },
-	.bad_tosec = { INIT_SECTIONS, NULL },
+	.bad_tosec = { ALL_INIT_SECTIONS, NULL },
 	.mismatch = ANY_INIT_TO_ANY_EXIT,
 },
 {
-- 
2.43.0


