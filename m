Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB086F14A6
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 11:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345881AbjD1JzS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 05:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345877AbjD1JzH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 05:55:07 -0400
Received: from out187-3.us.a.mail.aliyun.com (out187-3.us.a.mail.aliyun.com [47.90.187.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2618B6197;
        Fri, 28 Apr 2023 02:54:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047201;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---.STCEPhX_1682675589;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.STCEPhX_1682675589)
          by smtp.aliyun-inc.com;
          Fri, 28 Apr 2023 17:53:10 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Thomas Garnier" <thgarnie@chromium.org>,
        "Lai Jiangshan" <jiangshan.ljs@antgroup.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, "Arnd Bergmann" <arnd@arndb.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Juergen Gross" <jgross@suse.com>,
        "Brian Gerst" <brgerst@gmail.com>, <linux-arch@vger.kernel.org>
Subject: [PATCH RFC 25/43] x86/mm: Make the x86 GOT read-only
Date:   Fri, 28 Apr 2023 17:51:05 +0800
Message-Id: <980069339b23a6cc4ae6d605d188338467a5b08b.1682673543.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
References: <cover.1682673542.git.houwenlong.hwl@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Garnier <thgarnie@chromium.org>

From: Thomas Garnier <thgarnie@chromium.org>

The GOT is changed during early boot when relocations are applied. Make
it read-only directly. This table exists only for PIE binary. Since weak
symbol reference would always be GOT reference, there are 8 entries in
GOT, but only one entry for __fentry__() is in use.  Other GOT
references have been optimized by linker.

[Hou Wenlong: Change commit message and skip GOT size check]

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/vmlinux.lds.S     |  2 ++
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index f02dcde9f8a8..fa4c6582663f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -462,6 +462,7 @@ SECTIONS
 #endif
 	       "Unexpected GOT/PLT entries detected!")
 
+#ifndef CONFIG_X86_PIE
 	/*
 	 * Sections that should stay zero sized, which is safer to
 	 * explicitly check instead of blindly discarding.
@@ -470,6 +471,7 @@ SECTIONS
 		*(.got) *(.igot.*)
 	}
 	ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
+#endif
 
 	.plt : {
 		*(.plt) *(.plt.*) *(.iplt)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d1f57e4868ed..438ed8b39896 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -441,6 +441,17 @@
 	__end_ro_after_init = .;
 #endif
 
+#ifdef CONFIG_X86_PIE
+#define RO_GOT_X86							\
+	.got        : AT(ADDR(.got) - LOAD_OFFSET) {			\
+		__start_got = .;					\
+		*(.got) *(.igot.*);					\
+		__end_got = .;						\
+	}
+#else
+#define RO_GOT_X86
+#endif
+
 /*
  * .kcfi_traps contains a list KCFI trap locations.
  */
@@ -486,6 +497,7 @@
 		BOUNDED_SECTION_PRE_LABEL(.pci_fixup_suspend_late, _pci_fixups_suspend_late, __start, __end) \
 	}								\
 									\
+	RO_GOT_X86							\
 	FW_LOADER_BUILT_IN_DATA						\
 	TRACEDATA							\
 									\
-- 
2.31.1

