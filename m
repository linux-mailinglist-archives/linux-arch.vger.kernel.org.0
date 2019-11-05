Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4BBEF91A
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 10:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfKEJ2Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 04:28:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40656 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388337AbfKEJ2Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 04:28:24 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRv7l-0007a1-9o; Tue, 05 Nov 2019 10:27:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BE6161C04E4;
        Tue,  5 Nov 2019 10:27:33 +0100 (CET)
Date:   Tue, 05 Nov 2019 09:27:33 -0000
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] vmlinux.lds.h: Move Program Header restoration into
 NOTES macro
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Will Deacon <will@kernel.org>, "x86-ml" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191029211351.13243-10-keescook@chromium.org>
References: <20191029211351.13243-10-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <157294605350.29376.17430557461465855450.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     fbe6a8e618a2d70621cff277e24f6eb338d3d149
Gitweb:        https://git.kernel.org/tip/fbe6a8e618a2d70621cff277e24f6eb338d3d149
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Tue, 29 Oct 2019 14:13:31 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Nov 2019 15:34:39 +01:00

vmlinux.lds.h: Move Program Header restoration into NOTES macro

In preparation for moving NOTES into RO_DATA, make the Program Header
assignment restoration be part of the NOTES macro itself.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-c6x-dev@linux-c6x.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Will Deacon <will@kernel.org>
Cc: x86-ml <x86@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: https://lkml.kernel.org/r/20191029211351.13243-10-keescook@chromium.org
---
 arch/alpha/kernel/vmlinux.lds.S   |  5 +----
 arch/ia64/kernel/vmlinux.lds.S    |  4 +---
 arch/mips/kernel/vmlinux.lds.S    |  3 +--
 arch/powerpc/kernel/vmlinux.lds.S |  4 +---
 arch/s390/kernel/vmlinux.lds.S    |  4 +---
 arch/x86/kernel/vmlinux.lds.S     |  3 +--
 include/asm-generic/vmlinux.lds.h | 13 +++++++++++--
 7 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index 363a60b..cdfdc91 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -34,10 +34,7 @@ SECTIONS
 	swapper_pg_dir = SWAPPER_PGD;
 	_etext = .;	/* End of text section */
 
-	NOTES :text :note
-	.dummy : {
-		*(.dummy)
-	} :text
+	NOTES
 
 	RODATA
 	EXCEPTION_TABLE(16)
diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index 7cf4958..bfc937e 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -70,9 +70,7 @@ SECTIONS {
 	/*
 	 * Read-only data
 	 */
-	NOTES :text :note       /* put .notes in text and mark in PT_NOTE  */
-	code_continues : {
-	} :text                /* switch back to regular program...  */
+	NOTES
 
 	EXCEPTION_TABLE(16)
 
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 1c95612..6a22f53 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -81,8 +81,7 @@ SECTIONS
 		__stop___dbe_table = .;
 	}
 
-	NOTES NOTES_HEADERS
-	.dummy : { *(.dummy) } :text
+	NOTES
 
 	_sdata = .;			/* Start of data section */
 	RODATA
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 7e26e20..4f19d81 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -164,9 +164,7 @@ SECTIONS
 #endif
 	EXCEPTION_TABLE(0)
 
-	NOTES :text :note
-	/* Restore program header away from PT_NOTE. */
-	.dummy : { *(.dummy) } :text
+	NOTES
 
 /*
  * Init sections discarded at runtime
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 646d939..f88eede 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -52,9 +52,7 @@ SECTIONS
 		_etext = .;		/* End of text section */
 	} :text = 0x0700
 
-	NOTES :text :note
-
-	.dummy : { *(.dummy) } :text
+	NOTES
 
 	RO_DATA_SECTION(PAGE_SIZE)
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 2e18bf5..8be25b0 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -148,8 +148,7 @@ SECTIONS
 		_etext = .;
 	} :text = 0x9090
 
-	NOTES :text :note
-	.dummy : { *(.dummy) } :text
+	NOTES
 
 	EXCEPTION_TABLE(16)
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f5dd45c..97d4299 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -56,10 +56,18 @@
 
 /*
  * Only some architectures want to have the .notes segment visible in
- * a separate PT_NOTE ELF Program Header.
+ * a separate PT_NOTE ELF Program Header. When this happens, it needs
+ * to be visible in both the kernel text's PT_LOAD and the PT_NOTE
+ * Program Headers. In this case, though, the PT_LOAD needs to be made
+ * the default again so that all the following sections don't also end
+ * up in the PT_NOTE Program Header.
  */
 #ifdef EMITS_PT_NOTE
 #define NOTES_HEADERS		:text :note
+#define NOTES_HEADERS_RESTORE	__restore_ph : { *(.__restore_ph) } :text
+#else
+#define NOTES_HEADERS
+#define NOTES_HEADERS_RESTORE
 #endif
 
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
@@ -798,7 +806,8 @@
 		__start_notes = .;					\
 		KEEP(*(.note.*))					\
 		__stop_notes = .;					\
-	}
+	} NOTES_HEADERS							\
+	NOTES_HEADERS_RESTORE
 
 #define INIT_SETUP(initsetup_align)					\
 		. = ALIGN(initsetup_align);				\
