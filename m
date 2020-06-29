Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A692E20E19C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 23:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgF2U5u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 16:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbgF2TNG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:13:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4D4C08EAF7
        for <linux-arch@vger.kernel.org>; Sun, 28 Jun 2020 23:18:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h4so599908plt.9
        for <linux-arch@vger.kernel.org>; Sun, 28 Jun 2020 23:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hZnstVfYoPOWJe22/uMPE3GyeVYaazSg9tzCfSWEM0=;
        b=g7mI0xRQzDC9tX/D2EXTMfRLSef8L0Y2sQz/4glsjoZ6Yj2AbQGPaF4thtUQ8/mWod
         vga4zH3CHMGXWR+3yabUgVfDV+o/W/uegg3rEYPkUquZyo2oihOokRRdS2JdBfO0z4ze
         SBzOKgs3B+l+APXQtOllt1mwPV0/1S7vr/9R4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hZnstVfYoPOWJe22/uMPE3GyeVYaazSg9tzCfSWEM0=;
        b=nMXrOLU6zRmVsxOmRFSBCVE12ZvmXKrNlukr6HF3xw5zG8xLikylupg8j7mMMguz9O
         Q9eFZPVuk7r6IIE/D3YLkCsZydMGiHaKxKAfP/40VmeTZVjKws8MzFW4rIBYY7alu0MT
         Pkd0eSf8G8cCqzH3KN415EGv9ZYIP5KUnJIcjVU8lqVlZaryaZBd22ys0hpB6H9I5kHg
         jTw50JSs8a8Va3kZQwsSz3TYt9JrL8Co8oH2sFqvGtUGJxu6Mp+8NqTyEsDSIlCigVK0
         Yp3OLxU9dyMeJ4S1qJqvlanXWkw2SKtGgKxPQoWtW3T2YZcyL13UbruoPEewuTQ7nCmw
         YXiw==
X-Gm-Message-State: AOAM532n8eBzL7C6RqlAxDbwop15a91RlP91znjaVfyDHhx0PvoyHDwY
        Q/rUKlCwZSukk8hBtUx0RB7Ugw==
X-Google-Smtp-Source: ABdhPJyceFu/euSgU0RFtNpZAq+i0oZxpc9IB6mMNzAJGXQZb1GRHNknkn66laen/hCrjyrGME0o9g==
X-Received: by 2002:a17:902:8a95:: with SMTP id p21mr11636474plo.230.1593411527513;
        Sun, 28 Jun 2020 23:18:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f23sm17736216pja.8.2020.06.28.23.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 23:18:44 -0700 (PDT)
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
Subject: [PATCH v4 03/17] vmlinux.lds.h: Split ELF_DETAILS from STABS_DEBUG
Date:   Sun, 28 Jun 2020 23:18:26 -0700
Message-Id: <20200629061840.4065483-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The .comment section doesn't belong in STABS_DEBUG. Split it out into a
new macro named ELF_DETAILS. This will gain other non-debug sections
that need to be accounted for when linking with --orphan-handling=warn.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/alpha/kernel/vmlinux.lds.S           | 1 +
 arch/arc/kernel/vmlinux.lds.S             | 1 +
 arch/arm/kernel/vmlinux-xip.lds.S         | 1 +
 arch/arm/kernel/vmlinux.lds.S             | 1 +
 arch/arm64/kernel/vmlinux.lds.S           | 1 +
 arch/csky/kernel/vmlinux.lds.S            | 1 +
 arch/hexagon/kernel/vmlinux.lds.S         | 1 +
 arch/ia64/kernel/vmlinux.lds.S            | 1 +
 arch/mips/kernel/vmlinux.lds.S            | 1 +
 arch/nds32/kernel/vmlinux.lds.S           | 1 +
 arch/nios2/kernel/vmlinux.lds.S           | 1 +
 arch/openrisc/kernel/vmlinux.lds.S        | 1 +
 arch/parisc/boot/compressed/vmlinux.lds.S | 1 +
 arch/parisc/kernel/vmlinux.lds.S          | 1 +
 arch/powerpc/kernel/vmlinux.lds.S         | 2 +-
 arch/riscv/kernel/vmlinux.lds.S           | 1 +
 arch/s390/kernel/vmlinux.lds.S            | 1 +
 arch/sh/kernel/vmlinux.lds.S              | 1 +
 arch/sparc/kernel/vmlinux.lds.S           | 1 +
 arch/um/kernel/dyn.lds.S                  | 2 +-
 arch/um/kernel/uml.lds.S                  | 2 +-
 arch/unicore32/kernel/vmlinux.lds.S       | 1 +
 arch/x86/boot/compressed/vmlinux.lds.S    | 2 ++
 arch/x86/kernel/vmlinux.lds.S             | 1 +
 include/asm-generic/vmlinux.lds.h         | 8 ++++++--
 25 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/kernel/vmlinux.lds.S b/arch/alpha/kernel/vmlinux.lds.S
