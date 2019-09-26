Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797C5BF862
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 19:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfIZR53 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 13:57:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39973 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfIZR41 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Sep 2019 13:56:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so1954981pgj.7
        for <linux-arch@vger.kernel.org>; Thu, 26 Sep 2019 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N0Ly0RoWNzS0e9pealT2AjXWyAS0JHK0C0PsWn5tREE=;
        b=BB+Wp2c62cK4be/dVurtn2OePQOvo8kO+/cwllKtmj/lBxl1iCi9+x2FEqqPcAfu3H
         5Jc3fOQT/WyzeOU1pOIuHyA+VT5vFLuQB6+QiCHBNurWJ+z4FXVlveHVrhV2+Pr+hwJX
         gZ7GbSmn29rI339LO1+fygFnZRmfnLy7trUyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N0Ly0RoWNzS0e9pealT2AjXWyAS0JHK0C0PsWn5tREE=;
        b=dn+etinEFAiJgz+juZjKihlBvgVgvYHDtukT46SU0oQihrNbe30QEUPJMlsnAhX94W
         4mOWlYsVNr3iiZ+iyIF9ZVHwf+ObytrUYFaSYj8EGH7pemVjVRE6cChi+P8EueiNUNSP
         JRaKd6T0m+JI3tuhFY6ak4nYZ5jllw7AGx4vDfuyKf/Q4wQ8IuG+qllmnvhi4Iupnnau
         L+zqJq0dXi8vkxK85tTFn5R6L76HRkHLI8mu0yXNlrUf9dwm8qycOZh0/dXLPUzSxR43
         QZgeLdZRAH+I6z82no0cv9RMaAd4ZmH+0zUjHpL3q6ueuKqYP6C8PuN1zRjLvCGcTgPw
         NhgQ==
X-Gm-Message-State: APjAAAUrS22onr9U9Y2220M2kcnhfubfvqAgQK2BgSe0B/DcO0xslEuE
        W8qYA7WTwZhTfcE+6lhp0MfoVA==
X-Google-Smtp-Source: APXvYqz+7EO2SDY0fOuWK5JlMtTN7+23UyO2mdFrzXpQW5FVGpWlsVRMn6xa/+DO76Xw8kfOXh9ozw==
X-Received: by 2002:a17:90a:2a4a:: with SMTP id d10mr4960722pjg.72.1569520586396;
        Thu, 26 Sep 2019 10:56:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l7sm8860071pga.92.2019.09.26.10.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:21 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>, linux-parisc@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/29] vmlinux.lds.h: Provide EMIT_PT_NOTE to indicate export of .notes
Date:   Thu, 26 Sep 2019 10:55:41 -0700
Message-Id: <20190926175602.33098-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for moving NOTES into RO_DATA, this provides a mechanism
for architectures that want to emit a PT_NOTE Program Header to do so.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/alpha/kernel/vmlinux.lds.S   |  3 +++
 arch/ia64/kernel/vmlinux.lds.S    |  2 ++
 arch/mips/kernel/vmlinux.lds.S    | 12 ++++++------
 arch/powerpc/kernel/vmlinux.lds.S |  1 +
 arch/s390/kernel/vmlinux.lds.S    |  2 ++
 arch/x86/kernel/vmlinux.lds.S     |  2 ++
 include/asm-generic/vmlinux.lds.h |  8 ++++++++
 7 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index 781090cacc96..363a60ba7c31 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
+#define EMITS_PT_NOTE
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/thread_info.h>
 #include <asm/cache.h>
diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index c1067992fcd1..e034a6a4a444 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -5,6 +5,8 @@
 #include <asm/pgtable.h>
 #include <asm/thread_info.h>
 
+#define EMITS_PT_NOTE
+
 #include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_FORMAT("elf64-ia64-little")
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index 33ee0d18fb0a..1c95612eb800 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -10,6 +10,11 @@
  */
 #define BSS_FIRST_SECTIONS *(.bss..swapper_pg_dir)
 
+/* Cavium Octeon should not have a separate PT_NOTE Program Header. */
+#ifndef CONFIG_CAVIUM_OCTEON_SOC
+#define EMITS_PT_NOTE
+#endif
+
 #include <asm-generic/vmlinux.lds.h>
 
 #undef mips
@@ -76,12 +81,7 @@ SECTIONS
 		__stop___dbe_table = .;
 	}
 
-#ifdef CONFIG_CAVIUM_OCTEON_SOC
-#define NOTES_HEADER
-#else /* CONFIG_CAVIUM_OCTEON_SOC */
-#define NOTES_HEADER :note
-#endif /* CONFIG_CAVIUM_OCTEON_SOC */
-	NOTES :text NOTES_HEADER
+	NOTES NOTES_HEADERS
 	.dummy : { *(.dummy) } :text
 
 	_sdata = .;			/* Start of data section */
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index e184a63aa5b0..7e26e20c8324 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -6,6 +6,7 @@
 #endif
 
 #define BSS_FIRST_SECTIONS *(.bss.prominit)
+#define EMITS_PT_NOTE
 
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 13294fef473e..646d939346df 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -15,6 +15,8 @@
 /* Handle ro_after_init data on our own. */
 #define RO_AFTER_INIT_DATA
 
+#define EMITS_PT_NOTE
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/vmlinux.lds.h>
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 788e78978030..2e18bf5c1aed 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -21,6 +21,8 @@
 #define LOAD_OFFSET __START_KERNEL_map
 #endif
 
+#define EMITS_PT_NOTE
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index cd28f63bfbc7..2cc3ff9ac8c7 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -54,6 +54,14 @@
 #define LOAD_OFFSET 0
 #endif
 
+/*
+ * Only some architectures want to have the .notes segment visible in
+ * a separate PT_NOTE ELF Program Header.
+ */
+#ifdef EMITS_PT_NOTE
+#define NOTES_HEADERS		:text :note
+#endif
+
 /* Align . to a 8 byte boundary equals to maximum function alignment. */
 #define ALIGN_FUNCTION()  . = ALIGN(8)
 
-- 
2.17.1

