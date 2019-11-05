Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474D0EF8C5
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 10:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388115AbfKEJ2P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 04:28:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40636 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388108AbfKEJ2P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 04:28:15 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRv7g-0007Yf-RS; Tue, 05 Nov 2019 10:27:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 64EDC1C048C;
        Tue,  5 Nov 2019 10:27:33 +0100 (CET)
Date:   Tue, 05 Nov 2019 09:27:33 -0000
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] vmlinux.lds.h: Move NOTES into RO_DATA
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
In-Reply-To: <20191029211351.13243-11-keescook@chromium.org>
References: <20191029211351.13243-11-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <157294605308.29376.210260919268288163.tip-bot2@tip-bot2>
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

Commit-ID:     eaf937075c9a42eb8ba51eb3050773d7205d3595
Gitweb:        https://git.kernel.org/tip/eaf937075c9a42eb8ba51eb3050773d7205d3595
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Tue, 29 Oct 2019 14:13:32 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Nov 2019 15:34:41 +01:00

vmlinux.lds.h: Move NOTES into RO_DATA

The .notes section should be non-executable read-only data. As such,
move it to the RO_DATA macro instead of being per-architecture defined.

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
Link: https://lkml.kernel.org/r/20191029211351.13243-11-keescook@chromium.org
---
 arch/alpha/kernel/vmlinux.lds.S      |  2 --
 arch/arc/kernel/vmlinux.lds.S        |  2 --
 arch/arm/kernel/vmlinux-xip.lds.S    |  2 --
 arch/arm/kernel/vmlinux.lds.S        |  2 --
 arch/arm64/kernel/vmlinux.lds.S      |  1 -
 arch/c6x/kernel/vmlinux.lds.S        |  1 -
 arch/csky/kernel/vmlinux.lds.S       |  1 -
 arch/h8300/kernel/vmlinux.lds.S      |  1 -
 arch/hexagon/kernel/vmlinux.lds.S    |  1 -
 arch/ia64/kernel/vmlinux.lds.S       |  2 --
 arch/microblaze/kernel/vmlinux.lds.S |  1 -
 arch/mips/kernel/vmlinux.lds.S       |  2 --
 arch/nds32/kernel/vmlinux.lds.S      |  1 -
 arch/nios2/kernel/vmlinux.lds.S      |  1 -
 arch/openrisc/kernel/vmlinux.lds.S   |  1 -
 arch/parisc/kernel/vmlinux.lds.S     |  1 -
 arch/powerpc/kernel/vmlinux.lds.S    |  2 --
 arch/riscv/kernel/vmlinux.lds.S      |  1 -
 arch/s390/kernel/vmlinux.lds.S       |  2 --
 arch/sh/kernel/vmlinux.lds.S         |  1 -
 arch/sparc/kernel/vmlinux.lds.S      |  1 -
 arch/um/include/asm/common.lds.S     |  1 -
 arch/unicore32/kernel/vmlinux.lds.S  |  1 -
 arch/x86/kernel/vmlinux.lds.S        |  2 --
 arch/xtensa/kernel/vmlinux.lds.S     |  1 -
 include/asm-generic/vmlinux.lds.h    |  9 +++++----
 26 files changed, 5 insertions(+), 38 deletions(-)

diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index cdfdc91..bf28043 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -34,8 +34,6 @@ SECTIONS
 	swapper_pg_dir = SWAPPER_PGD;
 	_etext = .;	/* End of text section */
 
-	NOTES
-
 	RODATA
 	EXCEPTION_TABLE(16)
 
diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index 6c693a9..1d6eef4 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -118,8 +118,6 @@ SECTIONS
 	/DISCARD/ : {	*(.eh_frame) }
 #endif
 
-	NOTES
-
 	. = ALIGN(PAGE_SIZE);
 	_end = . ;
 
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 8c74037..d2a9651 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -70,8 +70,6 @@ SECTIONS
 	ARM_UNWIND_SECTIONS
 #endif
 
-	NOTES
-
 	_etext = .;			/* End of text and rodata section */
 
 	ARM_VECTORS
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 23150c0..068db68 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -81,8 +81,6 @@ SECTIONS
 	ARM_UNWIND_SECTIONS
 #endif
 
