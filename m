Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C8B311271
	for <lists+linux-arch@lfdr.de>; Fri,  5 Feb 2021 21:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhBESol (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 5 Feb 2021 13:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbhBESmc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 Feb 2021 13:42:32 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2A9C0617A9
        for <linux-arch@vger.kernel.org>; Fri,  5 Feb 2021 12:22:37 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id z199so3955230pfc.15
        for <linux-arch@vger.kernel.org>; Fri, 05 Feb 2021 12:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Ac6X1Rdkx1EJk+C0lhpfh2FkmSOBw6HTNuqApzD6R7U=;
        b=UzSV3/EypNuCGey4dBevN4B9QElBYrTy37arbLthKlOL5mdUZciKGGW8ytYnIEpP+0
         UxotsxAOV5KrMxzU3yUTxpnJMOwNusS/wjoce4+l4dSawJbKa+7zaPd0OIRSkIuvId5j
         2sQM8INE1pKeK5al/NUG4neoFgPeU+3pdbV3JBF3Rt5aSayFwWDdn1wKtNM+C9tUO6ST
         on+gQusutR7C3NRMWU98KlrJEYb5sfpMT/H7meBzCpZArjG/NDB+ZgwK5gC2CafEANhd
         xe7xRUOB5XXpMsiUfnXtTVAUZ6SvabzCbPLek8slPKQB7H0WgEW7cZbSA9sEdw0I5h4J
         zSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ac6X1Rdkx1EJk+C0lhpfh2FkmSOBw6HTNuqApzD6R7U=;
        b=o64D1coQqvksPLvzsfMXpQ27pYVSY/LeFk2W0PRd3QU8OeFp2KMkB0NxjzB6psS+Wl
         RaqahyMIt6q8Mm/j2xi8kxUlUg36ojFAvgF6eemPex6KNcHDEF4V9C6i4FDp0eTBCMaj
         oZ+slJCnWQaMv1uPz8WKnIeF6UWdBtbHm2PJyaP5ibM4eEtEFoMBEqDcrPRrn7/7PMRk
         l/VXEDAyAwsUSUvzNnbBpXiyIcrJeIqsso36R9HkS2u/P2vyPXs27FnNuCNB4fgIxgmv
         ebGceKMiL2voTZtnPOgxRbVruDLlz8GYX1F7FbiQTDjNGOdAmNCAyzk8OIGVmZXoXNKs
         SD2A==
X-Gm-Message-State: AOAM531qcNMRHwKCj0E8WfSjcmqakm4qjRsXPkEBVD5TPsa9z6XH8izw
        zkIhMGz7eEoFDWAnCqioV1osiNS5yIa/EmHPOi4=
X-Google-Smtp-Source: ABdhPJxKh/M3AiD4pbSDUAyNP03bBwmcbR5fWfCUCO/5MaLxzgNWsK0DiAd891V0eV2tNKuDGDYdyUoh1aDCl+CQtAE=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:fce9:1439:f67f:bf26])
 (user=ndesaulniers job=sendgmr) by 2002:a17:90a:8d83:: with SMTP id
 d3mr547398pjo.0.1612556556283; Fri, 05 Feb 2021 12:22:36 -0800 (PST)
Date:   Fri,  5 Feb 2021 12:22:20 -0800
In-Reply-To: <20210205202220.2748551-1-ndesaulniers@google.com>
Message-Id: <20210205202220.2748551-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210205202220.2748551-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v9 3/3] Kconfig: allow explicit opt in to DWARF v5
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chris Murphy <bugzilla@colorremedies.com>,
        Mark Wielaard <mark@klomp.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

DWARF v5 is the latest standard of the DWARF debug info format. GCC 11
will change the implicit default DWARF version, if left unspecified, to
DWARF v5.

Allow users of Clang and older versions of GCC that have not changed the
implicit default DWARF version to DWARF v5 to opt in. This can help
testing consumers of DWARF debug info in preparation of v5 becoming more
widespread, as well as result in significant binary size savings of the
pre-stripped vmlinux image.

DWARF5 wins significantly in terms of size when mixed with compression
(CONFIG_DEBUG_INFO_COMPRESSED).

363M    vmlinux.clang12.dwarf5.compressed
434M    vmlinux.clang12.dwarf4.compressed
439M    vmlinux.clang12.dwarf2.compressed
457M    vmlinux.clang12.dwarf5
536M    vmlinux.clang12.dwarf4
548M    vmlinux.clang12.dwarf2

515M    vmlinux.gcc10.2.dwarf5.compressed
599M    vmlinux.gcc10.2.dwarf4.compressed
624M    vmlinux.gcc10.2.dwarf2.compressed
630M    vmlinux.gcc10.2.dwarf5
765M    vmlinux.gcc10.2.dwarf4
809M    vmlinux.gcc10.2.dwarf2

