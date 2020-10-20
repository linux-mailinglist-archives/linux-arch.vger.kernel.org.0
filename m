Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3926E284985
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 11:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFJom (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 05:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJFJom (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 05:44:42 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B77C061755
        for <linux-arch@vger.kernel.org>; Tue,  6 Oct 2020 02:44:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u24so7706431pgi.1
        for <linux-arch@vger.kernel.org>; Tue, 06 Oct 2020 02:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5HupZhyhdxhyU5ESUBoW3WJglSEmqi4YqPJcfU0jdA=;
        b=LjjLB32yvD1n9/7BEummsz7fgn5Jy044QjFMq+P9ENxWQ2VzO9rEe3gW1thNK+Ixor
         0kiS6arkWANX1bvATm9V83FQO35Qgrm5zpbXDVIsaelGBc+PmKCCZVEUGrvWoaLrTP21
         lUqEnCV/IQgDEZ1fJ5fVH/JBpx96NX8IcIZuv/W1VFcuL6ebOwHunXV2Ravm9Lv64FN5
         zW27Hb8CulMZz8WGfhdTd6XKYBNFKHpwwh56frcSai6t0zHqoqNHZf6KhFYOI+0cyNRM
         Mjdo2Kx7lULRmWeldCnxFEP+Gq1ks6LgC3wBIOtlyNLmDRl74WSwn6hmC5yS6qavQ8Cv
         Fqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5HupZhyhdxhyU5ESUBoW3WJglSEmqi4YqPJcfU0jdA=;
        b=trVTOhKsIJRZUfZvlQU+98eD0lQvG0nDh1N9+5e8Jc6opjEmEPjuzAojiapsEBbbxU
         09z+dhsybT+LcH7NUJh4jeQ+WyGLqYhiF+58RCvOfsUOjqn7wr0SWLhE4pNuMsKwdGpe
         GpSyJXgqG4u64CxtDmsYfd9waGuSK3W2Ydr6Qi5DHD8INVZZnny8aGK663H4752vAuE9
         s4BLmULWnqRpFtVaReWHkx4hNqgwARoTwE7GhJI9EFIQ3OtSrkFYhUhsHaXSYK3D/mdn
         CfFgFAFAHtnfIN5ESCZfHgg++q3Hk4/1qyTSmfb8zheTXgeJKtz1ZOg7OgFuMbgJIcVB
         /GsQ==
X-Gm-Message-State: AOAM530JtYNwSXcb48cf3fNBPoldogerccF77GUj7/9G6Jq2IOZ5pNkZ
        b8UDXwKZtJ69hVcAHB2gI4bVHSsyWJN98A==
X-Google-Smtp-Source: ABdhPJxYZAxt6LsQEcV6CcVDixCmMqOND/CZv6T5w1F1AKkcvK5rJZUVRUctKbABon2ozTFUF7uQDg==
X-Received: by 2002:a63:1958:: with SMTP id 24mr3292589pgz.326.1601977481752;
        Tue, 06 Oct 2020 02:44:41 -0700 (PDT)
Received: from earth-mac.local (219x123x138x129.ap219.ftth.ucom.ne.jp. [219.123.138.129])
        by smtp.gmail.com with ESMTPSA id i9sm2885979pfq.53.2020.10.06.02.44.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 02:44:41 -0700 (PDT)
Received: by earth-mac.local (Postfix, from userid 501)
        id D4B6420390F414; Tue,  6 Oct 2020 18:44:38 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at,
        anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, retrage01@gmail.com,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Octavian Purdila <tavi@cs.pub.ro>,
        Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v7 01/21] um: split build in kernel and host parts
Date:   Tue,  6 Oct 2020 18:44:10 +0900
Message-Id: <82462f23ef633768dc8db644edc42345e585a245.1601960644.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi@cs.pub.ro>

This patch splits the UML build in two parts: a kernel part that
generates a relocatable object (linux.o) and a host build part that
links the relocatable object into an executable.

This allows us to simplify the linker script since we can now remove
the host bits (e.g. .rel sections). It also gives us greater
flexibility since it will be much easier to support other
architectures and OSes if we use the standard linker script.

The host build part has been implemented in tools/um so that we can
reuse the available host build infrastructure.

The patch preserves the way to invoke the UML build as follows,

 $ make ARCH=um defconfig
 $ make ARCH=um

but it internally calls tools/um/Makefile in order to complete the full
build to link the relocatable object and the rest of files.

To statically compiled UML use:

 $ make ARCH=um UML_STATIC=y

Signed-off-by: Octavian Purdila <tavi@cs.pub.ro>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/Kconfig                  |  12 +--
 arch/um/Makefile                 |  22 +++-
 arch/um/include/asm/common.lds.S |  99 ------------------
 arch/um/kernel/dyn.lds.S         | 171 -------------------------------
 arch/um/kernel/uml.lds.S         | 115 ---------------------
 arch/um/kernel/vmlinux.lds.S     |  91 ++++++++++++++--
 scripts/link-vmlinux.sh          |  42 +++-----
 tools/um/Makefile                |  72 +++++++++++++
 tools/um/Targets                 |   4 +
 tools/um/uml/Build               |   0
 10 files changed, 191 insertions(+), 437 deletions(-)
 delete mode 100644 arch/um/include/asm/common.lds.S
 delete mode 100644 arch/um/kernel/dyn.lds.S
 delete mode 100644 arch/um/kernel/uml.lds.S
 create mode 100644 tools/um/Makefile
 create mode 100644 tools/um/Targets
 create mode 100644 tools/um/uml/Build

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index eb51fec75948..e41d31d0d875 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -20,6 +20,7 @@ config UML
 	select GENERIC_CLOCKEVENTS
 	select HAVE_GCC_PLUGINS
 	select TTY # Needed for line.c
+	select MODULE_REL_CRCS if MODVERSIONS
 
 config MMU
 	bool
@@ -79,17 +80,6 @@ config STATIC_LINK
 	  NOTE: This option is incompatible with some networking features which
 	  depend on features that require being dynamically loaded (like NSS).
 
-config LD_SCRIPT_STATIC
-	bool
-	default y
-	depends on STATIC_LINK
-
-config LD_SCRIPT_DYN
-	bool
-	default y
-	depends on !LD_SCRIPT_STATIC
-	select MODULE_REL_CRCS if MODVERSIONS
-
 config HOSTFS
 	tristate "Host filesystem"
 	help
diff --git a/arch/um/Makefile b/arch/um/Makefile
index 1cea46ff9bb7..09745b40c52d 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -95,14 +95,25 @@ KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/include \
 KERNEL_DEFINES = $(strip -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
 			 -Dmktime=kernel_mktime $(ARCH_KERNEL_DEFINES))
 KBUILD_CFLAGS += $(KERNEL_DEFINES)
+LDFLAGS_vmlinux += -r
 
-PHONY += linux
-
+INSTALL_PATH=$(objtree)/tools/um
 all: linux
+install: linux.o
+	@echo "  INSTALL	$(INSTALL_PATH)/lib/$<"
+	@mkdir -p $(INSTALL_PATH)/lib/
+	@cp $< $(INSTALL_PATH)/lib/
+
+PHONY += linux.o
+
+linux: linux.o
+	$(Q)$(MAKE) -C $(srctree)/tools/um
+	$(Q)cp $(objtree)/tools/um/uml/linux $(objtree)/
 
-linux: vmlinux
-	@echo '  LINK $@'
-	$(Q)ln -f $< $@
+linux.o: vmlinux
+	@echo '  LINK	$@'
+	$(Q)$(OBJCOPY) -R .eh_frame $< $@
+	$(Q)mkdir -p $(objtree)/tools/um/lib
 
 define archhelp
   echo '* linux		- Binary kernel image (./linux) - for backward'
@@ -144,5 +155,6 @@ MRPROPER_FILES += arch/$(SUBARCH)/include/generated
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
 		-o -name '*.gcov' \) -type f -print | xargs rm -f