index bc6f727278fd..5b78d640725d 100644
--- a/arch/alpha/kernel/vmlinux.lds.S
+++ b/arch/alpha/kernel/vmlinux.lds.S
@@ -72,6 +72,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	DISCARDS
 }
diff --git a/arch/arc/kernel/vmlinux.lds.S b/arch/arc/kernel/vmlinux.lds.S
index 54139a6f469b..33ce59d91461 100644
--- a/arch/arc/kernel/vmlinux.lds.S
+++ b/arch/arc/kernel/vmlinux.lds.S
@@ -122,6 +122,7 @@ SECTIONS
 	_end = . ;
 
 	STABS_DEBUG
+	ELF_DETAILS
 	DISCARDS
 
 	.arcextmap 0 : {
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 6d2be994ae58..3d4e88f08196 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -152,6 +152,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	ELF_DETAILS
 }
 
 /*
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 7f24bc08403e..5592f14b7e35 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -151,6 +151,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	ELF_DETAILS
 }
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6827da7f3aa5..55ae731b6368 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -245,6 +245,7 @@ SECTIONS
 	_end = .;
 
 	STABS_DEBUG
+	ELF_DETAILS
 
 	HEAD_SYMBOLS
 }
diff --git a/arch/csky/kernel/vmlinux.lds.S b/arch/csky/kernel/vmlinux.lds.S
index f05b413df328..f03033e17c29 100644
--- a/arch/csky/kernel/vmlinux.lds.S
+++ b/arch/csky/kernel/vmlinux.lds.S
@@ -109,6 +109,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	DISCARDS
 }
diff --git a/arch/hexagon/kernel/vmlinux.lds.S b/arch/hexagon/kernel/vmlinux.lds.S
index 0ca2471ddb9f..35b18e55eae8 100644
--- a/arch/hexagon/kernel/vmlinux.lds.S
+++ b/arch/hexagon/kernel/vmlinux.lds.S
@@ -67,5 +67,6 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 }
diff --git a/arch/ia64/kernel/vmlinux.lds.S b/arch/ia64/kernel/vmlinux.lds.S
index d259690eb91a..9b265783be6a 100644
--- a/arch/ia64/kernel/vmlinux.lds.S
+++ b/arch/ia64/kernel/vmlinux.lds.S
@@ -218,6 +218,7 @@ SECTIONS {
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	/* Default discards */
 	DISCARDS
diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
index f185a85a27c1..5e97e9d02f98 100644
--- a/arch/mips/kernel/vmlinux.lds.S
+++ b/arch/mips/kernel/vmlinux.lds.S
@@ -202,6 +202,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	/* These must appear regardless of  .  */
 	.gptab.sdata : {
diff --git a/arch/nds32/kernel/vmlinux.lds.S b/arch/nds32/kernel/vmlinux.lds.S
index 7a6c1cefe3fe..6a91b965fb1e 100644
--- a/arch/nds32/kernel/vmlinux.lds.S
+++ b/arch/nds32/kernel/vmlinux.lds.S
@@ -64,6 +64,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	DISCARDS
 }
diff --git a/arch/nios2/kernel/vmlinux.lds.S b/arch/nios2/kernel/vmlinux.lds.S
index c55a7cfa1075..126e114744cb 100644
--- a/arch/nios2/kernel/vmlinux.lds.S
+++ b/arch/nios2/kernel/vmlinux.lds.S
@@ -58,6 +58,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	DISCARDS
 }
diff --git a/arch/openrisc/kernel/vmlinux.lds.S b/arch/openrisc/kernel/vmlinux.lds.S
index 60449fd7f16f..d287dbb84d0f 100644
--- a/arch/openrisc/kernel/vmlinux.lds.S
+++ b/arch/openrisc/kernel/vmlinux.lds.S
@@ -115,6 +115,7 @@ SECTIONS
 	/* Throw in the debugging sections */
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
         /* Sections to be discarded -- must be last */
 	DISCARDS
