Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 470EEBF856
	for <lists+linux-arch@lfdr.de>; Thu, 26 Sep 2019 19:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfIZR5Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Sep 2019 13:57:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43398 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbfIZR42 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Sep 2019 13:56:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id v27so1941223pgk.10
        for <linux-arch@vger.kernel.org>; Thu, 26 Sep 2019 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rv+0o5mJKqlMVqhb1qXAA1i/NAPfwklm1J1wPL8Rg+Y=;
        b=KLMaaspib7B9k3L/1fjMwxKFPEIRUIbpqLyP7POH8bfp98DccIDvMUY0g/JO8OD+IN
         yHHIJMMU6qn805SoMyIRfugF7Tq24dOAzvst7C2KmNwTMJj/RAmnNHk+jLu3WZplt2Zq
         Wt/ngd69A/ym7jGwQZ5tUEQ8U9Lc+GLLZx1vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rv+0o5mJKqlMVqhb1qXAA1i/NAPfwklm1J1wPL8Rg+Y=;
        b=AeCxHyl9IVsL1RfLTVJ9BeqGm5bb3+gDmvYII2gPY+BR4vxtVCMDURha0i7u8g23nv
         /PFGjcFrkyublHnEmmUKyeczNYpVxyDqUjlTjWrpY/cKP8NRc1wSqniXkW/gWEdg+lOD
         Po7xq6bLlDNLmaOEUgjUHV9e3HsBTxlYixu8/Mi5Pc1SlLn9FSJtSCao9BWqBj2ZNUqX
         JNI5jsnaZL5EEShF+YDL13uw+yBqVAlCeRGJ6sZgSGoStRAINzOrPmCbqXwa145Brnbg
         KutBpE5lOVKt8sPtfZ9lx2rbxkxSkVBB/427ytflobVRtGkZxvCvj2W8Bk9VaQ46jvyd
         jMpg==
X-Gm-Message-State: APjAAAUpe8KhUuVzynzbgCVxcXFuznOXkmseuyX5m4m2X8TEHXfOrEXK
        irCjtaEn83LBkfISE6p40Up3jw==