+	$(Q)$(MAKE) -C $(srctree)/tools/um clean
 
 export HEADER_ARCH SUBARCH USER_CFLAGS CFLAGS_NO_HARDENING OS DEV_NULL_PATH
diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
deleted file mode 100644
index eca6c452a41b..000000000000
--- a/arch/um/include/asm/common.lds.S
+++ /dev/null
@@ -1,99 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm-generic/vmlinux.lds.h>
-
-  .fini      : { *(.fini)    } =0x9090
-  _etext = .;
-  PROVIDE (etext = .);
-
-  . = ALIGN(4096);
-  _sdata = .;
-  PROVIDE (sdata = .);
-
-  RO_DATA(4096)
-
-  .unprotected : { *(.unprotected) }
-  . = ALIGN(4096);
-  PROVIDE (_unprotected_end = .);
-
-  . = ALIGN(4096);
-  EXCEPTION_TABLE(0)
-
-  BUG_TABLE
-
-  .uml.setup.init : {
-	__uml_setup_start = .;
-	*(.uml.setup.init)
-	__uml_setup_end = .;
-  }
-	
-  .uml.help.init : {
-	__uml_help_start = .;
-	*(.uml.help.init)
-	__uml_help_end = .;
-  }
-	
-  .uml.postsetup.init : {
-	__uml_postsetup_start = .;
-	*(.uml.postsetup.init)
-	__uml_postsetup_end = .;
-  }
-	
-  .init.setup : {
-	INIT_SETUP(0)
-  }
-
-  PERCPU_SECTION(32)
-	
-  .initcall.init : {
-	INIT_CALLS
-  }
-
-  .con_initcall.init : {
-	CON_INITCALL
-  }
-
-  .exitcall : {
-	__exitcall_begin = .;
-	*(.exitcall.exit)
-	__exitcall_end = .;
-  }
-
-  .uml.exitcall : {
-	__uml_exitcall_begin = .;
-	*(.uml.exitcall.exit)
-	__uml_exitcall_end = .;
-  }
-
-  . = ALIGN(4);
-  .altinstructions : {
-	__alt_instructions = .;
-	*(.altinstructions)
-	__alt_instructions_end = .;
-  }
-  .altinstr_replacement : { *(.altinstr_replacement) }
-  /* .exit.text is discard at runtime, not link time, to deal with references
-     from .altinstructions and .eh_frame */
-  .exit.text : { EXIT_TEXT }
-  .exit.data : { *(.exit.data) }
-
-  .preinit_array : {
-	__preinit_array_start = .;
-	*(.preinit_array)
-	__preinit_array_end = .;
-  }
-  .init_array : {
-	__init_array_start = .;
-	*(.init_array)
-	__init_array_end = .;
-  }
-  .fini_array : {
-	__fini_array_start = .;
-	*(.fini_array)
-	__fini_array_end = .;
-  }
-
-   . = ALIGN(4096);
-  .init.ramfs : {
-	INIT_RAM_FS
-  }
-
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
deleted file mode 100644
index f5001481010c..000000000000
--- a/arch/um/kernel/dyn.lds.S
+++ /dev/null
@@ -1,171 +0,0 @@
-#include <asm/vmlinux.lds.h>
-#include <asm/page.h>
-
-OUTPUT_FORMAT(ELF_FORMAT)
-OUTPUT_ARCH(ELF_ARCH)
-ENTRY(_start)
-jiffies = jiffies_64;
-
-SECTIONS
-{
-  PROVIDE (__executable_start = START);
-  . = START + SIZEOF_HEADERS;
-  .interp         : { *(.interp) }
-  __binary_start = .;
-  . = ALIGN(4096);		/* Init code and data */
-  _text = .;
-  INIT_TEXT_SECTION(PAGE_SIZE)
-
-  . = ALIGN(PAGE_SIZE);
-
-  /* Read-only sections, merged into text segment: */
-  .hash           : { *(.hash) }
-  .gnu.hash       : { *(.gnu.hash) }
-  .dynsym         : { *(.dynsym) }
-  .dynstr         : { *(.dynstr) }
-  .gnu.version    : { *(.gnu.version) }
-  .gnu.version_d  : { *(.gnu.version_d) }
-  .gnu.version_r  : { *(.gnu.version_r) }
-  .rel.init       : { *(.rel.init) }
-  .rela.init      : { *(.rela.init) }
-  .rel.text       : { *(.rel.text .rel.text.* .rel.gnu.linkonce.t.*) }
-  .rela.text      : { *(.rela.text .rela.text.* .rela.gnu.linkonce.t.*) }
-  .rel.fini       : { *(.rel.fini) }
-  .rela.fini      : { *(.rela.fini) }
-  .rel.rodata     : { *(.rel.rodata .rel.rodata.* .rel.gnu.linkonce.r.*) }
-  .rela.rodata    : { *(.rela.rodata .rela.rodata.* .rela.gnu.linkonce.r.*) }
-  .rel.data       : { *(.rel.data .rel.data.* .rel.gnu.linkonce.d.*) }
-  .rela.data      : { *(.rela.data .rela.data.* .rela.gnu.linkonce.d.*) }
-  .rel.tdata	  : { *(.rel.tdata .rel.tdata.* .rel.gnu.linkonce.td.*) }
-  .rela.tdata	  : { *(.rela.tdata .rela.tdata.* .rela.gnu.linkonce.td.*) }
-  .rel.tbss	  : { *(.rel.tbss .rel.tbss.* .rel.gnu.linkonce.tb.*) }
-  .rela.tbss	  : { *(.rela.tbss .rela.tbss.* .rela.gnu.linkonce.tb.*) }
-  .rel.ctors      : { *(.rel.ctors) }
-  .rela.ctors     : { *(.rela.ctors) }
-  .rel.dtors      : { *(.rel.dtors) }
-  .rela.dtors     : { *(.rela.dtors) }
-  .rel.got        : { *(.rel.got) }
-  .rela.got       : { *(.rela.got) }
-  .rel.bss        : { *(.rel.bss .rel.bss.* .rel.gnu.linkonce.b.*) }
-  .rela.bss       : { *(.rela.bss .rela.bss.* .rela.gnu.linkonce.b.*) }
-  .rel.plt : {
-	*(.rel.plt)
-	PROVIDE_HIDDEN(__rel_iplt_start = .);
-	*(.rel.iplt)
-	PROVIDE_HIDDEN(__rel_iplt_end = .);
-  }
-  .rela.plt : {
-	*(.rela.plt)
-	PROVIDE_HIDDEN(__rela_iplt_start = .);
-	*(.rela.iplt)
-	PROVIDE_HIDDEN(__rela_iplt_end = .);
-  }
-  .init           : {
-    KEEP (*(.init))
-  } =0x90909090
-  .plt            : { *(.plt) }
-  .text           : {
-    _stext = .;
-    TEXT_TEXT
-    SCHED_TEXT
-    CPUIDLE_TEXT
-    LOCK_TEXT
-    IRQENTRY_TEXT
-    SOFTIRQENTRY_TEXT
-    *(.fixup)
-    *(.stub .text.* .gnu.linkonce.t.*)
-    /* .gnu.warning sections are handled specially by elf32.em.  */
-    *(.gnu.warning)
-
-    . = ALIGN(PAGE_SIZE);
-  } =0x90909090
-  . = ALIGN(PAGE_SIZE);
-  .syscall_stub : {
-	__syscall_stub_start = .;
-	*(.__syscall_stub*)
-	__syscall_stub_end = .;
-  }
-  .fini           : {
-    KEEP (*(.fini))
-  } =0x90909090
-
-  .kstrtab : { *(.kstrtab) }
-
-  #include <asm/common.lds.S>
-
-  __init_begin = .;
-  init.data : { INIT_DATA }
-  __init_end = .;
-
-  /* Ensure the __preinit_array_start label is properly aligned.  We
-     could instead move the label definition inside the section, but
-     the linker would then create the section even if it turns out to
-     be empty, which isn't pretty.  */
-  . = ALIGN(32 / 8);
-  .preinit_array     : { *(.preinit_array) }
-  .init_array     : { *(.init_array) }
-  .fini_array     : { *(.fini_array) }
-  .data           : {
-    INIT_TASK_DATA(KERNEL_STACK_SIZE)
-    . = ALIGN(KERNEL_STACK_SIZE);
-    *(.data..init_irqstack)
-    DATA_DATA
-    *(.data.* .gnu.linkonce.d.*)
-    SORT(CONSTRUCTORS)
-  }
-  .data1          : { *(.data1) }
-  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
-  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
-  .eh_frame       : { KEEP (*(.eh_frame)) }
-  .gcc_except_table   : { *(.gcc_except_table) }
-  .dynamic        : { *(.dynamic) }
-  .ctors          : {
-    /* gcc uses crtbegin.o to find the start of
-       the constructors, so we make sure it is
-       first.  Because this is a wildcard, it
-       doesn't matter if the user does not
-       actually link against crtbegin.o; the
-       linker won't look for a file to match a
-       wildcard.  The wildcard also means that it
-       doesn't matter which directory crtbegin.o
-       is in.  */
-    KEEP (*crtbegin.o(.ctors))
-    /* We don't want to include the .ctor section from
-       from the crtend.o file until after the sorted ctors.
-       The .ctor section from the crtend file contains the
-       end of ctors marker and it must be last */
-    KEEP (*(EXCLUDE_FILE (*crtend.o ) .ctors))
-    KEEP (*(SORT(.ctors.*)))
-    KEEP (*(.ctors))
-  }
-  .dtors          : {
-    KEEP (*crtbegin.o(.dtors))
-    KEEP (*(EXCLUDE_FILE (*crtend.o ) .dtors))
-    KEEP (*(SORT(.dtors.*)))
-    KEEP (*(.dtors))
-  }
-  .jcr            : { KEEP (*(.jcr)) }
-  .got            : { *(.got.plt) *(.got) }
-  _edata = .;
-  PROVIDE (edata = .);
-  .bss            : {
-   __bss_start = .;
-   *(.dynbss)
-   *(.bss .bss.* .gnu.linkonce.b.*)
-   *(COMMON)
-   /* Align here to ensure that the .bss section occupies space up to
-      _end.  Align after .bss to ensure correct alignment even if the
-      .bss section disappears because there are no input sections.  */
-   . = ALIGN(32 / 8);
-  . = ALIGN(32 / 8);
-  }
-   __bss_stop = .;
-  _end = .;
-  PROVIDE (end = .);
-
-  STABS_DEBUG
-
-  DWARF_DEBUG
-
-  DISCARDS
-}
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
deleted file mode 100644
index 3b6dab3d4501..000000000000
--- a/arch/um/kernel/uml.lds.S
+++ /dev/null
@@ -1,115 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/vmlinux.lds.h>
-#include <asm/page.h>
-
-OUTPUT_FORMAT(ELF_FORMAT)
-OUTPUT_ARCH(ELF_ARCH)
-ENTRY(_start)
-jiffies = jiffies_64;
-
-SECTIONS
-{
-  /* This must contain the right address - not quite the default ELF one.*/
-  PROVIDE (__executable_start = START);
-  /* Static binaries stick stuff here, like the sigreturn trampoline,
-   * invisibly to objdump.  So, just make __binary_start equal to the very
-   * beginning of the executable, and if there are unmapped pages after this,
-   * they are forever unusable.
-   */
-  __binary_start = START;
-
-  . = START + SIZEOF_HEADERS;
-  . = ALIGN(PAGE_SIZE);
-
-  _text = .;
-  INIT_TEXT_SECTION(0)
-
-  .text      :
-  {
-    _stext = .;
-    TEXT_TEXT
-    SCHED_TEXT
-    CPUIDLE_TEXT
-    LOCK_TEXT
-    IRQENTRY_TEXT
-    SOFTIRQENTRY_TEXT
-    *(.fixup)
-    /* .gnu.warning sections are handled specially by elf32.em.  */
-    *(.gnu.warning)
-    *(.gnu.linkonce.t*)
-  }
-
-  . = ALIGN(PAGE_SIZE);
-  .syscall_stub : {
-	__syscall_stub_start = .;
-	*(.__syscall_stub*)
-	__syscall_stub_end = .;
-  }
-
-  /*
-   * These are needed even in a static link, even if they wind up being empty.
-   * Newer glibc needs these __rel{,a}_iplt_{start,end} symbols.
-   */
-  .rel.plt : {
-	*(.rel.plt)
-	PROVIDE_HIDDEN(__rel_iplt_start = .);
-	*(.rel.iplt)
-	PROVIDE_HIDDEN(__rel_iplt_end = .);
-  }
-  .rela.plt : {
-	*(.rela.plt)
-	PROVIDE_HIDDEN(__rela_iplt_start = .);
-	*(.rela.iplt)
-	PROVIDE_HIDDEN(__rela_iplt_end = .);
-  }
-
-  #include <asm/common.lds.S>
-
-  __init_begin = .;
-  init.data : { INIT_DATA }
-  __init_end = .;
-
-  .data    :
-  {
-    INIT_TASK_DATA(KERNEL_STACK_SIZE)
-    . = ALIGN(KERNEL_STACK_SIZE);
-    *(.data..init_irqstack)
-    DATA_DATA
-    *(.gnu.linkonce.d*)
-    CONSTRUCTORS
-  }
-  .data1   : { *(.data1) }
-  .ctors         :
-  {
-    *(.ctors)
-  }
-  .dtors         :
-  {
-    *(.dtors)
-  }
-
-  .got           : { *(.got.plt) *(.got) }
-  .dynamic       : { *(.dynamic) }
-  .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
-  .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
-  /* We want the small data sections together, so single-instruction offsets
-     can access them all, and initialized data all before uninitialized, so
-     we can shorten the on-disk segment size.  */
-  .sdata     : { *(.sdata) }
-  _edata  =  .;
-  PROVIDE (edata = .);
-  . = ALIGN(PAGE_SIZE);
-  __bss_start = .;
-  PROVIDE(_bss_start = .);
-  SBSS(0)
-  BSS(0)
-   __bss_stop = .;
-  _end = .;
-  PROVIDE (end = .);
-
-  STABS_DEBUG
-
-  DWARF_DEBUG
-
-  DISCARDS
-}
diff --git a/arch/um/kernel/vmlinux.lds.S b/arch/um/kernel/vmlinux.lds.S
index 16e49bfa2b42..aaedd66772fa 100644
--- a/arch/um/kernel/vmlinux.lds.S
+++ b/arch/um/kernel/vmlinux.lds.S
@@ -1,8 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/vmlinux.lds.h>
+#include <asm/thread_info.h>
+#include <asm/page.h>
+#include <asm/thread_info.h>
+#include <asm/cache.h>
+#include <linux/export.h>
 
