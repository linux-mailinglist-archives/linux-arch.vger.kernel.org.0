Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA634F3F4D
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfKHFEQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:04:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41613 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfKHFEQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id d29so3233451plj.8
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=veF3L6iMfbaC8NBWTh973dGGvIbVBEAjTKEMk/CcrRk=;
        b=mjnQaYJjvrt9ygOVwQaScwiemE8j0Jl+1HtszqqLBpuqDQhXs/eSUXWfyIA6ZVytDX
         /thQblMf/sWRJc+hMHVjTeSdCUW8a9a4ORVQuy90MQjuMFd62Zfnh7fNtya8horm7zty
         EKNmJBRqQffPDqzs+M0gy/F7qDYUCFKMmmieTdQvnDp7xgjYVPQmnSYGd5/ezZXxLEYV
         O+OBmrT7F5qOPSgdDwKlcMI8yuvSRap/STrGMXR085Mgz1DEVUHBJ9da4xtRiMSO6gsY
         yi/EDL0TT2Zb3wcKfdYH07P6A987qTOZuWuXs6wjUfM4V7Y5qJu8RVuGqmvLeX70JQJH
         nOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veF3L6iMfbaC8NBWTh973dGGvIbVBEAjTKEMk/CcrRk=;
        b=Cj1bCxoYWYyXY601BZKWs6kKbfkc1R97Tk1cf8VPxO8V3zdYvR3UiL++wKl7Novj6W
         Znr9kZiUkbSzEvRfE4B0ccXB1DkT1/w7VD2ruxdNRROlPmoMKL73t1y8bWpCOic8CzoR
         jin3QoN18OHPfXeT2E+PpSMLhCmS7TvMqiZ8x2Ns7fPIeQzm9VY75j3B8SB10uV/0yET
         a9nGgShST296CQG2PZWXPs5Hwrx5yatQ6KrYPWpzOgNW3kQTqtA5ix7lg6kfaaTSonGN
         y8x4sXNoLHHO1XfVI+mQlZJxlDQ/x2qg0PvfXWy3zre77ysuOCghCtNSVgXd8jpTNBqt
         wW9Q==
X-Gm-Message-State: APjAAAWK0PLH2QDYQHgPCPdJzy9Ze/b0h8hVsxyYaZraxWmF2DgxgRTE
        7jyc41M4ESXZqm7hLp8e6e0=
X-Google-Smtp-Source: APXvYqwWp9UHAYtzot/xa1PPayf1HqeSKEeerJx9lN2CfPX+/Smd8o9cISVKg3dTUusiuXunKrOJ3A==
X-Received: by 2002:a17:902:8f89:: with SMTP id z9mr7954059plo.228.1573189454869;
        Thu, 07 Nov 2019 21:04:14 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id u36sm4371553pgn.29.2019.11.07.21.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:04:14 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id B5B81201ACFE83; Fri,  8 Nov 2019 14:04:12 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org,
        Hajime Tazaki <thehajime@gmail.com>,
        Jens Staal <staal1978@gmail.com>
Subject: [RFC v2 31/37] lkl: add support for Windows hosts
Date:   Fri,  8 Nov 2019 14:02:46 +0900
Message-Id: <8562184b77c641a99cb80ff37fb3d3b405f5f6ec.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Octavian Purdila <tavi.purdila@gmail.com>

This patch allows LKL to be compiled for windows hosts with the mingw
toolchain. Note that patches [1] that fix weak symbols linking are
required to successfully compile LKL with mingw.

The patch disables the modpost pass over vmlinux since modpost only
works with ELF objects.

It also adds and workaround to an #include_next <stdard.h> error which
is apparently caused by using -nosdtinc.

[1] https://sourceware.org/ml/binutils/2015-10/msg00234.html

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Jens Staal <staal1978@gmail.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/Kconfig                 | 2 ++
 arch/um/lkl/include/system/stdarg.h | 2 ++
 include/linux/compiler_attributes.h | 4 ++++
 lib/.gitignore                      | 2 ++
 lib/raid6/.gitignore                | 1 +
 scripts/.gitignore                  | 2 ++
 scripts/basic/.gitignore            | 1 +
 scripts/kconfig/.gitignore          | 1 +
 scripts/link-vmlinux.sh             | 2 ++
 scripts/mod/.gitignore              | 1 +
 10 files changed, 18 insertions(+)
 create mode 100644 arch/um/lkl/include/system/stdarg.h

