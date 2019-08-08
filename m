Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFAB86001
	for <lists+linux-arch@lfdr.de>; Thu,  8 Aug 2019 12:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403827AbfHHKjF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Aug 2019 06:39:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:47480 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403816AbfHHKjF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Aug 2019 06:39:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7217FAFD4;
        Thu,  8 Aug 2019 10:39:04 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v8 12/28] x86/boot/compressed: annotate data appropriatelly
Date:   Thu,  8 Aug 2019 12:38:38 +0200
Message-Id: <20190808103854.6192-13-jslaby@suse.cz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808103854.6192-1-jslaby@suse.cz>
References: <20190808103854.6192-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Use the new SYM_DATA, SYM_DATA_START, and SYM_DATA_END* macros for data.

Now, the data in the object file look sane:
Value   Size Type    Bind   Vis      Ndx Name
  0000    10 OBJECT  GLOBAL DEFAULT    3 efi32_boot_gdt
  000a    10 OBJECT  LOCAL  DEFAULT    3 save_gdt
  0014     8 OBJECT  LOCAL  DEFAULT    3 func_rt_ptr
  001c    48 OBJECT  GLOBAL DEFAULT    3 efi_gdt64
  004c     0 OBJECT  LOCAL  DEFAULT    3 efi_gdt64_end

  0000    48 OBJECT  LOCAL  DEFAULT    3 gdt
  0030     0 OBJECT  LOCAL  DEFAULT    3 gdt_end
  0030     8 OBJECT  LOCAL  DEFAULT    3 efi_config
  0038    49 OBJECT  GLOBAL DEFAULT    3 efi32_config
  0069    49 OBJECT  GLOBAL DEFAULT    3 efi64_config

All have correct size and type now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86@kernel.org
---
 arch/x86/boot/compressed/efi_thunk_64.S | 21 +++++++++-------
 arch/x86/boot/compressed/head_64.S      | 32 ++++++++++++-------------
 arch/x86/boot/compressed/mem_encrypt.S  |  3 +--
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/x86/boot/compressed/efi_thunk_64.S b/arch/x86/boot/compressed/efi_thunk_64.S
index bff9ab7c6317..d66000d23921 100644
--- a/arch/x86/boot/compressed/efi_thunk_64.S
+++ b/arch/x86/boot/compressed/efi_thunk_64.S
@@ -176,16 +176,19 @@ ENDPROC(efi_enter32)
 
 	.data
 	.balign	8
-	.global	efi32_boot_gdt
-efi32_boot_gdt:	.word	0
-		.quad	0
+SYM_DATA_START(efi32_boot_gdt)
+	.word	0
+	.quad	0
+SYM_DATA_END(efi32_boot_gdt)
+
+SYM_DATA_START_LOCAL(save_gdt)
+	.word	0
+	.quad	0
+SYM_DATA_END(save_gdt)
 
-save_gdt:	.word	0
-		.quad	0
-func_rt_ptr:	.quad	0
+SYM_DATA_LOCAL(func_rt_ptr, .quad 0)
 
-	.global efi_gdt64
-efi_gdt64:
+SYM_DATA_START(efi_gdt64)
 	.word	efi_gdt64_end - efi_gdt64
 	.long	0			/* Filled out by user */
 	.word	0
@@ -194,4 +197,4 @@ efi_gdt64:
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 	.quad	0x0080890000000000	/* TS descriptor */
 	.quad   0x0000000000000000	/* TS continued */
-efi_gdt64_end:
+SYM_DATA_END_LABEL(efi_gdt64, SYM_L_LOCAL, efi_gdt64_end)
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index c8ce6ffc9fe5..70a25e0fa71e 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -659,11 +659,12 @@ SYM_FUNC_END(no_longmode)
 #include "../../kernel/verify_cpu.S"
 
 	.data
-gdt64:
+SYM_DATA_START_LOCAL(gdt64)
 	.word	gdt_end - gdt
 	.quad   0
+SYM_DATA_END(gdt64)
 	.balign	8
-gdt:
+SYM_DATA_START_LOCAL(gdt)
 	.word	gdt_end - gdt
 	.long	gdt
 	.word	0
@@ -672,25 +673,24 @@ gdt:
 	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
 	.quad	0x0080890000000000	/* TS descriptor */
 	.quad   0x0000000000000000	/* TS continued */
-gdt_end:
+SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
 
 #ifdef CONFIG_EFI_STUB
-efi_config:
-	.quad	0
+SYM_DATA_LOCAL(efi_config, .quad 0)
 
 #ifdef CONFIG_EFI_MIXED
-	.global efi32_config
-efi32_config:
+SYM_DATA_START(efi32_config)
 	.fill	5,8,0
 	.quad	efi64_thunk
 	.byte	0
+SYM_DATA_END(efi32_config)
 #endif
 
-	.global efi64_config
-efi64_config:
+SYM_DATA_START(efi64_config)
 	.fill	5,8,0
 	.quad	efi_call
 	.byte	1
+SYM_DATA_END(efi64_config)
 #endif /* CONFIG_EFI_STUB */
 
 /*
@@ -698,23 +698,21 @@ efi64_config:
  */
 	.bss
 	.balign 4
-boot_heap:
-	.fill BOOT_HEAP_SIZE, 1, 0
-boot_stack:
+SYM_DATA_LOCAL(boot_heap,	.fill BOOT_HEAP_SIZE, 1, 0)
+
+SYM_DATA_START_LOCAL(boot_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
-boot_stack_end:
+SYM_DATA_END_LABEL(boot_stack, SYM_L_LOCAL, boot_stack_end)
 
 /*
  * Space for page tables (not in .bss so not zeroed)
  */
 	.section ".pgtable","a",@nobits
 	.balign 4096
-pgtable:
-	.fill BOOT_PGT_SIZE, 1, 0
+SYM_DATA_LOCAL(pgtable,		.fill BOOT_PGT_SIZE, 1, 0)
 
 /*
  * The page table is going to be used instead of page table in the trampoline
  * memory.
  */
-top_pgtable:
-	.fill PAGE_SIZE, 1, 0
+SYM_DATA_LOCAL(top_pgtable,	.fill PAGE_SIZE, 1, 0)
diff --git a/arch/x86/boot/compressed/mem_encrypt.S b/arch/x86/boot/compressed/mem_encrypt.S
index 6afb7130a387..28d703cad310 100644
--- a/arch/x86/boot/compressed/mem_encrypt.S
+++ b/arch/x86/boot/compressed/mem_encrypt.S
@@ -96,6 +96,5 @@ ENDPROC(set_sev_encryption_mask)
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	.balign	8
-GLOBAL(sme_me_mask)
-	.quad	0
+SYM_DATA(sme_me_mask, .quad 0)
 #endif
-- 
2.22.0

