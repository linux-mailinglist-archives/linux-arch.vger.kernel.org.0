Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93456F3F55
	for <lists+linux-arch@lfdr.de>; Fri,  8 Nov 2019 06:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfKHFE0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Nov 2019 00:04:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39873 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfKHFE0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Nov 2019 00:04:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id x28so3857838pfo.6
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2019 21:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QrjmXpZuOzccN2+JudtgFdgeHtwX1E16OtMi3lDfOVM=;
        b=Y9yadeGOgErzUddVQaR3NPy/OAB4ecyzula11ciS1U1xJsZyGEqe7Wbbt36DbWKXj1
         g7eOOXXR+C7CyM+vBqstnaOz3nHtH1jguEy6BjRDA2T18xBct7sooeZZpToT6DpW1FkD
         ut/KJkgbu8HDB/dBbMlQkg59N3k/pfFtAw5bMJNEqqkM//DFypFWt4rX+1FkVoOScIMb
         Ez969CYAPvkPdCe4v2hr4mEUezByfTw5o9/c9IR3oCAb8Y92qbNBgI/6EmATHHZbHcmJ
         Bnvo/y+ldvjaLlbtFoPY/xXcUze9DsvNVqhdUqd+KgF9QeIzi7U7chu1duPLosGCj79Y
         q+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QrjmXpZuOzccN2+JudtgFdgeHtwX1E16OtMi3lDfOVM=;
        b=dibHTljlFryb8p36gc46JinIRyoRCeGdzAuPfgT/ns3UOQzknRO3Hu4smt90gvF1lX
         tL8tO6u09tkOzhTtezTAx5CBlmg6b9WDBKPZ/idFs3njjE6bcitmPXquAzdUHlZsXEBt
         pKw05Rc7YnKKsi9lsbXY9imUtQXbyRLqJ+JAxUPNo3IKHvwiy9+K6K8wuI1L598Pqjk/
         C2JcFyxnt4Dhw0mI2udn+VqAgCpMu1KYtf8UEdxe2RmD/Ok8SAlvLJYSFkynPYgPI1g4
         GvTM/rVkO5jzlF+BQw7zBB3gvP0IqYYGNZEpXHjYbRnDxCce951TqtJgHthb8r9Pcib+
         MVoQ==
X-Gm-Message-State: APjAAAWkufpH1DlxOsjr3/uInfmWXCpFLEVZBc/xiEBLEX1V5XdlptcZ
        y7tyJlwfxef+HFfP1SZjHHw=
X-Google-Smtp-Source: APXvYqxQD8QrWXP7+eiU17/ipd12O0nObfnHNN9xVDYT3JbAFjZOV7aXzVkoEG/46k1PmhUGLmGvSQ==
X-Received: by 2002:a65:68d7:: with SMTP id k23mr9286140pgt.157.1573189464648;
        Thu, 07 Nov 2019 21:04:24 -0800 (PST)
Received: from earth-mac.local ([202.214.86.179])
        by smtp.gmail.com with ESMTPSA id n21sm2148057pjq.13.2019.11.07.21.04.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 21:04:24 -0800 (PST)
Received: by earth-mac.local (Postfix, from userid 501)
        id CFABE201ACFEB6; Fri,  8 Nov 2019 14:04:22 +0900 (JST)
From:   Hajime Tazaki <thehajime@gmail.com>
To:     linux-um@lists.infradead.org
Cc:     Octavian Purdila <tavi.purdila@gmail.com>,
        Akira Moroo <retrage01@gmail.com>,
        linux-kernel-library@freelists.org, linux-arch@vger.kernel.org
Subject: [RFC v2 33/37] kallsyms: Add a config option to select section for kallsyms
Date:   Fri,  8 Nov 2019 14:02:48 +0900
Message-Id: <1f8a9e18edf808f2016899887a3110be63cbc3c1.1573179553.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1573179553.git.thehajime@gmail.com>
References: <cover.1573179553.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Andreas Abel <aabel@google.com>

