Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFEA7D24BE
	for <lists+linux-arch@lfdr.de>; Sun, 22 Oct 2023 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjJVRGW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 22 Oct 2023 13:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjJVRGV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 22 Oct 2023 13:06:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2120FB;
        Sun, 22 Oct 2023 10:06:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E73C433C9;
        Sun, 22 Oct 2023 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697994379;
        bh=klj6Dt1O3IFnuEbVBaMKnEH5PHbcOOc8u9BRgE9Xcvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hyw36vLefLqO0h3tmBg7UjEL82jIdgaEdY5OErb/6CXJJExzrMvD4wUDCUixHNPwz
         olKshjs26T7uvDiORT8cgyKRqKgBCQdjG3CswB3qiOl0/AERGoYRwo35biBXbH+wqD
         GB0Cw0OGIaW9uCz5IaDLwbMf1LJHUXob4BuG+J2+97fcX0v7xt2DDoxBGLJopQN8Rs
         +pnG2Hn9juUA7/BUAEk7rt7jg/+/hHUWuX/cm2EeEjTHJv2ivMjEszJRmvWu9CrDfh
         HhFPdz0qa41rrFsEYDmaOTDc6pD/E+ESaYsUe17WKo89jX93o+ND4Ylmh4A6mHz3IW
         HuPLsUXuBsteA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org
Subject: [PATCH 02/10] linux/init: remove __memexit* annotations
Date:   Mon, 23 Oct 2023 02:06:05 +0900
Message-Id: <20231022170613.2072838-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231022170613.2072838-1-masahiroy@kernel.org>
References: <20231022170613.2072838-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We have never used __memexit, __memexitdata, or __memexitconst.

These were unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/asm-generic/vmlinux.lds.h |  6 ------
 include/linux/init.h              |  3 ---
 scripts/mod/modpost.c             | 15 +++------------
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 67d8dd2f1bde..bae0fe4d499b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -356,7 +356,6 @@
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
 	MEM_KEEP(init.data*)						\
-	MEM_KEEP(exit.data*)						\
 	*(.data.unlikely)						\
 	__start_once = .;						\
 	*(.data.once)							\
@@ -521,7 +520,6 @@
 	__init_rodata : AT(ADDR(__init_rodata) - LOAD_OFFSET) {		\
 		*(.ref.rodata)						\
 		MEM_KEEP(init.rodata)					\
-		MEM_KEEP(exit.rodata)					\
 	}								\
 									\
 	/* Built-in module parameters. */				\
@@ -574,7 +572,6 @@
 		*(.ref.text)						\
 		*(.text.asan.* .text.tsan.*)				\
 	MEM_KEEP(init.text*)						\
-	MEM_KEEP(exit.text*)						\
 
 
 /* sched.text is aling to function alignment to secure we have same
@@ -714,13 +711,10 @@
 	*(.exit.data .exit.data.*)					\
 	*(.fini_array .fini_array.*)					\
 	*(.dtors .dtors.*)						\
-	MEM_DISCARD(exit.data*)						\
-	MEM_DISCARD(exit.rodata*)
 
 #define EXIT_TEXT							\
 	*(.exit.text)							\
 	*(.text.exit)							\
-	MEM_DISCARD(exit.text)
 
 #define EXIT_CALL							\
 	*(.exitcall.exit)
diff --git a/include/linux/init.h b/include/linux/init.h
index 266c3e1640d4..01b52c9c7526 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -89,9 +89,6 @@
 						  __latent_entropy
 #define __meminitdata    __section(".meminit.data")
 #define __meminitconst   __section(".meminit.rodata")
-#define __memexit        __section(".memexit.text") __exitused __cold notrace
-#define __memexitdata    __section(".memexit.data")
-#define __memexitconst   __section(".memexit.rodata")
 
 /* For assembly routines */
 #define __HEAD		.section	".head.text","ax"
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d936fa5fbbb1..bcc334b28a2c 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -798,7 +798,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 #define ALL_INIT_TEXT_SECTIONS \
 	".init.text", ".meminit.text"
 #define ALL_EXIT_TEXT_SECTIONS \
-	".exit.text", ".memexit.text"
+	".exit.text"
 
 #define ALL_PCI_INIT_SECTIONS	\
 	".pci_fixup_early", ".pci_fixup_header", ".pci_fixup_final", \
@@ -806,10 +806,9 @@ static void check_section(const char *modname, struct elf_info *elf,
 	".pci_fixup_resume_early", ".pci_fixup_suspend"
 
 #define ALL_XXXINIT_SECTIONS MEM_INIT_SECTIONS
-#define ALL_XXXEXIT_SECTIONS MEM_EXIT_SECTIONS
 
 #define ALL_INIT_SECTIONS INIT_SECTIONS, ALL_XXXINIT_SECTIONS
-#define ALL_EXIT_SECTIONS EXIT_SECTIONS, ALL_XXXEXIT_SECTIONS
+#define ALL_EXIT_SECTIONS EXIT_SECTIONS
 
 #define DATA_SECTIONS ".data", ".data.rel"
 #define TEXT_SECTIONS ".text", ".text.*", ".sched.text", \
@@ -822,7 +821,6 @@ static void check_section(const char *modname, struct elf_info *elf,
 #define MEM_INIT_SECTIONS  ".meminit.*"
 
 #define EXIT_SECTIONS      ".exit.*"
-#define MEM_EXIT_SECTIONS  ".memexit.*"
 
 #define ALL_TEXT_SECTIONS  ALL_INIT_TEXT_SECTIONS, ALL_EXIT_TEXT_SECTIONS, \
 		TEXT_SECTIONS, OTHER_TEXT_SECTIONS
@@ -832,7 +830,6 @@ enum mismatch {
 	DATA_TO_ANY_INIT,
 	TEXTDATA_TO_ANY_EXIT,
 	XXXINIT_TO_SOME_INIT,
-	XXXEXIT_TO_SOME_EXIT,
 	ANY_INIT_TO_ANY_EXIT,
 	ANY_EXIT_TO_ANY_INIT,
 	EXTABLE_TO_NON_TEXT,
@@ -883,12 +880,6 @@ static const struct sectioncheck sectioncheck[] = {
 	.bad_tosec = { INIT_SECTIONS, NULL },
 	.mismatch = XXXINIT_TO_SOME_INIT,
 },
-/* Do not reference exit code/data from memexit code/data */
-{
-	.fromsec = { ALL_XXXEXIT_SECTIONS, NULL },
-	.bad_tosec = { EXIT_SECTIONS, NULL },
-	.mismatch = XXXEXIT_TO_SOME_EXIT,
-},
 /* Do not use exit code/data from init code */
 {
 	.fromsec = { ALL_INIT_SECTIONS, NULL },
@@ -1017,7 +1008,7 @@ static int secref_whitelist(const char *fromsec, const char *fromsym,
 
 	/* symbols in data sections that may refer to meminit sections */
 	if (match(fromsec, PATTERNS(DATA_SECTIONS)) &&
-	    match(tosec, PATTERNS(ALL_XXXINIT_SECTIONS, ALL_XXXEXIT_SECTIONS)) &&
+	    match(tosec, PATTERNS(ALL_XXXINIT_SECTIONS)) &&
 	    match(fromsym, PATTERNS("*driver")))
 		return 0;
 
-- 
2.40.1

