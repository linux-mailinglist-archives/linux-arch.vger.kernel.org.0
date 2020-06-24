Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E672069C4
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 03:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbgFXBt5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 21:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388575AbgFXBty (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2020 21:49:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A62DC06179B
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e9so561785pgo.9
        for <linux-arch@vger.kernel.org>; Tue, 23 Jun 2020 18:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r1CVChw5lv6qJCnYUjb6+Q15TOtyE7dXeIu2ryL/SHg=;
        b=Xc9+JYeXrl67VMx0uVowsuIYnsATDq6ULZ939GoCguzhjaFWLLl4cD/FugiZrvwDVj
         dcaX0DvDaFJH5IX/9il9Nhce+Nh90R/QQkoJjrHNRgS9PCSBBeYUl63RaVjs/jh4OgWA
         bFr2LutY30k7TpbCrU6PqCwe82AQIBkSpbU8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r1CVChw5lv6qJCnYUjb6+Q15TOtyE7dXeIu2ryL/SHg=;
        b=MG2Zplgxi7FSffsAfiuAIlQk4C9ZyA9NJ0cC5hzUs116ZEDPgCBQcTqxjOFQNd+bXu
         reXzZytWxZscv7ztMKXSRYIk2zxwcBpu4HyUhgsGPFI5BYKu3o0vJLS47/VY/atnX4nx
         iI5vbs2mDur9iHHZGg2bE/hEXcAd0mP5P10KBkfeh8X2Db1/TFhulGtX16ivb+bK1eWF
         ubOqTbMWmDzHo91vXMaJDHmxeJjuXSnhA1gwiAPFHEh4B2pT1+cg6OJcCld6Oh8Inbcl
         IqqsuOO2jtLjxwBIAB/Mf+Y/JCMTPoU9+koRTJ/CMXHn+NXFZVGRn2+WCJCsXwH8cc9v
         7IUA==
X-Gm-Message-State: AOAM53322KgHNSHBgK0S4TFlt0QkHe68GVGCvT76jYjE548UEwPO+flx
        /09Q94EQ5Bkc1lcJi1tOG7A1XQ==
X-Google-Smtp-Source: ABdhPJwLyoPBCNvc6M7baPOo8YMhHaddUREkUy6nArCFg5rUy31c3O6TT7HTn6Prsx8Lzfg5bJwdKg==
X-Received: by 2002:a62:8f8f:: with SMTP id n137mr12048606pfd.270.1592963393918;
        Tue, 23 Jun 2020 18:49:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u200sm2497659pfc.43.2020.06.23.18.49.48
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
Subject: [PATCH v3 7/9] arm/boot: Warn on orphan section placement
Date:   Tue, 23 Jun 2020 18:49:38 -0700
Message-Id: <20200624014940.1204448-8-keescook@chromium.org>
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

Use common macros for debug sections, discards, and text stubs. Add
discards for unwanted .note, and .rel sections. Finally, enable orphan
section warning.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/boot/compressed/Makefile      |  2 ++
 arch/arm/boot/compressed/vmlinux.lds.S | 17 +++++++----------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 00602a6fba04..b8a97d81662d 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -128,6 +128,8 @@ endif
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
 LDFLAGS_vmlinux += -X
+# Report orphan sections
+LDFLAGS_vmlinux += --orphan-handling=warn
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
 
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index 09ac33f52814..c2a8509f876f 100644
--- a/arch/arm/boot/compressed/vmlinux.lds.S
+++ b/arch/arm/boot/compressed/vmlinux.lds.S
@@ -2,6 +2,7 @@
 /*
  *  Copyright (C) 2000 Russell King
  */
+#include <asm/vmlinux.lds.h>
 
 #ifdef CONFIG_CPU_ENDIAN_BE8
 #define ZIMAGE_MAGIC(x) ( (((x) >> 24) & 0x000000ff) | \
@@ -17,8 +18,11 @@ ENTRY(_start)
 SECTIONS
 {
   /DISCARD/ : {
+    ARM_COMMON_DISCARD
     *(.ARM.exidx*)
     *(.ARM.extab*)
+    *(.note.*)
+    *(.rel.*)
     /*
      * Discard any r/w data - this produces a link error if we have any,
      * which is required for PIC decompression.  Local data generates
@@ -36,9 +40,7 @@ SECTIONS
     *(.start)
     *(.text)
     *(.text.*)
-    *(.gnu.warning)
-    *(.glue_7t)
-    *(.glue_7)
+    ARM_STUBS_TEXT
   }
   .table : ALIGN(4) {
     _table_start = .;
@@ -128,12 +130,7 @@ SECTIONS
   PROVIDE(__pecoff_data_size = ALIGN(512) - ADDR(.data));
   PROVIDE(__pecoff_end = ALIGN(512));
 
-  .stab 0		: { *(.stab) }
-  .stabstr 0		: { *(.stabstr) }
-  .stab.excl 0		: { *(.stab.excl) }
-  .stab.exclstr 0	: { *(.stab.exclstr) }
-  .stab.index 0		: { *(.stab.index) }
-  .stab.indexstr 0	: { *(.stab.indexstr) }
-  .comment 0		: { *(.comment) }
+  STABS_DEBUG
+  DWARF_DEBUG
 }
 ASSERT(_edata_real == _edata, "error: zImage file size is incorrect");
-- 
2.25.1