X-Google-Smtp-Source: APXvYqx0rFDBs+mkI2PjjMDWWKbtBTnPHLojfYZE0HyLFhA1JQjLM+1gn1UCEg3Av7cuqozcAO0fqQ==
X-Received: by 2002:a17:90b:f11:: with SMTP id br17mr4904149pjb.80.1569520586710;
        Thu, 26 Sep 2019 10:56:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v5sm3337154pfv.76.2019.09.26.10.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 10:56:26 -0700 (PDT)
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
Subject: [PATCH 12/29] vmlinux.lds.h: Replace RO_DATA_SECTION with RO_DATA
Date:   Thu, 26 Sep 2019 10:55:45 -0700
Message-Id: <20190926175602.33098-13-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190926175602.33098-1-keescook@chromium.org>
References: <20190926175602.33098-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This finishes renaming RO_DATA_SECTION to RO_DATA. (Calling this a
"section" is a lie, since it's multiple sections and section flags cannot
be applied to the macro.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arc/kernel/vmlinux.lds.S       | 2 +-
 arch/c6x/kernel/vmlinux.lds.S       | 2 +-
 arch/csky/kernel/vmlinux.lds.S      | 2 +-
 arch/h8300/kernel/vmlinux.lds.S     | 2 +-
 arch/hexagon/kernel/vmlinux.lds.S   | 2 +-
 arch/m68k/kernel/vmlinux-nommu.lds  | 2 +-
 arch/nds32/kernel/vmlinux.lds.S     | 2 +-
 arch/nios2/kernel/vmlinux.lds.S     | 2 +-
 arch/openrisc/kernel/vmlinux.lds.S  | 4 ++--
 arch/parisc/kernel/vmlinux.lds.S    | 4 ++--
 arch/riscv/kernel/vmlinux.lds.S     | 2 +-
 arch/s390/kernel/vmlinux.lds.S      | 2 +-
 arch/unicore32/kernel/vmlinux.lds.S | 2 +-
 include/asm-generic/vmlinux.lds.h   | 7 ++-----
 14 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index 1d6eef4b6976..7d1d27066deb 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -95,7 +95,7 @@ SECTIONS
 	_etext = .;
 
 	_sdata = .;
-	RO_DATA_SECTION(PAGE_SIZE)
+	RO_DATA(PAGE_SIZE)
 
 	/*
 	 * 1. this is .data essentially
diff --git a/arch/c6x/kernel/vmlinux.lds.S b/arch/c6x/kernel/vmlinux.lds.S
index d6e3802536b3..a3547f9d415b 100644
--- a/arch/c6x/kernel/vmlinux.lds.S
+++ b/arch/c6x/kernel/vmlinux.lds.S
@@ -82,7 +82,7 @@ SECTIONS
 
 	EXCEPTION_TABLE(16)
 
-	RO_DATA_SECTION(PAGE_SIZE)
+	RO_DATA(PAGE_SIZE)
 	.const :
 	{
 		*(.const .const.* .gnu.linkonce.r.*)
diff --git a/arch/csky/kernel/vmlinux.lds.S b/arch/csky/kernel/vmlinux.lds.S
index 75dd31412242..8598bd7a7bcd 100644
--- a/arch/csky/kernel/vmlinux.lds.S
+++ b/arch/csky/kernel/vmlinux.lds.S
@@ -49,7 +49,7 @@ SECTIONS
 
 
 	_sdata = .;
-	RO_DATA_SECTION(PAGE_SIZE)
+	RO_DATA(PAGE_SIZE)
 	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	_edata = .;
 
diff --git a/arch/h8300/kernel/vmlinux.lds.S b/arch/h8300/kernel/vmlinux.lds.S
index 88776e785245..d3247d33b115 100644
--- a/arch/h8300/kernel/vmlinux.lds.S
+++ b/arch/h8300/kernel/vmlinux.lds.S
@@ -38,7 +38,7 @@ SECTIONS
 	_etext = . ;
 	}
 	EXCEPTION_TABLE(16)
-	RO_DATA_SECTION(4)
+	RO_DATA(4)
 	ROMEND = .;
 #if defined(CONFIG_ROMKERNEL)
 	. = RAMTOP;
diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index 6a6e8fc422ee..0145251fa317 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -50,7 +50,7 @@ SECTIONS
 
 	_sdata = .;
 		RW_DATA_SECTION(32,PAGE_SIZE,_THREAD_SIZE)
-		RO_DATA_SECTION(PAGE_SIZE)
+		RO_DATA(PAGE_SIZE)
 	_edata = .;
 
 	EXCEPTION_TABLE(16)
diff --git a/arch/m68k/kernel/vmlinux-nommu.lds b/arch/m68k/kernel/vmlinux-nommu.lds
index cf6edda38971..de80f8b8ae78 100644
--- a/arch/m68k/kernel/vmlinux-nommu.lds
+++ b/arch/m68k/kernel/vmlinux-nommu.lds
@@ -60,7 +60,7 @@ SECTIONS {
 #endif
 
 	_sdata = .;
-	RO_DATA_SECTION(PAGE_SIZE)
+	RO_DATA(PAGE_SIZE)
 	RW_DATA_SECTION(16, PAGE_SIZE, THREAD_SIZE)
 	_edata = .;
 
diff --git a/arch/nds32/kernel/vmlinux.lds.S b/arch/nds32/kernel/vmlinux.lds.S
index c4f1c5a604c3..10ff570ba95b 100644
--- a/arch/nds32/kernel/vmlinux.lds.S
+++ b/arch/nds32/kernel/vmlinux.lds.S
@@ -53,7 +53,7 @@ SECTIONS
 	_etext = .;			/* End of text and rodata section */
 
 	_sdata = .;
-	RO_DATA_SECTION(PAGE_SIZE)
+	RO_DATA(PAGE_SIZE)
 	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	_edata  =  .;
 
diff --git a/arch/nios2/kernel/vmlinux.lds.S b/arch/nios2/kernel/vmlinux.lds.S
index 20e4078b3477..318804a2c7a1 100644
--- a/arch/nios2/kernel/vmlinux.lds.S
+++ b/arch/nios2/kernel/vmlinux.lds.S
@@ -49,7 +49,7 @@ SECTIONS
 	__init_end = .;
 
 	_sdata = .;
-	RO_DATA_SECTION(PAGE_SIZE)
+	RO_DATA(PAGE_SIZE)
 	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	_edata = .;
 
diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
index 142c51c994f5..f73e0d3ea09f 100644
--- a/arch/openrisc/kernel/vmlinux.lds.S
+++ b/arch/openrisc/kernel/vmlinux.lds.S
@@ -67,8 +67,8 @@ SECTIONS
 
 	_sdata = .;
 
-	/* Page alignment required for RO_DATA_SECTION */
-	RO_DATA_SECTION(PAGE_SIZE)
+	/* Page alignment required for RO_DATA */
+	RO_DATA(PAGE_SIZE)
 	_e_kernel_ro = .;
 
 	/* Whatever comes after _e_kernel_ro had better be page-aligend, too */
diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index 168d12b2ebb8..e1c563c7dca1 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -109,7 +109,7 @@ SECTIONS
 	_sdata = .;
 
 	/* Architecturally we need to keep __gp below 0x1000000 and thus
-	 * in front of RO_DATA_SECTION() which stores lots of tracepoint
+	 * in front of RO_DATA() which stores lots of tracepoint
 	 * and ftrace symbols. */
 #ifdef CONFIG_64BIT
 	. = ALIGN(16);
@@ -127,7 +127,7 @@ SECTIONS
 	}
 #endif
 