-KERNEL_STACK_SIZE = 4096 * (1 << CONFIG_KERNEL_STACK_ORDER);
+OUTPUT_FORMAT(ELF_FORMAT)
+jiffies = jiffies_64;
 
-#ifdef CONFIG_LD_SCRIPT_STATIC
-#include "uml.lds.S"
-#else
-#include "dyn.lds.S"
-#endif
+
+SECTIONS
+{
+	__init_begin = . ;
+	HEAD_TEXT_SECTION
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	INIT_DATA_SECTION(16)
+	PERCPU_SECTION(L1_CACHE_BYTES)
+	__init_end = . ;
+
+	_stext = . ;
+	_text = . ;
+	.text : ALIGN(THREAD_SIZE)
+	{
+		__binary_start = . ;
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+		CPUIDLE_TEXT
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
+	}
+	_etext = . ;
+
+	.syscall_stub : ALIGN(PAGE_SIZE)
+	{
+		__syscall_stub_start = .;
+		*(.__syscall_stub*)
+		__syscall_stub_end = .;
+	}
+
+	_sdata = . ;
+	RO_DATA(PAGE_SIZE)
+	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+	.data : ALIGN(THREAD_SIZE)  { }
+
+	EXCEPTION_TABLE(16)
+
+	.uml.init_irqstack : ALIGN(THREAD_SIZE) {
+		*(.data..init_irqstack)
+	}
+
+	.uml.setup.init : ALIGN(8) {
+		__uml_setup_start = .;
+		*(.uml.setup.init)
+		__uml_setup_end = .;
+	}
+
+	.uml.help.init : ALIGN(8)  {
+		__uml_help_start = .;
+		*(.uml.help.init)
+		__uml_help_end = .;
+	}
+
+	.uml.postsetup.init : ALIGN(8) {
+		__uml_postsetup_start = .;
+		*(.uml.postsetup.init)
+		__uml_postsetup_end = .;
+	}
+
+	.uml.exitcall : ALIGN(8) {
+		__uml_exitcall_begin = .;
+		*(.uml.exitcall.exit)
+		__uml_exitcall_end = .;
+	}
+	_edata = . ;
+
+	BSS_SECTION(0, 0, 0)
+	_end = . ;
+
+	STABS_DEBUG
+
+	DWARF_DEBUG
+
+	DISCARDS
+}
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index e6e2d9e5ff48..903fc8053d07 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -102,36 +102,18 @@ vmlinux_link()
 		strip_debug=-Wl,--strip-debug
 	fi
 
