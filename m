Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9412069C9
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 03:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbgFXBt6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 21:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388562AbgFXBty (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 21:49:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F41BC0613ED
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:52 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k6so327103pll.9
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5ovQdOa53Wq08SUrbeqBNAB7olZAVfsR3FjDV/m7eY=;
        b=HU0okjxiFMvFctCffkQ7z2I5GXmLT1gaNRYMQRFcgYl5tSYJfuUMDlXvZKj80rjKKa
         yDPcFEuDuT1buIkUcXQlmVdjIfloGs7ZqN0zimqyc3ma6N3SZKtRnjISbLa1WJUqrcLr
         i29IZiC5pQBaTbC59gJVAGqy18hz7C2vTrLUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5ovQdOa53Wq08SUrbeqBNAB7olZAVfsR3FjDV/m7eY=;
        b=WiXt9p+8+xHo1pTkSFu4J7k0HFH+vNdaEhRWZcfJd4+Y4ZGtgd40SuGBk7VdnMiYV6
         KrCcLuxtvK2cFTiZ/Ny4aJ/i8xB9pgF66EX5hI/buU2pas1lIIok33TQm0/KuI5EgFQr
         qo2733LCu17IOtaUtvt07cessbdNDWDG92sfVfEdoWL3/LaCY/mfcjbYc7PH3NMAkK8l
         5lhijBOtwt51h+O4/ZN6sHBvlyQPIKLT/Am0gY7ykF+NCCO/LB33NOpF9YPWJg3ZXlYQ
         wf+cbERj4gEyUg0Qmqg+f84BNZ2Gk+Xsyxd40IM7sGLrAScqJ1XTvQhkOF5NUIs733kY
         SAlQ==
X-Gm-Message-State: AOAM53301lb2z75Yaez2Re5vUYE+1ogOwWN/3YWLbWxhwOM1rEccmOKk
        aAqXfnvu4vFBuwiYvuYfUPXbqA==
X-Google-Smtp-Source: ABdhPJwzVxoBS+bR4nUcdi2cBNUW1MxtFXQkch5ct6ivADYFpQcNz0i+34vFO2Sqx+gzfU7fOMW1Zg==
X-Received: by 2002:a17:902:b184:: with SMTP id s4mr26340353plr.148.1592963392122;
        Tue, 23 Jun 2020 18:49:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 25sm18020100pfi.7.2020.06.23.18.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:49:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] arm/build: Warn on orphan section placement
Date:   Tue, 23 Jun 2020 18:49:37 -0700
Message-Id: <20200624014940.1204448-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624014940.1204448-1-keescook@chromium.org>
References: <20200624014940.1204448-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We don't want to depend on the linker's orphan section placement
heuristics as these can vary between linkers, and may change between
versions. All sections need to be explicitly named in the linker
script.

Specifically, this would have made a recently fixed bug very obvious:

ld: warning: orphan section `.fixup' from `arch/arm/lib/copy_from_user.o' being placed in section `.fixup'

Refactor linker script include file for use in standard and XIP linker
scripts, as well as in the coming boot linker script changes. Add debug
sections explicitly. Create ARM_COMMON_DISCARD macro with unneeded
sections .ARM.attributes, .iplt, .rel.iplt, .igot.plt, and .modinfo.
Create ARM_STUBS_TEXT macro with missed text stub sections .vfp11_veneer,
and .v4_bx. Finally enable orphan section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/Makefile                             |  4 ++++
 .../arm/{kernel => include/asm}/vmlinux.lds.h | 22 ++++++++++++++-----
 arch/arm/kernel/vmlinux-xip.lds.S             |  5 ++---
 arch/arm/kernel/vmlinux.lds.S                 |  5 ++---
 4 files changed, 25 insertions(+), 11 deletions(-)
 rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (92%)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 59fde2d598d8..e414e3732b3a 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,6 +16,10 @@ LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
 endif
 
+# We never want expected sections to be placed heuristically by the
+# linker. All sections should be explicitly named in the linker script.
+LDFLAGS_vmlinux += --orphan-handling=warn
+
 ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
 KBUILD_LDS_MODULE	+= $(srctree)/arch/arm/kernel/module.lds
 endif
diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/include/asm/vmlinux.lds.h
similarity index 92%
rename from arch/arm/kernel/vmlinux.lds.h
rename to arch/arm/include/asm/vmlinux.lds.h
index 381a8e105fa5..3d88ea74f4cd 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/include/asm/vmlinux.lds.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <asm-generic/vmlinux.lds.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define ARM_CPU_DISCARD(x)
@@ -37,6 +38,13 @@
 		*(.idmap.text)						\
 		__idmap_text_end = .;					\
 
+#define ARM_COMMON_DISCARD						\
+		*(.ARM.attributes)					\
+		*(.iplt) *(.rel.iplt) *(.igot.plt)			\
+		*(.modinfo)						\
+		*(.discard)						\
+		*(.discard.*)
+
 #define ARM_DISCARD							\
 		*(.ARM.exidx.exit.text)					\
 		*(.ARM.extab.exit.text)					\
@@ -49,8 +57,14 @@
 		EXIT_CALL						\
 		ARM_MMU_DISCARD(*(.text.fixup))				\
 		ARM_MMU_DISCARD(*(__ex_table))				\
-		*(.discard)						\
-		*(.discard.*)
+		ARM_COMMON_DISCARD
+
+#define ARM_STUBS_TEXT							\
+		*(.gnu.warning)						\
+		*(.glue_7t)						\
+		*(.glue_7)						\
+		*(.vfp11_veneer)					\
+		*(.v4_bx)
 
 #define ARM_TEXT							\
 		IDMAP_TEXT						\
@@ -64,9 +78,7 @@
 		CPUIDLE_TEXT						\
 		LOCK_TEXT						\
 		KPROBES_TEXT						\
-		*(.gnu.warning)						\
-		*(.glue_7)						\
-		*(.glue_7t)						\
+		ARM_STUBS_TEXT						\
 		. = ALIGN(4);						\
 		*(.got)			/* Global offset table */	\
 		ARM_CPU_KEEP(PROC_INFO)
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 6d2be994ae58..0807f40844a2 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -9,15 +9,13 @@
 
 #include <linux/sizes.h>
 
-#include <asm-generic/vmlinux.lds.h>
+#include <asm/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/mpu.h>
 #include <asm/page.h>
 
-#include "vmlinux.lds.h"
-
 OUTPUT_ARCH(arm)
 ENTRY(stext)
 
@@ -152,6 +150,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 }
 
 /*
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 7f24bc08403e..969205f125ca 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -9,15 +9,13 @@
 #else
 
 #include <linux/pgtable.h>
-#include <asm-generic/vmlinux.lds.h>
+#include <asm/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/mpu.h>
 #include <asm/page.h>
 
-#include "vmlinux.lds.h"
-
 OUTPUT_ARCH(arm)
 ENTRY(stext)
 
@@ -151,6 +149,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	DWARF_DEBUG
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-- 
2.25.1

