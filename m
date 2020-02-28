Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E3A172D17
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2020 01:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgB1AXA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Feb 2020 19:23:00 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53968 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730474AbgB1AW5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 19:22:57 -0500
Received: by mail-pj1-f68.google.com with SMTP id i11so435887pju.3
        for <linux-arch@vger.kernel.org>; Thu, 27 Feb 2020 16:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pMXhDd5WkHmc2Nd9+Jjb38fhh7Zetn6tk9gX3pPvjM=;
        b=NdpfQ9E77BQQDeLbRe4C0kneiRaa4BRWlG/661nY6+36gEg6ulvyK6zJdrM6FlpkLx
         rZnuOrOoXJH6eCy0PMi8rot0VETFWym5wj0fDsIe9QVrzJg7KEO+1C0QPBYDgIEB4mcg
         xFYZAsgdnMK5ZAzxXgLUxelkrt9eHsy30qa9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pMXhDd5WkHmc2Nd9+Jjb38fhh7Zetn6tk9gX3pPvjM=;
        b=lL+WnRvIA1Xs5zgkU5t2Gz/IfJ3re9s+adgXRh0/+RhV7WzlpLDUMf1jq5zI4MzXMg
         h7ZoIcrMSnmxMNqyVjuzE8ClCHavecPlmrvJ7FLNQGlasDXkGvUN5Bh4kzFFEgT2iXBs
         WZ74J8f7m57BKyoJhSRT0izLsW8o+V3/3mn7hRgYF7dPqoZxFh4mMGOVBhGXdIFSOuak
         I2nSKiHbxbWlyEXSrVvs0y1x8cHb3Cvuov3qnycXUL1X7xdvirBZrtsHNsOpl0gwpz1f
         ZoG7u8MtLPr9hbZ/rKdUpqf4LyEePn1vR1Vl8l/iGFkTr/MFNlr7YBGGuLOQgLxaRGBg
         7uxA==
X-Gm-Message-State: APjAAAVdwriE1bMxG83kkqC/3q8y+R/SyP8PalNlwUl1Rmx2weMRm5+x
        01KvNKpWFKg5ouV/9nHF3Kf7Qg==
X-Google-Smtp-Source: APXvYqzuOX0XiyVaOeVuugXOJBvn7E6Nhu05xm90KTUN/qkQ34/SDiQ4lE0A5jOUkXzf88ArP2HuXA==
X-Received: by 2002:a17:902:694b:: with SMTP id k11mr1375405plt.334.1582849375873;
        Thu, 27 Feb 2020 16:22:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 3sm8455845pfi.13.2020.02.27.16.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:22:52 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] arm/boot: Warn on orphan section placement
Date:   Thu, 27 Feb 2020 16:22:44 -0800
Message-Id: <20200228002244.15240-10-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
References: <20200228002244.15240-1-keescook@chromium.org>
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
index da599c3a1193..7faa2b5e7e16 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -136,6 +136,8 @@ endif
 LDFLAGS_vmlinux += --no-undefined
 # Delete all temporary local symbols
 LDFLAGS_vmlinux += -X
+# Report orphan sections
+LDFLAGS_vmlinux += --orphan-handling=warn
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
 
diff --git a/arch/arm/boot/compressed/vmlinux.lds.S b/arch/arm/boot/compressed/vmlinux.lds.S
index fc7ed03d8b93..a6a51b5d2328 100644
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
@@ -37,9 +41,7 @@ SECTIONS
     *(.text)
     *(.text.*)
     *(.fixup)
-    *(.gnu.warning)
-    *(.glue_7t)
-    *(.glue_7)
+    ARM_STUBS_TEXT
   }
   .table : ALIGN(4) {
     _table_start = .;
@@ -124,12 +126,7 @@ SECTIONS
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
2.20.1

