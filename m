Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EADBD3EE6
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2019 13:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfJKLwJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Oct 2019 07:52:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:33182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728074AbfJKLvY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5023AB491;
        Fri, 11 Oct 2019 11:51:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     bp@alien8.de
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v9 19/28] x86/asm: Kill the last GLOBAL user and remove the macro
Date:   Fri, 11 Oct 2019 13:50:59 +0200
Message-Id: <20191011115108.12392-20-jslaby@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Convert the remaining 32bit users and remove GLOBAL macro finally. In
particular, this means to use SYM_ENTRY for the singlestepping hack
region.

Exclude the global definition of GLOBAL from x86 too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/entry/entry_32.S      | 4 ++--
 arch/x86/include/asm/linkage.h | 8 --------
 include/linux/linkage.h        | 2 ++
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index f37ff583cecb..4900a6a5e125 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -832,7 +832,7 @@ SYM_INNER_LABEL_ALIGN(resume_userspace, SYM_L_LOCAL)
 	jmp	restore_all
 SYM_CODE_END(ret_from_exception)
 
-GLOBAL(__begin_SYSENTER_singlestep_region)
+SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
 /*
  * All code from here through __end_SYSENTER_singlestep_region is subject
  * to being single-stepped if a user program sets TF and executes SYSENTER.
@@ -1011,7 +1011,7 @@ ENTRY(entry_SYSENTER_32)
 	pushl	$X86_EFLAGS_FIXED
 	popfl
 	jmp	.Lsysenter_flags_fixed
-GLOBAL(__end_SYSENTER_singlestep_region)
+SYM_ENTRY(__end_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
 ENDPROC(entry_SYSENTER_32)
 
 /*
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index e07188e8d763..365111789cc6 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -13,14 +13,6 @@
 
 #ifdef __ASSEMBLY__
 
-/*
- * GLOBAL is DEPRECATED
- *
- * use SYM_DATA_START, SYM_FUNC_START, SYM_INNER_LABEL, SYM_CODE_START, or
- * similar
- */
-#define GLOBAL(name)	SYM_ENTRY(name, SYM_L_GLOBAL, SYM_A_NONE)
-
 #if defined(CONFIG_X86_64) || defined(CONFIG_X86_ALIGNMENT_16)
 #define __ALIGN		.p2align 4, 0x90
 #define __ALIGN_STR	__stringify(__ALIGN)
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index f3ae8f3dea2c..cb1108dde385 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -105,12 +105,14 @@
 
 /* === DEPRECATED annotations === */
 
+#ifndef CONFIG_X86
 #ifndef GLOBAL
 /* deprecated, use SYM_DATA*, SYM_ENTRY, or similar */
 #define GLOBAL(name) \
 	.globl name ASM_NL \
 	name:
 #endif
+#endif
 
 #ifndef ENTRY
 /* deprecated, use SYM_FUNC_START */
-- 
2.23.0

