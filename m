Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68519F3F51
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfKHFET (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:04:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42255 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfKHFES (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id j12so3227240plt.9
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmovPrBVrojECoupwUSqtJuGXUQkvWFnzlS6Ggqihtw=;
        b=LYzPCF7V6KWEhCLynuIZ+HubDSLuZoMHPVmcGD3VTIfsifZyBtZPeT2PTdavKRXHR5
         1u+Z/WfKXGKnq8TVRQqFEXnDa7IiAe9pklSSOBkNE3GM5/bbsQr3n5VBuNnok57oO2Vg
         leolIzYtN1az8IItEgZ1OB1whZpiFlr2oxCSGbo5dlps5cQt/uexMpCq+j30kKShF8hC
         7m72PbVlRVOXLaxUXgoaXcPqrIXOCYATHnhTiphYQRq2vxphpYQwCUUKD6tW/Xxf2uOC
         v9iDxz8fTJvRmKU5gODPqLnQ/JMsWwq2KZ/jiV23cr52XuzGzFUBa+EhugxmgKTQOi2z
         c8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmovPrBVrojECoupwUSqtJuGXUQkvWFnzlS6Ggqihtw=;
        b=GZGB5tRkWwJw9hEO4Skehfdr1rXvLBfgxG8FZVAA7XDBfcYn/OX7ukLr0Nga5+1T6Z
         upzaROZzRsRbTZVTkX5xwKO3+efe3eMuC0zU1jZsroWNNy8eS7tFkXVh3G4qVXyN9e7h
         OeMno1zpzIg3GH4xw4Ra+tpDPi9V5y3AbFLw5qYaDqwtO/rWeYH599Nq6BrBzO3oR6fC
         NsRyI1FOvGporfLh6s5l8iuyqPbc+bRTv0j8eStNyxCrzfyHzcsaJZ0FK0PMRIbKCMgS
         0Wo4eCtIVzP8ARdj8xS4cjx3D3mOV2O2nDePG21QVpyWC3QYuAsVFmi9aUiC17P7hZPI
         Vqlw==
X-Gm-Message-State: APjAAAUciMUjhqGwhSAi2nFV6dtMn/DH89u8Jr+8PaNAMxLn16KS+AT9
        ASw1xdIKCQOv8tqrDm8lFjI=
X-Google-Smtp-Source: APXvYqwG64vmQeO1YAmHgOy8BkWkq3p4cuu96Q+GNRyNPBwQr/W+tGPsZ4BPTGmNL90wvTxd0bmj8g==
X-Received: by 2002:a17:90a:bb0a:: with SMTP id u10mr10999096pjr.14.1573189456431;
        Thu, 07 Nov 2019 21:04:16 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id y4sm4470893pgy.27.2019.11.07.21.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:04:14 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id AC30E201ACFE81; Fri,  8 Nov 2019 14:04:12 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v2 30/37] scripts: revert CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX patches
Date:   Fri,  8 Nov 2019 14:02:45 +0900
Message-Id: <e7b7be96ac1337435772d44e6c2ad0f7fb734d17.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

LKL requires this config option in order to build/run on Windows host
because Windows compiler (mingw32) prepends '_' to each symbol.

This commit reverts:
commit 7953002a7c65 ("vmlinux.lds.h: remove stale <linux/export.h>
include")
commit c4df32c80d04 ("export.h: remove VMLINUX_SYMBOL() and
VMLINUX_SYMBOL_STR()")
commit 00979ce4fcc9 ("linux/linkage.h: replace VMLINUX_SYMBOL_STR()
with __stringify()")
commit a6b04f0ed5e9 ("checkpatch: remove VMLINUX_SYMBOL() check")
commit a62143850053 ("vmlinux.lds.h: remove no-op macro
VMLINUX_SYMBOL()")
commit 704db5433fb4 ("kbuild: remove
CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX")
commit 94e58e0ac312 ("export.h: remove code for prefixing symbols
with underscore")
commit 5a144a1acd0b ("depmod.sh: remove symbol prefix support")
commit 534c9f2ec4c9 ("kallsyms: remove symbol prefix support")
commit 74d931716151 ("genksyms: remove symbol prefix support")
commit b2c5cdcfd4bc ("modpost: remove symbol prefix support")

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 Makefile                          |   2 +-
 arch/Kconfig                      |   6 +
 certs/system_certificates.S       |  16 +-
 include/asm-generic/export.h      |  34 ++--
 include/asm-generic/vmlinux.lds.h | 279 +++++++++++++++---------------
 include/linux/export.h            |  23 ++-
 include/linux/linkage.h           |  12 +-
 scripts/Makefile.build            |   9 +-
 scripts/adjust_autoksyms.sh       |   6 +
 scripts/checkpatch.pl             |  10 ++
 scripts/depmod.sh                 |  25 ++-
 scripts/genksyms/genksyms.c       |  11 +-
 scripts/kallsyms.c                |  47 +++--
 scripts/link-vmlinux.sh           |   4 +
 scripts/mod/modpost.c             |  30 ++--
 usr/initramfs_data.S              |   4 +-
 16 files changed, 318 insertions(+), 200 deletions(-)

diff --git a/Makefile b/Makefile
index 874c0aec0f9c..d2c9e3a420f6 100644
--- a/Makefile
+++ b/Makefile
@@ -1805,7 +1805,7 @@ quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files))
 # Run depmod only if we have System.map and depmod is executable
 quiet_cmd_depmod = DEPMOD  $(KERNELRELEASE)
       cmd_depmod = $(CONFIG_SHELL) $(srctree)/scripts/depmod.sh $(DEPMOD) \
-                   $(KERNELRELEASE)
+                   $(KERNELRELEASE) "$(patsubst y,_,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))"
 
 # read saved command lines for existing targets
 existing-targets := $(wildcard $(sort $(targets)))
diff --git a/arch/Kconfig b/arch/Kconfig
index a7b57dd42c26..a01df2ae6a1b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -594,6 +594,12 @@ config MODULES_USE_ELF_REL
 	  Modules only use ELF REL relocations.  Modules with ELF RELA
 	  relocations will give an error.
 
+config HAVE_UNDERSCORE_SYMBOL_PREFIX
+	bool
+	help
+	  Some architectures generate an _ in front of C symbols; things like
+	  module loading and assembly files need to know about this.
+
 config HAVE_IRQ_EXIT_ON_IRQ_STACK
 	bool
 	help
diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index 8f29058adf93..3918ff7235ed 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -5,8 +5,8 @@
 	__INITRODATA
 
 	.align 8
-	.globl system_certificate_list
-system_certificate_list:
+	.globl VMLINUX_SYMBOL(system_certificate_list)
+VMLINUX_SYMBOL(system_certificate_list):
 __cert_list_start:
 #ifdef CONFIG_MODULE_SIG
 	.incbin "certs/signing_key.x509"
@@ -15,21 +15,21 @@ __cert_list_start:
 __cert_list_end:
 
 #ifdef CONFIG_SYSTEM_EXTRA_CERTIFICATE
-	.globl system_extra_cert
+	.globl VMLINUX_SYMBOL(system_extra_cert)
 	.size system_extra_cert, CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE
-system_extra_cert:
+VMLINUX_SYMBOL(system_extra_cert):
 	.fill CONFIG_SYSTEM_EXTRA_CERTIFICATE_SIZE, 1, 0
 
 	.align 4
-	.globl system_extra_cert_used
-system_extra_cert_used:
+	.globl VMLINUX_SYMBOL(system_extra_cert_used)
+VMLINUX_SYMBOL(system_extra_cert_used):
 	.int 0
 
 #endif /* CONFIG_SYSTEM_EXTRA_CERTIFICATE */
 
 	.align 8
-	.globl system_certificate_list_size
-system_certificate_list_size:
+	.globl VMLINUX_SYMBOL(system_certificate_list_size)
+VMLINUX_SYMBOL(system_certificate_list_size):
 #ifdef CONFIG_64BIT
 	.quad __cert_list_end - __cert_list_start
 #else
diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 294d6ae785d4..69ce0914b025 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -27,32 +27,42 @@
 #endif
 .endm
 
+#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+#define KSYM(name) _##name
+#else
+#define KSYM(name) name
+#endif
+
 /*
  * note on .section use: @progbits vs %progbits nastiness doesn't matter,
  * since we immediately emit into those sections anyway.
  */
 .macro ___EXPORT_SYMBOL name,val,sec
 #ifdef CONFIG_MODULES
-	.globl __ksymtab_\name
+	.globl KSYM(__ksymtab_\name)
 	.section ___ksymtab\sec+\name,"a"
 	.balign KSYM_ALIGN
-__ksymtab_\name:
-	__put \val, __kstrtab_\name
+KSYM(__ksymtab_\name):
+	__put \val, KSYM(__kstrtab_\name)
 	.previous
 	.section __ksymtab_strings,"a"
-__kstrtab_\name:
+KSYM(__kstrtab_\name):
+#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+	.asciz "_\name"
+#else
 	.asciz "\name"
+#endif
 	.previous
 #ifdef CONFIG_MODVERSIONS
 	.section ___kcrctab\sec+\name,"a"
 	.balign KCRC_ALIGN
-__kcrctab_\name:
+KSYM(__kcrctab_\name):
 #if defined(CONFIG_MODULE_REL_CRCS)
-	.long __crc_\name - .
+	.long KSYM(__crc_\name) - .
 #else
-	.long __crc_\name
+	.long KSYM(__crc_\name)
 #endif
-	.weak __crc_\name
+	.weak KSYM(__crc_\name)
 	.previous
 #endif
 #endif
@@ -85,12 +95,12 @@ __ksym_marker_\sym:
 #endif
 
 #define EXPORT_SYMBOL(name)					\
-	__EXPORT_SYMBOL(name, KSYM_FUNC(name),)
+	__EXPORT_SYMBOL(name, KSYM_FUNC(KSYM(name)),)
 #define EXPORT_SYMBOL_GPL(name) 				\
-	__EXPORT_SYMBOL(name, KSYM_FUNC(name), _gpl)
+	__EXPORT_SYMBOL(name, KSYM_FUNC(KSYM(name)), _gpl)
 #define EXPORT_DATA_SYMBOL(name)				\
-	__EXPORT_SYMBOL(name, name,)
+	__EXPORT_SYMBOL(name, KSYM(name),)
 #define EXPORT_DATA_SYMBOL_GPL(name)				\
-	__EXPORT_SYMBOL(name, name,_gpl)
+	__EXPORT_SYMBOL(name, KSYM(name),_gpl)
 
 #endif
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index cd28f63bfbc7..d0043449d2d3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -54,6 +54,8 @@
 #define LOAD_OFFSET 0
 #endif
 
+#include <linux/export.h>
+
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
 #define ALIGN_FUNCTION()  . = ALIGN(8)
 
@@ -117,67 +119,67 @@
 			__stop_mcount_loc = .;
 #else
 #define MCOUNT_REC()	. = ALIGN(8);				\
-			__start_mcount_loc = .;			\
+			VMLINUX_SYMBOL(__start_mcount_loc) = .; \
 			KEEP(*(__mcount_loc))			\
-			__stop_mcount_loc = .;
+			VMLINUX_SYMBOL(__stop_mcount_loc) = .;
 #endif
 #else
 #define MCOUNT_REC()
 #endif
 
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
-#define LIKELY_PROFILE()	__start_annotated_branch_profile = .;	\
-				KEEP(*(_ftrace_annotated_branch))	\
-				__stop_annotated_branch_profile = .;
+#define LIKELY_PROFILE()	VMLINUX_SYMBOL(__start_annotated_branch_profile) = .; \
+				KEEP(*(_ftrace_annotated_branch))		      \
+				VMLINUX_SYMBOL(__stop_annotated_branch_profile) = .;
 #else
 #define LIKELY_PROFILE()
 #endif
 
 #ifdef CONFIG_PROFILE_ALL_BRANCHES
-#define BRANCH_PROFILE()	__start_branch_profile = .;		\
-				KEEP(*(_ftrace_branch))			\
-				__stop_branch_profile = .;
+#define BRANCH_PROFILE()	VMLINUX_SYMBOL(__start_branch_profile) = .;   \
+				KEEP(*(_ftrace_branch))			      \
+				VMLINUX_SYMBOL(__stop_branch_profile) = .;
 #else
 #define BRANCH_PROFILE()
 #endif
 
 #ifdef CONFIG_KPROBES
 #define KPROBE_BLACKLIST()	. = ALIGN(8);				      \
-				__start_kprobe_blacklist = .;		      \
+				VMLINUX_SYMBOL(__start_kprobe_blacklist) = .; \
 				KEEP(*(_kprobe_blacklist))		      \
-				__stop_kprobe_blacklist = .;
+				VMLINUX_SYMBOL(__stop_kprobe_blacklist) = .;
 #else
 #define KPROBE_BLACKLIST()
 #endif
 
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 #define ERROR_INJECT_WHITELIST()	STRUCT_ALIGN();			      \
-			__start_error_injection_whitelist = .;		      \
+			VMLINUX_SYMBOL(__start_error_injection_whitelist) = .;\
 			KEEP(*(_error_injection_whitelist))		      \
-			__stop_error_injection_whitelist = .;
+			VMLINUX_SYMBOL(__stop_error_injection_whitelist) = .;
 #else
 #define ERROR_INJECT_WHITELIST()
 #endif
 
 #ifdef CONFIG_EVENT_TRACING
 #define FTRACE_EVENTS()	. = ALIGN(8);					\
-			__start_ftrace_events = .;			\
+			VMLINUX_SYMBOL(__start_ftrace_events) = .;	\
 			KEEP(*(_ftrace_events))				\
-			__stop_ftrace_events = .;			\
-			__start_ftrace_eval_maps = .;			\
+			VMLINUX_SYMBOL(__stop_ftrace_events) = .;	\
+			VMLINUX_SYMBOL(__start_ftrace_eval_maps) = .;	\
 			KEEP(*(_ftrace_eval_map))			\
-			__stop_ftrace_eval_maps = .;
+			VMLINUX_SYMBOL(__stop_ftrace_eval_maps) = .;
 #else
 #define FTRACE_EVENTS()
 #endif
 
 #ifdef CONFIG_TRACING
-#define TRACE_PRINTKS()	 __start___trace_bprintk_fmt = .;      \
+#define TRACE_PRINTKS() VMLINUX_SYMBOL(__start___trace_bprintk_fmt) = .;      \
 			 KEEP(*(__trace_printk_fmt)) /* Trace_printk fmt' pointer */ \
-			 __stop___trace_bprintk_fmt = .;
-#define TRACEPOINT_STR() __start___tracepoint_str = .;	\
+			 VMLINUX_SYMBOL(__stop___trace_bprintk_fmt) = .;
+#define TRACEPOINT_STR() VMLINUX_SYMBOL(__start___tracepoint_str) = .;	\
 			 KEEP(*(__tracepoint_str)) /* Trace_printk fmt' pointer */ \
-			 __stop___tracepoint_str = .;
+			 VMLINUX_SYMBOL(__stop___tracepoint_str) = .;
 #else
 #define TRACE_PRINTKS()
 #define TRACEPOINT_STR()
@@ -185,27 +187,27 @@
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #define TRACE_SYSCALLS() . = ALIGN(8);					\
-			 __start_syscalls_metadata = .;			\
+			 VMLINUX_SYMBOL(__start_syscalls_metadata) = .;	\
 			 KEEP(*(__syscalls_metadata))			\
-			 __stop_syscalls_metadata = .;
+			 VMLINUX_SYMBOL(__stop_syscalls_metadata) = .;
 #else
 #define TRACE_SYSCALLS()
 #endif
 
 #ifdef CONFIG_BPF_EVENTS
 #define BPF_RAW_TP() STRUCT_ALIGN();					\
-			 __start__bpf_raw_tp = .;			\
+			 VMLINUX_SYMBOL(__start__bpf_raw_tp) = .;	\
 			 KEEP(*(__bpf_raw_tp_map))			\
-			 __stop__bpf_raw_tp = .;
+			 VMLINUX_SYMBOL(__stop__bpf_raw_tp) = .;
 #else
 #define BPF_RAW_TP()
 #endif
 
 #ifdef CONFIG_SERIAL_EARLYCON
 #define EARLYCON_TABLE() . = ALIGN(8);				\
-			 __earlycon_table = .;			\
+			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
 			 KEEP(*(__earlycon_table))		\
-			 __earlycon_table_end = .;
+			 VMLINUX_SYMBOL(__earlycon_table_end) = .;
 #else
 #define EARLYCON_TABLE()
 #endif
@@ -225,7 +227,7 @@
 #define _OF_TABLE_0(name)
 #define _OF_TABLE_1(name)						\
 	. = ALIGN(8);							\
-	__##name##_of_table = .;					\
+	VMLINUX_SYMBOL(__##name##_of_table) = .;			\
 	KEEP(*(__##name##_of_table))					\
 	KEEP(*(__##name##_of_table_end))
 
@@ -239,9 +241,9 @@
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
 	. = ALIGN(8);							\
-	__##name##_acpi_probe_table = .;				\
+	VMLINUX_SYMBOL(__##name##_acpi_probe_table) = .;		\
 	KEEP(*(__##name##_acpi_probe_table))				\
-	__##name##_acpi_probe_table_end = .;
+	VMLINUX_SYMBOL(__##name##_acpi_probe_table_end) = .;
 #else
 #define ACPI_PROBE_TABLE(name)
 #endif
@@ -258,9 +260,9 @@
 
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
-	__dtb_start = .;						\
+	VMLINUX_SYMBOL(__dtb_start) = .;				\
 	KEEP(*(.dtb.init.rodata))					\
-	__dtb_end = .;
+	VMLINUX_SYMBOL(__dtb_end) = .;
 
 /*
  * .data section
@@ -273,16 +275,16 @@
 	MEM_KEEP(init.data*)						\
 	MEM_KEEP(exit.data*)						\
 	*(.data.unlikely)						\
-	__start_once = .;						\
+	VMLINUX_SYMBOL(__start_once) = .;				\
 	*(.data.once)							\
-	__end_once = .;							\
+	VMLINUX_SYMBOL(__end_once) = .;					\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);							\
-	__start___verbose = .;						\
+	VMLINUX_SYMBOL(__start___verbose) = .;                          \
 	KEEP(*(__verbose))                                              \
-	__stop___verbose = .;						\
+	VMLINUX_SYMBOL(__stop___verbose) = .;				\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
@@ -294,10 +296,10 @@
  */
 #define NOSAVE_DATA							\
 	. = ALIGN(PAGE_SIZE);						\
-	__nosave_begin = .;						\
+	VMLINUX_SYMBOL(__nosave_begin) = .;				\
 	*(.data..nosave)						\
 	. = ALIGN(PAGE_SIZE);						\
-	__nosave_end = .;
+	VMLINUX_SYMBOL(__nosave_end) = .;
 
 #define PAGE_ALIGNED_DATA(page_align)					\
 	. = ALIGN(page_align);						\
@@ -314,13 +316,13 @@
 
 #define INIT_TASK_DATA(align)						\
 	. = ALIGN(align);						\
-	__start_init_task = .;						\
-	init_thread_union = .;						\
-	init_stack = .;							\
+	VMLINUX_SYMBOL(__start_init_task) = .;				\
+	VMLINUX_SYMBOL(init_thread_union) = .;				\
+	VMLINUX_SYMBOL(init_stack) = .;					\
 	KEEP(*(.data..init_task))					\
 	KEEP(*(.data..init_thread_info))				\
-	. = __start_init_task + THREAD_SIZE;				\
-	__end_init_task = .;
+	. = VMLINUX_SYMBOL(__start_init_task) + THREAD_SIZE;		\
+	VMLINUX_SYMBOL(__end_init_task) = .;
 
 #define JUMP_TABLE_DATA							\
 	. = ALIGN(8);							\
@@ -334,10 +336,10 @@
  */
 #ifndef RO_AFTER_INIT_DATA
 #define RO_AFTER_INIT_DATA						\
-	__start_ro_after_init = .;					\
+	VMLINUX_SYMBOL(__start_ro_after_init) = .;			\
 	*(.data..ro_after_init)						\
 	JUMP_TABLE_DATA							\
-	__end_ro_after_init = .;
+	VMLINUX_SYMBOL(__end_ro_after_init) = .;
 #endif
 
 /*
@@ -346,13 +348,13 @@
 #define RO_DATA_SECTION(align)						\
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
-		__start_rodata = .;					\
+		VMLINUX_SYMBOL(__start_rodata) = .;			\
 		*(.rodata) *(.rodata.*)					\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
-		__start___tracepoints_ptrs = .;				\
+		VMLINUX_SYMBOL(__start___tracepoints_ptrs) = .;		\
 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
-		__stop___tracepoints_ptrs = .;				\
+		VMLINUX_SYMBOL(__stop___tracepoints_ptrs) = .;		\
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
 	}								\
 									\
@@ -362,109 +364,109 @@
 									\
 	/* PCI quirks */						\
 	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
-		__start_pci_fixups_early = .;				\
+		VMLINUX_SYMBOL(__start_pci_fixups_early) = .;		\
 		KEEP(*(.pci_fixup_early))				\
-		__end_pci_fixups_early = .;				\
-		__start_pci_fixups_header = .;				\
+		VMLINUX_SYMBOL(__end_pci_fixups_early) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_header) = .;		\
 		KEEP(*(.pci_fixup_header))				\
-		__end_pci_fixups_header = .;				\
-		__start_pci_fixups_final = .;				\
+		VMLINUX_SYMBOL(__end_pci_fixups_header) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_final) = .;		\
 		KEEP(*(.pci_fixup_final))				\
-		__end_pci_fixups_final = .;				\
-		__start_pci_fixups_enable = .;				\
+		VMLINUX_SYMBOL(__end_pci_fixups_final) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_enable) = .;		\
 		KEEP(*(.pci_fixup_enable))				\
-		__end_pci_fixups_enable = .;				\
-		__start_pci_fixups_resume = .;				\
+		VMLINUX_SYMBOL(__end_pci_fixups_enable) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_resume) = .;		\
 		KEEP(*(.pci_fixup_resume))				\
-		__end_pci_fixups_resume = .;				\
-		__start_pci_fixups_resume_early = .;			\
+		VMLINUX_SYMBOL(__end_pci_fixups_resume) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_resume_early) = .;	\
 		KEEP(*(.pci_fixup_resume_early))			\
-		__end_pci_fixups_resume_early = .;			\
-		__start_pci_fixups_suspend = .;				\
+		VMLINUX_SYMBOL(__end_pci_fixups_resume_early) = .;	\
+		VMLINUX_SYMBOL(__start_pci_fixups_suspend) = .;		\
 		KEEP(*(.pci_fixup_suspend))				\
-		__end_pci_fixups_suspend = .;				\
-		__start_pci_fixups_suspend_late = .;			\
+		VMLINUX_SYMBOL(__end_pci_fixups_suspend) = .;		\
+		VMLINUX_SYMBOL(__start_pci_fixups_suspend_late) = .;	\
 		KEEP(*(.pci_fixup_suspend_late))			\
-		__end_pci_fixups_suspend_late = .;			\
+		VMLINUX_SYMBOL(__end_pci_fixups_suspend_late) = .;	\
 	}								\
 									\
 	/* Built-in firmware blobs */					\
 	.builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
-		__start_builtin_fw = .;					\
+		VMLINUX_SYMBOL(__start_builtin_fw) = .;			\
 		KEEP(*(.builtin_fw))					\
-		__end_builtin_fw = .;					\
+		VMLINUX_SYMBOL(__end_builtin_fw) = .;			\
 	}								\
 									\
 	TRACEDATA							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
-		__start___ksymtab = .;					\
+		VMLINUX_SYMBOL(__start___ksymtab) = .;			\
 		KEEP(*(SORT(___ksymtab+*)))				\
-		__stop___ksymtab = .;					\
+		VMLINUX_SYMBOL(__stop___ksymtab) = .;			\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
 	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
-		__start___ksymtab_gpl = .;				\
+		VMLINUX_SYMBOL(__start___ksymtab_gpl) = .;		\
 		KEEP(*(SORT(___ksymtab_gpl+*)))				\
-		__stop___ksymtab_gpl = .;				\
+		VMLINUX_SYMBOL(__stop___ksymtab_gpl) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: Normal unused symbols */		\
 	__ksymtab_unused  : AT(ADDR(__ksymtab_unused) - LOAD_OFFSET) {	\
-		__start___ksymtab_unused = .;				\
+		VMLINUX_SYMBOL(__start___ksymtab_unused) = .;		\
 		KEEP(*(SORT(___ksymtab_unused+*)))			\
-		__stop___ksymtab_unused = .;				\
+		VMLINUX_SYMBOL(__stop___ksymtab_unused) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only unused symbols */		\
 	__ksymtab_unused_gpl : AT(ADDR(__ksymtab_unused_gpl) - LOAD_OFFSET) { \
-		__start___ksymtab_unused_gpl = .;			\
+		VMLINUX_SYMBOL(__start___ksymtab_unused_gpl) = .;	\
 		KEEP(*(SORT(___ksymtab_unused_gpl+*)))			\
-		__stop___ksymtab_unused_gpl = .;			\
+		VMLINUX_SYMBOL(__stop___ksymtab_unused_gpl) = .;	\
 	}								\
 									\
 	/* Kernel symbol table: GPL-future-only symbols */		\
 	__ksymtab_gpl_future : AT(ADDR(__ksymtab_gpl_future) - LOAD_OFFSET) { \
-		__start___ksymtab_gpl_future = .;			\
+		VMLINUX_SYMBOL(__start___ksymtab_gpl_future) = .;	\
 		KEEP(*(SORT(___ksymtab_gpl_future+*)))			\
-		__stop___ksymtab_gpl_future = .;			\
+		VMLINUX_SYMBOL(__stop___ksymtab_gpl_future) = .;	\
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
-		__start___kcrctab = .;					\
+		VMLINUX_SYMBOL(__start___kcrctab) = .;			\
 		KEEP(*(SORT(___kcrctab+*)))				\
-		__stop___kcrctab = .;					\
+		VMLINUX_SYMBOL(__stop___kcrctab) = .;			\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
 	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
-		__start___kcrctab_gpl = .;				\
+		VMLINUX_SYMBOL(__start___kcrctab_gpl) = .;		\
 		KEEP(*(SORT(___kcrctab_gpl+*)))				\
-		__stop___kcrctab_gpl = .;				\
+		VMLINUX_SYMBOL(__stop___kcrctab_gpl) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: Normal unused symbols */		\
 	__kcrctab_unused  : AT(ADDR(__kcrctab_unused) - LOAD_OFFSET) {	\
-		__start___kcrctab_unused = .;				\
+		VMLINUX_SYMBOL(__start___kcrctab_unused) = .;		\
 		KEEP(*(SORT(___kcrctab_unused+*)))			\
-		__stop___kcrctab_unused = .;				\
+		VMLINUX_SYMBOL(__stop___kcrctab_unused) = .;		\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only unused symbols */		\
 	__kcrctab_unused_gpl : AT(ADDR(__kcrctab_unused_gpl) - LOAD_OFFSET) { \
-		__start___kcrctab_unused_gpl = .;			\
+		VMLINUX_SYMBOL(__start___kcrctab_unused_gpl) = .;	\
 		KEEP(*(SORT(___kcrctab_unused_gpl+*)))			\
-		__stop___kcrctab_unused_gpl = .;			\
+		VMLINUX_SYMBOL(__stop___kcrctab_unused_gpl) = .;	\
 	}								\
 									\
 	/* Kernel symbol table: GPL-future-only symbols */		\
 	__kcrctab_gpl_future : AT(ADDR(__kcrctab_gpl_future) - LOAD_OFFSET) { \
-		__start___kcrctab_gpl_future = .;			\
+		VMLINUX_SYMBOL(__start___kcrctab_gpl_future) = .;	\
 		KEEP(*(SORT(___kcrctab_gpl_future+*)))			\
-		__stop___kcrctab_gpl_future = .;			\
+		VMLINUX_SYMBOL(__stop___kcrctab_gpl_future) = .;	\
 	}								\
 									\
 	/* Kernel symbol table: strings */				\
@@ -481,18 +483,18 @@
 									\
 	/* Built-in module parameters. */				\
 	__param : AT(ADDR(__param) - LOAD_OFFSET) {			\
-		__start___param = .;					\
+		VMLINUX_SYMBOL(__start___param) = .;			\
 		KEEP(*(__param))					\
-		__stop___param = .;					\
+		VMLINUX_SYMBOL(__stop___param) = .;			\
 	}								\
 									\
 	/* Built-in module versions. */					\
 	__modver : AT(ADDR(__modver) - LOAD_OFFSET) {			\
-		__start___modver = .;					\
+		VMLINUX_SYMBOL(__start___modver) = .;			\
 		KEEP(*(__modver))					\
-		__stop___modver = .;					\
+		VMLINUX_SYMBOL(__stop___modver) = .;			\
 		. = ALIGN((align));					\
-		__end_rodata = .;					\
+		VMLINUX_SYMBOL(__end_rodata) = .;			\
 	}								\
 	. = ALIGN((align));
 
@@ -522,47 +524,47 @@
  * address even at second ld pass when generating System.map */
 #define SCHED_TEXT							\
 		ALIGN_FUNCTION();					\
-		__sched_text_start = .;					\
+		VMLINUX_SYMBOL(__sched_text_start) = .;			\
 		*(.sched.text)						\
-		__sched_text_end = .;
+		VMLINUX_SYMBOL(__sched_text_end) = .;
 
 /* spinlock.text is aling to function alignment to secure we have same
  * address even at second ld pass when generating System.map */
 #define LOCK_TEXT							\
 		ALIGN_FUNCTION();					\
-		__lock_text_start = .;					\
+		VMLINUX_SYMBOL(__lock_text_start) = .;			\
 		*(.spinlock.text)					\
-		__lock_text_end = .;
+		VMLINUX_SYMBOL(__lock_text_end) = .;
 
 #define CPUIDLE_TEXT							\
 		ALIGN_FUNCTION();					\
-		__cpuidle_text_start = .;				\
+		VMLINUX_SYMBOL(__cpuidle_text_start) = .;		\
 		*(.cpuidle.text)					\
-		__cpuidle_text_end = .;
+		VMLINUX_SYMBOL(__cpuidle_text_end) = .;
 
 #define KPROBES_TEXT							\
 		ALIGN_FUNCTION();					\
-		__kprobes_text_start = .;				\
+		VMLINUX_SYMBOL(__kprobes_text_start) = .;		\
 		*(.kprobes.text)					\
-		__kprobes_text_end = .;
+		VMLINUX_SYMBOL(__kprobes_text_end) = .;
 
 #define ENTRY_TEXT							\
 		ALIGN_FUNCTION();					\
-		__entry_text_start = .;					\
+		VMLINUX_SYMBOL(__entry_text_start) = .;			\
 		*(.entry.text)						\
-		__entry_text_end = .;
+		VMLINUX_SYMBOL(__entry_text_end) = .;
 
 #define IRQENTRY_TEXT							\
 		ALIGN_FUNCTION();					\
-		__irqentry_text_start = .;				\
+		VMLINUX_SYMBOL(__irqentry_text_start) = .;		\
 		*(.irqentry.text)					\
-		__irqentry_text_end = .;
+		VMLINUX_SYMBOL(__irqentry_text_end) = .;
 
 #define SOFTIRQENTRY_TEXT						\
 		ALIGN_FUNCTION();					\
-		__softirqentry_text_start = .;				\
+		VMLINUX_SYMBOL(__softirqentry_text_start) = .;		\
 		*(.softirqentry.text)					\
-		__softirqentry_text_end = .;
+		VMLINUX_SYMBOL(__softirqentry_text_end) = .;
 
 /* Section used for early init (in .S files) */
 #define HEAD_TEXT  KEEP(*(.head.text))
@@ -578,9 +580,9 @@
 #define EXCEPTION_TABLE(align)						\
 	. = ALIGN(align);						\
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {		\
-		__start___ex_table = .;					\
+		VMLINUX_SYMBOL(__start___ex_table) = .;			\
 		KEEP(*(__ex_table))					\
-		__stop___ex_table = .;					\
+		VMLINUX_SYMBOL(__stop___ex_table) = .;			\
 	}
 
 /*
@@ -594,11 +596,11 @@
 
 #ifdef CONFIG_CONSTRUCTORS
 #define KERNEL_CTORS()	. = ALIGN(8);			   \
-			__ctors_start = .;		   \
+			VMLINUX_SYMBOL(__ctors_start) = .; \
 			KEEP(*(.ctors))			   \
 			KEEP(*(SORT(.init_array.*)))	   \
 			KEEP(*(.init_array))		   \
-			__ctors_end = .;
+			VMLINUX_SYMBOL(__ctors_end) = .;
 #else
 #define KERNEL_CTORS()
 #endif
@@ -734,9 +736,9 @@
 #define BUG_TABLE							\
 	. = ALIGN(8);							\
 	__bug_table : AT(ADDR(__bug_table) - LOAD_OFFSET) {		\
-		__start___bug_table = .;				\
+		VMLINUX_SYMBOL(__start___bug_table) = .;		\
 		KEEP(*(__bug_table))					\
-		__stop___bug_table = .;					\
+		VMLINUX_SYMBOL(__stop___bug_table) = .;			\
 	}
 #else
 #define BUG_TABLE
@@ -746,22 +748,22 @@
 #define ORC_UNWIND_TABLE						\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
-		__start_orc_unwind_ip = .;				\
+		VMLINUX_SYMBOL(__start_orc_unwind_ip) = .;		\
 		KEEP(*(.orc_unwind_ip))					\
-		__stop_orc_unwind_ip = .;				\
+		VMLINUX_SYMBOL(__stop_orc_unwind_ip) = .;		\
 	}								\
 	. = ALIGN(2);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
-		__start_orc_unwind = .;					\
+		VMLINUX_SYMBOL(__start_orc_unwind) = .;			\
 		KEEP(*(.orc_unwind))					\
-		__stop_orc_unwind = .;					\
+		VMLINUX_SYMBOL(__stop_orc_unwind) = .;			\
 	}								\
 	. = ALIGN(4);							\
 	.orc_lookup : AT(ADDR(.orc_lookup) - LOAD_OFFSET) {		\
-		orc_lookup = .;						\
+		VMLINUX_SYMBOL(orc_lookup) = .;				\
 		. += (((SIZEOF(.text) + LOOKUP_BLOCK_SIZE - 1) /	\
 			LOOKUP_BLOCK_SIZE) + 1) * 4;			\
-		orc_lookup_end = .;					\
+		VMLINUX_SYMBOL(orc_lookup_end) = .;			\
 	}
 #else
 #define ORC_UNWIND_TABLE
@@ -771,9 +773,9 @@
 #define TRACEDATA							\
 	. = ALIGN(4);							\
 	.tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {		\
-		__tracedata_start = .;					\
+		VMLINUX_SYMBOL(__tracedata_start) = .;			\
 		KEEP(*(.tracedata))					\
-		__tracedata_end = .;					\
+		VMLINUX_SYMBOL(__tracedata_end) = .;			\
 	}
 #else
 #define TRACEDATA
@@ -781,24 +783,24 @@
 
 #define NOTES								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
-		__start_notes = .;					\
+		VMLINUX_SYMBOL(__start_notes) = .;			\
 		KEEP(*(.note.*))					\
-		__stop_notes = .;					\
+		VMLINUX_SYMBOL(__stop_notes) = .;			\
 	}
 
 #define INIT_SETUP(initsetup_align)					\
 		. = ALIGN(initsetup_align);				\
-		__setup_start = .;					\
+		VMLINUX_SYMBOL(__setup_start) = .;			\
 		KEEP(*(.init.setup))					\
-		__setup_end = .;
+		VMLINUX_SYMBOL(__setup_end) = .;
 
 #define INIT_CALLS_LEVEL(level)						\
-		__initcall##level##_start = .;				\
+		VMLINUX_SYMBOL(__initcall##level##_start) = .;		\
 		KEEP(*(.initcall##level##.init))			\
 		KEEP(*(.initcall##level##s.init))			\
 
 #define INIT_CALLS							\
-		__initcall_start = .;					\
+		VMLINUX_SYMBOL(__initcall_start) = .;			\
 		KEEP(*(.initcallearly.init))				\
 		INIT_CALLS_LEVEL(0)					\
 		INIT_CALLS_LEVEL(1)					\
@@ -809,17 +811,17 @@
 		INIT_CALLS_LEVEL(rootfs)				\
 		INIT_CALLS_LEVEL(6)					\
 		INIT_CALLS_LEVEL(7)					\
-		__initcall_end = .;
+		VMLINUX_SYMBOL(__initcall_end) = .;
 
 #define CON_INITCALL							\
-		__con_initcall_start = .;				\
+		VMLINUX_SYMBOL(__con_initcall_start) = .;		\
 		KEEP(*(.con_initcall.init))				\
-		__con_initcall_end = .;
+		VMLINUX_SYMBOL(__con_initcall_end) = .;
 
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
-	__initramfs_start = .;						\
+	VMLINUX_SYMBOL(__initramfs_start) = .;				\
 	KEEP(*(.init.ramfs))						\
 	. = ALIGN(8);							\
 	KEEP(*(.init.ramfs.info))
@@ -875,7 +877,7 @@
  * sharing between subsections for different purposes.
  */
 #define PERCPU_INPUT(cacheline)						\
-	__per_cpu_start = .;						\
+	VMLINUX_SYMBOL(__per_cpu_start) = .;				\
 	*(.data..percpu..first)						\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
@@ -885,7 +887,7 @@
 	*(.data..percpu)						\
 	*(.data..percpu..shared_aligned)				\
 	PERCPU_DECRYPTED_SECTION					\
-	__per_cpu_end = .;
+	VMLINUX_SYMBOL(__per_cpu_end) = .;
 
 /**
  * PERCPU_VADDR - define output section for percpu area
@@ -912,11 +914,12 @@
  * address, use PERCPU_SECTION.
  */
 #define PERCPU_VADDR(cacheline, vaddr, phdr)				\
-	__per_cpu_load = .;						\
-	.data..percpu vaddr : AT(__per_cpu_load - LOAD_OFFSET) {	\
+	VMLINUX_SYMBOL(__per_cpu_load) = .;				\
+	.data..percpu vaddr : AT(VMLINUX_SYMBOL(__per_cpu_load)		\
+				- LOAD_OFFSET) {			\
 		PERCPU_INPUT(cacheline)					\
 	} phdr								\
-	. = __per_cpu_load + SIZEOF(.data..percpu);
+	. = VMLINUX_SYMBOL(__per_cpu_load) + SIZEOF(.data..percpu);
 
 /**
  * PERCPU_SECTION - define output section for percpu area, simple version
@@ -933,7 +936,7 @@
 #define PERCPU_SECTION(cacheline)					\
 	. = ALIGN(PAGE_SIZE);						\
 	.data..percpu	: AT(ADDR(.data..percpu) - LOAD_OFFSET) {	\
-		__per_cpu_load = .;					\
+		VMLINUX_SYMBOL(__per_cpu_load) = .;			\
 		PERCPU_INPUT(cacheline)					\
 	}
 
@@ -972,9 +975,9 @@
 #define INIT_TEXT_SECTION(inittext_align)				\
 	. = ALIGN(inittext_align);					\
 	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {		\
-		_sinittext = .;						\
+		VMLINUX_SYMBOL(_sinittext) = .;				\
 		INIT_TEXT						\
-		_einittext = .;						\
+		VMLINUX_SYMBOL(_einittext) = .;				\
 	}
 
 #define INIT_DATA_SECTION(initsetup_align)				\
@@ -988,8 +991,8 @@
 
 #define BSS_SECTION(sbss_align, bss_align, stop_align)			\
 	. = ALIGN(sbss_align);						\
-	__bss_start = .;						\
+	VMLINUX_SYMBOL(__bss_start) = .;				\
 	SBSS(sbss_align)						\
 	BSS(bss_align)							\
 	. = ALIGN(stop_align);						\
-	__bss_stop = .;
+	VMLINUX_SYMBOL(__bss_stop) = .;
diff --git a/include/linux/export.h b/include/linux/export.h
index fd8711ed9ac4..34c34d09103c 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -10,6 +10,19 @@
  * hackers place grumpy comments in header files.
  */
 
+/* Some toolchains use a `_' prefix for all user symbols. */
+#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+#define __VMLINUX_SYMBOL(x) _##x
+#define __VMLINUX_SYMBOL_STR(x) "_" #x
+#else
+#define __VMLINUX_SYMBOL(x) x
+#define __VMLINUX_SYMBOL_STR(x) #x
+#endif
+
+/* Indirect, so macros are expanded before pasting. */
+#define VMLINUX_SYMBOL(x) __VMLINUX_SYMBOL(x)
+#define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
+
 #ifndef __ASSEMBLY__
 #ifdef MODULE
 extern struct module __this_module;
@@ -27,14 +40,14 @@ extern struct module __this_module;
 #if defined(CONFIG_MODULE_REL_CRCS)
 #define __CRC_SYMBOL(sym, sec)						\
 	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.weak	__crc_" #sym "				\n"	\
-	    "	.long	__crc_" #sym " - .			\n"	\
+	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
+	    "	.long	" VMLINUX_SYMBOL_STR(__crc_##sym) " - .	\n"	\
 	    "	.previous					\n");
 #else
 #define __CRC_SYMBOL(sym, sec)						\
 	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.weak	__crc_" #sym "				\n"	\
-	    "	.long	__crc_" #sym "				\n"	\
+	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
+	    "	.long	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
 	    "	.previous					\n");
 #endif
 #else
@@ -80,7 +93,7 @@ struct kernel_symbol {
 	__CRC_SYMBOL(sym, sec)						\
 	static const char __kstrtab_##sym[]				\
 	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
-	= #sym;								\
+	= VMLINUX_SYMBOL_STR(#sym);					\
 	__KSYMTAB_ENTRY(sym, sec)
 
 #if defined(__DISABLE_EXPORTS)
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 7e020782ade2..d287823ee947 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -24,16 +24,16 @@
 
 #ifndef cond_syscall
 #define cond_syscall(x)	asm(				\
-	".weak " __stringify(x) "\n\t"			\
-	".set  " __stringify(x) ","			\
-		 __stringify(sys_ni_syscall))
+	".weak " VMLINUX_SYMBOL_STR(x) "\n\t"		\
+	".set  " VMLINUX_SYMBOL_STR(x) ","		\
+		 VMLINUX_SYMBOL_STR(sys_ni_syscall))
 #endif
 
 #ifndef SYSCALL_ALIAS
 #define SYSCALL_ALIAS(alias, name) asm(			\
-	".globl " __stringify(alias) "\n\t"		\
-	".set   " __stringify(alias) ","		\
-		  __stringify(name))
+	".globl " VMLINUX_SYMBOL_STR(alias) "\n\t"	\
+	".set   " VMLINUX_SYMBOL_STR(alias) ","		\
+		  VMLINUX_SYMBOL_STR(name))
 #endif
 
 #define __page_aligned_data	__section(.data..page_aligned) __aligned(PAGE_SIZE)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2f66ed388d1c..aa4dac94e563 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -123,6 +123,7 @@ $(obj)/%.i: $(src)/%.c FORCE
 cmd_gensymtypes_c =                                                         \
     $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
     scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
+     $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
      $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
      $(if $(KBUILD_PRESERVE),-p)                                            \
      -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
@@ -334,6 +335,7 @@ cmd_gensymtypes_S =                                                         \
      sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ; } | \
     $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
     scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
+     $(patsubst y,-s _,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))             \
      $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
      $(if $(KBUILD_PRESERVE),-p)                                            \
      -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
@@ -444,10 +446,15 @@ targets += $(lib-target)
 
 dummy-object = $(obj)/.lib_exports.o
 ksyms-lds = $(dot-target).lds
+ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+ref_prefix = EXTERN(_
+else
+ref_prefix = EXTERN(
+endif
 
 quiet_cmd_export_list = EXPORTS $@
 cmd_export_list = $(OBJDUMP) -h $< | \
-	sed -ne '/___ksymtab/s/.*+\([^ ]*\).*/EXTERN(\1)/p' >$(ksyms-lds);\
+	sed -ne '/___ksymtab/s/.*+\([^ ]*\).*/$(ref_prefix)\1)/p' >$(ksyms-lds);\
 	rm -f $(dummy-object);\
 	echo | $(CC) $(a_flags) -c -o $(dummy-object) -x assembler -;\
 	$(LD) $(ld_flags) -r -o $@ -T $(ksyms-lds) $(dummy-object);\
diff --git a/scripts/adjust_autoksyms.sh b/scripts/adjust_autoksyms.sh
index a904bf1f5e67..e6023399ceb0 100755
--- a/scripts/adjust_autoksyms.sh
+++ b/scripts/adjust_autoksyms.sh
@@ -49,6 +49,12 @@ EOT
 sed 's/ko$/mod/' modules.order |
 xargs -n1 sed -n -e '2{s/ /\n/g;/^$/!p;}' -- |
 sort -u |
+while read sym; do
+	if [ -n "$CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX" ]; then
+		sym="${sym#_}"
+	fi
+	echo ${sym}
+done |
 sed -e 's/\(.*\)/#define __KSYM_\1 1/' >> "$new_ksyms_file"
 
 # Special case for modversions (see modpost.c)
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e739f565497e..c65f5647d2af 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5274,6 +5274,16 @@ sub process {
 			}
 		}
 
+# make sure symbols are always wrapped with VMLINUX_SYMBOL() ...
+# all assignments may have only one of the following with an assignment:
+#	.
+#	ALIGN(...)
+#	VMLINUX_SYMBOL(...)
+		if ($realfile eq 'vmlinux.lds.h' && $line =~ /(?:(?:^|\s)$Ident\s*=|=\s*$Ident(?:\s|$))/) {
+			WARN("MISSING_VMLINUX_SYMBOL",
+			     "vmlinux.lds.h needs VMLINUX_SYMBOL() around C-visible symbols\n" . $herecurr);
+		}
+
 # check for redundant bracing round if etc
 		if ($line =~ /(^.*)\bif\b/ && $1 !~ /else\s*$/) {
 			my ($level, $endln, @chunks) =
diff --git a/scripts/depmod.sh b/scripts/depmod.sh
index e083bcae343f..805b6d5b36a2 100755
--- a/scripts/depmod.sh
+++ b/scripts/depmod.sh
@@ -3,12 +3,13 @@
 #
 # A depmod wrapper used by the toplevel Makefile
 
-if test $# -ne 2; then
-	echo "Usage: $0 /sbin/depmod <kernelrelease>" >&2
+if test $# -ne 3; then
+	echo "Usage: $0 /sbin/depmod <kernelrelease> <symbolprefix>" >&2
 	exit 1
 fi
 DEPMOD=$1
 KERNELRELEASE=$2
+SYMBOL_PREFIX=$3
 
 if ! test -r System.map ; then
 	echo "Warning: modules_install: missing 'System.map' file. Skipping depmod." >&2
@@ -21,6 +22,24 @@ if [ -z $(command -v $DEPMOD) ]; then
 	exit 0
 fi
 
+# older versions of depmod don't support -P <symbol-prefix>
+# support was added in module-init-tools 3.13
+if test -n "$SYMBOL_PREFIX"; then
+	release=$("$DEPMOD" --version)
+	package=$(echo "$release" | cut -d' ' -f 1)
+	if test "$package" = "module-init-tools"; then
+		version=$(echo "$release" | cut -d' ' -f 2)
+		later=$(printf '%s\n' "$version" "3.13" | sort -V | tail -n 1)
+		if test "$later" != "$version"; then
+			# module-init-tools < 3.13, drop the symbol prefix
+			SYMBOL_PREFIX=""
+		fi
+	fi
+	if test -n "$SYMBOL_PREFIX"; then
+		SYMBOL_PREFIX="-P $SYMBOL_PREFIX"
+	fi
+fi
+
 # older versions of depmod require the version string to start with three
 # numbers, so we cheat with a symlink here
 depmod_hack_needed=true
@@ -43,7 +62,7 @@ set -- -ae -F System.map
 if test -n "$INSTALL_MOD_PATH"; then
 	set -- "$@" -b "$INSTALL_MOD_PATH"
 fi
-"$DEPMOD" "$@" "$KERNELRELEASE"
+"$DEPMOD" "$@" "$KERNELRELEASE" $SYMBOL_PREFIX
 ret=$?
 
 if $depmod_hack_needed; then
diff --git a/scripts/genksyms/genksyms.c b/scripts/genksyms/genksyms.c
index 23eff234184f..139bf698a7a8 100644
--- a/scripts/genksyms/genksyms.c
+++ b/scripts/genksyms/genksyms.c
@@ -34,6 +34,7 @@ int in_source_file;
 
 static int flag_debug, flag_dump_defs, flag_reference, flag_dump_types,
 	   flag_preserve, flag_warnings, flag_rel_crcs;
+static const char *mod_prefix = "";
 
 static int errors;
 static int nsyms;
@@ -681,10 +682,10 @@ void export_symbol(const char *name)
 			fputs(">\n", debugfile);
 
 		/* Used as a linker script. */
-		printf(!flag_rel_crcs ? "__crc_%s = 0x%08lx;\n" :
+		printf(!flag_rel_crcs ? "%s__crc_%s = 0x%08lx;\n" :
 		       "SECTIONS { .rodata : ALIGN(4) { "
-		       "__crc_%s = .; LONG(0x%08lx); } }\n",
-		       name, crc);
+		       "%s__crc_%s = .; LONG(0x%08lx); } }\n",
+		       mod_prefix, name, crc);
 	}
 }
 
@@ -757,6 +758,7 @@ int main(int argc, char **argv)
 
 #ifdef __GNU_LIBRARY__
 	struct option long_opts[] = {
+		{"symbol-prefix", 1, 0, 's'},
 		{"debug", 0, 0, 'd'},
 		{"warnings", 0, 0, 'w'},
 		{"quiet", 0, 0, 'q'},
@@ -776,6 +778,9 @@ int main(int argc, char **argv)
 	while ((o = getopt(argc, argv, "s:dwqVDr:T:phR")) != EOF)
 #endif				/* __GNU_LIBRARY__ */
 		switch (o) {
+		case 's':
+			mod_prefix = optarg;
+			break;
 		case 'd':
 			flag_debug++;
 			break;
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index ae6504d07fd6..75ec25554111 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -60,6 +60,7 @@ static struct sym_entry *table;
 static unsigned int table_size, table_cnt;
 static int all_symbols = 0;
 static int absolute_percpu = 0;
+static char symbol_prefix_char = '\0';
 static int base_relative = 0;
 
 static int token_profit[0x10000];
@@ -72,6 +73,7 @@ static unsigned char best_table_len[256];
 static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] "
+			"[--symbol-prefix=<prefix char>] "
 			"[--base-relative] < in.map > out.S\n");
 	exit(1);
 }
@@ -109,22 +111,28 @@ static int check_symbol_range(const char *sym, unsigned long long addr,
 
 static int read_symbol(FILE *in, struct sym_entry *s)
 {
-	char sym[500], stype;
+	char str[500];
+	char *sym, stype;
 	int rc;
 
-	rc = fscanf(in, "%llx %c %499s\n", &s->addr, &stype, sym);
+	rc = fscanf(in, "%llx %c %499s\n", &s->addr, &stype, str);
 	if (rc != 3) {
-		if (rc != EOF && fgets(sym, 500, in) == NULL)
+		if (rc != EOF && fgets(str, 500, in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return -1;
 	}
-	if (strlen(sym) >= KSYM_NAME_LEN) {
+	if (strlen(str) >= KSYM_NAME_LEN) {
 		fprintf(stderr, "Symbol %s too long for kallsyms (%zu >= %d).\n"
 				"Please increase KSYM_NAME_LEN both in kernel and kallsyms.c\n",
-			sym, strlen(sym), KSYM_NAME_LEN);
+			str, strlen(str), KSYM_NAME_LEN);
 		return -1;
 	}
 
+	sym = str;
+	/* skip prefix char */
+	if (symbol_prefix_char && str[0] == symbol_prefix_char)
+		sym++;
+
 	/* Ignore most absolute/undefined (?) symbols. */
 	if (strcmp(sym, "_text") == 0)
 		_text = s->addr;
@@ -145,7 +153,7 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 		 is_arm_mapping_symbol(sym))
 		return -1;
 	/* exclude also MIPS ELF local symbols ($L123 instead of .L123) */
-	else if (sym[0] == '$')
+	else if (str[0] == '$')
 		return -1;
 	/* exclude debugging symbols */
 	else if (stype == 'N' || stype == 'n')
@@ -156,14 +164,14 @@ static int read_symbol(FILE *in, struct sym_entry *s)
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
-	s->len = strlen(sym) + 1;
+	s->len = strlen(str) + 1;
 	s->sym = malloc(s->len + 1);
 	if (!s->sym) {
 		fprintf(stderr, "kallsyms failure: "
 			"unable to allocate required amount of memory\n");
 		exit(EXIT_FAILURE);
 	}
-	strcpy((char *)s->sym + 1, sym);
+	strcpy((char *)s->sym + 1, str);
 	s->sym[0] = stype;
 
 	s->percpu_absolute = 0;
@@ -226,6 +234,11 @@ static int symbol_valid(struct sym_entry *s)
 	int i;
 	char *sym_name = (char *)s->sym + 1;
 
+	/* skip prefix char */
+	if (symbol_prefix_char && *sym_name == symbol_prefix_char)
+		sym_name++;
+
+
 	/* if --all-symbols is not specified, then symbols outside the text
 	 * and inittext sections are discarded */
 	if (!all_symbols) {
@@ -290,9 +303,15 @@ static void read_map(FILE *in)
 
 static void output_label(char *label)
 {
-	printf(".globl %s\n", label);
+	if (symbol_prefix_char)
+		printf(".globl %c%s\n", symbol_prefix_char, label);
+	else
+		printf(".globl %s\n", label);
 	printf("\tALGN\n");
-	printf("%s:\n", label);
+	if (symbol_prefix_char)
+		printf("%c%s:\n", symbol_prefix_char, label);
+	else
+		printf("%s:\n", label);
 }
 
 /* uncompress a compressed symbol. When this function is called, the best table
@@ -749,7 +768,13 @@ int main(int argc, char **argv)
 				absolute_percpu = 1;
 			else if (strcmp(argv[i], "--base-relative") == 0)
 				base_relative = 1;
-			else
+			else if (strncmp(argv[i], "--symbol-prefix=", 16) == 0) {
+				char *p = &argv[i][16];
+				/* skip quote */
+				if ((*p == '"' && *(p+2) == '"') || (*p == '\'' && *(p+2) == '\''))
+					p++;
+				symbol_prefix_char = *p;
+			} else
 				usage();
 		}
 	} else if (argc != 1)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 915775eb2921..c3c5758ed7d6 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -117,6 +117,10 @@ kallsyms()
 	info KSYM ${2}
 	local kallsymopt;
 
+	if [ -n "${CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX}" ]; then
+		kallsymopt="${kallsymopt} --symbol-prefix=_"
+	fi
+
 	if [ -n "${CONFIG_KALLSYMS_ALL}" ]; then
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f277e116e0eb..555f152bbebe 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -19,7 +19,9 @@
 #include <stdbool.h>
 #include <errno.h>
 #include "modpost.h"
+#include "../../include/generated/autoconf.h"
 #include "../../include/linux/license.h"
+#include "../../include/linux/export.h"
 
 /* Are we using CONFIG_MODVERSIONS? */
 static int modversions = 0;
@@ -588,7 +590,7 @@ static void parse_elf_finish(struct elf_info *info)
 static int ignore_undef_symbol(struct elf_info *info, const char *symname)
 {
 	/* ignore __this_module, it will be resolved shortly */
-	if (strcmp(symname, "__this_module") == 0)
+	if (strcmp(symname, VMLINUX_SYMBOL_STR(__this_module)) == 0)
 		return 1;
 	/* ignore global offset table */
 	if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
@@ -614,6 +616,9 @@ static int ignore_undef_symbol(struct elf_info *info, const char *symname)
 	return 0;
 }
 
+#define CRC_PFX     VMLINUX_SYMBOL_STR(__crc_)
+#define KSYMTAB_PFX VMLINUX_SYMBOL_STR(__ksymtab_)
+
 static void handle_modversions(struct module *mod, struct elf_info *info,
 			       Elf_Sym *sym, const char *symname)
 {
@@ -628,7 +633,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 		export = export_from_sec(info, get_secindex(info, sym));
 
 	/* CRC'd symbol */
-	if (strstarts(symname, "__crc_")) {
+	if (strstarts(symname, CRC_PFX)) {
 		is_crc = true;
 		crc = (unsigned int) sym->st_value;
 		if (sym->st_shndx != SHN_UNDEF && sym->st_shndx != SHN_ABS) {
@@ -641,7 +646,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 				info->sechdrs[sym->st_shndx].sh_addr : 0);
 			crc = TO_NATIVE(*crcp);
 		}
-		sym_update_crc(symname + strlen("__crc_"), mod, crc,
+		sym_update_crc(symname + strlen(CRC_PFX), mod, crc,
 				export);
 	}
 
@@ -679,10 +684,15 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 		}
 #endif
 
+#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+		if (symname[0] != '_')
+			break;
+		else
+			symname++;
+#endif
 		if (is_crc) {
 			const char *e = is_vmlinux(mod->name) ?"":".ko";
-			warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n",
-			     symname + strlen("__crc_"), mod->name, e);
+			warn("EXPORT symbol \"%s\" [%s%s] version generation failed, symbol will not be versioned.\n", symname + strlen(CRC_PFX), mod->name, e);
 		}
 		mod->unres = alloc_symbol(symname,
 					  ELF_ST_BIND(sym->st_info) == STB_WEAK,
@@ -690,13 +700,13 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
 		break;
 	default:
 		/* All exported symbols */
-		if (strstarts(symname, "__ksymtab_")) {
-			sym_add_exported(symname + strlen("__ksymtab_"), mod,
+		if (strstarts(symname, KSYMTAB_PFX)) {
+			sym_add_exported(symname + strlen(KSYMTAB_PFX), mod,
 					export);
 		}
-		if (strcmp(symname, "init_module") == 0)
+		if (strcmp(symname, VMLINUX_SYMBOL_STR(init_module)) == 0)
 			mod->has_init = 1;
-		if (strcmp(symname, "cleanup_module") == 0)
+		if (strcmp(symname, VMLINUX_SYMBOL_STR(cleanup_module)) == 0)
 			mod->has_cleanup = 1;
 		break;
 	}
@@ -2230,7 +2240,7 @@ static int add_versions(struct buffer *b, struct module *mod)
 			err = 1;
 			break;
 		}
-		buf_printf(b, "\t{ %#8x, \"%s\" },\n",
+		buf_printf(b, "\t{ %#8x, __VMLINUX_SYMBOL_STR(%s) },\n",
 			   s->crc, s->name);
 	}
 
diff --git a/usr/initramfs_data.S b/usr/initramfs_data.S
index d07648f05bbf..b28da799f6a6 100644
--- a/usr/initramfs_data.S
+++ b/usr/initramfs_data.S
@@ -30,8 +30,8 @@ __irf_start:
 .incbin __stringify(INITRAMFS_IMAGE)
 __irf_end:
 .section .init.ramfs.info,"a"
-.globl __initramfs_size
-__initramfs_size:
+.globl VMLINUX_SYMBOL(__initramfs_size)
+VMLINUX_SYMBOL(__initramfs_size):
 #ifdef CONFIG_64BIT
 	.quad __irf_end - __irf_start
 #else
-- 
2.20.1 (Apple Git-117)