This commit adds a kernel config option to select whether the
kallsyms data should be in the .rodata section (the default for
non-LKL builds), or in the .data section (the default for LKL).

This is to avoid relocations in the text segment (TEXTRELs) that
would otherwise occur with LKL when the .rodata and the .text
section end up in the same segment.

Having TEXTRELs can lead to a number of issues:

1. If a shared library contains a TEXTREL, the corresponding memory
pages cannot be shared.

2. Android >=6 and SELinux do not support binaries with TEXTRELs
(http://android-developers.blogspot.com/2016/06/android-changes-for-ndk-developers.html).

3. If a program has a TEXTREL, uses an ifunc, and is compiled with
early binding, this can lead to a segmentation fault when processing
the relocation for the ifunc during dynamic linking because the text
segment is made temporarily non-executable to process the TEXTREL
(line 248 in dl_reloc.c).

Signed-off-by: Andreas Abel <aabel@google.com>
---
 init/Kconfig            | 12 ++++++++++++
 scripts/kallsyms.c      | 11 +++++++++--
 scripts/link-vmlinux.sh |  4 ++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 81293d78a6ad..bd1a846e0ee0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1385,6 +1385,18 @@ config POSIX_TIMERS
 
 	  If unsure say y.
 
+config KALLSYMS_USE_DATA_SECTION
+	bool "Use .data instead of .rodata section for kallsyms"
+	depends on KALLSYMS
+	default n
+	help
+	  Enabling this option will put the kallsyms data in the .data section
+	  instead of the .rodata section.
+
+	  This is useful when building the kernel as a library, as it avoids
+	  relocations in the text segment that could otherwise occur if the
+	  .rodata section is in the same segment as the .text section.
+
 config PRINTK
 	default y
 	bool "Enable support for printk" if EXPERT
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 75ec25554111..5e4f270c3904 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -59,6 +59,7 @@ static struct addr_range percpu_range = {
 static struct sym_entry *table;
 static unsigned int table_size, table_cnt;
 static int all_symbols = 0;
+static int use_data_section;
 static int absolute_percpu = 0;
 static char symbol_prefix_char = '\0';
 static int base_relative = 0;
@@ -74,6 +75,7 @@ static void usage(void)
 {
 	fprintf(stderr, "Usage: kallsyms [--all-symbols] "
 			"[--symbol-prefix=<prefix char>] "
+			"[--use-data-section] "
 			"[--base-relative] < in.map > out.S\n");
 	exit(1);
 }
@@ -362,7 +364,10 @@ static void write_src(void)
 	printf("#define ALGN .balign 4\n");
 	printf("#endif\n");
 
-	printf("\t.section .rodata, \"a\"\n");
+	if (use_data_section)
+		printf("\t.section .data\n");
+	else
+		printf("\t.section .rodata, \"a\"\n");
 
 	/* Provide proper symbols relocatability by their relativeness
 	 * to a fixed anchor point in the runtime image, either '_text'
@@ -774,7 +779,9 @@ int main(int argc, char **argv)
 				if ((*p == '"' && *(p+2) == '"') || (*p == '\'' && *(p+2) == '\''))
 					p++;
 				symbol_prefix_char = *p;
-			} else
+			} else if (strcmp(argv[i], "--use-data-section") == 0)
+				use_data_section = 1;
+			else
 				usage();
 		}
 	} else if (argc != 1)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 553d966a1986..3fc1fc406b38 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -133,6 +133,10 @@ kallsyms()
 		kallsymopt="${kallsymopt} --base-relative"
 	fi
 
+	if [ -n "${CONFIG_KALLSYMS_USE_DATA_SECTION}" ]; then
+		kallsymopt="${kallsymopt} --use-data-section"
+	fi
+
 	local aflags="${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERNEL}               \
 		      ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS}"
 
-- 
2.20.1 (Apple Git-117)

