Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04034308DA0
	for <lists+linux-arch@lfdr.de>; Fri, 29 Jan 2021 20:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhA2ToP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Jan 2021 14:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhA2ToG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2021 14:44:06 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C41BC0613D6
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 11:43:26 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id j78so7923369qke.11
        for <linux-arch@vger.kernel.org>; Fri, 29 Jan 2021 11:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=T0BCD++IafOESsvir6N/Nl3Poh+QbVCsSZz/sfNR8xA=;
        b=svdb9knN6UPETzRcL79VyvAk4LAzs2FywJw+89K/C31jcuASLR/ezP7KyuzrAgOa+4
         S8J5iYMOu0HH13/Nq+b36dW8xomNOiEky4nst8pj8KoRMI0HsfCVVXkIm2DjY2l1CBUb
         ThknPlYIq5T/+c9/TBQ7QEtRMhxyRLVmHnbz/bfONWJhXW/74+4NmRDw7lE/SeRGb+JU
         +Mc8QrdHUAVbiD+5VfsnkYPxKCN8A5PsF+blI0NC3R/rq2SCrtMIHSg2MlFxdAET+nx3
         W1PKFBmwE89Ea7VIrC0nDdZN5msg1HCyTkDz/YngU6s36o+mwrj8Bmxu0wm+VgZ+H1oJ
         w1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T0BCD++IafOESsvir6N/Nl3Poh+QbVCsSZz/sfNR8xA=;
        b=MXS6pyzXMsn3vNR0Bu3mPGgHiITj4MVHFgMJyFmk/rXJcO0no+Gok1evG+T/8YjLJZ
         AVmz/dILNA7XNoDWsxfc4rHP/vaWk6qaoY7lmsw0auMFtD1RHmlGXsm9tqCb0oWwQOZY
         wCm0GvgxxKlpDo99baklS0omWpyMMqMQ3wvEXgNd7nVrboH4U0TC/KkU4fAuTpJBhRUo
         6MKjz1Wj1C354gJhamEpktKUUVKxQL0iNyrcs0ZVDZEAcwd6bDMHkr1xZeAWP5XLWRpP
         ALm18pXFvnegbZEN3SWcfzrP/FcXENky2B6KlasJdlSBCVc/ABvBukw4tEwsNsKUmnGf
         XZbw==
X-Gm-Message-State: AOAM531YE/iBEsX2MDa/HvHXrOAic+w3r9af91DrEOQnIXmMBjNEMHsN
        03sBcob+Rlop3Xq7h/vowJhGnrB07iE6Nn4wpms=
X-Google-Smtp-Source: ABdhPJxj8YBkkWzNp9cuQValdk/w0zgRUcS7K4d1oFXhPIdW0LqdanFcuBJEM8UJCVS1MJr020p3wL1PXKQbUujY6pY=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:3f0:: with SMTP id
 cf16mr5289648qvb.25.1611949405727; Fri, 29 Jan 2021 11:43:25 -0800 (PST)
Date:   Fri, 29 Jan 2021 11:43:17 -0800
In-Reply-To: <20210129194318.2125748-1-ndesaulniers@google.com>
Message-Id: <20210129194318.2125748-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210129194318.2125748-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v6 1/2] Kbuild: make DWARF version a choice
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice. Adds an
explicit CONFIG_DEBUG_INFO_DWARF2, which is the default. Does so in a
way that's forward compatible with existing configs, and makes adding
future versions more straightforward.

Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile          |  6 +++---
 lib/Kconfig.debug | 21 ++++++++++++++++-----
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 95ab9856f357..20141cd9319e 100644
--- a/Makefile
+++ b/Makefile
@@ -830,9 +830,9 @@ ifneq ($(LLVM_IAS),1)
 KBUILD_AFLAGS	+= -Wa,-gdwarf-2
 endif
 
-ifdef CONFIG_DEBUG_INFO_DWARF4
-DEBUG_CFLAGS	+= -gdwarf-4
-endif
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
+DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
 
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+= $(call cc-option, -femit-struct-debug-baseonly) \
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e906ea906cb7..1850728b23e6 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -256,13 +256,24 @@ config DEBUG_INFO_SPLIT
 	  to know about the .dwo files and include them.
 	  Incompatible with older versions of ccache.
 
+choice
+	prompt "DWARF version"
+	help
+	  Which version of DWARF debug info to emit.
+
+config DEBUG_INFO_DWARF2
+	bool "Generate DWARF Version 2 debuginfo"
+	help
+	  Generate DWARF v2 debug info.
+
 config DEBUG_INFO_DWARF4
-	bool "Generate dwarf4 debuginfo"
+	bool "Generate DWARF Version 4 debuginfo"
 	help
-	  Generate dwarf4 debug info. This requires recent versions
-	  of gcc and gdb. It makes the debug information larger.
-	  But it significantly improves the success of resolving
-	  variables in gdb on optimized code.
+	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
+	  It makes the debug information larger, but it significantly
+	  improves the success of resolving variables in gdb on optimized code.
+
+endchoice # "DWARF version"
 
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
-- 
2.30.0.365.g02bc693789-goog