diff --git a/arch/parisc/boot/compressed/vmlinux.lds.S b/arch/parisc/boot/compressed/vmlinux.lds.S
index 2ac3a643f2eb..ab7b43990857 100644
--- a/arch/parisc/boot/compressed/vmlinux.lds.S
+++ b/arch/parisc/boot/compressed/vmlinux.lds.S
@@ -84,6 +84,7 @@ SECTIONS
 	}
 
 	STABS_DEBUG
+	ELF_DETAILS
 	.note 0 : { *(.note) }
 
 	/* Sections to be discarded */
diff --git a/arch/parisc/kernel/vmlinux.lds.S b/arch/parisc/kernel/vmlinux.lds.S
index 53e29d88f99c..2769eb991f58 100644
--- a/arch/parisc/kernel/vmlinux.lds.S
+++ b/arch/parisc/kernel/vmlinux.lds.S
@@ -164,6 +164,7 @@ SECTIONS
 	_end = . ;
 
 	STABS_DEBUG
+	ELF_DETAILS
 	.note 0 : { *(.note) }
 
 	/* Sections to be discarded */
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 326e113d2e45..e0548b4950de 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -360,8 +360,8 @@ SECTIONS
 	PROVIDE32 (end = .);
 
 	STABS_DEBUG
-
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	DISCARDS
 	/DISCARD/ : {
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index e6f8016b366a..00a325289a26 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -97,6 +97,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	DISCARDS
 }
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 37695499717d..177ccfbda40a 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -181,6 +181,7 @@ SECTIONS
 	/* Debugging sections.	*/
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	/* Sections to be discarded */
 	DISCARDS
diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
index bde7a6c01aaf..3161b9ccd2a5 100644
--- a/arch/sh/kernel/vmlinux.lds.S
+++ b/arch/sh/kernel/vmlinux.lds.S
@@ -76,6 +76,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	DISCARDS
 }
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index f99e99e58075..d55ae65a07ad 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -187,6 +187,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	DISCARDS
 }
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index f5001481010c..dacbfabf66d8 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -164,8 +164,8 @@ SECTIONS
   PROVIDE (end = .);
 
   STABS_DEBUG
-
   DWARF_DEBUG
+  ELF_DETAILS
 
   DISCARDS
 }
diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 3b6dab3d4501..45d957d7004c 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -108,8 +108,8 @@ SECTIONS
   PROVIDE (end = .);
 
   STABS_DEBUG
-
   DWARF_DEBUG
+  ELF_DETAILS
 
   DISCARDS
 }
diff --git a/arch/unicore32/kernel/vmlinux.lds.S b/arch/unicore32/kernel/vmlinux.lds.S
index 6fb320b337ef..22eb642c7280 100644
--- a/arch/unicore32/kernel/vmlinux.lds.S
+++ b/arch/unicore32/kernel/vmlinux.lds.S
@@ -54,6 +54,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	DISCARDS		/* Exit code and data */
 }
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 8f1025d1f681..d88612e3091f 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -75,5 +75,7 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
 
+	ELF_DETAILS
+
 	DISCARDS
 }
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 3bfc8dd8a43d..504d16968ed8 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -410,6 +410,7 @@ SECTIONS
 
 	STABS_DEBUG
 	DWARF_DEBUG
+	ELF_DETAILS
 
 	DISCARDS
 }
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e53a2d4f47f6..c5d10bc53996 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -34,6 +34,7 @@
  *
  *	STABS_DEBUG
  *	DWARF_DEBUG
+ *	ELF_DETAILS
  *
  *	DISCARDS		// must be the last
  * }
@@ -784,14 +785,17 @@
 		.debug_macro	0 : { *(.debug_macro) }			\
 		.debug_addr	0 : { *(.debug_addr) }
 
-		/* Stabs debugging sections.  */
+/* Stabs debugging sections. */
 #define STABS_DEBUG							\
 		.stab 0 : { *(.stab) }					\
 		.stabstr 0 : { *(.stabstr) }				\
 		.stab.excl 0 : { *(.stab.excl) }			\
 		.stab.exclstr 0 : { *(.stab.exclstr) }			\
 		.stab.index 0 : { *(.stab.index) }			\
-		.stab.indexstr 0 : { *(.stab.indexstr) }		\
+		.stab.indexstr 0 : { *(.stab.indexstr) }
+
+/* Required sections not related to debugging. */
+#define ELF_DETAILS							\
 		.comment 0 : { *(.comment) }
 
 #ifdef CONFIG_GENERIC_BUG
-- 
2.25.1

