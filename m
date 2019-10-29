Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570D2E9164
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2019 22:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfJ2VOL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Oct 2019 17:14:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42187 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbfJ2VOL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 17:14:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id 21so10518705pfj.9
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDpEXta6gblz8RcQG8Y0aSP7MVebXWwYNQQzkqw1syM=;
        b=SKSnYHxJHmii8xo5Z4mTmdRCVC7yrS/D7oEkTo/iOkxl6ZHwOveMu6U4vwyneQKKse
         wkiElGkgFNqM/pnNorMlK0ipsYoYkCUlQluZIT2JQEfehDHl0Rk4eib7HwU4Q5SXpm1R
         hLusOWfC9hyYA7DP6xjHwrrx4gSVO2QQe2Xfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WDpEXta6gblz8RcQG8Y0aSP7MVebXWwYNQQzkqw1syM=;
        b=KNx1UoEKkBOg7Cvxa0E6G9SDXsZ6SFfVdhSNXK+Pq/36ZThacq12s5DntCEc+1hSEn
         6ZaYtNKSUl/FJ3I2g4azi9NWqox4CucuMzc2o1/f4zRm5oT6XxEntbkaeeklsYq+RlOm
         kKRvQajmyGcDsCUnn91s2G6IfXuHf5HEqEYd92Q0JlJd6yJV8Cl3/Q5atvUTlTN0KGkR
         odVRXYNfIwzPQfduozdcPAtndAAmENmQCKEwGMre0gartPJQt5NG4otL1ezkEQfxd3xu
         ORugLjcZcV9h6RA+x9Yyz398jpzPJdBwR9CTJs1omlytt0b3rvxSbydT6OVue2ob6UM5
         tCHA==
X-Gm-Message-State: APjAAAXBLoYjSMO5ksTRcjJ3QrQD4bpw2Dx9uOQPnNL6B0c58c9B5qyu
        Nji/alAoPrrsUh+Ue0TeqR83MQ==
X-Google-Smtp-Source: APXvYqxFx3lAs83NleldSHvJtGYr8uultjy/q194MXgo4WsWAIjlsO+XPESSMmA+TJVWlA+I7JD0Zw==
X-Received: by 2002:a62:3441:: with SMTP id b62mr30262216pfa.233.1572383650475;
        Tue, 29 Oct 2019 14:14:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f25sm50907pfk.10.2019.10.29.14.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:14:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH v3 08/29] vmlinux.lds.h: Provide EMIT_PT_NOTE to indicate export of .notes
Date:   Tue, 29 Oct 2019 14:13:30 -0700
Message-Id: <20191029211351.13243-9-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029211351.13243-1-keescook@chromium.org>
References: <20191029211351.13243-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

In preparation for moving NOTES into RO_DATA, provide a mechanism for
architectures that want to emit a PT_NOTE Program Header to do so.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # s390
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
index 2c4f23c390ad..7cf4958b732d 100644
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
index dae64600ccbf..f5dd45ce73f1 100644
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