diff --git a/arch/um/lkl/Kconfig b/arch/um/lkl/Kconfig
index 07b3699095ae..1629e2679b75 100644
--- a/arch/um/lkl/Kconfig
+++ b/arch/um/lkl/Kconfig
@@ -20,6 +20,8 @@ config LKL
        select DMA_DIRECT_OPS
        select PHYS_ADDR_T_64BIT if 64BIT
        select 64BIT if "$(OUTPUT_FORMAT)" = "elf64-x86-64"
+       select 64BIT if "$(OUTPUT_FORMAT)" = "pe-x86-64"
+       select HAVE_UNDERSCORE_SYMBOL_PREFIX if "$(OUTPUT_FORMAT)" = "pe-i386"
        select 64BIT if "$(OUTPUT_FORMAT)" = "elf64-x86-64-freebsd"
        select NET
        select MULTIUSER
diff --git a/arch/um/lkl/include/system/stdarg.h b/arch/um/lkl/include/system/stdarg.h
new file mode 100644
index 000000000000..12077a36828c
--- /dev/null
+++ b/arch/um/lkl/include/system/stdarg.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* empty file to avoid #include_next<stdarg.h> error */
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 6b318efd8a74..1981b1c323c1 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -154,7 +154,11 @@
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-format-function-attribute
  * clang: https://clang.llvm.org/docs/AttributeReference.html#format
  */
+#ifdef __MINGW32__
+#define __printf(a, b)             __attribute__((__format__(gnu_printf, a, b)))
+#else
 #define __printf(a, b)                  __attribute__((__format__(printf, a, b)))
+#endif
 #define __scanf(a, b)                   __attribute__((__format__(scanf, a, b)))
 
 /*
diff --git a/lib/.gitignore b/lib/.gitignore
index f2a39c9e5485..eb9f11b81fe1 100644
--- a/lib/.gitignore
+++ b/lib/.gitignore
@@ -2,7 +2,9 @@
 # Generated files
 #
 gen_crc32table
+gen_crc32table.exe
 gen_crc64table
+gen_crc64table.exe
 crc32table.h
 crc64table.h
 oid_registry_data.c
diff --git a/lib/raid6/.gitignore b/lib/raid6/.gitignore
index 3de0d8921286..80e3566535aa 100644
--- a/lib/raid6/.gitignore
+++ b/lib/raid6/.gitignore
@@ -1,4 +1,5 @@
 mktables
+mktables.exe
 altivec*.c
 int*.c
 tables.c
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 17f8cef88fa8..ec9138a39b25 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -4,8 +4,10 @@
 bin2c
 conmakehash
 kallsyms
+kallsyms.exe
 pnmtologo
 unifdef
+unifdef.exe
 recordmcount
 sortextable
 asn1_compiler
diff --git a/scripts/basic/.gitignore b/scripts/basic/.gitignore
index a776371a3502..77ce153243fa 100644
--- a/scripts/basic/.gitignore
+++ b/scripts/basic/.gitignore
@@ -1 +1,2 @@
 fixdep
+fixdep.exe
diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
index b5bf92f66d11..aa27000d896f 100644
--- a/scripts/kconfig/.gitignore
+++ b/scripts/kconfig/.gitignore
@@ -8,6 +8,7 @@
 # configuration programs
 #
 conf
+conf.exe
 mconf
 nconf
 qconf
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c3c5758ed7d6..553d966a1986 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -209,6 +209,7 @@ fi;
 # final build of init/
 ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init
 
+if [ -e scripts/mod/modpost ]; then
 #link vmlinux.o
 info LD vmlinux.o
 modpost_link vmlinux.o
@@ -218,6 +219,7 @@ ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=1
 
 info MODINFO modules.builtin.modinfo
 ${OBJCOPY} -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
+fi
 
 kallsymso=""
 kallsyms_vmlinux=""
diff --git a/scripts/mod/.gitignore b/scripts/mod/.gitignore
index 3bd11b603173..cd67845e326d 100644
--- a/scripts/mod/.gitignore
+++ b/scripts/mod/.gitignore
@@ -1,4 +1,5 @@
 elfconfig.h
 mk_elfconfig
 modpost
+modpost.exe
 devicetable-offsets.h
-- 
2.20.1 (Apple Git-117)

