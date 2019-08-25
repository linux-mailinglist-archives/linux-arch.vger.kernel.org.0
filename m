Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E4B9C380
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2019 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfHYNX4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 25 Aug 2019 09:23:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36557 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbfHYNX4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 25 Aug 2019 09:23:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so9837458pfi.3;
        Sun, 25 Aug 2019 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATcCbM6biHkdS6pzkwBCxjjCLgoJOMzk+hMVWKlY49s=;
        b=g0nxmzW0zZ8NOi10EuoUp6vH1QqnVKl2IMIkaHt7cnF9O3K6n0oILEW7cwjrYanydu
         gtoL3DlYM2M5MgCbMEnM06N2evopvAboFj4vypZN5kjGpI15b8rhq5rh/KAkudzPdJpR
         sLDbzKbUi7x6t+5MFWoJogmWGPO2NmboeiEiGdRisvYQ9toPvwp5sS0u6lAQ6B1HzHtA
         NeqnHB9yIGItC6Df2iIXR2yzDjYytV106x33kfO6K4887MnkmD7Xx47qsOPdysl9o3r6
         VHxKFYS5Dpwv/D05aGqO18ep0Y7hxYUSiawMaYs0cINAZIcwP14La+QLXLaoHQpwqAit
         rYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATcCbM6biHkdS6pzkwBCxjjCLgoJOMzk+hMVWKlY49s=;
        b=GanDRWznDBo54jt/JsvObCFwYeJ8SgipQCWKvua2970KvnY5KjBXiE+cs9U0xGaFAq
         P24tN9W2N9E4zIeD/f1oBn95MMAu+oUqFSnh2Qqim9XPEpiGPuZMRsMxFbm1B2mFM96L
         /udd+B0Zs2eQEEDWE926MNOzmwhHF7N8EydU2EO38wbDwcDVFR/bET8H5yzV9WRB5utC
         HpkhxsDWTbsYh/a5EhJGNheVJTp+A3sPIVzLPIk2SU90IjbuPvxqGKdqcvep42qvRo80
         sUtcwI2GH48eg2VI11hrVdNH68AyyDy2CBy4527F2ZyUvkb9bh54EiyLOmLcOYsovInT
         WhsQ==
X-Gm-Message-State: APjAAAUpmUctY94d+1qDS3TBHlSNy34RDGbSzKVb3ZYFBPzrnpdB4jaZ
        u8k+jztMvOM5/DdfuRdwfLE=
X-Google-Smtp-Source: APXvYqzaJqepN4zSy7ymgD+GkZvtuT8tWiHagREHmYhkwZsvhh4laEBbm32dRe/EdCR5Hh5hXENyXQ==
X-Received: by 2002:a17:90a:fb8e:: with SMTP id cp14mr14686883pjb.54.1566739434878;
        Sun, 25 Aug 2019 06:23:54 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id y23sm11076562pfr.86.2019.08.25.06.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 06:23:54 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        "John F . Reiser" <jreiser@BitWagon.com>
Subject: [PATCH 01/11] ftrace: move recordmcount tools to scripts/ftrace
Date:   Sun, 25 Aug 2019 21:23:20 +0800
Message-Id: <20190825132330.5015-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190825132330.5015-1-changbin.du@gmail.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move ftrace tools to its own directory. We will add another tool later.

Cc: John F. Reiser <jreiser@BitWagon.com>
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 scripts/.gitignore                   |  1 -
 scripts/Makefile                     |  2 +-
 scripts/Makefile.build               | 10 +++++-----
 scripts/ftrace/.gitignore            |  4 ++++
 scripts/ftrace/Makefile              |  4 ++++
 scripts/{ => ftrace}/recordmcount.c  |  0
 scripts/{ => ftrace}/recordmcount.h  |  0
 scripts/{ => ftrace}/recordmcount.pl |  0
 8 files changed, 14 insertions(+), 7 deletions(-)
 create mode 100644 scripts/ftrace/.gitignore
 create mode 100644 scripts/ftrace/Makefile
 rename scripts/{ => ftrace}/recordmcount.c (100%)
 rename scripts/{ => ftrace}/recordmcount.h (100%)
 rename scripts/{ => ftrace}/recordmcount.pl (100%)
 mode change 100755 => 100644