-	if [ "${SRCARCH}" != "um" ]; then
-		objects="--whole-archive			\
-			${KBUILD_VMLINUX_OBJS}			\
-			--no-whole-archive			\
-			--start-group				\
-			${KBUILD_VMLINUX_LIBS}			\
-			--end-group				\
-			${@}"
-
-		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}	\
-			${strip_debug#-Wl,}			\
-			-o ${output}				\
-			-T ${lds} ${objects}
-	else
-		objects="-Wl,--whole-archive			\
-			${KBUILD_VMLINUX_OBJS}			\
-			-Wl,--no-whole-archive			\
-			-Wl,--start-group			\
-			${KBUILD_VMLINUX_LIBS}			\
-			-Wl,--end-group				\
-			${@}"
-
-		${CC} ${CFLAGS_vmlinux}				\
-			${strip_debug}				\
-			-o ${output}				\
-			-Wl,-T,${lds}				\
-			${objects}				\
-			-lutil -lrt -lpthread
-		rm -f linux
-	fi
+	objects="--whole-archive			\
+		${KBUILD_VMLINUX_OBJS}			\
+		--no-whole-archive			\
+		--start-group				\
+		${KBUILD_VMLINUX_LIBS}			\
+		--end-group				\
+		${@}"
+
+	${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}	\
+		${strip_debug#-Wl,}			\
+		-o ${output}				\
+		-T ${lds} ${objects}
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
diff --git a/tools/um/Makefile b/tools/um/Makefile
new file mode 100644
index 000000000000..a63466ef7ef5
--- /dev/null
+++ b/tools/um/Makefile
@@ -0,0 +1,72 @@
+# Do not use make's built-in rules
+# (this improves performance and avoids hard-to-debug behaviour);
+# also do not print "Entering directory..." messages from make
+.SUFFIXES:
+MAKEFLAGS += -r --no-print-directory
+
+KCONFIG?=defconfig
+
+ifneq ($(silent),1)
+  ifneq ($(V),1)
+	QUIET_AUTOCONF       = @echo '  AUTOCONF '$@;
+	Q = @
+  endif
+endif
+
+PREFIX   := /usr
+
+ifeq (,$(srctree))
+  srctree := $(patsubst %/,%,$(dir $(shell pwd)))
+  srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+export srctree
+
+-include ../scripts/Makefile.include
+
+# OUTPUT fixup should be *after* include ../scripts/Makefile.include
+ifneq ($(OUTPUT),)
+  OUTPUT := $(OUTPUT)/tools/um/
+else
+  OUTPUT := $(CURDIR)/
+endif
+export OUTPUT
+export objtree := $(OUTPUT)/../..
+
+
+all:
+
+export CFLAGS += -I$(OUTPUT)/include -Iinclude -Wall -g -O2 -Wextra -fPIC \
+	 -Wno-unused-parameter \
+	 -Wno-missing-field-initializers -fno-strict-aliasing
+
+-include Targets
+
+TARGETS := $(progs-y:%=$(OUTPUT)%)
+TARGETS += $(libs-y:%=$(OUTPUT)%)
+all: $(TARGETS)
+
+# rule to build linux.o
+$(OUTPUT)lib/linux.o:
+	$(Q)CFLAGS= $(MAKE) -C ../.. ARCH=um $(KOPT) $(KCONFIG)
+	$(Q)CFLAGS= $(MAKE) -C ../.. ARCH=um $(KOPT) install INSTALL_PATH=$(OUTPUT)
+
+$(OUTPUT)liblinux.a: $(OUTPUT)lib/linux.o $(OUTPUT)uml/liblinux-in.o
+	$(QUIET_AR)$(AR) -rc $@ $^
+
+# rule to link programs
+$(OUTPUT)%: $(OUTPUT)%-in.o $(OUTPUT)liblinux.a
+	$(QUIET_LINK)$(CC) $(LDFLAGS) $(LDFLAGS_$(notdir $*)-y) -o $@ $^ $(LDLIBS) $(LDLIBS_$(notdir $*)-y)
+
+$(OUTPUT)%-in.o: FORCE
+	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(patsubst %/,%,$(dir $*)) obj=$(notdir $*)
+
+clean:
+	$(call QUIET_CLEAN, objects)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd'\
+	 -delete -o -name '\.*.d' -delete
+	$(call QUIET_CLEAN, liblinux.a)$(RM) $(OUTPUT)/liblinux.a
+	$(call QUIET_CLEAN, $(TARGETS))$(RM) $(TARGETS)
+
+FORCE: ;
+.PHONY: all clean FORCE
+.IGNORE: clean
+.NOTPARALLEL : lib/linux.o
diff --git a/tools/um/Targets b/tools/um/Targets
new file mode 100644
index 000000000000..a4711f1ef422
--- /dev/null
+++ b/tools/um/Targets
@@ -0,0 +1,4 @@
+progs-y += uml/linux
+LDLIBS_linux-y := -lrt -lpthread -lutil
+LDFLAGS_linux-y := -no-pie -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
+LDFLAGS_linux-$(UML_STATIC) += -static
diff --git a/tools/um/uml/Build b/tools/um/uml/Build
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.21.0 (Apple Git-122.2)

