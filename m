Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A014DCB04
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2019 18:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439749AbfJRQam (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Oct 2019 12:30:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57593 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389858AbfJRQal (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:41 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iLV93-0002jb-72; Fri, 18 Oct 2019 18:30:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CC0BE1C0450;
        Fri, 18 Oct 2019 18:30:28 +0200 (CEST)
Date:   Fri, 18 Oct 2019 16:30:28 -0000
From:   "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Remove the last GLOBAL user and remove the macro
Cc:     Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, "x86-ml" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191011115108.12392-20-jslaby@suse.cz>
References: <20191011115108.12392-20-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141622856.29376.8848286493548483799.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     b4edca150106a68d05eaf823d665a355ff19e28b
Gitweb:        https://git.kernel.org/tip/b4edca150106a68d05eaf823d665a355ff19e28b
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:59 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 11:29:50 +02:00

x86/asm: Remove the last GLOBAL user and remove the macro

Convert the remaining 32bit users and remove the GLOBAL macro finally.
In particular, this means to use SYM_ENTRY for the singlestepping hack
region.

Exclude the global definition of GLOBAL from x86 too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-arch@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191011115108.12392-20-jslaby@suse.cz
---
 arch/x86/entry/entry_32.S      | 4 ++--
 arch/x86/include/asm/linkage.h | 8 --------
 include/linux/linkage.h        | 2 ++
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index f37ff58..4900a6a 100644
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
index e07188e..3651117 100644
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
index f3ae8f3..cb1108d 100644
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