diff --git a/scripts/.gitignore b/scripts/.gitignore
index 17f8cef88fa8..1b5b5d595d80 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -6,7 +6,6 @@ conmakehash
 kallsyms
 pnmtologo
 unifdef
-recordmcount
 sortextable
 asn1_compiler
 extract-cert
diff --git a/scripts/Makefile b/scripts/Makefile
index 16bcb8087899..d5992def49a8 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -14,7 +14,6 @@ hostprogs-$(CONFIG_BUILD_BIN2C)  += bin2c
 hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
 hostprogs-$(CONFIG_LOGO)         += pnmtologo
 hostprogs-$(CONFIG_VT)           += conmakehash
-hostprogs-$(BUILD_C_RECORDMCOUNT) += recordmcount
 hostprogs-$(CONFIG_BUILDTIME_EXTABLE_SORT) += sortextable
 hostprogs-$(CONFIG_ASN1)	 += asn1_compiler
 hostprogs-$(CONFIG_MODULE_SIG)	 += sign-file
@@ -34,6 +33,7 @@ hostprogs-y += unifdef
 subdir-$(CONFIG_GCC_PLUGINS) += gcc-plugins
 subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
+subdir-$(CONFIG_FTRACE) += ftrace
 
 # Let clean descend into subdirs
 subdir-	+= basic dtc gdb kconfig mod package
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2f66ed388d1c..67558983c518 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -188,18 +188,18 @@ endif
 # files, including recordmcount.
 sub_cmd_record_mcount =					\
 	if [ $(@) != "scripts/mod/empty.o" ]; then	\
-		$(objtree)/scripts/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
+		$(objtree)/scripts/ftrace/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)"; \
 	fi;
-recordmcount_source := $(srctree)/scripts/recordmcount.c \
-		    $(srctree)/scripts/recordmcount.h
+recordmcount_source := $(srctree)/scripts/ftrace/recordmcount.c \
+		       $(srctree)/scripts/ftrace/recordmcount.h
 else
-sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
+sub_cmd_record_mcount = perl $(srctree)/scripts/ftrace/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
 	"$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
-recordmcount_source := $(srctree)/scripts/recordmcount.pl
+recordmcount_source := $(srctree)/scripts/ftrace/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
 cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
 	$(sub_cmd_record_mcount))
diff --git a/scripts/ftrace/.gitignore b/scripts/ftrace/.gitignore
new file mode 100644
index 000000000000..54d582c8faad
--- /dev/null
+++ b/scripts/ftrace/.gitignore
@@ -0,0 +1,4 @@
+#
+# Generated files
+#
+recordmcount
diff --git a/scripts/ftrace/Makefile b/scripts/ftrace/Makefile
new file mode 100644
index 000000000000..6797e51473e5
--- /dev/null
+++ b/scripts/ftrace/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+hostprogs-$(BUILD_C_RECORDMCOUNT) += recordmcount
+always         := $(hostprogs-y)
diff --git a/scripts/recordmcount.c b/scripts/ftrace/recordmcount.c
similarity index 100%
rename from scripts/recordmcount.c
rename to scripts/ftrace/recordmcount.c
diff --git a/scripts/recordmcount.h b/scripts/ftrace/recordmcount.h
similarity index 100%
rename from scripts/recordmcount.h
rename to scripts/ftrace/recordmcount.h
diff --git a/scripts/recordmcount.pl b/scripts/ftrace/recordmcount.pl
old mode 100755
new mode 100644
similarity index 100%
rename from scripts/recordmcount.pl
rename to scripts/ftrace/recordmcount.pl
-- 
2.20.1