Though the quality of debug info is harder to quantify; size is not a
proxy for quality.

Jakub notes:
  One thing is GCC DWARF-5 support, that is whether the compiler will
  support -gdwarf-5 flag, and that support should be there from GCC 7
  onwards.

  All [GCC] 5.1 - 6.x did was start accepting -gdwarf-5 as experimental
  option that enabled some small DWARF subset (initially only a few
  DW_LANG_* codes newly added to DWARF5 drafts).  Only GCC 7 (released
  after DWARF 5 has been finalized) started emitting DWARF5 section
  headers and got most of the DWARF5 changes in...

  Another separate thing is whether the assembler does support
  the -gdwarf-5 option (i.e. if you can compile assembler files
  with -Wa,-gdwarf-5) ... That option is about whether the assembler
  will emit DWARF5 or DWARF2 .debug_line.  It is fine to compile C sources
  with -gdwarf-5 and use DWARF2 .debug_line for assembler files if as
  doesn't support it.

Version check GCC so that we don't need to worry about the difference in
command line args between GNU readelf and llvm-readelf/llvm-dwarfdump to
validate the DWARF Version in the assembler feature detection script.

Most issues with clang produced assembler were fixed in binutils 2.35.1,
but 2.35.2 fixed issues related to requiring the flag -Wa,-gdwarf-5
explicitly. The added shell script test checks for the latter, and is
only required when using clang without its integrated assembler, though
we use for clang regardless as we do not yet have a way to query the
assembler from Kconfig.

Disabled for now if CONFIG_DEBUG_INFO_BTF is set; pahole doesn't yet
recognize the new additions to the DWARF debug info.

This only modifies the DWARF version emitted by the compiler, not the
assembler.

The DWARF version of a binary can be validated with:
$ llvm-dwarfdump <object file> | head -n 4 | grep version
or
$ readelf --debug-dump=info <object file> 2>/dev/null | grep Version

Parts of the tree don't reuse DEBUG_CFLAGS as they should; such cleanup
is left as a follow up.

Link: http://www.dwarfstd.org/doc/DWARF5.pdf
Link: https://bugzilla.redhat.com/show_bug.cgi?id=1922707
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Caroline Tice <cmtice@google.com>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Jakub Jelinek <jakub@redhat.com>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile                       |  1 +
 lib/Kconfig.debug              | 18 ++++++++++++++++++
 scripts/test_dwarf5_support.sh |  8 ++++++++
 3 files changed, 27 insertions(+)
 create mode 100755 scripts/test_dwarf5_support.sh

diff --git a/Makefile b/Makefile
index a7eee28dd091..a85535eb6a7d 100644
--- a/Makefile
+++ b/Makefile
@@ -831,6 +831,7 @@ endif
 
 ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
 DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
 endif
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3ac450346dbe..c85d82d3c6ef 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -282,6 +282,24 @@ config DEBUG_INFO_DWARF4
 	  newer revisions of DWARF, you may wish to choose this or have your
 	  config select this.
 
+config DEBUG_INFO_DWARF5
+	bool "Generate DWARF Version 5 debuginfo"
+	depends on GCC_VERSION >= 50000 || CC_IS_CLANG
+	depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
+	depends on !DEBUG_INFO_BTF
+	help
+	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
+	  5.0+ accepts the -gdwarf-5 flag but only had partial support for some
+	  draft features until 7.0), and gdb 8.0+.
+
+	  Changes to the structure of debug info in Version 5 allow for around
+	  15-18% savings in resulting image and debug info section sizes as
+	  compared to DWARF Version 4. DWARF Version 5 standardizes previous
+	  extensions such as accelerators for symbol indexing and the format
+	  for fission (.dwo/.dwp) files. Users may not want to select this
+	  config if they rely on tooling that has not yet been updated to
+	  support DWARF Version 5.
+
 endchoice # "DWARF version"
 
 config DEBUG_INFO_BTF
diff --git a/scripts/test_dwarf5_support.sh b/scripts/test_dwarf5_support.sh
new file mode 100755
index 000000000000..c46e2456b47a
--- /dev/null
+++ b/scripts/test_dwarf5_support.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+# Test that the assembler doesn't need -Wa,-gdwarf-5 when presented with DWARF
+# v5 input, such as `.file 0` and `md5 0x00`. Should be fixed in GNU binutils
+# 2.35.2. https://sourceware.org/bugzilla/show_bug.cgi?id=25611
+echo '.file 0 "filename" md5 0x7a0b65214090b6693bd1dc24dd248245' | \
+  $* -gdwarf-5 -Wno-unused-command-line-argument -c -x assembler -o /dev/null -
-- 
2.30.0.365.g02bc693789-goog