-	NOTES
-
 #ifdef CONFIG_STRICT_KERNEL_RWX
 	. = ALIGN(1<<SECTION_SHIFT);
 #else
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index aa76f72..e7dafc2 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -137,7 +137,6 @@ SECTIONS
 
 	RO_DATA(PAGE_SIZE)		/* everything from this point to     */
 	EXCEPTION_TABLE(8)		/* __init_begin will be marked RO NX */
-	NOTES
 
 	. = ALIGN(PAGE_SIZE);
 	idmap_pg_dir = .;
diff --git a/arch/c6x/kernel/vmlinux.lds.S b/arch/c6x/kernel/vmlinux.lds.S
index 584bab2..d6e3802 100644
--- a/arch/c6x/kernel/vmlinux.lds.S
+++ b/arch/c6x/kernel/vmlinux.lds.S
@@ -81,7 +81,6 @@ SECTIONS
 	}
 
 	EXCEPTION_TABLE(16)
-	NOTES
 
 	RO_DATA_SECTION(PAGE_SIZE)
 	.const :
diff --git a/arch/csky/kernel/vmlinux.lds.S b/arch/csky/kernel/vmlinux.lds.S
index ae7961b..75dd314 100644
--- a/arch/csky/kernel/vmlinux.lds.S
+++ b/arch/csky/kernel/vmlinux.lds.S
@@ -53,7 +53,6 @@ SECTIONS
 	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	_edata = .;
 
-	NOTES
 	EXCEPTION_TABLE(L1_CACHE_BYTES)
 	BSS_SECTION(L1_CACHE_BYTES, PAGE_SIZE, L1_CACHE_BYTES)
 	VBR_BASE
diff --git a/arch/h8300/kernel/vmlinux.lds.S b/arch/h8300/kernel/vmlinux.lds.S
index 49f716c..88776e7 100644
--- a/arch/h8300/kernel/vmlinux.lds.S
+++ b/arch/h8300/kernel/vmlinux.lds.S
@@ -38,7 +38,6 @@ SECTIONS
 	_etext = . ;
 	}
 	EXCEPTION_TABLE(16)
-	NOTES
 	RO_DATA_SECTION(4)
 	ROMEND = .;
 #if defined(CONFIG_ROMKERNEL)
diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index 78f2418..6a6e8fc 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -54,7 +54,6 @@ SECTIONS
 	_edata = .;
 
 	EXCEPTION_TABLE(16)
-	NOTES
 
 	BSS_SECTION(_PAGE_SIZE, _PAGE_SIZE, _PAGE_SIZE)
 
diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index bfc937e..fae0775 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -70,8 +70,6 @@ SECTIONS {
 	/*
 	 * Read-only data
 	 */
-	NOTES
-
 	EXCEPTION_TABLE(16)
 
 	/* MCA table */
diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index e1f3e87..d008e50 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -53,7 +53,6 @@ SECTIONS {
 	. = ALIGN(16);
 	RODATA
 	EXCEPTION_TABLE(16)
-	NOTES
 
 	/*
 	 * sdata2 section can go anywhere, but must be word aligned
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 6a22f53..91e566d 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -81,8 +81,6 @@ SECTIONS
 		__stop___dbe_table = .;
 	}
 
-	NOTES
-
 	_sdata = .;			/* Start of data section */
 	RODATA
 
diff --git a/arch/nds32/kernel/vmlinux.lds.S b/arch/nds32/kernel/vmlinux.lds.S
index 9e90f30..c4f1c5a 100644
--- a/arch/nds32/kernel/vmlinux.lds.S
+++ b/arch/nds32/kernel/vmlinux.lds.S
@@ -58,7 +58,6 @@ SECTIONS
 	_edata  =  .;
 
 	EXCEPTION_TABLE(16)
-	NOTES
 	BSS_SECTION(4, 4, 4)
 	_end = .;
 
diff --git a/arch/nios2/kernel/vmlinux.lds.S b/arch/nios2/kernel/vmlinux.lds.S
index 6ad64f1..20e4078 100644
--- a/arch/nios2/kernel/vmlinux.lds.S
+++ b/arch/nios2/kernel/vmlinux.lds.S
@@ -58,7 +58,6 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
-	NOTES
 
 	DISCARDS
 }
diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
index 2e2c72c..142c51c 100644
--- a/arch/openrisc/kernel/vmlinux.lds.S
+++ b/arch/openrisc/kernel/vmlinux.lds.S
@@ -79,7 +79,6 @@ SECTIONS
         _edata  =  .;
 
 	EXCEPTION_TABLE(4)
-	NOTES
 
 	/* Init code and data */
 	. = ALIGN(PAGE_SIZE);
diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index 99cd24f..168d12b 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -131,7 +131,6 @@ SECTIONS
 
 	/* RO because of BUILDTIME_EXTABLE_SORT */
 	EXCEPTION_TABLE(8)
-	NOTES
 
 	/* unwind info */
 	.PARISC.unwind : {
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 4f19d81..4e7cec0 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -164,8 +164,6 @@ SECTIONS
 #endif
 	EXCEPTION_TABLE(0)
 
-	NOTES
-
 /*
  * Init sections discarded at runtime
  */
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 23cd1a9..df5229c 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -69,7 +69,6 @@ SECTIONS
 	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
 
 	EXCEPTION_TABLE(0x10)
-	NOTES
 
 	.rel.dyn : {
 		*(.rel.dyn*)
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index f88eede..beb4df0 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -52,8 +52,6 @@ SECTIONS
 		_etext = .;		/* End of text section */
 	} :text = 0x0700
 
-	NOTES
-
 	RO_DATA_SECTION(PAGE_SIZE)
 
 	. = ALIGN(PAGE_SIZE);
diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
index 77a59d8..fef3905 100644
--- a/arch/sh/kernel/vmlinux.lds.S
+++ b/arch/sh/kernel/vmlinux.lds.S
@@ -48,7 +48,6 @@ SECTIONS
 	} = 0x0009
 
 	EXCEPTION_TABLE(16)
-	NOTES
 
 	_sdata = .;
 	RO_DATA(PAGE_SIZE)
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 61afd78..8929fbc 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -78,7 +78,6 @@ SECTIONS
 		__stop___fixup = .;
 	}
 	EXCEPTION_TABLE(16)
-	NOTES
 
 	. = ALIGN(PAGE_SIZE);
 	__init_begin = ALIGN(PAGE_SIZE);
diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index d7086b9..91aca35 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -16,7 +16,6 @@
   PROVIDE (_unprotected_end = .);
 
   . = ALIGN(4096);
-  NOTES
   EXCEPTION_TABLE(0)
 
   BUG_TABLE
diff --git a/arch/unicore32/kernel/vmlinux.lds.S b/arch/unicore32/kernel/vmlinux.lds.S
index 7abf905..78c4c56 100644
--- a/arch/unicore32/kernel/vmlinux.lds.S
+++ b/arch/unicore32/kernel/vmlinux.lds.S
@@ -48,7 +48,6 @@ SECTIONS
 	_edata = .;
 
 	EXCEPTION_TABLE(L1_CACHE_BYTES)
-	NOTES
 
 	BSS_SECTION(0, 0, 0)
 	_end = .;
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8be25b0..41362e9 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -148,8 +148,6 @@ SECTIONS
 		_etext = .;
 	} :text = 0x9090
 
-	NOTES
-
 	EXCEPTION_TABLE(16)
 
 	/* .text should occupy whole number of pages */
diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index 943f106..a0a8437 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -131,7 +131,6 @@ SECTIONS
   .fixup   : { *(.fixup) }
 
   EXCEPTION_TABLE(16)
-  NOTES
   /* Data section */
 
   _sdata = .;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 97d4299..dc3390e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -28,7 +28,6 @@
  *	_edata = .;
  *
  *	EXCEPTION_TABLE(...)
- *	NOTES
  *
  *	BSS_SECTION(0, 0, 0)
  *	_end = .;
@@ -512,10 +511,12 @@
 		__start___modver = .;					\
 		KEEP(*(__modver))					\
 		__stop___modver = .;					\
-		. = ALIGN((align));					\
-		__end_rodata = .;					\
 	}								\
-	. = ALIGN((align));
+									\
+	NOTES								\
+									\
+	. = ALIGN((align));						\
+	__end_rodata = .;
 
 /* RODATA & RO_DATA provided for backward compatibility.
  * All archs are supposed to use RO_DATA() */