-	RO_DATA_SECTION(8)
+	RO_DATA(8)
 
 	/* RO because of BUILDTIME_EXTABLE_SORT */
 	EXCEPTION_TABLE(8)
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index df5229c4034d..66dc17d24dd9 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -52,7 +52,7 @@ SECTIONS
 
 	/* Start of data section */
 	_sdata = .;
-	RO_DATA_SECTION(L1_CACHE_BYTES)
+	RO_DATA(L1_CACHE_BYTES)
 	.srodata : {
 		*(.srodata*)
 	}
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index beb4df053e20..b33c4823f8b5 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -52,7 +52,7 @@ SECTIONS
 		_etext = .;		/* End of text section */
 	} :text = 0x0700
 
-	RO_DATA_SECTION(PAGE_SIZE)
+	RO_DATA(PAGE_SIZE)
 
 	. = ALIGN(PAGE_SIZE);
 	_sdata = .;		/* Start of data section */
diff --git a/arch/unicore32/kernel/vmlinux.lds.S b/arch/unicore32/kernel/vmlinux.lds.S
index 78c4c56057b0..367c80313bec 100644
--- a/arch/unicore32/kernel/vmlinux.lds.S
+++ b/arch/unicore32/kernel/vmlinux.lds.S
@@ -43,7 +43,7 @@ SECTIONS
 	_etext = .;
 
 	_sdata = .;
-	RO_DATA_SECTION(PAGE_SIZE)
+	RO_DATA(PAGE_SIZE)
 	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	_edata = .;
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9520dede6c7a..cdff8ba42d4d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -23,7 +23,7 @@
  *	_etext = .;
  *
  *      _sdata = .;
- *	RO_DATA_SECTION(PAGE_SIZE)
+ *	RO_DATA(PAGE_SIZE)
  *	RW_DATA_SECTION(...)
  *	_edata = .;
  *
@@ -358,7 +358,7 @@
 /*
  * Read only Data
  */
-#define RO_DATA_SECTION(align)						\
+#define RO_DATA(align)							\
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
@@ -513,9 +513,6 @@
 	. = ALIGN((align));						\
 	__end_rodata = .;
 
-/* All archs are supposed to use RO_DATA() */
-#define RO_DATA(align)  RO_DATA_SECTION(align)
-
 /*
  * .text section. Map to function alignment to avoid address changes
  * during second ld run in second ld pass when generating System.map
-- 
2.17.1

